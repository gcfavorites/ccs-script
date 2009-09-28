
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ban"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.1" \
				"24-Sep-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang ban {<nick/host> [время] [причина] [stick]}
	set_text -type help -- $_lang ban {Выставляет бан}
	set_text -type help2 -- $_lang ban {
		{Банит \002nick\002 или \002host\002 (nick!ident@host) с канала.}
		{Время указывается в минутах, если время не указано, то время берётся из параметра «ban-time» канала.}
		{Если в параметре указано \002stick\002, то бан будет сразу возвращаться при его снятии.}
	}
	
	set_text -type args -- $_lang unban {<hostmask>}
	set_text -type help -- $_lang unban {Снимает бан \002host\002 с канала.}
	
	set_text -type args -- $_lang gban {<nick/host> [время] [причина] [stick]}
	set_text -type help -- $_lang gban {Выставляет глобальный бан}
	set_text -type help2 -- $_lang gban {
		{Банит \002nick\002 или \002host\002 (nick!ident@host) глобально (на всех каналах, где есть бот).}
		{Время указывается в минутах, если время не указано, то время - 1 день.}
		{Если в параметре указано \002stick\002, то бан будет сразу возвращаться при его снятии.}
	}
	
	set_text -type args -- $_lang gunban {<hostmask>}
	set_text -type help -- $_lang gunban {Снимает глобальный бан \002host\002 со всех каналов}
	
	set_text -type args -- $_lang banlist {[mask] [global]}
	set_text -type help -- $_lang banlist {Выводит банлист канала, если указан параметр \002global\002, то выводит глобальный банлист}
	
	set_text -type args -- $_lang resetbans {}
	set_text -type help -- $_lang resetbans {Убирает с канала все баны, которых нет в банлисте бота}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Добавлен \002постоянный\002%s бан: \037%s\037."
	set_text $_lang $_name #103 "Добавлен%s бан: \037%s\037 на \002%s\002."
	set_text $_lang $_name #104 "%s (до %s)."
	set_text $_lang $_name #105 "\037стик\037"
	set_text $_lang $_name #106 "Снят%s бан: \002%s\002."
	set_text $_lang $_name #107 "Бана \002%s\002 на \002%s\002 не существует."
	set_text $_lang $_name #108 "Requested"
	set_text $_lang $_name #109 "Добавлен \002постоянный\002 глобальный%s бан: \037%s\037."
	set_text $_lang $_name #110 "Добавлен глобальный%s бан: \037%s\037 на %s."
	set_text $_lang $_name #111 "Снят глобальный%s бан: \002%s\002"
	set_text $_lang $_name #112 "Глобального бана \002%s\002 не существует."
	set_text $_lang $_name #113 "--- Глобальный банлист%s ---"
	set_text $_lang $_name #114 "--- Банлист \002%s\002%s ---"
	set_text $_lang $_name #115 "*** Пуст ***"
	set_text $_lang $_name #116 "(маска \002%s\002)"
	set_text $_lang $_name #117 "Бан \002постоянный\002."
	set_text $_lang $_name #118 "Истекает через %s."
	set_text $_lang $_name #119 "%s. » \002%s\002%s ¤ Причина: «%s» ¤ %s ¤ Бан добавлен %s назад (%s) ¤ Создатель: \002%s\002.%s"
	set_text $_lang $_name #120 "--- Конец банлиста ---"
	set_text $_lang $_name #121 "Баны, которых нет в банлисте бота, были удалены."
	set_text $_lang $_name #122 "Недостаточно прав снять бан \002%s\002, создатель: \002%s\002."
	set_text $_lang $_name #123 "Выставил на канале: \002%s\002 %s назад (%s)."
	set_text $_lang $_name #124 "--- Канальные баны ---"
	set_text $_lang $_name #125 "» \002%s\002 ¤ Выставил на канале: \002%s\002 %s назад (%s)."
	
}