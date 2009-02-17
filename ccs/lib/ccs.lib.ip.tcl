if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set libname		"ip"
addfileinfo lib $libname "Buster <buster@ircworld.ru> (c)" \
				"1.0.0" \
				"06-Jan-2009" \
				"Библиотека с функциями обработки IP адресов"

if {$ccs(lib,name,$libname)} {
	
	proc gate_to_ipv4 {text} {
		
		if {[string index $text 0] == "~"} {
			set text [string range $text 1 end]
		}
		if {[string length $text] != 8} {return ""}
		set ip [longip_to_ipv4 [scan $text "%x"]]
		if {[string_is_ipv4 $ip]} {
			return $ip
		} else {
			return ""
		}
		
	}
	
	proc ipv4_to_gate {ipaddr} {
		
		if {$ipaddr == ""} {return ""}
		foreach {a b c d} [split $ipaddr .] break
		return [format "%08x" [expr {($a << 24) + ($b << 16) + ($c << 8) + $d}]]
		
	}
	
	proc ipv6_to_ipv4 {ip} {
		
		if {![ipv6_in_net 2002::/16 $ip]} {return ""}
		set ip [ipv6_normalize $ip]
		set ip [string map [list ":" ""] $ip]
		set ip [string range $ip 4 11]
		return [longip_to_ipv4 [expr "0x$ip"]]
		
	}
	
	proc ipv4_to_ipv6 {ip} {
		foreach {a b c d} [split $ip .] break
		return "2002:[format "%04x" [expr {($a << 8) + $b}]]:[format "%04x" [expr {($c << 8) + $d}]]::"
	}
	
	proc string_is_ipv4 {text} {
		
		set ld [split $text .]
		if {[llength $ld] != 4} {return 0}
		foreach _ $ld {
			if {$_ == ""} {set $_ 0}
			if {![string is digit $_]} {return 0}
			if {$_ < 0 || $_ > 255} {return 0}
		}
		return 1
		
	}
	
	proc string_is_ipv6 {text} {
		
		set df [expr {[string range $text 0 1] == "::"}]
		set dl [expr {[string range $text end-1 end] == "::"}]
		set ld [split $text :]
		if {[llength $ld] > 8} {return 0}
		set n 0
		foreach _ $ld {
			if {$_ == ""} {incr n; continue}
			if {![string is xdigit $_]} {return 0}
			if {[expr "0x$_"] < 0 || [expr "0x$_"] > 65535} {return 0}
		}
		if {$n > 1 && !($n == 2 && ($df || $dl))} {return 0}
		if {$n == 0 && [llength $ld] != 8} {return 0}
		
		return 1
		
	}
	
	proc ipv4_to_longip {ipaddr} {
		
		if {$ipaddr == ""} {return -1}
		set ipaddr [ipv4_normalize $ipaddr]
		foreach _ [split $ipaddr .] {
			set _ [string trimleft $_ 0]
			if {$_ == ""} {set _ 0}
			append hexaddr [format {%02x} $_]
		}
		return [expr "0x$hexaddr"]
		
	}
	
	proc ipv6_to_longip {ip} {
		
		if {$ip == ""} {return -1}
		set ip [ipv6_normalize $ip]
		set ip [string map [list ":" ""] $ip]
		return [expr "0x$ip"]
		
	}
	
	proc ipv4_normalize {ip {trim 0}} {
		set ld [split $ip .]
		set lnip [list]
		set find 0
		foreach _ $ld {
			if {$trim} {
				if {[set _ [string trimleft $_ 0]] == ""} {set _ 0}
			} else {
				set _ "[string repeat "0" [expr 3 - [string length $_]]]$_"
			}
			lappend lnip $_
		}
		while {[llength $lnip] < 4} {
			if {$trim} {lappend lnip "0"} else {lappend lnip "000"}
		}
		return [join $lnip .]
	}
	
	proc ipv6_normalize {ip {trim 0}} {
		set ld [split $ip :]
		set lnip [list]
		set find 0
		foreach _ $ld {
			if {$_ == "" && !$find} {
				for {set a 1} {$a <= [expr 9 - [llength $ld]]} {incr a} {
					if {$trim} {lappend lnip "0"} else {lappend lnip "0000"}
				}
				set find 1
				continue
			}
			if {$trim} {
				if {[set _ [string trimleft $_ 0]] == ""} {set _ 0}
			} else {
				set _ "[string repeat "0" [expr 4 - [string length $_]]]$_"
			}
			lappend lnip $_
		}
		while {[llength $lnip] < 8} {
			if {$trim} {lappend lnip "0"} else {lappend lnip "0000"}
		}
		return [join $lnip :]
	}
	
	proc longip_to_ipv4 {longip} {
		set lip [list]
		for {set a 24} {$a >= 0} {incr a -8} {
			lappend lip [expr {$longip >> $a & 0xFF}]
		}
		return [join $lip .]
	}
	
	proc longip_to_ipv6 {longip} {
		set lip [list]
		for {set a 112} {$a >= 0} {incr a -16} {
			lappend lip [format {%04x} [expr {$longip >> $a & 0xFFFF}]]
		}
		return [join $lip :]
	}
	
	proc ipv4_in_net {netmask ip} {
		
		foreach {net mask} [split $netmask /] break
		
		if {$mask == "" || $mask > 32} {set mask 32}
		
		set longipnet [ipv4_to_longip $net]
		set longip [ipv4_to_longip $ip]
		if {$longip >= $longipnet && $longip < [expr $longipnet + pow(2,(32-$mask))]} {return 1}
		return 0
		
	}
	
	proc ipv6_in_net {netmask ip} {
		
		foreach {net mask} [split $netmask /] break
		
		if {$mask == "" || $mask > 128} {set mask 128}
		
		set longipnet [ipv6_to_longip $net]
		set longip [ipv6_to_longip $ip]
		if {$longip >= $longipnet && $longip < [expr $longipnet + entier(pow(2,(128-$mask)))]} {return 1}
		return 0
		
	}
	
}