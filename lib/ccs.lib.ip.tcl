if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

addfileinfo lib "ip" "Buster <buster@buster-net.ru> (c)" \
				"2.0.0" \
				"14-Mar-2009" \
				"Библиотека с функциями обработки IP адресов"

if {[package versions [namespace current]::ip] == ""} {
	package ifneeded [namespace current]::ip 2.0.0 "namespace eval [namespace current] {source [info script]}"
	return
}

namespace eval ip {
	
	variable author			"Buster <buster@buster-net.ru> (c)"
	variable version		"2.0.0"
	variable date			"14-Mar-2009"
	variable description	"Библиотека с функциями обработки IP адресов"
	# Часть функций взята из tcllib-1.11.1 ip.tcl by Pat Thoyts <patthoyts@users.sourceforge.net>
	
	variable IPv4Ranges
	if {![info exists IPv4Ranges]} {
		array set IPv4Ranges {
			0/8			private
			10/8		private
			127/8		private
			172.16/12	private
			192.168/16	private
			223/8		reserved
			224/3		reserved
		}
	}

	variable IPv6Ranges
	if {![info exists IPv6Ranges]} {
		# RFC 3513: 2.4
		# RFC 3056: 2
		array set IPv6Ranges {
			2002::/16	"6to4 unicast"
			fe80::/10	"link local"
			fec0::/10	"site local"
			ff00::/8	"multicast"
			::/128		"unspecified"
			::1/128		"localhost"
		}
	}
	
	variable IPv4_address_space
	set IPv4_address_space {
		{10.0.0.0/8}		{IANA - Private Use}	{}
		{127.0.0.0/8}		{IANA - Loopback}		{}
		{172.16.0.0/12}		{Private-Use Networks}	{}
		{192.0.2.0/24}		{Test-Net}				{}
		{192.88.99.0/24}	{6to4 Relay Anycast}	{}
		{192.168.0.0/16}	{Private-Use Networks}	{}
		{224.0.0.0/4}		{Multicast}				{}
		{240.0.0.0/4}		{Future use}			{}
		{169.254.0.0/16}	{Link Local}			{}
		{223.0.0.0/8}		{IANA}					{}
		{224.0.0.0/4}		{Multicast}				{}
		{240.0.0.0/4}		{Future use}			{}
		{24.132.0.0/14}		{RIPE NCC}	{whois.ripe.net}
		{41.0.0.0/8}		{AfriNIC}	{whois.afrinic.net}
		{43.0.0.0/8}		{}	{whois.v6nic.net}
		{59.0.0.0/11}		{}	{whois.nic.or.kr}
		{58.0.0.0/7}		{APNIC}	{whois.apnic.net}
		{61.72.0.0/13}		{}	{whois.nic.or.kr}
		{61.80.0.0/14}		{}	{whois.nic.or.kr}
		{61.84.0.0/15}		{}	{whois.nic.or.kr}
		{61.112.0.0/12}		{}	{whois.nic.ad.jp}
		{61.192.0.0/12}		{}	{whois.nic.ad.jp}
		{61.208.0.0/13}		{}	{whois.nic.ad.jp}
		{60.0.0.0/7}		{APNIC}	{whois.apnic.net}
		{62.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{77.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{78.0.0.0/7}		{RIPE NCC}	{whois.ripe.net}
		{80.0.0.0/4}		{RIPE NCC}	{whois.ripe.net}
		{96.0.0.0/6}		{ARIN}	{whois.arin.net}
		{108.0.0.0/8}		{ARIN}	{whois.arin.net}
		{109.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{110.0.0.0/7}		{APNIC}	{whois.apnic.net}
		{96.0.0.0/4}		{}	{}
		{118.32.0.0/11}		{}	{whois.nic.or.kr}
		{119.192.0.0/11}	{}	{whois.nic.or.kr}
		{115.0.0.0/12}		{}	{whois.nic.or.kr}
		{115.16.0.0/13}		{}	{whois.nic.or.kr}
		{112.0.0.0/5}		{APNIC}	{whois.apnic.net}
		{121.128.0.0/10}	{}	{whois.nic.or.kr}
		{125.128.0.0/11}	{}	{whois.nic.or.kr}
		{120.0.0.0/6}		{APNIC}	{whois.apnic.net}
		{124.0.0.0/7}		{APNIC}	{whois.apnic.net}
		{126.0.0.0/8}		{APNIC}	{whois.apnic.net}
		{0.0.0.0/1}			{ARIN}	{whois.arin.net}
		{133.0.0.0/8}		{}	{whois.nic.ad.jp}
		{139.20.0.0/14}		{RIPE NCC}	{whois.ripe.net}
		{139.24.0.0/14}		{RIPE NCC}	{whois.ripe.net}
		{139.28.0.0/15}		{RIPE NCC}	{whois.ripe.net}
		{141.0.0.0/10}		{RIPE NCC}	{whois.ripe.net}
		{141.64.0.0/12}		{RIPE NCC}	{whois.ripe.net}
		{141.80.0.0/14}		{RIPE NCC}	{whois.ripe.net}
		{141.84.0.0/15}		{RIPE NCC}	{whois.ripe.net}
		{145.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{146.48.0.0/16}		{RIPE NCC}	{whois.ripe.net}
		{149.202.0.0/15}	{RIPE NCC}	{whois.ripe.net}
		{149.204.0.0/16}	{RIPE NCC}	{whois.ripe.net}
		{149.206.0.0/15}	{RIPE NCC}	{whois.ripe.net}
		{149.208.0.0/12}	{RIPE NCC}	{whois.ripe.net}
		{149.224.0.0/12}	{RIPE NCC}	{whois.ripe.net}
		{149.240.0.0/13}	{RIPE NCC}	{whois.ripe.net}
		{149.248.0.0/14}	{RIPE NCC}	{whois.ripe.net}
		{150.183.0.0/16}	{}	{whois.nic.or.kr}
		{150.254.0.0/16}	{RIPE NCC}	{whois.ripe.net}
		{151.0.0.0/10}		{RIPE NCC}	{whois.ripe.net}
		{151.64.0.0/11}		{RIPE NCC}	{whois.ripe.net}
		{151.96.0.0/14}		{RIPE NCC}	{whois.ripe.net}
		{151.100.0.0/16}	{RIPE NCC}	{whois.ripe.net}
		{155.232.0.0/13}	{AfriNIC}	{whois.afrinic.net}
		{155.240.0.0/16}	{AfriNIC}	{whois.afrinic.net}
		{160.216.0.0/14}	{RIPE NCC}	{whois.ripe.net}
		{160.220.0.0/16}	{RIPE NCC}	{whois.ripe.net}
		{160.44.0.0/14}		{RIPE NCC}	{whois.ripe.net}
		{160.48.0.0/12}		{RIPE NCC}	{whois.ripe.net}
		{160.115.0.0/16}	{AfriNIC}	{whois.afrinic.net}
		{160.116.0.0/14}	{AfriNIC}	{whois.afrinic.net}
		{160.120.0.0/14}	{AfriNIC}	{whois.afrinic.net}
		{160.124.0.0/16}	{AfriNIC}	{whois.afrinic.net}
		{163.156.0.0/14}	{RIPE NCC}	{whois.ripe.net}
		{163.160.0.0/12}	{RIPE NCC}	{whois.ripe.net}
		{163.195.0.0/16}	{AfriNIC}	{whois.afrinic.net}
		{163.196.0.0/14}	{AfriNIC}	{whois.afrinic.net}
		{163.200.0.0/14}	{AfriNIC}	{whois.afrinic.net}
		{164.0.0.0/11}		{RIPE NCC}	{whois.ripe.net}
		{164.32.0.0/13}		{RIPE NCC}	{whois.ripe.net}
		{164.40.0.0/16}		{RIPE NCC}	{whois.ripe.net}
		{164.128.0.0/12}	{RIPE NCC}	{whois.ripe.net}
		{164.146.0.0/15}	{AfriNIC}	{whois.afrinic.net}
		{164.148.0.0/14}	{AfriNIC}	{whois.afrinic.net}
		{165.143.0.0/16}	{AfriNIC}	{whois.afrinic.net}
		{165.144.0.0/14}	{AfriNIC}	{whois.afrinic.net}
		{165.148.0.0/15}	{AfriNIC}	{whois.afrinic.net}
		{169.208.0.0/12}	{APNIC}	{whois.apnic.net}
		{171.16.0.0/12}		{RIPE NCC}	{whois.ripe.net}
		{171.32.0.0/15}		{RIPE NCC}	{whois.ripe.net}
		{178.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{186.0.0.0/7}		{LACNIC}	{whois.lacnic.net}
		{188.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{189.0.0.0/8}		{LACNIC}	{whois.lacnic.net}
		{190.0.0.0/8}		{LACNIC}	{whois.lacnic.net}
		{128.0.0.0/2}		{ARIN}	{whois.arin.net}
		{192.71.0.0/16}		{RIPE NCC}	{whois.ripe.net}
		{192.72.253.0/24}	{ARIN}	{whois.arin.net}
		{192.72.254.0/24}	{ARIN}	{whois.arin.net}
		{192.72.0.0/16}		{APNIC}	{whois.apnic.net}
		{192.106.0.0/16}	{RIPE NCC}	{whois.ripe.net}
		{192.114.0.0/15}	{RIPE NCC}	{whois.ripe.net}
		{192.116.0.0/15}	{RIPE NCC}	{whois.ripe.net}
		{192.118.0.0/16}	{RIPE NCC}	{whois.ripe.net}
		{192.162.0.0/16}	{RIPE NCC}	{whois.ripe.net}
		{192.164.0.0/14}	{RIPE NCC}	{whois.ripe.net}
		{192.0.0.0/8}		{ARIN}	{whois.arin.net}
		{193.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{194.0.0.0/7}		{RIPE NCC}	{whois.ripe.net}
		{196.0.0.0/7}		{AfriNIC}	{whois.afrinic.net}
		{198.0.0.0/7}		{ARIN}	{whois.arin.net}
		{200.17.0.0/16}		{}	{whois.nic.br}
		{200.18.0.0/15}		{}	{whois.nic.br}
		{200.20.0.0/16}		{}	{whois.nic.br}
		{200.96.0.0/13}		{}	{whois.nic.br}
		{200.128.0.0/9}		{}	{whois.nic.br}
		{200.0.0.0/7}		{LACNIC}	{whois.lacnic.net}
		{202.11.0.0/16}		{}	{whois.nic.ad.jp}
		{202.13.0.0/16}		{}	{whois.nic.ad.jp}
		{202.15.0.0/16}		{}	{whois.nic.ad.jp}
		{202.16.0.0/14}		{}	{whois.nic.ad.jp}
		{202.20.128.0/17}	{}	{whois.nic.or.kr}
		{202.23.0.0/16}		{}	{whois.nic.ad.jp}
		{202.24.0.0/15}		{}	{whois.nic.ad.jp}
		{202.26.0.0/16}		{}	{whois.nic.ad.jp}
		{202.30.0.0/15}		{}	{whois.nic.or.kr}
		{202.32.0.0/14}		{}	{whois.nic.ad.jp}
		{202.48.0.0/16}		{}	{whois.nic.ad.jp}
		{202.39.128.0/17}	{}	{whois.twnic.net}
		{202.208.0.0/12}	{}	{whois.nic.ad.jp}
		{202.224.0.0/11}	{}	{whois.nic.ad.jp}
		{203.0.0.0/10}		{APNIC}	{whois.apnic.net}
		{203.66.0.0/16}		{}	{whois.twnic.net}
		{203.69.0.0/16}		{}	{whois.twnic.net}
		{203.74.0.0/15}		{}	{whois.twnic.net}
		{203.136.0.0/14}	{}	{whois.nic.ad.jp}
		{203.140.0.0/15}	{}	{whois.nic.ad.jp}
		{203.178.0.0/15}	{}	{whois.nic.ad.jp}
		{203.180.0.0/14}	{}	{whois.nic.ad.jp}
		{203.224.0.0/11}	{}	{whois.nic.or.kr}
		{202.0.0.0/7}		{APNIC}	{whois.apnic.net}
		{204.0.0.0/14}		{}	{rwhois.gin.ntt.net}
		{204.0.0.0/6}		{ARIN}	{whois.arin.net}
		{208.0.0.0/7}		{ARIN}	{whois.arin.net}
		{209.94.192.0/19}	{LACNIC}	{whois.lacnic.net}
		{210.59.128.0/17}	{}	{whois.twnic.net}
		{210.61.0.0/16}		{}	{whois.twnic.net}
		{210.62.252.0/22}	{}	{whois.twnic.net}
		{210.65.0.0/16}		{}	{whois.twnic.net}
		{210.71.128.0/16}	{}	{whois.twnic.net}
		{210.90.0.0/15}		{}	{whois.nic.or.kr}
		{210.92.0.0/14}		{}	{whois.nic.or.kr}
		{210.96.0.0/11}		{}	{whois.nic.or.kr}
		{210.128.0.0/11}	{}	{whois.nic.ad.jp}
		{210.160.0.0/12}	{}	{whois.nic.ad.jp}
		{210.178.0.0/15}	{}	{whois.nic.or.kr}
		{210.180.0.0/14}	{}	{whois.nic.or.kr}
		{210.188.0.0/14}	{}	{whois.nic.ad.jp}
		{210.196.0.0/14}	{}	{whois.nic.ad.jp}
		{210.204.0.0/14}	{}	{whois.nic.or.kr}
		{210.216.0.0/13}	{}	{whois.nic.or.kr}
		{210.224.0.0/12}	{}	{whois.nic.ad.jp}
		{210.240.0.0/16}	{}	{whois.twnic.net}
		{210.241.0.0/15}	{}	{whois.twnic.net}
		{210.241.224.0/19}	{}	{whois.twnic.net}
		{210.242.0.0/15}	{}	{whois.twnic.net}
		{210.248.0.0/13}	{}	{whois.nic.ad.jp}
		{211.0.0.0/12}		{}	{whois.nic.ad.jp}
		{211.16.0.0/14}		{}	{whois.nic.ad.jp}
		{211.20.0.0/15}		{}	{whois.twnic.net}
		{211.22.0.0/16}		{}	{whois.twnic.net}
		{211.32.0.0/11}		{}	{whois.nic.or.kr}
		{211.75.0.0/16}		{}	{whois.twnic.net}
		{211.72.0.0/16}		{}	{whois.twnic.net}
		{211.104.0.0/13}	{}	{whois.nic.or.kr}
		{211.112.0.0/13}	{}	{whois.nic.or.kr}
		{211.120.0.0/13}	{}	{whois.nic.ad.jp}
		{211.128.0.0/13}	{}	{whois.nic.ad.jp}
		{211.168.0.0/13}	{}	{whois.nic.or.kr}
		{211.176.0.0/12}	{}	{whois.nic.or.kr}
		{211.192.0.0/10}	{}	{whois.nic.or.kr}
		{210.0.0.0/7}		{APNIC}	{whois.apnic.net}
		{213.154.32.0/19}	{AfriNIC}	{whois.afrinic.net}
		{213.154.64.0/19}	{AfriNIC}	{whois.afrinic.net}
		{212.0.0.0/7}		{RIPE NCC}	{whois.ripe.net}
		{214.0.0.0/7}		{ARIN}	{whois.arin.net}
		{216.0.0.0/8}		{ARIN}	{whois.arin.net}
		{217.0.0.0/8}		{RIPE NCC}	{whois.ripe.net}
		{218.36.0.0/14}		{}	{whois.nic.or.kr}
		{218.40.0.0/13}		{}	{whois.nic.ad.jp}
		{218.48.0.0/13}		{}	{whois.nic.or.kr}
		{219.96.0.0/11}		{}	{whois.nic.ad.jp}
		{218.144.0.0/12}	{}	{whois.nic.or.kr}
		{218.160.0.0/12}	{}	{whois.twnic.net}
		{218.216.0.0/13}	{}	{whois.nic.ad.jp}
		{218.224.0.0/13}	{}	{whois.nic.ad.jp}
		{218.232.0.0/13}	{}	{whois.nic.or.kr}
		{219.240.0.0/15}	{}	{whois.nic.or.kr}
		{219.248.0.0/13}	{}	{whois.nic.or.kr}
		{218.0.0.0/7}		{APNIC}	{whois.apnic.net}
		{220.64.0.0/11}		{}	{whois.nic.or.kr}
		{220.96.0.0/14}		{}	{whois.nic.ad.jp}
		{220.103.0.0/16}	{}	{whois.nic.or.kr}
		{220.104.0.0/13}	{}	{whois.nic.ad.jp}
		{220.149.0.0/16}	{}	{whois.nic.or.kr}
		{221.138.0.0/13}	{}	{whois.nic.or.kr}
		{221.144.0.0/12}	{}	{whois.nic.or.kr}
		{221.160.0.0/13}	{}	{whois.nic.or.kr}
		{222.96.0.0/12}		{}	{whois.nic.or.kr}
		{222.112.0.0/13}	{}	{whois.nic.or.kr}
		{222.120.0.0/15}	{}	{whois.nic.or.kr}
		{222.122.0.0/16}	{}	{whois.nic.or.kr}
		{222.232.0.0/13}	{}	{whois.nic.or.kr}
		{223.0.0.0/8}		{}	{}
		{220.0.0.0/6}		{APNIC}	{whois.apnic.net}
	}
	
	variable IPv6_address_space
	set IPv6_address_space {
		{::0/128}			{unspecified}	{}
		{::1/128}			{localhost}		{}
		{2001:0000::/32}	{teredo}		{}
		{2001:0200::/23}	{APNIC}			{whois.apnic.net}
		{2001:0400::/23}	{ARIN}			{whois.arin.net}
		{2001:0600::/23}	{RIPE NCC}		{whois.ripe.net}
		{2001:0800::/22}	{RIPE NCC}		{whois.ripe.net}
		{2001:0C00::/22}	{APNIC}			{whois.apnic.net}
		{2001:1000::/23}	{not allocated}	{}
		{2001:1000::/22}	{LACNIC}		{whois.lacnic.net}
		{2001:1400::/22}	{RIPE NCC}		{whois.ripe.net}
		{2001:1800::/23}	{ARIN}			{whois.arin.net}
		{2001:1A00::/23}	{RIPE NCC}		{whois.ripe.net}
		{2001:1C00::/22}	{RIPE NCC}		{whois.ripe.net}
		{2001:3C00::/22}	{reserved for RIPE but not allocated}	{}
		{2001:2000::/19}	{RIPE NCC}		{whois.ripe.net}
		{2001:4000::/23}	{RIPE NCC}		{whois.ripe.net}
		{2001:4200::/23}	{AfriNIC}		{whois.afrinic.net}
		{2001:4400::/23}	{APNIC}			{whois.apnic.net}
		{2001:4600::/23}	{RIPE NCC}		{whois.ripe.net}
		{2001:4800::/23}	{ARIN}			{whois.arin.net}
		{2001:4A00::/23}	{RIPE NCC}		{whois.ripe.net}
		{2001:4E00::/23}	{not allocated}	{}
		{2001:4C00::/22}	{RIPE NCC}		{whois.ripe.net}
		{2001:5000::/20}	{RIPE NCC}		{whois.ripe.net}
		{2001:8000::/18}	{APNIC}			{whois.apnic.net}
		{2002:0000::/16}	{6to4}			{}
		{2003:0000::/18}	{RIPE NCC}		{whois.ripe.net}
		{2400:0000::/20}	{}				{whois.nic.or.kr}
		{2400:0000::/12}	{APNIC}			{whois.apnic.net}
		{2600:0000::/12}	{ARIN}			{whois.arin.net}
		{2610:0000::/23}	{ARIN}			{whois.arin.net}
		{2620:0000::/23}	{ARIN}			{whois.arin.net}
		{2800:0000::/12}	{LACNIC}		{whois.lacnic.net}
		{2A00:0000::/12}	{RIPE NCC}		{whois.ripe.net}
		{2C00:0000::/12}	{AfriNIC}		{whois.afrinic.net}
		{3FFE:0000::/16}	{}				{whois.6bone.net}
		{fe80::/10}			{link local}	{}
		{fec0::/10}			{site local}	{}
		{ff00::/8}			{multicast}		{}
		{::0/0}				{not allocated}	{}
	}
	
	proc gate_to_ipv4 {text} {
		
		if {[string index $text 0] == "~"} {
			set text [string range $text 1 end]
		}
		if {[string length $text] != 8} {return ""}
		set ip [longip_to_ipv4 [scan $text "%x"]]
		if {[IPv4? $ip]} {
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
		set ip [normalize6 $ip]
		set ip [string map [list ":" ""] $ip]
		set ip [string range $ip 4 11]
		return [longip_to_ipv4 [expr "0x$ip"]]
		
	}
	
	proc ipv4_to_ipv6 {ip} {
		foreach {a b c d} [split $ip .] break
		return "2002:[format "%04x" [expr {($a << 8) + $b}]]:[format "%04x" [expr {($c << 8) + $d}]]::"
	}
	
	proc ipv4_to_longip {ipaddr} {
		
		if {$ipaddr == ""} {return -1}
		set ipaddr [normalize4 $ipaddr]
		foreach _ [split $ipaddr .] {
			set _ [string trimleft $_ 0]
			if {$_ == ""} {set _ 0}
			append hexaddr [format {%02x} $_]
		}
		return [expr "0x$hexaddr"]
		
	}
	
	proc longip_to_ipv4 {longip} {
		set lip [list]
		for {set a 24} {$a >= 0} {incr a -8} {
			lappend lip [expr {$longip >> $a & 0xFF}]
		}
		return [join $lip .]
	}
	
	proc ip_to_arpa4 {ip} {
		
		set addr [lreverse [split $ip .]]
		lappend addr in-addr arpa
		return [join $addr .]
		
	}
	
	proc ip_to_arpa6 {ip} {
		
		set addr [lreverse [split [string map [list : ""] [normalize $ip]] ""]]
		lappend addr ip6 arpa
		return [join $addr .]
		
	}
	
	proc is {class ip} {
		foreach {ip mask} [split $ip /] break
		switch -exact -- $class {
			ipv4 - IPv4 - 4 {
				return [IPv4? $ip]
			}
			ipv6 - IPv6 - 6 {
				return [IPv6? $ip]
			}
			default {
				return -code error "bad class \"$class\": must be ipv4 or ipv6"
			}
		}
	}
	
	proc version {ip} {
		set version -1
		foreach {addr mask} [split $ip /] break
		if {[IPv4? $addr]} {
			set version 4
		} elseif {[IPv6? $addr]} {
			set version 6
		}
		return $version
	}
	
	proc equal {lhs rhs} {
		foreach {LHS LM} [SplitIp $lhs] break
		foreach {RHS RM} [SplitIp $rhs] break
		if {[set version [version $LHS]] != [version $RHS]} {
			return -code error "type mismatch:\
				cannot compare different address types"
		}
		if {$version == 4} {set fmt I} else {set fmt I4}
		set LHS [Mask$version [Normalize $LHS $version] $LM]
		set RHS [Mask$version [Normalize $RHS $version] $RM]
		binary scan $LHS $fmt LLL
		binary scan $RHS $fmt RRR
		foreach L $LLL R $RRR {
			if {$L != $R} {return 0}
		}
		return 1
	}
	
	proc include {lhs rhs} {
		foreach {LHS LM} [SplitIp $lhs] break
		foreach {RHS RM} [SplitIp $rhs] break
		if {[set version [version $LHS]] != [version $RHS]} {
			return -code error "type mismatch:\
				cannot compare different address types"
		}
		if {$version == 4} {set fmt I} else {set fmt I4}
		set LHS [Mask$version [Normalize $LHS $version] $LM]
		set RHS [Mask$version [Normalize $RHS $version] $LM]
		binary scan $LHS $fmt LLL
		binary scan $RHS $fmt RRR
		foreach L $LLL R $RRR {
			if {$L != $R} {return 0}
		}
		return 1
	}
	
	proc normalize {ip {Ip4inIp6 0}} {
		foreach {ip mask} [SplitIp $ip] break
		set version [version $ip]
		set s [ToString [Normalize $ip $version] $Ip4inIp6]
		if {($version == 6 && $mask != 128) || ($version == 4 && $mask != 32)} {
			append s /$mask
		}
		return $s
	}
	
	proc normalize4 {ip} {
		foreach {ip mask} [SplitIp $ip] break
		set s [ToString [Normalize $ip 4]]
		if {$mask != 32} {append s /$mask}
		return $s
	}
	
	proc normalize6 {ip {Ip4inIp6 0}} {
		foreach {ip mask} [SplitIp $ip] break
		set s [ToString [Normalize $ip 6] $Ip4inIp6]
		if {$mask != 128} {append s /$mask}
		return $s
	}
	
	proc contract {ip} {
		foreach {ip mask} [SplitIp $ip] break
		set version [version $ip]
		set s [ToString [Normalize $ip $version]]
		if {$version == 6} {
			set r ""
			foreach o [split $s :] { 
				append r [format %x: 0x$o] 
			}
			set r [string trimright $r :]
			regsub {(?:^|:)0(?::0)+(?::|$)} $r {::} r
		} else {
			set r [string trimright $s .0]
		}
		return $r
	}
	
	# Returns an IP address prefix.
	# For instance: 
	#  prefix 192.168.1.4/16 => 192.168.0.0
	#  prefix fec0::4/16     => fec0:0:0:0:0:0:0:0
	#  prefix fec0::4/ffff:: => fec0:0:0:0:0:0:0:0
	#
	proc prefix {ip} {
		foreach {addr mask} [SplitIp $ip] break
		set version [version $addr]
		set addr [Normalize $addr $version]
		return [ToString [Mask$version $addr $mask]]
	}
	
	# Return the address type. For IPv4 this is one of private, reserved 
	# or normal
	# For IPv6 it is one of site local, link local, multicast, unicast,
	# unspecified or loopback.
	proc type {ip} {
		set version [version $ip]
		upvar [namespace current]::IPv${version}Ranges types
		set ip [prefix $ip]
		foreach prefix [array names types] {
			set mask [mask $prefix]
			if {[equal $ip/$mask $prefix]} {
				return $types($prefix)
			}
		}
		if {$version == 4} {
			return "normal"
		} else {
			return "unicast"
		}
	}
	
	proc mask {ip} {
		foreach {addr mask} [split $ip /] break
		return $mask
	}
	
	# -------------------------------------------------------------------------
	# Returns true is the argument can be converted into an IPv4 address.
	#
	proc IPv4? {ip} {
		
		set ld [split $ip .]
		if {[llength $ld] != 4} {return 0}
		foreach _ $ld {
			if {$_ == ""} {set $_ 0}
			if {![string is digit $_]} {return 0}
			if {$_ < 0 || $_ > 255} {return 0}
		}
		return 1
		
	}
	
	proc IPv6? {ip} {
		
		set df [expr {[string range $ip 0 1] == "::"}]
		set dl [expr {[string range $ip end-1 end] == "::"}]
		set octets [split $ip :]
		if {[llength $octets] > 8} {return 0}
		set ndx 0
		foreach _ $octets {
			if {$_ == ""} {incr ndx; continue}
			if {![string is xdigit $_]} {return 0}
			if {[expr "0x$_"] < 0 || [expr "0x$_"] > 65535} {return 0}
		}
		if {$ndx > 1 && !($ndx == 2 && ($df || $dl))} {return 0}
		if {$ndx == 0 && [llength $octets] != 8} {return 0}
		
		return 1
		
	}
	
	proc IPgate? {ip} {
		
		if {[string index $ip 0] == "~"} {
			set ip [string range $ip 1 end]
		}
		if {[string length $ip] != 8} {return 0}
		if {[string is xdigit $ip]} {return 1}
		return 0
		
	}
	
	proc IPlong? {ip} {
		
		if {![string is digit $ip]} {return 0}
		if {$ip < 0 || $ip > 4294967295} {return 0}
		return 1
		
	}
	
	proc Mask4 {ip {bits {}}} {
		if {[string length $bits] < 1} { set bits 32 }
		binary scan $ip I ipx
		if {[string is integer $bits]} {
			set mask [expr {(0xFFFFFFFF << (32 - $bits)) & 0xFFFFFFFF}]
		} else {
			binary scan [Normalize4 $bits] I mask
		}
		return [binary format I [expr {$ipx & $mask}]]
	}
	
	proc Mask6 {ip {bits {}}} {
		if {[string length $bits] < 1} { set bits 128 }
		if {[string is integer $bits]} {
			set mask [binary format B128 [string repeat 1 $bits]]
		} else {
			binary scan [Normalize6 $bits] I4 mask
		}
		binary scan $ip I4 Addr
		binary scan $mask I4 Mask
		foreach A $Addr M $Mask {
			lappend r [expr {$A & $M}]
		}
		return [binary format I4 $r]
	}
	
	# A network address specification is an IPv4 address with an optional bitmask
	# Split an address specification into a IPv4 address and a network bitmask.
	# This doesn't validate the address portion.
	# If a spec with no mask is provided then the mask will be 32
	# (all bits significant).
	# Masks may be either integer number of significant bits or dotted-quad
	# notation.
	#
	proc SplitIp {spec} {
		set slash [string last / $spec]
		if {$slash != -1} {
			incr slash -1
			set ip [string range $spec 0 $slash]
			incr slash 2
			set bits [string range $spec $slash end]
		} else {
			set ip $spec
			if {[string length $ip] > 0 && [version $ip] == 6} {
				set bits 128
			} else {
				set bits 32
			}
		}
		return [list $ip $bits]
	}
	
	# Given an IP string from the user, convert to a normalized internal rep.
	# For IPv4 this is currently a hex string (0xHHHHHHHH).
	# For IPv6 this is a binary string or 16 chars.
	proc Normalize {ip {version 0}} {
		if {$version < 0} {
			set version [version $ip]
			if {$version < 0} {
				return -code error "invalid address \"$ip\":\
					value must be a valid IPv4 or IPv6 address"
			}
		}
		return [Normalize$version $ip]
	}
	
	proc Normalize4 {ip} {
		set octets [split $ip .]
		if {[llength $octets] > 4} {
			return -code error "invalid ip address \"$ip\""
		} elseif {[llength $octets] < 4} {
			set octets [lrange [concat $octets 0 0 0] 0 3]
		}
		foreach oct $octets {
			if {$oct < 0 || $oct > 255} {
				return -code error "invalid ip address"
			}
		}
		return [binary format c4 $octets]
	}
	
	proc Normalize6 {ip} {
		set octets [split $ip :]
		set ip4embed [string first . $ip]
		set len [llength $octets]
		if {$len < 0 || $len > 8} {
			return -code error "invalid address: this is not an IPv6 address"
		}
		set result ""
		for {set n 0} {$n < $len} {incr n} {
			set octet [lindex $octets $n]
			if {$octet == {}} {
				if {$n == 0 || $n == ($len - 1)} {
					set octet \0\0
				} else {
					set missing [expr {9 - $len}]
					if {$ip4embed != -1} {incr missing -1}
					set octet [string repeat \0\0 $missing]
				}
			} elseif {[string first . $octet] != -1} {
				set octet [Normalize4 $octet]
			} else {
				set m [expr {4 - [string length $octet]}]
				if {$m != 0} {
					set octet [string repeat 0 $m]$octet
				}
				set octet [binary format H4 $octet]
			}
			append result $octet
		}
		if {[string length $result] != 16} {
			return -code error "invalid address: \"$ip\" is not an IPv6 address"
		}
		return $result
	}
	
	# This will convert a full ipv4/ipv6 in binary format into a normal
	# expanded string rep.
	proc ToString {bin {Ip4inIp6 0}} {
		
		set len [string length $bin]
		set r ""
		if {$len == 4} {
			binary scan $bin c4 octets
			foreach octet $octets {
				lappend r [expr {$octet & 0xff}]
			}
			return [join $r .]
		} elseif {$len == 16} {
			if {$Ip4inIp6 == 0} {
				binary scan $bin H32 hex
				for {set n 0} {$n < 32} {incr n} {
					append r [string range $hex $n [incr n 3]]:
				}
				return [string trimright $r :]
			} else {
				binary scan $bin H24c4 hex octets
				for {set n 0} {$n < 24} {incr n} {
					append r [string range $hex $n [incr n 3]]:
				}
				foreach octet $octets {
					append r [expr {$octet & 0xff}].
				}
				return [string trimright $r .]
			}
		} else {
			return -code error "invalid binary address:\
				argument is neither an IPv4 nor an IPv6 address"
		}
	}
	
}

package provide [namespace current]::ip $ip::version
