
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ignore"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang addignore {<nick/host> [время] [причина]}
	set_text -type help -- $_lang addignore {Добавляет игнор на \002nick\002 или \002host\002 (nick!ident@host). Время указывается в минутах, если время не указано, то стандартное время - 1 день}
	
	set_text -type args -- $_lang delignore {<host>}
	set_text -type help -- $_lang delignore {Снимает игнор \002host\002}
	
	set_text -type args -- $_lang ignorelist {}
	set_text -type help -- $_lang ignorelist {Выводит список игноров}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Добавлен игнор: \037%s\037 на %s."
	set_text $_lang $_name #103 "Добавлен \002постоянный\002 игнор: \037%s\037."
	set_text $_lang $_name #104 "Снят игнор: \002%s\002."
	set_text $_lang $_name #105 "Игнора \002%s\002 не существует."
	set_text $_lang $_name #106 "--- Глобальный игнорлист ---"
	set_text $_lang $_name #107 "Игнор \002постоянный\002."
	set_text $_lang $_name #108 "Истекает через %s."
	set_text $_lang $_name #109 "» %s ¤ Причина: «%s» ¤ %s ¤ Игнор добавлен %s назад ¤ Создатель: \002%s\002."
	set_text $_lang $_name #110 "*** Пуст ***"
	set_text $_lang $_name #111 "--- Конец игнорлиста ---"
	
	
}