
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"traf"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,traf) {[тип трафига]}
	set ccs(help,pod,traf) {Паказывайед инфармацийу а трафиге. Юзайте: \002irc\002, \002botnet\002, \002partyline\002, \002transfer\002, \002misc\002, \002total\002, \002botnet\002}
	
	set ccs(text,traf,pod,#101) "Статистека \002%s\002 нинайдина. Идите лесам и юзайти \002IRC\002, \002BotNet\002, \002Partyline\002, \002Transfer\002, \002Misc\002, \002Total\002."
	
}