##################################################################################################################
## ћодуль дл€ вызова DCC коннекта от бота. ѕо просьбе vindi ;)
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chat"
addmod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"chat"
	
	#############################################################################################################
	# ѕорт по которому будет производитьс€ DCC коннект. ≈сли порт 0, то будет производитьс€ поиск открытых портов
	set ccs(dccport)		0
	
	#############################################################################################################
	# IP адрес, через который будет производитьс€ коннект, если поле оставить пустым IP адрес будет братьс€ из
	# системы
	set ccs(dccip)			""
	
	set ccs(group,chat) "other"
	set ccs(use_chan,chat) 0
	set ccs(flags,chat) {p}
	set ccs(alias,chat) {%pref_chat}
	set ccs(block,chat) 5
	set ccs(regexp,chat) {{^$} {}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,traf,en,#101) "Stats about \002%s\002 not found. Valid group are: \002IRC, BotNet, Partyline, Transfer, Misc, Total."
	
	proc cmd_chat {} {
		importvars [list onick ochan obot snick shand schan command]
		variable ccs
		
		set port $ccs(dccport)
		if {$port == 0} {
			foreach _ [dcclist] {
				if {[lindex $_ 3] == "TELNET"} {
					set port [string trim [string map [list lstn ""] [lindex $_ 4]]]
					break
				}
			}
		}
		if {$port == 0} {put_msg [sprintf chat #101];return 0}
		
		if {$ccs(dccip) == ""} {set ip [myip]} else {set ip $ccs(dccip)}
		
		putserv "PRIVMSG $snick :\001DCC CHAT chat $ip $port\001"
		
	}
	
}