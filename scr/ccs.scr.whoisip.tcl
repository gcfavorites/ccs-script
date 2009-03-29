
## Скрипт получения информации об IP адресе (script that allows you to get info about specified host/IP)
##################################################################################################################
# Список последних изменений (changelog):
#	v1.2.1
# - Добавлена поддержка старого модуля eggdrop для DNS запросов.
# - Добавлена черно белая цветовая раскраска.
#	v1.2.0
# - Интегрирована поддержка библиотеки DNS.
# - Улучшена работа с запросами IPv6. Разрешение прямой и обратной зоны для хостов.
# - В качестве дополнительной информации выводятся NS, MX, CNAME записи.
#	v1.1.3
# - English translation
# - Заменена функция lsearch_equal
#	v1.1.2
# - Добавлена поддержка IPv6 (added IPv6 support, TCL 8.5 required)
# - Часть функций перенесена в библиотеку ip (most of functions was moved to ip lib)

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set scrname		"whoisip"
addfileinfo scr $scrname "Buster <buster@buster-net.ru> (c)" \
				"1.2.1" \
				"29-Mar-2009" \
				"Скрипт выдающий информацию по IP адресу"

if {$ccs(scr,name,$scrname)} {
	
	package require [namespace current]::ip 2.0.0
	
	lappend ccs(scr_commands)	"whoisip"
	
	#############################################################################################################
	# Время в милисекундах в течении которого ожидать ответа.
	# Request timeout (period within we should wait for answer)
	set ccs(whoisip_timeout)	20000
	
	#############################################################################################################
	# Список выводимой информации.
	# Output info entries.
	set ccs(whoisip_info)		{netname descr country person address city stateprov postalcode e-mail orgtechemail phone orgtechphone orgtechname orgname rtechname rtechemail rtechphone}
	
	#############################################################################################################
	# Метод получения DNS запросов. 
	# 1 - используя модуль бота DNS (dns.so), при этом будут не доступны некоторые функции, такие как: полная
	#     поддержка IPv6, получение записей NS серверов, MX записи, каноническое имя;
	# 2 - используя библиотеку ccs.lib.dns.tcl, для её работы необходимо чтобы DNS сервер принимал запросы по
	#     протоколу TCP, либо потребуется установка пакета обрабатывающего UDP запросы.
	set ccs(mode_dns_reply)		2
	
	#############################################################################################################
	# Загрузка библиотеки dns. _НЕ ИЗМЕНЯТЬ_
	if {[info exists ccs(mode_dns_reply)] && $ccs(mode_dns_reply) == 2} {package require [namespace current]::dns 1.0.0}
	
	#############################################################################################################
	# Параметры DNS сервера. Требуется настройки только в случае использования библиотеки ccs.lib.dns.tcl.
	# Следует раскомментировать и внести нужные параметры только в случае если значения по умолчанию не являются
	# корректными. Для Unix систем IP адрес NS сервера определяется автоматически. Некоторые DNS сервера не
	# способны принять запрос по протоколу TCP, для решения этой проблемы следует установить пакет tcludp
	# или ceptcl. После корректной установки пакета, DNS запросы будет автоматически использовать протокол UDP.
	# Пакет tcludp можно скачать с http://sourceforge.net/project/showfiles.php?group_id=75201
	#dns::configure -nameserver 127.0.0.1
	#dns::configure -port 53
	#dns::configure -timeout 10000
	#dns::configure -protocol tcp
	
	set ccs(group,whoisip)		"info"
	set ccs(use_auth,whoisip)	0
	set ccs(use_chan,whoisip)	0
	set ccs(flags,whoisip)		{-|-}
	set ccs(alias,whoisip)		{%pref_whoisip}
	set ccs(block,whoisip)		5
	set ccs(regexp,whoisip)		{{^([^\ ]+)$} {-> stext}}
	set ccs(use_botnet,whoisip)	0
	set ccs(use_mode,whoisip)	1
	
	set ccs(args,ru,whoisip)	{<nick/host/ip/gate/longip>}
	set ccs(help,ru,whoisip)	{Выяснить всю информацию о хосте}
	set ccs(help,en,whoisip)	{Get info about specified host}
	set ccs(help2,ru,whoisip)	{
		{Выяснить всю информацию о хосте. Возможно указание ника, хоста, IP адреса, веб гейта, длинного IP адреса.}
	}
	set ccs(help2,en,whoisip)	{
		{Get the whois-info about given host. You can specify nick, host, IP-address, web-gate address or longIP.}
	}
	
	set ccs(text,whoisip,ru,#101)	"Не удалось преобразовать данные в IP адрес."
	set ccs(text,whoisip,ru,#102)	"\00314Полученные данные по запросу: \017\002%s\002. %s."
	set ccs(text,whoisip,ru,#103)	"\00314Прямая зона IPv4: %s"
	set ccs(text,whoisip,ru,#104)	"\00314Прямая зона IPv6: %s"
	set ccs(text,whoisip,ru,#105)	"\00314Каноническое имя: %s"
	set ccs(text,whoisip,ru,#106)	"\00314Почтовый сервер: \00312%s\017"
	set ccs(text,whoisip,ru,#107)	"\00314Обратная зона: \00312%s\017"
	set ccs(text,whoisip,ru,#108)	"\00314NS сервера: \00312%s\017"
	set ccs(text,whoisip,ru,#109)	"\00314%s: \00312%s\017"
	set ccs(text,whoisip,ru,#110)	"\00303%s\017"
	set ccs(text,whoisip,ru,#111)	"\00312%s\017"
	
	set ccs(bwtext,whoisip,ru,#101)	"Не удалось преобразовать данные в IP адрес."
	set ccs(bwtext,whoisip,ru,#102)	"Полученные данные по запросу: \002%s\002. %s."
	set ccs(bwtext,whoisip,ru,#103)	"\002Прямая зона IPv4\002: %s"
	set ccs(bwtext,whoisip,ru,#104)	"\002Прямая зона IPv6\002: %s"
	set ccs(bwtext,whoisip,ru,#105)	"\002Каноническое имя\002: %s"
	set ccs(bwtext,whoisip,ru,#106)	"\002Почтовый сервер\002: %s"
	set ccs(bwtext,whoisip,ru,#107)	"\002Обратная зона\002: %s"
	set ccs(bwtext,whoisip,ru,#108)	"\002NS сервера\002: %s"
	set ccs(bwtext,whoisip,ru,#109)	"\002%s\002: %s"
	set ccs(bwtext,whoisip,ru,#110)	"%s"
	set ccs(bwtext,whoisip,ru,#111)	"%s"
	
	set ccs(text,whoisip,ru,#112)	"\00312Whois IPv4: \017\002%s\002; \00312Range: \00303%s\017 (%s); \00312WebGate: \00303%s; \00312IPv4 in IPv6: \00303%s\017%s"
	set ccs(text,whoisip,ru,#113)	"\00312Whois IPv6: \017\002%s\002; \00312Range: \00303%s\017 (%s)%s"
	
	set ccs(bwtext,whoisip,ru,#112)	"\002Whois IPv4\002: %s; \002Range\002: %s (%s); \002WebGate\002: %s; \002IPv4 in IPv6\002: %s%s"
	set ccs(bwtext,whoisip,ru,#113)	"\002Whois IPv6\002: %s; \002Range\002: %s (%s)%s"
	
	set ccs(text,whoisip,ru,#netname)		"\00312Имя сети: \017%s"
	set ccs(text,whoisip,ru,#descr)			"\00312descr: \017%s"
	set ccs(text,whoisip,ru,#orgname)		"\00312descr: \017%s"
	set ccs(text,whoisip,ru,#country)		"\00312Страна: \017%s"
	set ccs(text,whoisip,ru,#stateprov)		"\00312Штат: \017%s"
	set ccs(text,whoisip,ru,#postalcode)	"\00312Почтовый код: \017%s"
	set ccs(text,whoisip,ru,#city)			"\00312Город: \017%s"
	set ccs(text,whoisip,ru,#mnt-by)		"\00312mnt-by: \017%s"
	set ccs(text,whoisip,ru,#person)		"\00312Лицо: \017%s"
	set ccs(text,whoisip,ru,#orgtechname)	"\00312Лицо: \017%s"
	set ccs(text,whoisip,ru,#rtechname)		"\00312Лицо: \017%s"
	set ccs(text,whoisip,ru,#address)		"\00312Адрес: \017%s"
	set ccs(text,whoisip,ru,#e-mail)		"\00312E-mail: \017%s"
	set ccs(text,whoisip,ru,#orgtechemail)	"\00312E-mail: \017%s"
	set ccs(text,whoisip,ru,#rtechemail)	"\00312E-mail: \017%s"
	set ccs(text,whoisip,ru,#phone)			"\00312Тел.: \017%s"
	set ccs(text,whoisip,ru,#orgtechphone)	"\00312Тел.: \017%s"
	set ccs(text,whoisip,ru,#rtechphone)	"\00312Тел.: \017%s"
	
	set ccs(bwtext,whoisip,ru,#netname)			"\002Имя сети\002: %s"
	set ccs(bwtext,whoisip,ru,#descr)			"\002descr\002: %s"
	set ccs(bwtext,whoisip,ru,#orgname)			"\002descr\002: %s"
	set ccs(bwtext,whoisip,ru,#country)			"\002Страна\002: %s"
	set ccs(bwtext,whoisip,ru,#stateprov)		"\002Штат\002: %s"
	set ccs(bwtext,whoisip,ru,#postalcode)		"\002Почтовый код\002: %s"
	set ccs(bwtext,whoisip,ru,#city)			"\002Город\002: %s"
	set ccs(bwtext,whoisip,ru,#mnt-by)			"\002mnt-by\002: %s"
	set ccs(bwtext,whoisip,ru,#person)			"\002Лицо\002: %s"
	set ccs(bwtext,whoisip,ru,#orgtechname)		"\002Лицо\002: %s"
	set ccs(bwtext,whoisip,ru,#rtechname)		"\002Лицо\002: %s"
	set ccs(bwtext,whoisip,ru,#address)			"\002Адрес\002: %s"
	set ccs(bwtext,whoisip,ru,#e-mail)			"\002E-mail\002: %s"
	set ccs(bwtext,whoisip,ru,#orgtechemail)	"\002E-mail\002: %s"
	set ccs(bwtext,whoisip,ru,#rtechemail)		"\002E-mail\002: %s"
	set ccs(bwtext,whoisip,ru,#phone)			"\002Тел.\002: %s"
	set ccs(bwtext,whoisip,ru,#orgtechphone)	"\002Тел.\002: %s"
	set ccs(bwtext,whoisip,ru,#rtechphone)		"\002Тел.\002: %s"
	
	set ccs(text,whoisip,en,#101)	"Can't proccess given data into IP-address."
	set ccs(text,whoisip,en,#102)	"\00314WHOIS-info for: \017\002%s\002. %s."
	set ccs(text,whoisip,en,#103)	"\00314IPv4 direct zone: %s"
	set ccs(text,whoisip,en,#104)	"\00314IPv6 direct zone: %s"
	set ccs(text,whoisip,en,#105)	"\00314Canon name: \00312%s\017"
	set ccs(text,whoisip,en,#106)	"\00314Mail server: \00312%s\017"
	set ccs(text,whoisip,en,#107)	"\00314Reverse zone: \00312%s\017"
	set ccs(text,whoisip,en,#108)	"\00314NS-servers: \00312%s\017"
	set ccs(text,whoisip,en,#109)	"\00314%s: \00312%s\017"
	set ccs(text,whoisip,en,#110)	"\00303%s\017"
	set ccs(text,whoisip,en,#111)	"\00312%s\017"
	
	set ccs(bwtext,whoisip,en,#101)	"Can't proccess given data into IP-address."
	set ccs(bwtext,whoisip,en,#102)	"\002WHOIS-info for\002: %s. %s."
	set ccs(bwtext,whoisip,en,#103)	"\002IPv4 direct zone\002: %s"
	set ccs(bwtext,whoisip,en,#104)	"\002IPv6 direct zone\002: %s"
	set ccs(bwtext,whoisip,en,#105)	"\002Canon name\002: %s"
	set ccs(bwtext,whoisip,en,#106)	"\002Mail server\002: %s"
	set ccs(bwtext,whoisip,en,#107)	"\002Reverse zone\002: %s"
	set ccs(bwtext,whoisip,en,#108)	"\002NS-servers\002: %s"
	set ccs(bwtext,whoisip,en,#109)	"\002%s\002: %s"
	set ccs(bwtext,whoisip,en,#110)	"%s"
	set ccs(bwtext,whoisip,en,#111)	"%s"
	
	set ccs(text,whoisip,en,#112)	"\00312Whois IPv4: \017\002%s\002; \00312Range: \00303%s\017 (%s); \00312WebGate: \00303%s; \00312IPv4 in IPv6: \00303%s\017%s"
	set ccs(text,whoisip,en,#113)	"\00312Whois IPv6: \017\002%s\002; \00312Range: \00303%s\017 (%s)%s"
	
	set ccs(bwtext,whoisip,en,#112)	"\002Whois IPv4\002: %s; \002Range\002: %s (%s); \002WebGate\002: %s; \002IPv4 in IPv6\002: %s%s"
	set ccs(bwtext,whoisip,en,#113)	"\002Whois IPv6\002: %s; \002Range\002: %s (%s)%s"
	
	set ccs(text,whoisip,en,#netname)		"\00312Network name: \017%s"
	set ccs(text,whoisip,en,#descr)			"\00312descr: \017%s"
	set ccs(text,whoisip,en,#orgname)		"\00312descr: \017%s"
	set ccs(text,whoisip,en,#country)		"\00312Country: \017%s"
	set ccs(text,whoisip,en,#stateprov)		"\00312State: \017%s"
	set ccs(text,whoisip,en,#postalcode)	"\00312Postal code: \017%s"
	set ccs(text,whoisip,en,#city)			"\00312City: \017%s"
	set ccs(text,whoisip,en,#mnt-by)		"\00312mnt-by: \017%s"
	set ccs(text,whoisip,en,#person)		"\00312Peron: \017%s"
	set ccs(text,whoisip,en,#orgtechname)	"\00312Org. name: \017%s"
	set ccs(text,whoisip,en,#rtechname)		"\00312Reg. name: \017%s"
	set ccs(text,whoisip,en,#address)		"\00312Address: \017%s"
	set ccs(text,whoisip,en,#e-mail)		"\00312E-mail: \017%s"
	set ccs(text,whoisip,en,#orgtechemail)	"\00312 Org. email: \017%s"
	set ccs(text,whoisip,en,#rtechemail)	"\00312Reg. email: \017%s"
	set ccs(text,whoisip,en,#phone)			"\00312Phone: \017%s"
	set ccs(text,whoisip,en,#orgtechphone)	"\00312Org. phone: \017%s"
	set ccs(text,whoisip,en,#rtechphone)	"\00312Reg. phone: \017%s"
	
	set ccs(bwtext,whoisip,en,#netname)			"\002Network name\002: %s"
	set ccs(bwtext,whoisip,en,#descr)			"\002descr\002: %s"
	set ccs(bwtext,whoisip,en,#orgname)			"\002descr\002: %s"
	set ccs(bwtext,whoisip,en,#country)			"\002Country\002: %s"
	set ccs(bwtext,whoisip,en,#stateprov)		"\002State\002: %s"
	set ccs(bwtext,whoisip,en,#postalcode)		"\002Postal code\002: %s"
	set ccs(bwtext,whoisip,en,#city)			"\002City\002: %s"
	set ccs(bwtext,whoisip,en,#mnt-by)			"\002mnt-by\002: %s"
	set ccs(bwtext,whoisip,en,#person)			"\002Peron\002: %s"
	set ccs(bwtext,whoisip,en,#orgtechname)		"\002Org. name\002: %s"
	set ccs(bwtext,whoisip,en,#rtechname)		"\002Reg. name\002: %s"
	set ccs(bwtext,whoisip,en,#address)			"\002Address\002: %s"
	set ccs(bwtext,whoisip,en,#e-mail)			"\002E-mail\002: %s"
	set ccs(bwtext,whoisip,en,#orgtechemail)	"\002 Org. email\002: %s"
	set ccs(bwtext,whoisip,en,#rtechemail)		"\002Reg. email\002: %s"
	set ccs(bwtext,whoisip,en,#phone)			"\002Phone\002: %s"
	set ccs(bwtext,whoisip,en,#orgtechphone)	"\002Org. phone\002: %s"
	set ccs(bwtext,whoisip,en,#rtechphone)		"\002Reg. phone\002: %s"
	
	setudef str ccs-mode-whoisip
	
	proc whoisip_dnslookup2 {token tokendns} {
		variable whoisipturn
		
		if {![info exists whoisipturn($token,on)]} return
		
		if {[dns::status $tokendns] == "ok"} {
			foreach _ [dns::address $tokendns] {
				foreach {a_type a_ip} $_ break
				if {[lsearch $whoisipturn($token,address) [list $a_type $a_ip * * * * * *]] < 0} {
					lappend whoisipturn($token,address) [list $a_type $a_ip 0 0 "" "" "" [list]]
				}
			}
			foreach _0 [dns::name $tokendns] {
				foreach {a_type a_ip} $_0 break
				if {[lsearch $whoisipturn($token,name) [list $a_type $a_ip]] < 0} {
					lappend whoisipturn($token,name) [list $a_type $a_ip]
				}
			}
		}
		
		dns::cleanup $tokendns
		
		set ind 0
		foreach _ $whoisipturn($token,dns_token) {
			foreach {a_tokendns a_reply} $_ break
			if {$a_tokendns == $tokendns} {
				lset whoisipturn($token,dns_token) $ind 1 1
				break
			}
			incr ind
		}
		
		foreach _ $whoisipturn($token,address) {
			foreach {a_type a_ip a_request a_reply a_socket a_designation a_range a_info} $_ break
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
			foreach {a_tokendns a_reply} $_ break
			if {$a_tokendns == $tokendns} {
				lset whoisipturn($token,dns_token) $ind 1 1
				break
			}
			incr ind
		}
		
		foreach _ $whoisipturn($token,address) {
			foreach {a_type a_ip a_request a_reply a_socket a_designation a_range a_info} $_ break
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
			foreach {a_tokendns a_reply} $_ break
			if {$a_reply == 0} {set find 1; break}
		}
		if {!$find} {
			foreach _ $whoisipturn($token,address) {
				foreach {a_type a_ip a_request a_reply a_socket a_designation a_range a_info} $_ break
				if {$a_reply == 0} {set find 1; break}
			}
		}
		
		if {!$find} {whoisip_out $token}
		
	}
	
	proc whoisip_out {token} {
		variable whoisipturn
		variable ccs
		
		if {![info exists whoisipturn($token,on)]} return
		
		set onick $whoisipturn($token,onick)
		set ochan $whoisipturn($token,ochan)
		set obot $whoisipturn($token,obot)
		set snick $whoisipturn($token,snick)
		set shand $whoisipturn($token,shand)
		set schan $whoisipturn($token,schan)
		set command $whoisipturn($token,command)
		set stext $whoisipturn($token,stext)
		
		set mode [get_use_mode $schan $command]
		
		if {[llength $whoisipturn($token,address)] == 0} {
			put_msg [sprintf whoisip #101]
		} else {
			
			set lout [list]
			foreach _ $whoisipturn($token,name) {
				foreach {a_type a_ip} $_ break
				switch -exact -- $a_type {
					A - AAAA {lappend h($a_type) [sprintf whoisip #111 $a_ip]}
					default {lappend h($a_type) $a_ip}
				}
			}
			
			foreach _0 $whoisipturn($token,address) {
				foreach {a_type a_ip a_request a_reply a_socket a_designation a_range a_info} $_0 break
				switch -exact -- $a_type {
					A - AAAA {lappend h($a_type) [sprintf whoisip #110 $a_ip]}
					default {lappend h($a_type) $a_ip}
				}
			}
			
			foreach a_type [lsort [array names h]] {
				switch -exact -- $a_type {
					A {lappend lout [sprintf whoisip #103 [join $h($a_type) ", "]]}
					AAAA {lappend lout [sprintf whoisip #104 [join $h($a_type) ", "]]}
					CNAME {lappend lout [sprintf whoisip #105 [join $h($a_type) ", "]]}
					MX {lappend lout [sprintf whoisip #106 [join $h($a_type) ", "]]}
					PTR {lappend lout [sprintf whoisip #107 [join $h($a_type) ", "]]}
					NS {lappend lout [sprintf whoisip #108 [join $h($a_type) ", "]]}
					default {lappend lout [sprintf whoisip #109 $a_type [join $h($a_type) ", "]}
				}
			}
			if {[info exists h]} {unset h}
			
			put_msg [sprintf whoisip #102 $stext [join $lout "; "]] -mode $mode
			
			foreach _0 $whoisipturn($token,address) {
				foreach {a_type a_ip a_request a_reply a_socket a_designation a_range a_info} $_0 break
				
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
						
						if {[lsearch -exact $ccs(whoisip_info) $a] < 0} {continue}
						
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
						put_msg [sprintf whoisip #112 $a_ip $a_range $a_designation [ip::ipv4_to_gate $a_ip] [ip::ipv4_to_ipv6 $a_ip] [expr {[llength $lout] > 0 ? "; [join $lout "; "]" : ""}]] -mode $mode
					}
					AAAA {
						
						foreach {ipa ipb} [split $a_range -] break
						set ipa [string trim $ipa]
						set ipb [string trim $ipb]
						set a_range ""
						if {$ipa != ""} {append a_range "[ip::contract $ipa]"}
						if {$ipb != ""} {append a_range " - [ip::contract $ipb]"}
						
						put_msg [sprintf whoisip #113 $a_ip $a_range $a_designation [expr {[llength $lout] > 0 ? "; [join $lout "; "]" : ""}]] -mode $mode
						
					}
				}
				
			}
		}
		
		after cancel $whoisipturn($token,afterid)
		
		foreach _ $whoisipturn($token,address) {
			foreach {a_type a_ip a_request a_reply a_socket a_designation a_range a_info} $_ break
			if {$a_socket != ""} {
				catch {fileevent $a_socket readable {}}
				catch {fileevent $a_socket writable {}}
				catch {close $a_socket}
			}
		}
		
		foreach _ [array names whoisipturn -glob "$token,*"] {unset whoisipturn($_)}
		
		clear_token whoisip $token
		
	}
	
	proc cmd_whoisip {} {
		importvars [list onick ochan obot snick shand schan command stext]
		variable whoisipturn
		variable ccs
		
		set ip $stext
		
		set ip [string map [list , .] $ip]
		
		set token [get_token whoisip]
		
		set whoisipturn($token,on)			0
		set whoisipturn($token,onick)		$onick
		set whoisipturn($token,ochan)		$ochan
		set whoisipturn($token,obot)		$obot
		set whoisipturn($token,snick)		$snick
		set whoisipturn($token,shand)		$shand
		set whoisipturn($token,schan)		$schan
		set whoisipturn($token,command)		$command
		set whoisipturn($token,stext)		$stext
		
		set whoisipturn($token,address)		[list]
		set whoisipturn($token,name)		[list]
		set whoisipturn($token,dns_token)	[list]
		
		set whoisipturn($token,afterid)		[after $ccs(whoisip_timeout) [list [namespace origin whoisip_out] $token]]
		
		if {[onchan $stext]} {
			set ip [getchanhost $stext]
			set whoisipturn($token,wnick) $stext
		}
		
		if {[set ind [string last @ $ip]] > 0} {
			set ip [string range $ip [expr $ind+1] end]
		}
		
		if {[ip::IPv4? $ip]} {
			lappend whoisipturn($token,address) [list A $ip 0 0 "" "" "" [list]]
			switch -exact -- $ccs(mode_dns_reply) {
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
				switch -exact -- $ccs(mode_dns_reply) {
					1 {
						lappend whoisipturn($token,dns_token) [list 2 0]
						dnslookup $ip [namespace origin whoisip_dnslookup1] $token 2
					}
					2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
				}
				whoisip_addwhois $token
			} else {
				lappend whoisipturn($token,address) [list AAAA $ip 0 0 "" "" "" [list]]
				switch -exact -- $ccs(mode_dns_reply) {
					1 {}
					2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
				}
				whoisip_addwhois $token
			}
		} elseif {[ip::IPgate? $ip]} {
			lappend whoisipturn($token,address) [list A [set ip [ip::gate_to_ipv4 $ip]] 0 0 "" "" "" [list]]
			switch -exact -- $ccs(mode_dns_reply) {
				1 {
					lappend whoisipturn($token,dns_token) [list 3 0]
					dnslookup $ip [namespace origin whoisip_dnslookup1] $token 3
				}
				2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
			}
			whoisip_addwhois $token
		} elseif {[ip::IPlong? $ip]} {
			lappend whoisipturn($token,address) [list A [set ip [ip::longip_to_ipv4 $ip]] 0 0 "" "" "" [list]]
			switch -exact -- $ccs(mode_dns_reply) {
				1 {
					lappend whoisipturn($token,dns_token) [list 4 0]
					dnslookup $ip [namespace origin whoisip_dnslookup1] $token 4
				}
				2 {lappend whoisipturn($token,dns_token) [list [dns::resolve $ip -type PTR -command "[namespace origin whoisip_dnslookup2] $token"] 0]}
			}
			whoisip_addwhois $token
		} else {
			switch -exact -- $ccs(mode_dns_reply) {
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
		variable ccs
		#putlog "whoisip_addwhois $token"
		
		set ind 0
		foreach _ $whoisipturn($token,address) {
			foreach {a_type a_ip a_request a_reply a_socket a_designation a_range a_info} $_ break
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
	
}

