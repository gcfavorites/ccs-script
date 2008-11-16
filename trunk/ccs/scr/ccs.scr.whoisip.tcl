if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set scrname		"whoisip"
addscr $scrname "Buster <buster@ircworld.ru> (c)" \
				"1.0.5" \
				"11-Nov-2008" \
				"Скрипт выдающий информацию по IP адресу"

if {$ccs(scr,name,$scrname)} {
	
	lappend ccs(scr_commands)	"whoisip"
	
	
	#############################################################################################################
	# Время в милисекундах в течении которого ожидать ответа.
	set ccs(whoisip_timeout) 10000
	
	#############################################################################################################
	# Список выводимой информации.
	set ccs(whoisip_info) {netname descr country mnt-by person address city stateprov postalcode e-mail phone}
	
	set ccs(whoisip_info_alias) {
		netrange inetnum
		orgtechemail e-mail
		orgtechphone phone
		orgtechname person
		orgname descr
	}
	
	set ccs(group,whoisip) "chan"
	set ccs(use_auth,whoisip) 0
	set ccs(use_chan,whoisip) 0
	set ccs(flags,whoisip) {-|-}
	set ccs(alias,whoisip) {%pref_whoisip}
	set ccs(block,whoisip) 5
	set ccs(regexp,whoisip) {{^([^\ ]+)$} {-> stext}}
	set ccs(use_botnet,whoisip) 0
	set ccs(use_mode,whoisip) 1
	
	set ccs(args,ru,whoisip) {<nick/host/ip/gate/longip>}
	set ccs(help,ru,whoisip) {Выяснить всю информацию о хосте.}
	set ccs(help2,ru,whoisip) {
		{Выяснить всю информацию о хосте.}
		{Возможно указание ника, хоста, IP адреса, веб гейта, длинного IP адреса.}
	}
	
	set ccs(text,whoisip,ru,#101) "Не удалось преобразовать данные в IP адрес."
	set ccs(text,whoisip,ru,#102) "Полученные данные по запросу: \002%s\002. IP: \002%s\002, host: \002%s\002, Gate: \002%s\002, LongIP: \002%s\002. Диапазон относится к \002%s\002. Подсеть \002%s\002."
	#set ccs(text,whoisip,ru,#inetnum) "\002Диапазон\002: %s"
	set ccs(text,whoisip,ru,#netname) "\002Имя сети\002: %s"
	set ccs(text,whoisip,ru,#descr) "\002descr\002: %s"
	set ccs(text,whoisip,ru,#country) "\002Страна\002: %s"
	set ccs(text,whoisip,ru,#stateprov) "\002Штат\002: %s"
	set ccs(text,whoisip,ru,#postalcode) "\002Почтовый код\002: %s"
	set ccs(text,whoisip,ru,#city) "\002Город\002: %s"
	set ccs(text,whoisip,ru,#mnt-by) "\002mnt-by\002: %s"
	set ccs(text,whoisip,ru,#person) "\002Лицо\002: %s"
	set ccs(text,whoisip,ru,#address) "\002Адрес\002: %s"
	set ccs(text,whoisip,ru,#e-mail) "\002E-mail\002: %s"
	set ccs(text,whoisip,ru,#phone) "\002Тел.\002: %s"
	
	#set ccs(text,whoisip,ru,#inetnum) "Диапазон: \00312%s\017"
	#set ccs(text,whoisip,ru,#descr) "descr: \00303%s\017"
	#set ccs(text,whoisip,ru,#country) "Страна: \00304%s\017"
	#set ccs(text,whoisip,ru,#mnt-by) "mnt-by: \00303%s\017"
	#set ccs(text,whoisip,ru,#person) "Лицо: \00306%s\017"
	#set ccs(text,whoisip,ru,#address) "Адрес: \00306%s\017"
	#set ccs(text,whoisip,ru,#e-mail) "E-mail: \00306%s\017"
	#set ccs(text,whoisip,ru,#phone) "Тел.: \00302%s\017"
	
	set ccs(ipv4_address_space) {
		{169.254/16} {Link Local} {}
		{172.16/12} {Private-Use Networks} {}
		{192.0.2/24} {Test-Net} {}
		{192.88.99/24} {6to4 Relay Anycast} {}
		{192.168/16} {Private-Use Networks} {}
		{198.18/15} {Network Interconnect Device Benchmark Testing} {}
		{000/8} {IANA - Local Identification} {}
		{001/8} {IANA} {}
		{002/8} {IANA} {}
		{003/8} {General Electric Company} {}
		{004/8} {Level 3 Communications, Inc.} {}
		{005/8} {IANA} {}
		{006/8} {Army Information Systems Center} {}
		{007/8} {Administered by ARIN} {whois.arin.net}
		{008/8} {Level 3 Communications, Inc.} {}
		{009/8} {IBM} {}
		{010/8} {IANA - Private Use} {}
		{011/8} {DoD Intel Information Systems} {}
		{012/8} {AT&T Bell Laboratories} {}
		{013/8} {Xerox Corporation} {}
		{014/8} {IANA} {}
		{015/8} {Hewlett-Packard Company} {}
		{016/8} {Digital Equipment Corporation} {}
		{017/8} {Apple Computer Inc.} {}
		{018/8} {MIT} {}
		{019/8} {Ford Motor Company} {}
		{020/8} {Computer Sciences Corporation} {}
		{021/8} {DDN-RVN} {}
		{022/8} {Defense Information Systems Agency} {}
		{023/8} {IANA} {}
		{024/8} {ARIN} {whois.arin.net}
		{025/8} {UK Ministry of Defence} {}
		{026/8} {Defense Information Systems Agency} {}
		{027/8} {IANA} {}
		{028/8} {DSI-North} {}
		{029/8} {Defense Information Systems Agency} {}
		{030/8} {Defense Information Systems Agency} {}
		{031/8} {IANA} {}
		{032/8} {AT&T Global Network Services} {}
		{033/8} {DLA Systems Automation Center} {}
		{034/8} {Halliburton Company} {}
		{035/8} {MERIT Computer Network} {}
		{036/8} {IANA} {}
		{037/8} {IANA} {}
		{038/8} {Performance Systems International} {}
		{039/8} {IANA} {}
		{040/8} {Eli Lily & Company} {}
		{041/8} {AfriNIC} {whois.afrinic.net}
		{042/8} {IANA} {}
		{043/8} {Japan Inet} {}
		{044/8} {Amateur Radio Digital Communications} {}
		{045/8} {Interop Show Network} {}
		{046/8} {IANA} {}
		{047/8} {Bell-Northern Research} {}
		{048/8} {Prudential Securities Inc.} {}
		{049/8} {IANA} {}
		{050/8} {IANA} {}
		{051/8} {Deparment of Social Security of UK} {}
		{052/8} {E.I. duPont de Nemours and Co., Inc.} {}
		{053/8} {Cap Debis CCS} {}
		{054/8} {Merck and Co., Inc.} {}
		{055/8} {DoD Network Information Center} {}
		{056/8} {US Postal Service} {}
		{057/8} {SITA} {}
		{058/8} {APNIC} {whois.apnic.net}
		{059/8} {APNIC} {whois.apnic.net}
		{060/8} {APNIC} {whois.apnic.net}
		{061/8} {APNIC} {whois.apnic.net}
		{062/8} {RIPE NCC} {whois.ripe.net}
		{063/8} {ARIN} {whois.arin.net}
		{064/8} {ARIN} {whois.arin.net}
		{065/8} {ARIN} {whois.arin.net}
		{066/8} {ARIN} {whois.arin.net}
		{067/8} {ARIN} {whois.arin.net}
		{068/8} {ARIN} {whois.arin.net}
		{069/8} {ARIN} {whois.arin.net}
		{070/8} {ARIN} {whois.arin.net}
		{071/8} {ARIN} {whois.arin.net}
		{072/8} {ARIN} {whois.arin.net}
		{073/8} {ARIN} {whois.arin.net}
		{074/8} {ARIN} {whois.arin.net}
		{075/8} {ARIN} {whois.arin.net}
		{076/8} {ARIN} {whois.arin.net}
		{077/8} {RIPE NCC} {whois.ripe.net}
		{078/8} {RIPE NCC} {whois.ripe.net}
		{079/8} {RIPE NCC} {whois.ripe.net}
		{080/8} {RIPE NCC} {whois.ripe.net}
		{081/8} {RIPE NCC} {whois.ripe.net}
		{082/8} {RIPE NCC} {whois.ripe.net}
		{083/8} {RIPE NCC} {whois.ripe.net}
		{084/8} {RIPE NCC} {whois.ripe.net}
		{085/8} {RIPE NCC} {whois.ripe.net}
		{086/8} {RIPE NCC} {whois.ripe.net}
		{087/8} {RIPE NCC} {whois.ripe.net}
		{088/8} {RIPE NCC} {whois.ripe.net}
		{089/8} {RIPE NCC} {whois.ripe.net}
		{090/8} {RIPE NCC} {whois.ripe.net}
		{091/8} {RIPE NCC} {whois.ripe.net}
		{092/8} {RIPE NCC} {whois.ripe.net}
		{093/8} {RIPE NCC} {whois.ripe.net}
		{094/8} {RIPE NCC} {whois.ripe.net}
		{095/8} {RIPE NCC} {whois.ripe.net}
		{096/8} {ARIN} {whois.arin.net}
		{097/8} {ARIN} {whois.arin.net}
		{098/8} {ARIN} {whois.arin.net}
		{099/8} {ARIN} {whois.arin.net}
		{100/4} {IANA} {}
		{101/8} {IANA} {}
		{102/8} {IANA} {}
		{103/8} {IANA} {}
		{104/8} {IANA} {}
		{105/8} {IANA} {}
		{106/8} {IANA} {}
		{107/8} {IANA} {}
		{108/8} {IANA} {}
		{109/8} {IANA} {}
		{110/8} {IANA} {}
		{111/8} {IANA} {}
		{112/8} {APNIC} {whois.apnic.net}
		{113/8} {APNIC} {whois.apnic.net}
		{114/8} {APNIC} {whois.apnic.net}
		{115/8} {APNIC} {whois.apnic.net}
		{116/8} {APNIC} {whois.apnic.net}
		{117/8} {APNIC} {whois.apnic.net}
		{118/8} {APNIC} {whois.apnic.net}
		{119/8} {APNIC} {whois.apnic.net}
		{120/8} {APNIC} {whois.apnic.net}
		{121/8} {APNIC} {whois.apnic.net}
		{122/8} {APNIC} {whois.apnic.net}
		{123/8} {APNIC} {whois.apnic.net}
		{124/8} {APNIC} {whois.apnic.net}
		{125/8} {APNIC} {whois.apnic.net}
		{126/8} {APNIC} {whois.apnic.net}
		{127/8} {IANA - Loopback} {}
		{128/8} {Administered by ARIN} {whois.arin.net}
		{129/8} {Administered by ARIN} {whois.arin.net}
		{130/8} {Administered by ARIN} {whois.arin.net}
		{131/8} {Administered by ARIN} {whois.arin.net}
		{132/8} {Administered by ARIN} {whois.arin.net}
		{133/8} {Administered by APNIC} {whois.apnic.net}
		{134/8} {Administered by ARIN} {whois.arin.net}
		{135/8} {Administered by ARIN} {whois.arin.net}
		{136/8} {Administered by ARIN} {whois.arin.net}
		{137/8} {Administered by ARIN} {whois.arin.net}
		{138/8} {Administered by ARIN} {whois.arin.net}
		{139/8} {Administered by ARIN} {whois.arin.net}
		{140/8} {Administered by ARIN} {whois.arin.net}
		{141/8} {Administered by RIPE NCC} {whois.ripe.net}
		{142/8} {Administered by ARIN} {whois.arin.net}
		{143/8} {Administered by ARIN} {whois.arin.net}
		{144/8} {Administered by ARIN} {whois.arin.net}
		{145/8} {Administered by RIPE NCC} {whois.ripe.net}
		{146/8} {Administered by ARIN} {whois.arin.net}
		{147/8} {Administered by ARIN} {whois.arin.net}
		{148/8} {Administered by ARIN} {whois.arin.net}
		{149/8} {Administered by ARIN} {whois.arin.net}
		{150/8} {Administered by APNIC} {whois.apnic.net}
		{151/8} {Administered by RIPE NCC} {whois.ripe.net}
		{152/8} {Administered by ARIN} {whois.arin.net}
		{153/8} {Administered by APNIC} {whois.apnic.net}
		{154/8} {Administered by AfriNIC} {whois.afrinic.net}
		{155/8} {Administered by ARIN} {whois.arin.net}
		{156/8} {Administered by ARIN} {whois.arin.net}
		{157/8} {Administered by ARIN} {whois.arin.net}
		{158/8} {Administered by ARIN} {whois.arin.net}
		{159/8} {Administered by ARIN} {whois.arin.net}
		{160/8} {Administered by ARIN} {whois.arin.net}
		{161/8} {Administered by ARIN} {whois.arin.net}
		{162/8} {Administered by ARIN} {whois.arin.net}
		{163/8} {Administered by APNIC} {whois.apnic.net}
		{164/8} {Administered by ARIN} {whois.arin.net}
		{165/8} {Administered by ARIN} {whois.arin.net}
		{166/8} {Administered by ARIN} {whois.arin.net}
		{167/8} {Administered by ARIN} {whois.arin.net}
		{168/8} {Administered by ARIN} {whois.arin.net}
		{169/8} {Administered by ARIN} {whois.arin.net}
		{170/8} {Administered by ARIN} {whois.arin.net}
		{171/8} {Administered by APNIC} {whois.apnic.net}
		{172/8} {Administered by ARIN} {whois.arin.net}
		{173/8} {ARIN} {whois.arin.net}
		{174/8} {ARIN} {whois.arin.net}
		{175/8} {IANA} {}
		{176/8} {IANA} {}
		{177/8} {IANA} {}
		{178/8} {IANA} {}
		{179/8} {IANA} {}
		{180/8} {IANA} {}
		{181/8} {IANA} {}
		{182/8} {IANA} {}
		{183/8} {IANA} {}
		{184/8} {IANA} {}
		{185/8} {IANA} {}
		{186/8} {LACNIC} {whois.lacnic.net}
		{187/8} {LACNIC} {whois.lacnic.net}
		{188/8} {Administered by RIPE NCC} {whois.ripe.net}
		{189/8} {LACNIC} {whois.lacnic.net}
		{190/8} {LACNIC} {whois.lacnic.net}
		{191/8} {Administered by LACNIC} {whois.lacnic.net}
		{192/8} {Administered by ARIN} {whois.arin.net}
		{193/8} {RIPE NCC} {whois.ripe.net}
		{194/8} {RIPE NCC} {whois.ripe.net}
		{195/8} {RIPE NCC} {whois.ripe.net}
		{196/8} {Administered by AfriNIC} {whois.afrinic.net}
		{197/8} {AfriNIC} {whois.afrinic.net}
		{198/8} {Administered by ARIN} {whois.arin.net}
		{199/8} {ARIN} {whois.arin.net}
		{200/8} {LACNIC} {whois.lacnic.net}
		{201/8} {LACNIC} {whois.lacnic.net}
		{202/8} {APNIC} {whois.apnic.net}
		{203/8} {APNIC} {whois.apnic.net}
		{204/8} {ARIN} {whois.arin.net}
		{205/8} {ARIN} {whois.arin.net}
		{206/8} {ARIN} {whois.arin.net}
		{207/8} {ARIN} {whois.arin.net}
		{208/8} {ARIN} {whois.arin.net}
		{209/8} {ARIN} {whois.arin.net}
		{210/8} {APNIC} {whois.apnic.net}
		{211/8} {APNIC} {whois.apnic.net}
		{212/8} {RIPE NCC} {whois.ripe.net}
		{213/8} {RIPE NCC} {whois.ripe.net}
		{214/8} {US-DOD} {}
		{215/8} {US-DOD} {}
		{216/8} {ARIN} {whois.arin.net}
		{217/8} {RIPE NCC} {whois.ripe.net}
		{218/8} {APNIC} {whois.apnic.net}
		{219/8} {APNIC} {whois.apnic.net}
		{220/8} {APNIC} {whois.apnic.net}
		{221/8} {APNIC} {whois.apnic.net}
		{222/8} {APNIC} {whois.apnic.net}
		{223/8} {IANA} {}
		{224/4} {Multicast} {}
		{240/4} {Future use} {}
	}
	
	setudef str ccs-mode-whoisip
	
	proc whoisip_dnslookup {ipaddr hostname status token} {
		variable whoisipturn
		
		if {![info exists whoisipturn($token,on)]} return
		
		set whoisipturn($token,dns) 1
		if {$status} {
			set whoisipturn($token,wip)		$ipaddr
			set whoisipturn($token,whost)	$hostname
			if {!$whoisipturn($token,addwhois)} {whoisip_addwhois $token}
		}
		if {$whoisipturn($token,whois) || (!$status && $whoisipturn($token,wip) == "")} {whoisip_out $token}
		
	}
	
	proc whoisip_out {token} {
		variable whoisipturn
		variable ccs
		
		if {![info exists whoisipturn($token,on)]} return
		
		if {$whoisipturn($token,wgate) == ""} {
			set whoisipturn($token,wgate) [ip2gate $whoisipturn($token,wip)]
		}
		if {$whoisipturn($token,wlongip) == ""} {
			set whoisipturn($token,wlongip) [ip2longip $whoisipturn($token,wip)]
		}
		
		set onick $whoisipturn($token,onick)
		set ochan $whoisipturn($token,ochan)
		set obot $whoisipturn($token,obot)
		set snick $whoisipturn($token,snick)
		set shand $whoisipturn($token,shand)
		set schan $whoisipturn($token,schan)
		set command $whoisipturn($token,command)
		set stext $whoisipturn($token,stext)
		
		if {$whoisipturn($token,wip) == ""} {
			put_msg [sprintf whoisip #101]
		} else {
			set mode [get_use_mode $schan $command]
			
			set last_info ""
			set last_text [list]
			set lout [list]
			
			foreach _ $whoisipturn($token,winfo) {
				if {[regexp -- {^([^\ ]+)\:(.*?)$} $_ -> a b]} {
					set a [string tolower $a]
					set a [string map $ccs(whoisip_info_alias) $a]
					
					set b [string trim $b]
					set b [string trimright $b ,]
					
					if {$a == "inetnum" || $a == "netrange"} {
						set whoisipturn($token,range) $b
					}
					
					if {[lsearch_equal $ccs(whoisip_info) $a] < 0} {continue}
					
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
			if {$last_info != ""} {
				lappend lout [sprintf whoisip #$last_info [join $last_text ", "]]
			}
			
			put_msg [sprintf whoisip #102 $stext $whoisipturn($token,wip) $whoisipturn($token,whost) $whoisipturn($token,wgate) $whoisipturn($token,wlongip) $whoisipturn($token,wdesignation) $whoisipturn($token,range)] -mode $mode
			put_msg [join $lout "; "] -mode $mode
			
		}
		
		after cancel $whoisipturn($token,afterid)
		
		unset whoisipturn($token,on) whoisipturn($token,onick) whoisipturn($token,ochan) whoisipturn($token,obot) whoisipturn($token,snick) whoisipturn($token,shand) whoisipturn($token,schan) whoisipturn($token,command) whoisipturn($token,stext) whoisipturn($token,wip) whoisipturn($token,wgate) whoisipturn($token,whost) whoisipturn($token,dns) whoisipturn($token,whois) whoisipturn($token,addwhois) whoisipturn($token,winfo) whoisipturn($token,wlongip) whoisipturn($token,wdesignation) whoisipturn($token,range)
		
		clear_token whoisip $token
		
	}
	
	proc cmd_whoisip {} {
		importvars [list onick ochan obot snick shand schan command stext]
		variable whoisipturn
		variable ccs
		
		set ip $stext
		
		set ip [string map [list , .] $ip]
		
		set token [get_token whoisip]
		
		set whoisipturn($token,on)				0
		set whoisipturn($token,onick)			$onick
		set whoisipturn($token,ochan)			$ochan
		set whoisipturn($token,obot)			$obot
		set whoisipturn($token,snick)			$snick
		set whoisipturn($token,shand)			$shand
		set whoisipturn($token,schan)			$schan
		set whoisipturn($token,command)			$command
		set whoisipturn($token,stext)			$stext
		set whoisipturn($token,wip)				""
		set whoisipturn($token,wgate)			""
		set whoisipturn($token,whost)			""
		set whoisipturn($token,wlongip)			""
		set whoisipturn($token,wdesignation)	""
		set whoisipturn($token,winfo)			[list]
		set whoisipturn($token,dns)				0
		set whoisipturn($token,whois)			0
		set whoisipturn($token,addwhois)		0
		set whoisipturn($token,range)			""
		
		set whoisipturn($token,afterid) [after $ccs(whoisip_timeout) [list [namespace origin whoisip_out] $token]]
		
		if {[onchan $stext]} {
			set ip [getchanhost $stext]
			set whoisipturn($token,wnick) $stext
		}
		
		if {[set ind [string last @ $ip]] > 0} {
			set ip [string range $ip [expr $ind+1] end]
		}
		
		if {[string_is_ip $ip]} {
			set whoisipturn($token,wip)		$ip
		} elseif {[set gateip [gate2ip $ip]] != ""} {
			set whoisipturn($token,wgate)	$ip
			set ip $gateip
			set whoisipturn($token,wip)		$ip
		} elseif {[string is digit $ip] && $ip < 4294967296} {
			set whoisipturn($token,wlongip)	$ip
			set ip [longip2ip $ip]
			set whoisipturn($token,wip)		$ip
		} else {
			set whoisipturn($token,whost)	$ip
		}
		
		if {$whoisipturn($token,wip) != ""} {whoisip_addwhois $token}
		
		dnslookup $ip [namespace origin whoisip_dnslookup] $token
		
		return 1
		
	}
	
	proc whoisip_whois_read {token} {
		variable whoisipturn
		
		set s $whoisipturn($token,socket)
		
		if {![eof $s]} {
			while {![eof $s]} {
				gets $s newdata
				if {[fblocked $s]} {break}
				lappend whoisipturn($token,winfo) $newdata
			}
		} else {
			fileevent $s readable {}
			close $s
			set whoisipturn($token,whois) 1
			if {$whoisipturn($token,dns)} {whoisip_out $token}
		}
		
	}
	
	proc whoisip_whois_write {token} {
		variable whoisipturn
		
		set s $whoisipturn($token,socket)
		
		puts $s $whoisipturn($token,wip)
		flush $s
		fconfigure $s -encoding binary -translation {auto binary}
		catch {fileevent $s writable {}}
		
	}
	
	proc whoisip_addwhois {token} {
		variable whoisipturn
		variable ccs
		
		set whoisipturn($token,addwhois) 1
		
		set find 0
		foreach {netmask designation whois} $ccs(ipv4_address_space) {
			if {[ip_in_net $netmask $whoisipturn($token,wip)]} {
				set whoisipturn($token,wdesignation) $designation
				set whoisipturn($token,range) $netmask
				set find 1
				break
			}
		}
		
		if {$find && $whois != ""} {
			set s [socket -async $whois 43]
			set whoisipturn($token,socket) $s
			if {$s != ""} {
				fconfigure $s -blocking 0 -buffering line
				fileevent $s readable [list [namespace origin whoisip_whois_read] $token]
				fileevent $s writable [list [namespace origin whoisip_whois_write] $token]
			} else {
				set whoisipturn($token,whois) 1
			}
		} else {
			set whoisipturn($token,whois) 1
		}
		
	}
	
	proc gate2ip {text} {
		
		if {[string index $text 0] == "~"} {
			set text [string range $text 1 end]
		}
		if {[string length $text] != 8} {return ""}
		set ip [longip2ip [scan $text "%x"]]
		if {[string_is_ip $ip]} {
			return $ip
		} else {
			return ""
		}
		
	}
	
	proc ip2gate {ipaddr} {
		
		if {$ipaddr == ""} {return ""}
		foreach {a b c d} [split $ipaddr .] break
		return [format "%08x" [expr {($a << 24) + ($b << 16) + ($c << 8) + $d}]]
		
	}
	
	proc string_is_ip {text} {
		
		set ld [split $text .]
		if {[llength $ld] != 4} {return 0}
		foreach _ $ld {
			if {![string is digit $_]} {return 0}
			if {$_ < 0 || $_ > 255} {return 0}
		}
		return 1
		
	}
	
	proc ip2longip {ipaddr} {
		
		if {$ipaddr == ""} {return -1}
		foreach {a b c d} [split $ipaddr .] break
		foreach _ {a b c d} {
			set $_ [string trimleft [set $_] 0]
			if {[set $_] == ""} {set $_ 0}
			append hexaddr [format {%02x} [set $_]]
		}
		return [format {%u} "0x$hexaddr"]
		
	}
	
	proc longip2ip {longip} {
		return [expr {$longip >> 24 & 0xFF}].[expr {$longip >> 16 & 0xFF}].[expr {$longip >> 8 & 0xFF}].[expr {$longip & 0xFF}]
	}
	
	proc ip_in_net {netmask ip} {
		
		foreach {net mask} [split $netmask /] break
		
		if {$mask == "" || $mask > 32} {set mask 32}
		
		set longipnet [ip2longip $net]
		set longip [ip2longip $ip]
		if {$longip >= $longipnet && $longip < [expr $longipnet + pow(2,(32-$mask))]} {return 1}
		return 0
		
	}
	
}

