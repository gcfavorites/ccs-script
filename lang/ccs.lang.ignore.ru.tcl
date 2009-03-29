
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"ignore"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,addignore) {<nick/host> [время] [причина]}
	set ccs(help,ru,addignore) {Добавляет игнор на \002nick\002 или \002host\002 (nick!ident@host). Время указывается в минутах, если время не указано, то стандартное время - 1 день}
	
	set ccs(args,ru,delignore) {<host>}
	set ccs(help,ru,delignore) {Снимает игнор \002host\002}
	
	set ccs(args,ru,ignorelist) {}
	set ccs(help,ru,ignorelist) {Выводит список игноров}
	
	set ccs(text,ignore,ru,#101) "Requested"
	set ccs(text,ignore,ru,#102) "Добавлен игнор: \037%s\037 на %s."
	set ccs(text,ignore,ru,#103) "Добавлен \002постоянный\002 игнор: \037%s\037."
	set ccs(text,ignore,ru,#104) "Снят игнор: \002%s\002."
	set ccs(text,ignore,ru,#105) "Игнора \002%s\002 не существует."
	set ccs(text,ignore,ru,#106) "--- Глобальный игнорлист ---"
	set ccs(text,ignore,ru,#107) "Игнор \002постоянный\002."
	set ccs(text,ignore,ru,#108) "Истекает через %s."
	set ccs(text,ignore,ru,#109) "» %s ¤ Причина: «%s» ¤ %s ¤ Игнор добавлен %s назад ¤ Создатель: \002%s\002."
	set ccs(text,ignore,ru,#110) "*** Пуст ***"
	set ccs(text,ignore,ru,#111) "--- Конец игнорлиста ---"
	
	
}