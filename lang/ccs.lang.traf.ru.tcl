
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"traf"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang traf {[type]}
	set_text -type help -- $_lang traf {Показывает информацию о трафике. Используйте: \002irc, botnet, partyline, transfer, misc, total, botnet}
	
	set_text $_lang $_name #101 "Статистика \002%s\002 не найдена. Используйте \002IRC, BotNet, Partyline, Transfer, Misc, Total."
	
}