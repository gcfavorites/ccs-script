
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"invite"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang invite {<nick/hostmask> [время] [причина] [stick]}
	set_text -type help -- $_lang invite {Выставляет инвайт}
	set_text -type help2 -- $_lang invite {
		{Ставит инвайт nick или host (nick!ident@host) на канале.}
		{Время указывается в минутах, если время не указано, то берётся стандартное время из параметра «invite-time» канала.}
		{Если в параметре указано \002stick\002, то инвайт будет сразу возвращаться при его снятии.}
	}
	
	set_text -type args -- $_lang uninvite {<hostmask>}
	set_text -type help -- $_lang uninvite {Снимает инвайт с канала}
	
	set_text -type args -- $_lang ginvite {<nick/hostmask> [время] [причина] [stick]}
	set_text -type help -- $_lang ginvite {Выставляет глобальный инвайт}
	set_text -type help2 -- $_lang ginvite {
		{Ставит инвайт nick или host (nick!ident@host) глобально (на всех каналах, где есть бот).}
		{Время указывается в минутах, если время не указано, то стандартное время - 1 день.}
		{Если в параметре указано \002stick\002, то инвайт будет сразу возвращаться при его снятии}
	}
	
	set_text -type args -- $_lang guninvite {<hostmask>}
	set_text -type help -- $_lang guninvite {Снимает глобальный инвайт со всех каналов}
	
	set_text -type args -- $_lang invitelist {[global]}
	set_text -type help -- $_lang invitelist {Выводит список инвайтов канала, если указан параметр «global», то выводит глобальный список инвайтов}
	
	set_text -type args -- $_lang resetinvites {}
	set_text -type help -- $_lang resetinvites {Убирает с канала все инвайты, которых нет в списке бота}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Добавлен \002постоянный\002%s инвайт: \037%s\037."
	set_text $_lang $_name #103 "%s (до %s)."
	set_text $_lang $_name #104 "Добавлен%s инвайт: \037%s\037 на %s."
	set_text $_lang $_name #105 "Снят%s инвайт: \002%s\002."
	set_text $_lang $_name #106 "Инвайта \002%s\002 на \002%s\002 не существует."
	set_text $_lang $_name #107 "Requested"
	set_text $_lang $_name #108 "Добавлен \002постоянный\002 глобальный%s инвайт: \037%s\037."
	set_text $_lang $_name #109 "Добавлен глобальный%s инвайт: \037%s\037 на %s."
	set_text $_lang $_name #110 "Снят глобальный%s инвайт: \002%s\002"
	set_text $_lang $_name #111 "Глобального инвайта \002%s\002 не существует."
	set_text $_lang $_name #112 "--- Глобальный список инвайтов%s ---"
	set_text $_lang $_name #113 "--- Список инвайтов \002%s\002%s ---"
	set_text $_lang $_name #114 "*** Пуст ***"
	set_text $_lang $_name #115 "Инвайт \002постоянный\002."
	set_text $_lang $_name #116 "Истекает через %s."
	set_text $_lang $_name #117 "» %s %s¤ Причина: «%s» ¤ %s ¤ Инвайт добавлен %s назад ¤ Создатель: \002%s\002.%s"
	set_text $_lang $_name #118 "--- Конец списка инвайтов ---"
	set_text $_lang $_name #119 "Инвайты, которых нет в списке бота, были удалены."
	set_text $_lang $_name #120 "\037стик\037"
	set_text $_lang $_name #121 "(маска \002%s\002)"
	set_text $_lang $_name #122 "Выставил на канале: \002%s\002 %s назад."
	set_text $_lang $_name #123 "--- Канальные инвайты ---"
	set_text $_lang $_name #124 "» \002%s\002 ¤ Выставил на канале: \002%s\002 %s назад."
	
}