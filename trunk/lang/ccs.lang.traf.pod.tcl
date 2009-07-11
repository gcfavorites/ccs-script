
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"traf"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang traf {[тип трафига]}
	set_text -type help -- $_lang traf {Паказывайед инфармацийу а трафиге. Юзайте: \002irc\002, \002botnet\002, \002partyline\002, \002transfer\002, \002misc\002, \002total\002, \002botnet\002}
	
	set_text $_lang $_name #101 "Статистека \002%s\002 нинайдина. Идите лесам и юзайти \002IRC\002, \002BotNet\002, \002Partyline\002, \002Transfer\002, \002Misc\002, \002Total\002."
	
}