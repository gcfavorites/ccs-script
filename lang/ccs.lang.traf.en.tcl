
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"traf"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.1" \
				"27-Aug-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,traf) {[type]}
	set ccs(help,en,traf) {Send traffic information. Groups: \002irc, botnet, partyline, transfer, misc, total, botnet}
	
	set ccs(text,traf,en,#101) "Stats about \002%s\002 not found. Valid group are: \002IRC, BotNet, Partyline, Transfer, Misc, Total."
	
}