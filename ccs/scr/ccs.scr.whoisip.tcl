##################################################################################################################
## Скрипт получения информации об IP адресе (script that allows you to get info about specified host/IP)
##################################################################################################################
# Список последних изменений (changelog):
#	v1.1.3
# - English translation
#	v1.1.2
# - Добавлена поддержка IPv6 (added IPv6 support, TCL 8.5 required)
# - Часть функций перенесена в библиотеку ip (most of functions was moved to ip lib)

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set scrname		"whoisip"
addfileinfo scr $scrname "Buster <buster@ircworld.ru> (c)" \
				"1.1.3" \
				"01-MAR-2009" \
				"Скрипт выдающий информацию по IP адресу"

if {$ccs(scr,name,$scrname)} {
	
	set llib [get_fileinfo lib 1]
	if {[lsearch_equal $llib "ip"] < 0} {debug "\002\00304${scrname} not loaded\002\003: \"ip\" lib not loaded or disabled, please install \"ip\" lib"; return 0}
	
	lappend ccs(scr_commands)	"whoisip"
	
	
	#############################################################################################################
	# Время в милисекундах в течении которого ожидать ответа.
	# Request timeout (period within we should wait for answer)
	set ccs(whoisip_timeout) 10000
	
	#############################################################################################################
	# Список выводимой информации.
	# Output info entries.
	set ccs(whoisip_info) {netname descr country mnt-by person address city stateprov postalcode e-mail orgtechemail phone orgtechphone orgtechname orgname rtechname rtechemail rtechphone}
	
	
	set ccs(group,whoisip) "info"
	set ccs(use_auth,whoisip) 0
	set ccs(use_chan,whoisip) 0
	set ccs(flags,whoisip) {-|-}
	set ccs(alias,whoisip) {%pref_whoisip}
	set ccs(block,whoisip) 5
	set ccs(regexp,whoisip) {{^([^\ ]+)$} {-> stext}}
	set ccs(use_botnet,whoisip) 0
	set ccs(use_mode,whoisip) 1
	
	set ccs(args,ru,whoisip) {<nick/host/ip/gate/longip>}
	set ccs(help,ru,whoisip) {Выяснить всю информацию о хосте}
	set ccs(help,en,whoisip) {Get info about specified host}
	set ccs(help2,ru,whoisip) {
		{Выяснить всю информацию о хосте. Возможно указание ника, хоста, IP адреса, веб гейта, длинного IP адреса.}
	}
	set ccs(help2,en,whoisip) {
		{Get the whois-info about given host. You can specify nick, host, IP-address, web-gate address or longIP.}
	}
	set ccs(text,whoisip,ru,#101) "Не удалось преобразовать данные в IP адрес."
	set ccs(text,whoisip,ru,#102) "Полученные данные по запросу: \002%s\002. IPv4: \002%s\002, IPv6: \002%s\002, host: \002%s\002, Gate: \002%s\002, LongIP: \002%s\002. Диапазон относится к \002%s\002. Подсеть \002%s\002."
	
	set ccs(text,whoisip,ru,#netname) "\002Имя сети\002: %s"
	set ccs(text,whoisip,ru,#descr) "\002descr\002: %s"
	set ccs(text,whoisip,ru,#orgname) "\002descr\002: %s"
	set ccs(text,whoisip,ru,#country) "\002Страна\002: %s"
	set ccs(text,whoisip,ru,#stateprov) "\002Штат\002: %s"
	set ccs(text,whoisip,ru,#postalcode) "\002Почтовый код\002: %s"
	set ccs(text,whoisip,ru,#city) "\002Город\002: %s"
	set ccs(text,whoisip,ru,#mnt-by) "\002mnt-by\002: %s"
	set ccs(text,whoisip,ru,#person) "\002Лицо\002: %s"
	set ccs(text,whoisip,ru,#orgtechname) "\002Лицо\002: %s"
	set ccs(text,whoisip,ru,#rtechname) "\002Лицо\002: %s"
	set ccs(text,whoisip,ru,#address) "\002Адрес\002: %s"
	set ccs(text,whoisip,ru,#e-mail) "\002E-mail\002: %s"
	set ccs(text,whoisip,ru,#orgtechemail) "\002E-mail\002: %s"
	set ccs(text,whoisip,ru,#rtechemail) "\002E-mail\002: %s"
	set ccs(text,whoisip,ru,#phone) "\002Тел.\002: %s"
	set ccs(text,whoisip,ru,#orgtechphone) "\002Тел.\002: %s"
	set ccs(text,whoisip,ru,#rtechphone) "\002Тел.\002: %s"
	
	set ccs(text,whoisip,en,#101) "Can't proccess given data into IP-address."
	set ccs(text,whoisip,en,#102) "WHOIS-info about: \002%s\002. IPv4: \002%s\002, IPv6: \002%s\002, host: \002%s\002, Gate: \002%s\002, LongIP: \002%s\002. Range: \002%s\002. Subnet: \002%s\002."
	
	set ccs(text,whoisip,en,#netname) "\002Network name\002: %s"
	set ccs(text,whoisip,en,#descr) "\002descr\002: %s"
	set ccs(text,whoisip,en,#orgname) "\002descr\002: %s"
	set ccs(text,whoisip,en,#country) "\002Country\002: %s"
	set ccs(text,whoisip,en,#stateprov) "\002State\002: %s"
	set ccs(text,whoisip,en,#postalcode) "\002Postal code\002: %s"
	set ccs(text,whoisip,en,#city) "\002City\002: %s"
	set ccs(text,whoisip,en,#mnt-by) "\002mnt-by\002: %s"
	set ccs(text,whoisip,en,#person) "\002Peron\002: %s"
	set ccs(text,whoisip,en,#orgtechname) "\002Org. name\002: %s"
	set ccs(text,whoisip,en,#rtechname) "\002Reg. name\002: %s"
	set ccs(text,whoisip,en,#address) "\002Address\002: %s"
	set ccs(text,whoisip,en,#e-mail) "\002E-mail\002: %s"
	set ccs(text,whoisip,en,#orgtechemail) "\002 Org. email\002: %s"
	set ccs(text,whoisip,en,#rtechemail) "\002Reg. email\002: %s"
	set ccs(text,whoisip,en,#phone) "\002Phone\002: %s"
	set ccs(text,whoisip,en,#orgtechphone) "\002Org. phone\002: %s"
	set ccs(text,whoisip,en,#rtechphone) "\002Reg. phone\002: %s"

	set ccs(ipv4_address_space) {
		{010/8}			{IANA - Private Use}		{}
		{127/8}			{IANA - Loopback}			{}
		{172.16/12}		{Private-Use Networks}		{}
		{192.0.2/24}	{Test-Net}					{}
		{192.88.99/24}	{6to4 Relay Anycast}		{}
		{192.168/16}	{Private-Use Networks}		{}
		{224/4}			{Multicast}					{}
		{240/4}			{Future use}				{}
		{169.254/16}	{Link Local}				{}
		{223/8}			{IANA}						{}
		{224/4}			{Multicast}					{}
		{240/4}			{Future use}				{}
		{24.132/14} {RIPE NCC} {whois.ripe.net}
		{41/8} {AfriNIC} {whois.afrinic.net}
		{43/8} {} {whois.v6nic.net}
		{59/11} {} {whois.nic.or.kr}
		{58/7} {APNIC} {whois.apnic.net}
		{61.72/13} {} {whois.nic.or.kr}
		{61.80/14} {} {whois.nic.or.kr}
		{61.84/15} {} {whois.nic.or.kr}
		{61.112/12} {} {whois.nic.ad.jp}
		{61.192/12} {} {whois.nic.ad.jp}
		{61.208/13} {} {whois.nic.ad.jp}
		{60/7} {APNIC} {whois.apnic.net}
		{62/8} {RIPE NCC} {whois.ripe.net}
		{77/8} {RIPE NCC} {whois.ripe.net}
		{78/7} {RIPE NCC} {whois.ripe.net}
		{80/4} {RIPE NCC} {whois.ripe.net}
		{96/6} {ARIN} {whois.arin.net}
		{110/7} {APNIC} {whois.apnic.net}
		{112/5} {APNIC} {whois.apnic.net}
		{121.128/10} {} {whois.nic.or.kr}
		{125.128/11} {} {whois.nic.or.kr}
		{120/6} {APNIC} {whois.apnic.net}
		{124/7} {APNIC} {whois.apnic.net}
		{126/8} {APNIC} {whois.apnic.net}
		{96/3} {} {}
		{0/1} {ARIN} {whois.arin.net}
		{133/8} {} {whois.nic.ad.jp}
		{139.20/14} {RIPE NCC} {whois.ripe.net}
		{139.24/14} {RIPE NCC} {whois.ripe.net}
		{139.28/15} {RIPE NCC} {whois.ripe.net}
		{141/10} {RIPE NCC} {whois.ripe.net}
		{141.64/12} {RIPE NCC} {whois.ripe.net}
		{141.80/14} {RIPE NCC} {whois.ripe.net}
		{141.84/15} {RIPE NCC} {whois.ripe.net}
		{145/8} {RIPE NCC} {whois.ripe.net}
		{146.48/16} {RIPE NCC} {whois.ripe.net}
		{149.202/15} {RIPE NCC} {whois.ripe.net}
		{149.204/16} {RIPE NCC} {whois.ripe.net}
		{149.206/15} {RIPE NCC} {whois.ripe.net}
		{149.208/12} {RIPE NCC} {whois.ripe.net}
		{149.224/12} {RIPE NCC} {whois.ripe.net}
		{149.240/13} {RIPE NCC} {whois.ripe.net}
		{149.248/14} {RIPE NCC} {whois.ripe.net}
		{150.183/16} {} {whois.nic.or.kr}
		{150.254/16} {RIPE NCC} {whois.ripe.net}
		{151/10} {RIPE NCC} {whois.ripe.net}
		{151.64/11} {RIPE NCC} {whois.ripe.net}
		{151.96/14} {RIPE NCC} {whois.ripe.net}
		{151.100/16} {RIPE NCC} {whois.ripe.net}
		{155.232/13} {AfriNIC} {whois.afrinic.net}
		{155.240/16} {AfriNIC} {whois.afrinic.net}
		{160.216/14} {RIPE NCC} {whois.ripe.net}
		{160.220/16} {RIPE NCC} {whois.ripe.net}
		{160.44/14} {RIPE NCC} {whois.ripe.net}
		{160.48/12} {RIPE NCC} {whois.ripe.net}
		{160.115/16} {AfriNIC} {whois.afrinic.net}
		{160.116/14} {AfriNIC} {whois.afrinic.net}
		{160.120/14} {AfriNIC} {whois.afrinic.net}
		{160.124/16} {AfriNIC} {whois.afrinic.net}
		{163.156/14} {RIPE NCC} {whois.ripe.net}
		{163.160/12} {RIPE NCC} {whois.ripe.net}
		{163.195/16} {AfriNIC} {whois.afrinic.net}
		{163.196/14} {AfriNIC} {whois.afrinic.net}
		{163.200/14} {AfriNIC} {whois.afrinic.net}
		{164/11} {RIPE NCC} {whois.ripe.net}
		{164.32/13} {RIPE NCC} {whois.ripe.net}
		{164.40/16} {RIPE NCC} {whois.ripe.net}
		{164.128/12} {RIPE NCC} {whois.ripe.net}
		{164.146/15} {AfriNIC} {whois.afrinic.net}
		{164.148/14} {AfriNIC} {whois.afrinic.net}
		{165.143/16} {AfriNIC} {whois.afrinic.net}
		{165.144/14} {AfriNIC} {whois.afrinic.net}
		{165.148/15} {AfriNIC} {whois.afrinic.net}
		{169.208/12} {APNIC} {whois.apnic.net}
		{171.16/12} {RIPE NCC} {whois.ripe.net}
		{171.32/15} {RIPE NCC} {whois.ripe.net}
		{186/7} {LACNIC} {whois.lacnic.net}
		{188/8} {RIPE NCC} {whois.ripe.net}
		{189/8} {LACNIC} {whois.lacnic.net}
		{190/8} {LACNIC} {whois.lacnic.net}
		{128/2} {ARIN} {whois.arin.net}
		{192.71/16} {RIPE NCC} {whois.ripe.net}
		{192.72.253/24} {ARIN} {whois.arin.net}
		{192.72.254/24} {ARIN} {whois.arin.net}
		{192.72/16} {APNIC} {whois.apnic.net}
		{192.106/16} {RIPE NCC} {whois.ripe.net}
		{192.114/15} {RIPE NCC} {whois.ripe.net}
		{192.116/15} {RIPE NCC} {whois.ripe.net}
		{192.118/16} {RIPE NCC} {whois.ripe.net}
		{192.162/16} {RIPE NCC} {whois.ripe.net}
		{192.164/14} {RIPE NCC} {whois.ripe.net}
		{192/8} {ARIN} {whois.arin.net}
		{193/8} {RIPE NCC} {whois.ripe.net}
		{194/7} {RIPE NCC} {whois.ripe.net}
		{196/7} {AfriNIC} {whois.afrinic.net}
		{198/7} {ARIN} {whois.arin.net}
		{200.17/16} {} {whois.nic.br}
		{200.18/15} {} {whois.nic.br}
		{200.20/16} {} {whois.nic.br}
		{200.96/13} {} {whois.nic.br}
		{200.128/9} {} {whois.nic.br}
		{200/7} {LACNIC} {whois.lacnic.net}
		{202.11/16} {} {whois.nic.ad.jp}
		{202.13/16} {} {whois.nic.ad.jp}
		{202.15/16} {} {whois.nic.ad.jp}
		{202.16/14} {} {whois.nic.ad.jp}
		{202.20.128/17} {} {whois.nic.or.kr}
		{202.23/16} {} {whois.nic.ad.jp}
		{202.24/15} {} {whois.nic.ad.jp}
		{202.26/16} {} {whois.nic.ad.jp}
		{202.30/15} {} {whois.nic.or.kr}
		{202.32/14} {} {whois.nic.ad.jp}
		{202.48/16} {} {whois.nic.ad.jp}
		{202.39.128/17} {} {whois.twnic.net}
		{202.208/12} {} {whois.nic.ad.jp}
		{202.224/11} {} {whois.nic.ad.jp}
		{203/10} {APNIC} {whois.apnic.net}
		{203.66/16} {} {whois.twnic.net}
		{203.69/16} {} {whois.twnic.net}
		{203.74/15} {} {whois.twnic.net}
		{203.136/14} {} {whois.nic.ad.jp}
		{203.140/15} {} {whois.nic.ad.jp}
		{203.178/15} {} {whois.nic.ad.jp}
		{203.180/14} {} {whois.nic.ad.jp}
		{203.224/11} {} {whois.nic.or.kr}
		{202/7} {APNIC} {whois.apnic.net}
		{204/14} {} {rwhois.gin.ntt.net}
		{204/6} {ARIN} {whois.arin.net}
		{208/7} {ARIN} {whois.arin.net}
		{209.94.192/19} {LACNIC} {whois.lacnic.net}
		{210.59.128/17} {} {whois.twnic.net}
		{210.61/16} {} {whois.twnic.net}
		{210.62.252/22} {} {whois.twnic.net}
		{210.65/16} {} {whois.twnic.net}
		{210.71.128/16} {} {whois.twnic.net}
		{210.90/15} {} {whois.nic.or.kr}
		{210.92/14} {} {whois.nic.or.kr}
		{210.96/11} {} {whois.nic.or.kr}
		{210.128/11} {} {whois.nic.ad.jp}
		{210.160/12} {} {whois.nic.ad.jp}
		{210.178/15} {} {whois.nic.or.kr}
		{210.180/14} {} {whois.nic.or.kr}
		{210.188/14} {} {whois.nic.ad.jp}
		{210.196/14} {} {whois.nic.ad.jp}
		{210.204/14} {} {whois.nic.or.kr}
		{210.216/13} {} {whois.nic.or.kr}
		{210.224/12} {} {whois.nic.ad.jp}
		{210.240/16} {} {whois.twnic.net}
		{210.241/15} {} {whois.twnic.net}
		{210.241.224/19} {} {whois.twnic.net}
		{210.242/15} {} {whois.twnic.net}
		{210.248/13} {} {whois.nic.ad.jp}
		{211/12} {} {whois.nic.ad.jp}
		{211.16/14} {} {whois.nic.ad.jp}
		{211.20/15} {} {whois.twnic.net}
		{211.22/16} {} {whois.twnic.net}
		{211.32/11} {} {whois.nic.or.kr}
		{211.75/16} {} {whois.twnic.net}
		{211.72/16} {} {whois.twnic.net}
		{211.104/13} {} {whois.nic.or.kr}
		{211.112/13} {} {whois.nic.or.kr}
		{211.120/13} {} {whois.nic.ad.jp}
		{211.128/13} {} {whois.nic.ad.jp}
		{211.168/13} {} {whois.nic.or.kr}
		{211.176/12} {} {whois.nic.or.kr}
		{211.192/10} {} {whois.nic.or.kr}
		{210/7} {APNIC} {whois.apnic.net}
		{213.154.32/19} {AfriNIC} {whois.afrinic.net}
		{213.154.64/19} {AfriNIC} {whois.afrinic.net}
		{212/7} {RIPE NCC} {whois.ripe.net}
		{214/7} {ARIN} {whois.arin.net}
		{216/8} {ARIN} {whois.arin.net}
		{217/8} {RIPE NCC} {whois.ripe.net}
		{218.36/14} {} {whois.nic.or.kr}
		{218.40/13} {} {whois.nic.ad.jp}
		{218.48/13} {} {whois.nic.or.kr}
		{219.96/11} {} {whois.nic.ad.jp}
		{218.144/12} {} {whois.nic.or.kr}
		{218.160/12} {} {whois.twnic.net}
		{218.216/13} {} {whois.nic.ad.jp}
		{218.224/13} {} {whois.nic.ad.jp}
		{218.232/13} {} {whois.nic.or.kr}
		{219.240/15} {} {whois.nic.or.kr}
		{219.248/13} {} {whois.nic.or.kr}
		{218/7} {APNIC} {whois.apnic.net}
		{220.64/11} {} {whois.nic.or.kr}
		{220.96/14} {} {whois.nic.ad.jp}
		{220.103/16} {} {whois.nic.or.kr}
		{220.104/13} {} {whois.nic.ad.jp}
		{220.149/16} {} {whois.nic.or.kr}
		{221.138/13} {} {whois.nic.or.kr}
		{221.144/12} {} {whois.nic.or.kr}
		{221.160/13} {} {whois.nic.or.kr}
		{222.96/12} {} {whois.nic.or.kr}
		{222.112/13} {} {whois.nic.or.kr}
		{222.120/15} {} {whois.nic.or.kr}
		{222.122/16} {} {whois.nic.or.kr}
		{222.232/13} {} {whois.nic.or.kr}
		{220/6} {APNIC} {whois.apnic.net}
	}
	
	set ccs(ipv6_address_space) {
		{::/128}			{unspecified}	{}
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
		{::/0}				{not allocated}	{}
	}
	
	setudef str ccs-mode-whoisip
	
	proc whoisip_dnslookup {ipaddr hostname status token} {
		variable whoisipturn
		
		if {![info exists whoisipturn($token,on)]} return
		
		set whoisipturn($token,dns) 1
		if {$status} {
			set whoisipturn($token,wipv4)	$ipaddr
			set whoisipturn($token,whost)	$hostname
			if {!$whoisipturn($token,addwhoisv4)} {whoisip_addwhois $token 4}
		}
		if {$whoisipturn($token,whoisv4) || $whoisipturn($token,whoisv6) || (!$status && $whoisipturn($token,wipv4) == "" && $whoisipturn($token,wipv6) == "")} {whoisip_out $token}
		
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
		
		if {$whoisipturn($token,wipv4) == "" && $whoisipturn($token,wipv6) == ""} {
			put_msg [sprintf whoisip #101]
		} else {
			set mode [get_use_mode $schan $command]
			
			set last_info ""
			set last_text [list]
			set lout [list]
			
			foreach _ $whoisipturn($token,winfo) {
				if {[regexp -- {^([^\ ]+)\:(.*?)$} $_ -> a b]} {
					
					set a [string tolower $a]
					set b [string trimright [string trim $b] ,]
					
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
			
			if {$whoisipturn($token,wipv4) != ""} {
				if {$whoisipturn($token,wgate) == ""} {
					set whoisipturn($token,wgate) [ipv4_to_gate $whoisipturn($token,wipv4)]
				}
				if {$whoisipturn($token,wlongip) == ""} {
					set whoisipturn($token,wlongip) [ipv4_to_longip $whoisipturn($token,wipv4)]
				}
				if {$whoisipturn($token,wipv6) == ""} {
					set whoisipturn($token,wipv6) [ipv4_to_ipv6 $whoisipturn($token,wipv4)]
				}
			}
			
			put_msg [sprintf whoisip #102 $stext $whoisipturn($token,wipv4) $whoisipturn($token,wipv6) $whoisipturn($token,whost) $whoisipturn($token,wgate) $whoisipturn($token,wlongip) $whoisipturn($token,wdesignation) $whoisipturn($token,range)] -mode $mode
			if {[llength $lout] > 0} {
				put_msg [join $lout "; "] -mode $mode
			}
			
		}
		
		after cancel $whoisipturn($token,afterid)
		
		unset whoisipturn($token,on) whoisipturn($token,onick) whoisipturn($token,ochan) \
			whoisipturn($token,obot) whoisipturn($token,snick) whoisipturn($token,shand) \
			whoisipturn($token,schan) whoisipturn($token,command) whoisipturn($token,stext) \
			whoisipturn($token,wipv4) whoisipturn($token,wipv6) whoisipturn($token,wgate) \
			whoisipturn($token,whost) whoisipturn($token,dns) whoisipturn($token,whoisv4) \
			whoisipturn($token,whoisv6) whoisipturn($token,addwhoisv4) \
			whoisipturn($token,addwhoisv6) whoisipturn($token,winfo) \
			whoisipturn($token,wlongip) whoisipturn($token,wdesignation) whoisipturn($token,range)
		
		foreach v {4 6} {
			if {[info exists whoisipturn($token,socket$v)]} {
				set s $whoisipturn($token,socket$v)
				catch {fileevent $s readable {}}
				catch {fileevent $s writable {}}
				catch {close $s}
				unset whoisipturn($token,socket$v)
			}
		}
		
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
		set whoisipturn($token,wipv4)			""
		set whoisipturn($token,wipv6)			""
		set whoisipturn($token,wgate)			""
		set whoisipturn($token,whost)			""
		set whoisipturn($token,wlongip)			""
		set whoisipturn($token,wdesignation)	""
		set whoisipturn($token,winfo)			[list]
		set whoisipturn($token,dns)				0
		set whoisipturn($token,whoisv4)			0
		set whoisipturn($token,whoisv6)			0
		set whoisipturn($token,addwhoisv4)		0
		set whoisipturn($token,addwhoisv6)		0
		set whoisipturn($token,range)			""
		
		set whoisipturn($token,afterid) [after $ccs(whoisip_timeout) [list [namespace origin whoisip_out] $token]]
		
		if {[onchan $stext]} {
			set ip [getchanhost $stext]
			set whoisipturn($token,wnick) $stext
		}
		
		if {[set ind [string last @ $ip]] > 0} {
			set ip [string range $ip [expr $ind+1] end]
		}
		
		if {[string_is_ipv4 $ip]} {
			set whoisipturn($token,wipv4)		$ip
		} elseif {[string_is_ipv6 $ip]} {
			if {[ipv6_in_net 2002::/16 $ip]} {
				set whoisipturn($token,wipv4)		[ipv6_to_ipv4 $ip]
			} else {
				set whoisipturn($token,wipv6)		$ip
			}
		} elseif {[set gateip [gate_to_ipv4 $ip]] != ""} {
			set whoisipturn($token,wgate)		$ip
			set ip $gateip
			set whoisipturn($token,wipv4)		$ip
		} elseif {[string is digit $ip] && $ip < 4294967296} {
			set whoisipturn($token,wlongip)		$ip
			set ip [longip_to_ipv4 $ip]
			set whoisipturn($token,wipv4)		$ip
		} else {
			set whoisipturn($token,whost)		$ip
		}
		
		if {$whoisipturn($token,wipv4) != ""} {whoisip_addwhois $token 4}
		if {$whoisipturn($token,wipv6) != ""} {whoisip_addwhois $token 6}
		
		dnslookup $ip [namespace origin whoisip_dnslookup] $token
		return 1
		
	}
	
	proc whoisip_whois_read {token v} {
		variable whoisipturn
		set s $whoisipturn($token,socket$v)
		
		if {![eof $s]} {
			while {![eof $s]} {
				gets $s newdata
				if {[fblocked $s]} {break}
				lappend whoisipturn($token,winfo) $newdata
			}
		} else {
			fileevent $s readable {}
			close $s
			unset whoisipturn($token,socket$v)
			set whoisipturn($token,whoisv$v) 1
			if {$whoisipturn($token,dns)} {whoisip_out $token}
		}
		
	}
	
	proc whoisip_whois_write {token v} {
		variable whoisipturn
		
		set s $whoisipturn($token,socket$v)
		puts $s $whoisipturn($token,wipv$v)
		flush $s
		fconfigure $s -encoding binary -translation {auto binary}
		catch {fileevent $s writable {}}
		
	}
	
	proc whoisip_addwhois {token v} {
		variable whoisipturn
		variable ccs
		
		set whoisipturn($token,addwhoisv$v) 1
		
		set find 0
		foreach {netmask designation whois} $ccs(ipv${v}_address_space) {
			if {[ipv${v}_in_net $netmask $whoisipturn($token,wipv$v)]} {
				set whoisipturn($token,wdesignation) $designation
				set whoisipturn($token,range) $netmask
				set find 1
				break
			}
		}
		if {$find && $whois != ""} {
			set s [socket -async $whois 43]
			set whoisipturn($token,socket$v) $s
			if {$s != ""} {
				fconfigure $s -blocking 0 -buffering line
				fileevent $s readable [list [namespace origin whoisip_whois_read] $token $v]
				fileevent $s writable [list [namespace origin whoisip_whois_write] $token $v]
			} else {
				set whoisipturn($token,whoisv$v) 1
			}
		} else {
			set whoisipturn($token,whoisv$v) 1
		}
	}
	
}

