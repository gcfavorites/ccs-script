
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"traf"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,traf) {[type]}
	set ccs(help,ru,traf) {Показывает информацию о трафике. Используйте: \002irc, botnet, partyline, transfer, misc, total, botnet}
	
	set ccs(text,traf,ru,#101) "Статистика \002%s\002 не найдена. Используйте \002IRC, BotNet, Partyline, Transfer, Misc, Total."
	
}