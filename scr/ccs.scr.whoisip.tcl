####################################################################################################
## Script that allows you to get info about specified host/IP
## ������ ��������� ���������� �� IP ������
####################################################################################################
# ������ ��������� ��������� (changelog):
#	v1.3.1
# - �������� ��������� IP � DNS ���������� �� ������ �������� ������. �� ���� ������� �������
#   ��������� ��������� ������ DNS, ���� ������� �������, � ���� ccs.rc2.tcl
#	v1.2.2
# - ���������� ���������� �������� ������� ��� ���������� DNS ������.
#	v1.2.1
# - ��������� ��������� ������� ������ eggdrop ��� DNS ��������.
# - ��������� ����� ����� �������� ���������.
#	v1.2.0
# - ������������� ��������� ���������� DNS.
# - �������� ������ � ��������� IPv6. ���������� ������ � �������� ���� ��� ������.
# - � �������� �������������� ���������� ��������� NS, MX, CNAME ������.
#	v1.1.3
# - English translation
# - �������� ������� lsearch_equal
#	v1.1.2
# - ��������� ��������� IPv6 (added IPv6 support, TCL 8.5 required)
# - ����� ������� ���������� � ���������� ip (most of functions was moved to ip lib)

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{whoisip}
pkg_add scr $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"������ �������� ���������� �� IP ������"

if {[pkg_info scr $_name on]} {
	
	################################################################################################
	# ����� � ������������ � ������� �������� ������� ������.
	# Request timeout (period within we should wait for answer)
	set options(whoisip_timeout)	20000
	
	################################################################################################
	# ������ ��������� ����������.
	# Output info entries.
	set options(whoisip_info) {
		netname descr country person address city stateprov postalcode e-mail
		orgtechemail phone orgtechphone orgtechname orgname rtechname rtechemail
		rtechphone
	}
	
	################################################################################################
	# ����� ��������� DNS ��������. 
	# 1 - ��������� ������ ���� DNS (dns.so), ��� ���� ����� �� �������� ��������� �������, �����
	#     ���: ������ ��������� IPv6, ��������� ������� NS ��������, MX ������, ������������ ���;
	# 2 - ��������� ���������� ccs.lib.dns.tcl, ��� � ������ ���������� ����� DNS ������ ��������
	#     ������� �� ��������� TCP, ���� ����������� ��������� ������ ��������������� UDP �������.
	set options(mode_dns_reply)		2
	
	cmd_configure whoisip -script -group "info" -flags {-|-} -block 5 -use_auth 0 -use_chan 0 -use_botnet 0 -use_mode 1 \
		-alias {%pref_whoisip} \
		-regexp {{^([^\ ]+)$} {-> stext}}
	
	set_text -type args -- ru whoisip {<nick/host/ip/gate/longip>}
	set_text -type help -- ru whoisip {�������� ��� ���������� � �����}
	set_text -type help2 -- ru whoisip {
		{�������� ��� ���������� � �����. �������� �������� ����, �����, IP ������, ��� �����, �������� IP ������.}
	}
	
	set_text -color -- ru $_name #101	"�� ������� ������������� ������ � IP �����."
	set_text -color -- ru $_name #102	"\00314�������������������������:�\017\002%s\002. %s."
	set_text -color -- ru $_name #103	"\00314�����������IPv4:�%s"
	set_text -color -- ru $_name #104	"\00314�����������IPv6:�%s"
	set_text -color -- ru $_name #105	"\00314���������������:�%s"
	set_text -color -- ru $_name #106	"\00314��������������:�\00312%s\017"
	set_text -color -- ru $_name #107	"\00314�������������:�\00312%s\017"
	set_text -color -- ru $_name #108	"\00314NS��������:�\00312%s\017"
	set_text -color -- ru $_name #109	"\00314%s:�\00312%s\017"
	set_text -color -- ru $_name #110	"\00303%s\017"
	set_text -color -- ru $_name #111	"\00312%s\017"
	
	set_text ru $_name #101	"�� ������� ������������� ������ � IP �����."
	set_text ru $_name #102	"�������������������������:�\002%s\002. %s."
	set_text ru $_name #103	"\002�����������IPv4\002:�%s"
	set_text ru $_name #104	"\002�����������IPv6\002:�%s"
	set_text ru $_name #105	"\002���������������\002:�%s"
	set_text ru $_name #106	"\002��������������\002:�%s"
	set_text ru $_name #107	"\002�������������\002:�%s"
	set_text ru $_name #108	"\002NS��������\002:�%s"
	set_text ru $_name #109	"\002%s\002:�%s"
	set_text ru $_name #110	"%s"
	set_text ru $_name #111	"%s"
	
	set_text ru $_name #112	"\00312Whois IPv4:�\017\002%s\002; \00312Range: \00303%s\017 (%s); \00312WebGate: \00303%s; \00312IPv4 in IPv6: \00303%s\017%s"
	set_text ru $_name #113	"\00312Whois IPv6:�\017\002%s\002; \00312Range: \00303%s\017 (%s)%s"
	
	set_text ru $_name #114	"���������� '%s', ��������� ��� ������ �������, �� ���������. ��������� � ����� �������� \002!ccsupdate download -type lib -name %s\002"
	
	set_text -color -- ru $_name #112	"\002Whois IPv4\002:�%s; \002Range\002: %s (%s); \002WebGate\002: %s; \002IPv4 in IPv6\002: %s%s"
	set_text -color -- ru $_name #113	"\002Whois IPv6\002:�%s; \002Range\002: %s (%s)%s"
	
	set_text -color -- ru $_name #netname		"\00312��������:�\017%s"
	set_text -color -- ru $_name #descr			"\00312descr:�\017%s"
	set_text -color -- ru $_name #orgname		"\00312descr:�\017%s"
	set_text -color -- ru $_name #country		"\00312������:�\017%s"
	set_text -color -- ru $_name #stateprov		"\00312����:�\017%s"
	set_text -color -- ru $_name #postalcode	"\00312�����������:�\017%s"
	set_text -color -- ru $_name #city			"\00312�����:�\017%s"
	set_text -color -- ru $_name #mnt-by		"\00312mnt-by:�\017%s"
	set_text -color -- ru $_name #person		"\00312����:�\017%s"
	set_text -color -- ru $_name #orgtechname	"\00312����:�\017%s"
	set_text -color -- ru $_name #rtechname		"\00312����:�\017%s"
	set_text -color -- ru $_name #address		"\00312�����:�\017%s"
	set_text -color -- ru $_name #e-mail		"\00312E-mail:�\017%s"
	set_text -color -- ru $_name #orgtechemail	"\00312E-mail:�\017%s"
	set_text -color -- ru $_name #rtechemail	"\00312E-mail:�\017%s"
	set_text -color -- ru $_name #phone			"\00312���.:�\017%s"
	set_text -color -- ru $_name #orgtechphone	"\00312���.:�\017%s"
	set_text -color -- ru $_name #rtechphone	"\00312���.:�\017%s"
	
	set_text ru $_name #netname			"\002��������\002:�%s"
	set_text ru $_name #descr			"\002descr\002:�%s"
	set_text ru $_name #orgname			"\002descr\002:�%s"
	set_text ru $_name #country			"\002������\002:�%s"
	set_text ru $_name #stateprov		"\002����\002:�%s"
	set_text ru $_name #postalcode		"\002�����������\002:�%s"
	set_text ru $_name #city			"\002�����\002:�%s"
	set_text ru $_name #mnt-by			"\002mnt-by\002:�%s"
	set_text ru $_name #person			"\002����\002:�%s"
	set_text ru $_name #orgtechname		"\002����\002:�%s"
	set_text ru $_name #rtechname		"\002����\002:�%s"
	set_text ru $_name #address			"\002�����\002:�%s"
	set_text ru $_name #e-mail			"\002E-mail\002:�%s"
	set_text ru $_name #orgtechemail	"\002E-mail\002:�%s"
	set_text ru $_name #rtechemail		"\002E-mail\002:�%s"
	set_text ru $_name #phone			"\002���.\002:�%s"
	set_text ru $_name #orgtechphone	"\002���.\002:�%s"
	set_text ru $_name #rtechphone		"\002���.\002:�%s"
	
	set_text -type args -- en whoisip {<nick/host/ip/gate/longip>}
	set_text -type help -- en whoisip {Get info about specified host}
	set_text -type help2 -- en whoisip {
		{Get the whois-info about given host. You can specify nick, host, IP-address, web-gate address or longIP.}
	}
	
	set_text -color -- en $_name #101	"Can't proccess given data into IP-address."
	set_text -color -- en $_name #102	"\00314WHOIS-info for:�\017\002%s\002. %s."
	set_text -color -- en $_name #103	"\00314IPv4 direct zone:�%s"
	set_text -color -- en $_name #104	"\00314IPv6 direct zone:�%s"
	set_text -color -- en $_name #105	"\00314Canon name:�\00312%s\017"
	set_text -color -- en $_name #106	"\00314Mail server:�\00312%s\017"
	set_text -color -- en $_name #107	"\00314Reverse zone:�\00312%s\017"
	set_text -color -- en $_name #108	"\00314NS-servers:�\00312%s\017"
	set_text -color -- en $_name #109	"\00314%s:�\00312%s\017"
	set_text -color -- en $_name #110	"\00303%s\017"
	set_text -color -- en $_name #111	"\00312%s\017"
	
	set_text en $_name #101	"Can't proccess given data into IP-address."
	set_text en $_name #102	"\002WHOIS-info for\002:�%s. %s."
	set_text en $_name #103	"\002IPv4 direct zone\002:�%s"
	set_text en $_name #104	"\002IPv6 direct zone\002:�%s"
	set_text en $_name #105	"\002Canon name\002:�%s"
	set_text en $_name #106	"\002Mail server\002:�%s"
	set_text en $_name #107	"\002Reverse zone\002:�%s"
	set_text en $_name #108	"\002NS-servers\002:�%s"
	set_text en $_name #109	"\002%s\002:�%s"
	set_text en $_name #110	"%s"
	set_text en $_name #111	"%s"
	
	set_text en $_name #112	"\00312Whois IPv4:�\017\002%s\002; \00312Range: \00303%s\017 (%s); \00312WebGate: \00303%s; \00312IPv4 in IPv6: \00303%s\017%s"
	set_text en $_name #113	"\00312Whois IPv6:�\017\002%s\002; \00312Range: \00303%s\017 (%s)%s"
	
	set_text -color -- en $_name #112	"\002Whois IPv4\002:�%s; \002Range\002: %s (%s); \002WebGate\002: %s; \002IPv4 in IPv6\002: %s%s"
	set_text -color -- en $_name #113	"\002Whois IPv6\002:�%s; \002Range\002: %s (%s)%s"
	
	set_text -color -- en $_name #netname		"\00312Network name:�\017%s"
	set_text -color -- en $_name #descr			"\00312descr:�\017%s"
	set_text -color -- en $_name #orgname		"\00312descr:�\017%s"
	set_text -color -- en $_name #country		"\00312Country:�\017%s"
	set_text -color -- en $_name #stateprov		"\00312State:�\017%s"
	set_text -color -- en $_name #postalcode	"\00312Postal code:�\017%s"
	set_text -color -- en $_name #city			"\00312City:�\017%s"
	set_text -color -- en $_name #mnt-by		"\00312mnt-by:�\017%s"
	set_text -color -- en $_name #person		"\00312Peron:�\017%s"
	set_text -color -- en $_name #orgtechname	"\00312Org. name:�\017%s"
	set_text -color -- en $_name #rtechname		"\00312Reg. name:�\017%s"
	set_text -color -- en $_name #address		"\00312Address:�\017%s"
	set_text -color -- en $_name #e-mail		"\00312E-mail:�\017%s"
	set_text -color -- en $_name #orgtechemail	"\00312 Org. email:�\017%s"
	set_text -color -- en $_name #rtechemail	"\00312Reg. email:�\017%s"
	set_text -color -- en $_name #phone			"\00312Phone:�\017%s"
	set_text -color -- en $_name #orgtechphone	"\00312Org. phone:�\017%s"
	set_text -color -- en $_name #rtechphone	"\00312Reg. phone:�\017%s"
	
	set_text en $_name #netname			"\002Network name\002:�%s"
	set_text en $_name #descr			"\002descr\002:�%s"
	set_text en $_name #orgname			"\002descr\002:�%s"
	set_text en $_name #country			"\002Country\002:�%s"
	set_text en $_name #stateprov		"\002State\002:�%s"
	set_text en $_name #postalcode		"\002Postal code\002:�%s"
	set_text en $_name #city			"\002City\002:�%s"
	set_text en $_name #mnt-by			"\002mnt-by\002:�%s"
	set_text en $_name #person			"\002Peron\002:�%s"
	set_text en $_name #orgtechname		"\002Org. name\002:�%s"
	set_text en $_name #rtechname		"\002Reg. name\002:�%s"
	set_text en $_name #address			"\002Address\002:�%s"
	set_text en $_name #e-mail			"\002E-mail\002:�%s"
	set_text en $_name #orgtechemail	"\002 Org. email\002:�%s"
	set_text en $_name #rtechemail		"\002Reg. email\002:�%s"
	set_text en $_name #phone			"\002Phone\002:�%s"
	set_text en $_name #orgtechphone	"\002Org. phone\002:�%s"
	set_text en $_name #rtechphone		"\002Reg. phone\002:�%s"
	
	setudef str ccs-mode-whoisip
	
	proc whoisip_dnslookup2 {token tokendns} {
		variable whoisipturn
		
		if {![info exists whoisipturn($token,on)]} return
		
		if {[dns::status $tokendns] == "ok"} {
			foreach _ [dns::address $tokendns] {
				lassign $_ a_type a_ip
				if {[lsearch $whoisipturn($token,address) [list $a_type $a_ip * * * * * *]] < 0} {
					lappend whoisipturn($token,address) [list $a_type $a_ip 0 0 "" "" "" [list]]
				}
			}
			foreach _ [dns::name $tokendns] {
				lassign $_ a_type a_ip
				if {[lsearch $whoisipturn($token,name) [list $a_type $a_ip]] < 0} {
					lappend whoisipturn($token,name) [list $a_type $a_ip]
				}
			}
		}
		
		dns::cleanup $tokendns
		
		set ind 0
		foreach _ $whoisipturn($token,dns_token) {
			lassign $_ a_tokendns a_reply
			if {$a_tokendns == $tokendns} {
				lset whoisipturn($token,dns_token) $ind 1 1
				break
			}
			incr ind
		}
		
		foreach _ $whoisipturn($token,address) {
			lassign $_ a_type a_ip a_request a_reply a_socket a_designation a_range a_info
			if {$a_request == 0} {
				whoisip_addwhois $token
				break
			}
		}
		
		whoisip_test_out $token
		
	}
	
	proc whoisip_dnslookup1 {ipaddr hostname status token tokendns} {
		variable whoisipturn
		
		if {![info exists whoisipturn($token,on)]} return
		
		if {$status} {
			if {[lsearch $whoisipturn($token,address) [list A $ipaddr * * * * * *]] < 0} {
				lappend whoisipturn($token,address) [list A $ipaddr 0 0 "" "" "" [list]]
			}
			if {[lsearch $whoisipturn($token,name) [list A $hostname]] < 0} {
				lappend whoisipturn($token,name) [list A $hostname]
			}
		}
		
		set ind 0
		foreach _ $whoisipturn($token,dns_token) {
			lassign $_ a_tokendns a_reply
			if {$a_tokendns == $tokendns} {
				lset whoisipturn($token,dns_token) $ind 1 1
				break
			}
			incr ind
		}
		
		foreach _ $whoisipturn($token,address) {
			lassign $_ a_type a_ip a_request a_reply a_socket a_designation a_range a_info
			if {$a_request == 0} {
				whoisip_addwhois $token
				break
			}
		}
		
		whoisip_test_out $token
		
	}
	
	proc whoisip_test_out {token} {
		variable whoisipturn
		
		set find 0
		foreach _ $whoisipturn($token,dns_token) {
			lassign $_ a_tokendns a_reply
			if {$a_reply == 0} {
				set find 1
				break
			}
		}
		if {!$find} {
			foreach _ $whoisipturn($token,address) {
				lassign $_ a_type a_ip a_request a_reply a_socket a_designation a_range a_info
				if {$a_reply == 0} {
					set find 1
					break
				}
			}
		}
		
		if {!$find} {whoisip_out $token}
		
	}
	
	proc whoisip_out {token} {
		variable whoisipturn
		variable options
		
		if {![info exists whoisipturn($token,on)]} return
		
		set array_out	$whoisipturn($token,array_out)
		set snick		$whoisipturn($token,snick)
		set shand		$whoisipturn($token,shand)
		set schan		$whoisipturn($token,schan)
		set command		$whoisipturn($token,command)
		set stext		$whoisipturn($token,stext)
		
		array set out $array_out
		
		set mode [get_mode $schan $command]
		
		if {[llength $whoisipturn($token,address)] == 0} {
			put_msg [sprintf whoisip #101]
		} else {
			
			set lout [list]
			foreach _ $whoisipturn($token,name) {
				lassign $_ a_type a_ip
				switch -exact -- $a_type {
					A - AAAA {lappend h($a_type) [sprintf whoisip #111 $a_ip]}
					default {lappend h($a_type) $a_ip}
				}
			}
			
			foreach _0 $whoisipturn($token,address) {
				lassign $_0 a_type a_ip a_request a_reply a_socket a_designation a_range a_info
				switch -exact -- $a_type {
					A - AAAA {lappend h($a_type) [sprintf whoisip #110 $a_ip]}
					default {lappend h($a_type) $a_ip}
				}
			}
			
			foreach a_type [lsort [array names h]] {
				switch -exact -- $a_type {
					A       { lappend lout [sprintf whoisip #103 [join $h($a_type) ", "]] }
					AAAA    { lappend lout [sprintf whoisip #104 [join $h($a_type) ", "]] }
					CNAME   { lappend lout [sprintf whoisip #105 [join $h($a_type) ", "]] }
					MX      { lappend lout [sprintf whoisip #106 [join $h($a_type) ", "]] }
					PTR     { lappend lout [sprintf whoisip #107 [join $h($a_type) ", "]] }
					NS      { lappend lout [sprintf whoisip #108 [join $h($a_type) ", "]] }
					default { lappend lout [sprintf whoisip #109 $a_type [join $h($a_type) ", "] }
				}
			}
			if {[info exists h]} {unset h}
			
			put_msg -type $mode -- [sprintf whoisip #102 $stext [join $lout "; "]]
			
			foreach _0 $whoisipturn($token,address) {
				lassign $_0 a_type a_ip a_request a_reply a_socket a_designation a_range a_info
				
				set last_info ""
				set last_text [list]
				set lout [list]
				
				foreach _ $a_info {
					if {[regexp -- {^([^\ ]+)\:(.*?)$} $_ -> a b]} {
						
						set a [string tolower $a]
						set b [string trimright [string trim $b] ,]
						
						if {$a == "inetnum" || $a == "netrange"} {
							set a_range $b
						}
						
						if {[lsearch -exact $options(whoisip_info) $a] < 0} {continue}
						
						if {$last_info != $a} {
							if {$last_info != ""} {
								lappend lout [sprintf whoisip #$last_info [join $last_text ", "]]
							}
							set last_text [list]
							set last_info $a
						}
						
						lappend last_text $b
						
					}
				}
				
				switch -exact -- $a_type {
					A {
						put_msg -type $mode -- [sprintf whoisip #112 $a_ip $a_range $a_designation [ip::ipv4_to_gate $a_ip] [ip::ipv4_to_ipv6 $a_ip] [expr {[llength $lout] > 0 ? "; [join $lout "; "]" : ""}]]
					}
					AAAA {
						
						lassign [split $a_range -] ipa ipb
						set ipa [string trim $ipa]
						set ipb [string trim $ipb]
						set a_range ""
						if {$ipa != ""} {append a_range "[ip::contract $ipa]"}
						if {$ipb != ""} {append a_range " - [ip::contract $ipb]"}
						
						put_msg -type $mode -- [sprintf whoisip #113 $a_ip $a_range $a_designation [expr {[llength $lout] > 0 ? "; [join $lout "; "]" : ""}]]
						
					}
				}
				
			}
		}
		
		after cancel $whoisipturn($token,afterid)
		
		foreach _ $whoisipturn($token,address) {
			lassign $_ a_type a_ip a_request a_reply a_socket a_designation a_range a_info
			if {$a_socket != ""} {
				catch {fileevent $a_socket readable {}}
				catch {fileevent $a_socket writable {}}
				catch {close $a_socket}
			}
		}
		
		foreach _ [array names whoisipturn -glob "$token,*"] {unset whoisipturn($_)}
		
		cleanup_token $token
		
	}
	
	proc cmd_whoisip {} {
		upvar out out
		importvars [list snick shand schan command stext]
		variable whoisipturn
		variable options
		
		if {[package versions [namespace current]::ip] == ""} {put_msg [sprintf whoisip #114 [namespace current]::ip ip]; return 0}
		if {[package versions [namespace current]::dns] == ""} {put_msg [sprintf whoisip #114 [namespace current]::dns dns]; return 0}
		
		set ip $stext
		set ip [string map [list , .] $ip]
		
		set token [get_token whoisip]
		
		set whoisipturn($token,on)			0
		set whoisipturn($token,array_out)	[array get out]
		set whoisipturn($token,snick)		$snick
		set whoisipturn($token,shand)		$shand
		set whoisipturn($token,schan)		$schan
		set whoisipturn($token,command)		$command
		set whoisipturn($token,stext)		$stext
		
		set whoisipturn($token,address)		[list]
		set whoisipturn($token,name)		[list]
		set whoisipturn($token,dns_token)	[list]
		
		set whoisipturn($token,afterid)		[after $options(whoisip_timeout) [list [namespace origin whoisip_out] $token]]
		
		if {[onchan $stext]} {
			set ip [getchanhost $stext]
			set whoisipturn($token,wnick) $stext
		}
		
		if {[set ind [string last @ $ip]] > 0} {
			set ip [string range $ip [expr $ind+1] end]
		}
		
		if {[ip::IPv4? $ip]} {
			lappend whoisipturn($token,address) [list A $ip 0 0 "" "" "" [list]]
			switch -exact -- $options(mode_dns_reply) {
				1 {
					lappend whoisipturn($token,dns_token) [list 1 0]
					dnslookup $ip [namespace origin whoisip_dnslookup1] $token 1
				}
				2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
			}
			whoisip_addwhois $token
		} elseif {[ip::IPv6? $ip]} {
			if {[ip::include 2002::/16 $ip]} {
				lappend whoisipturn($token,address) [list A [set ip [ip::ipv6_to_ipv4 $ip]] 0 0 "" "" "" [list]]
				switch -exact -- $options(mode_dns_reply) {
					1 {
						lappend whoisipturn($token,dns_token) [list 2 0]
						dnslookup $ip [namespace origin whoisip_dnslookup1] $token 2
					}
					2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
				}
				whoisip_addwhois $token
			} else {
				lappend whoisipturn($token,address) [list AAAA $ip 0 0 "" "" "" [list]]
				switch -exact -- $options(mode_dns_reply) {
					1 {}
					2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
				}
				whoisip_addwhois $token
			}
		} elseif {[ip::IPgate? $ip]} {
			lappend whoisipturn($token,address) [list A [set ip [ip::gate_to_ipv4 $ip]] 0 0 "" "" "" [list]]
			switch -exact -- $options(mode_dns_reply) {
				1 {
					lappend whoisipturn($token,dns_token) [list 3 0]
					dnslookup $ip [namespace origin whoisip_dnslookup1] $token 3
				}
				2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
			}
			whoisip_addwhois $token
		} elseif {[ip::IPlong? $ip]} {
			lappend whoisipturn($token,address) [list A [set ip [ip::longip_to_ipv4 $ip]] 0 0 "" "" "" [list]]
			switch -exact -- $options(mode_dns_reply) {
				1 {
					lappend whoisipturn($token,dns_token) [list 4 0]
					dnslookup $ip [namespace origin whoisip_dnslookup1] $token 4
				}
				2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
			}
			whoisip_addwhois $token
		} else {
			switch -exact -- $options(mode_dns_reply) {
				1 {
					lappend whoisipturn($token,dns_token) [list 5 0]
					dnslookup $ip [namespace origin whoisip_dnslookup1] $token 5
				}
				2 {
					lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type A -command "[namespace origin whoisip_dnslookup2] $token"] 0]
					lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type AAAA -command "[namespace origin whoisip_dnslookup2] $token"] 0]
					lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type MX -command "[namespace origin whoisip_dnslookup2] $token"] 0]
					lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type NS -command "[namespace origin whoisip_dnslookup2] $token"] 0]
				}
			}
		}
		
		put_log "$stext"
		return 1
		
	}
	
	proc whoisip_whois_read {token ind} {
		variable whoisipturn
		#putlog "whoisip_whois_read $token $ind"
		
		set s [lindex [lindex $whoisipturn($token,address) $ind] 4]
		
		if {![eof $s]} {
			set linfo [lindex [lindex $whoisipturn($token,address) $ind] 7]
			while {![eof $s]} {
				gets $s newdata
				if {[fblocked $s]} {break}
				lappend linfo $newdata
			}
			lset whoisipturn($token,address) $ind 7 $linfo
		} else {
			fileevent $s readable {}
			close $s
			lset whoisipturn($token,address) $ind 3 1
			lset whoisipturn($token,address) $ind 4 ""
			
			whoisip_test_out $token
		}
		
	}
	
	proc whoisip_whois_write {s ip} {
		variable whoisipturn
		#putlog "whoisip_whois_write $s $ip"
		
		puts $s $ip
		flush $s
		fconfigure $s -encoding binary -translation {auto binary}
		catch {fileevent $s writable {}}
		
	}
	
	proc whoisip_addwhois {token} {
		variable whoisipturn
		#putlog "whoisip_addwhois $token"
		
		set ind 0
		foreach _ $whoisipturn($token,address) {
			lassign $_ a_type a_ip a_request a_reply a_socket a_designation a_range a_info
			if {$a_request == 1} {incr ind; continue}
			set a_whois ""
			switch -exact -- $a_type {
				A {
					foreach {b_range b_designation b_whois} $ip::IPv4_address_space {
						if {[ip::include $b_range $a_ip]} {
							lset whoisipturn($token,address) $ind 5 [set a_designation $b_designation]
							lset whoisipturn($token,address) $ind 6 [set a_range $b_range]
							set a_whois $b_whois
							break
						}
					}
				}
				AAAA {
					foreach {b_range b_designation b_whois} $ip::IPv6_address_space {
						if {[ip::include $b_range $a_ip]} {
							lset whoisipturn($token,address) $ind 5 [set a_designation $b_designation]
							lset whoisipturn($token,address) $ind 6 [set a_range $b_range]
							set a_whois $b_whois
							break
						}
					}
				}
			}
			
			lset whoisipturn($token,address) $ind 2 1
			if {$a_whois != ""} {
				if {[set s [socket -async $a_whois 43]] != ""} {
					lset whoisipturn($token,address) $ind 4 $s
					fconfigure $s -blocking 0 -buffering line
					fileevent $s readable [list [namespace origin whoisip_whois_read] $token $ind]
					fileevent $s writable [list [namespace origin whoisip_whois_write] $s $a_ip]
				} else {
					lset whoisipturn($token,address) $ind 3 1
				}
			} else {
				lset whoisipturn($token,address) $ind 3 1
			}
			
			incr ind
		}
		
		whoisip_test_out $token
		
	}
	
	proc main_$_name {} {
		variable options
		
		if {[catch {
			package require [namespace current]::ip 2.0.0
		} errMsg]} {
			debug "Error package require [namespace current]::ip"
			debug "($errMsg)"
		}
		
		if {$options(mode_dns_reply) == 2} {
			if {[catch {
				package require [namespace current]::dns 1.0.0
			} errMsg]} {
				debug "Error package require [namespace current]::dns"
				debug "($errMsg)"
			}
			
			########################################################################################
			# ��������� DNS �������. ��������� ��������� ������ � ������ ������������� ����������
			# ccs.lib.dns.tcl. ������� ����������������� � ������ ������ ��������� ������ � ������
			# ���� �������� �� ��������� �� �������� �����������. ��� Unix ������ IP ����� NS
			# ������� ������������ �������������. ��������� DNS ������� �� �������� ������� ������
			# �� ��������� TCP, ��� ������� ���� �������� ������� ���������� ����� tcludp ��� ceptcl
			# ����� ����������  ��������� ������, DNS ������� ����� ������������� ������������
			# �������� UDP.
			# ����� tcludp ����� ������� http://sourceforge.net/project/showfiles.php?group_id=75201
			#dns::configure -nameserver 127.0.0.1
			#dns::configure -port 53
			#dns::configure -timeout 10000
			#dns::configure -protocol tcp
		}
		
	}
	
}

