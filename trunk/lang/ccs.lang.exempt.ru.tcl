
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"exempt"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang exempt {<nick/host> [время] [причина] [stick]}
	set_text -type help -- $_lang exempt {Ставит исключение nick или host (nick!ident@host) на канале. Время указывается в минутах, если время не указано, то берётся стандартное время из параметра «exempt-time» канала. Если в параметре указано \002stick\002, то исключение будет сразу возвращаться при его снятии.}
	
	set_text -type args -- $_lang unexempt {<host>}
	set_text -type help -- $_lang unexempt {Снимает исключение с канала}
	
	set_text -type args -- $_lang gexempt {<nick/host> [время] [причина] [stick]}
	set_text -type help -- $_lang gexempt {Ставит исключение nick или host (nick!ident@host) глобально (на всех каналах, где есть бот). Время указывается в минутах, если время не указано, то стандартное время - 1 день. Если в параметре указано \002stick\002, то исключение будет сразу возвращаться при его снятии}
	
	set_text -type args -- $_lang gunexempt {<host>}
	set_text -type help -- $_lang gunexempt {Снимает глобальное исключение со всех каналов}
	
	set_text -type args -- $_lang exemptlist {[global]}
	set_text -type help -- $_lang exemptlist {Выводит список исключений канала, если указан параметр «global», то выводит глобальный список исключений}
	
	set_text -type args -- $_lang resetexempts {}
	set_text -type help -- $_lang resetexempts {Убирает с канала все исключения, которых нет в списке бота}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Добавлено \002постоянное\002%s исключение: \037%s\037."
	set_text $_lang $_name #103 "%s (до %s)."
	set_text $_lang $_name #104 "Добавлено%s исключение: \037%s\037 на %s."
	set_text $_lang $_name #105 "Снято%s исключение: \002%s\002."
	set_text $_lang $_name #106 "Исключения \002%s\002 на \002%s\002 не существует."
	set_text $_lang $_name #107 "Requested"
	set_text $_lang $_name #108 "Добавлено \002постоянное\002 глобальное%s исключение: \037%s\037."
	set_text $_lang $_name #109 "Добавлено глобальное%s исключение: \037%s\037 на %s."
	set_text $_lang $_name #110 "Снято глобальное%s исключение: \002%s\002"
	set_text $_lang $_name #111 "Глобального исключения \002%s\002 не существует."
	set_text $_lang $_name #112 "--- Глобальный список исключений%s ---"
	set_text $_lang $_name #113 "--- Список исключений \002%s\002%s ---"
	set_text $_lang $_name #114 "*** Пуст ***"
	set_text $_lang $_name #115 "Исключение \002постоянное\002."
	set_text $_lang $_name #116 "Истекает через %s."
	set_text $_lang $_name #117 "» %s %s¤ Причина: «%s» ¤ %s ¤ Исключение добавлено %s назад ¤ Создатель: \002%s\002.%s"
	set_text $_lang $_name #118 "--- Конец списка исключений ---"
	set_text $_lang $_name #119 "Исключения, которых нет в списке бота, были удалены."
	set_text $_lang $_name #120 "\037стик\037"
	set_text $_lang $_name #121 "(маска \002%s\002)"
	set_text $_lang $_name #122 "Выставил на канале: \002%s\002 %s назад."
	set_text $_lang $_name #123 "--- Канальные исключения ---"
	set_text $_lang $_name #124 "» \002%s\002 ¤ Выставил на канале: \002%s\002 %s назад."
	
}