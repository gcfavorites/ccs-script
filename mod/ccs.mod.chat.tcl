####################################################################################################
## ћодуль дл€ вызова DCC коннекта от бота. ѕо просьбе vindi ;)
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{chat}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"ћодуль DCC соединени€ бота с клиентом."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# ѕорт по которому будет производитьс€ DCC коннект. ≈сли порт 0, то будет производитьс€ поиск
	# открытых портов
	set options(dccport)		0
	
	################################################################################################
	# IP адрес, через который будет производитьс€ коннект, если поле оставить пустым IP адрес будет
	# братьс€ из системы
	set options(dccip)			""
	
	cmd_configure chat -control -group "other" -flags {p} -block 5 -use_chan 0 \
		-alias {%pref_chat} \
		-regexp {{^$} {}}
	
	proc cmd_chat {} {
		upvar out out
		importvars [list snick shand schan command]
		variable options
		
		set port $options(dccport)
		if {$port == 0} {
			foreach _ [dcclist] {
				if {[lindex $_ 3] == "TELNET"} {
					set port [string trim [string map [list lstn ""] [lindex $_ 4]]]
					break
				}
			}
		}
		if {$port == 0} {put_msg [sprintf chat #101];return 0}
		
		if {$options(dccip) == ""} {set ip [myip]} else {set ip $options(dccip)}
		
		putserv "PRIVMSG $snick :\001DCC CHAT chat $ip $port\001"
		
	}
	
}