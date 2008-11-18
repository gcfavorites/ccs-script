
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"exempt"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.1" \
				"26-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,exempt) {<nick/host> [время] [причина] [stick]}
	set ccs(help,ru,exempt) {Ставит исключение nick или host (nick!ident@host) на канале. Время указывается в минутах, если время не указано, то берётся стандартное время из параметра «exempt-time» канала. Если в параметре указано \002stick\002, то исключение будет сразу возвращаться при его снятии.}
	
	set ccs(args,ru,unexempt) {<host>}
	set ccs(help,ru,unexempt) {Снимает исключение с канала}
	
	set ccs(args,ru,gexempt) {<nick/host> [время] [причина] [stick]}
	set ccs(help,ru,gexempt) {Ставит исключение nick или host (nick!ident@host) глобально (на всех каналах, где есть бот). Время указывается в минутах, если время не указано, то стандартное время - 1 день. Если в параметре указано \002stick\002, то исключение будет сразу возвращаться при его снятии}
	
	set ccs(args,ru,gunexempt) {<host>}
	set ccs(help,ru,gunexempt) {Снимает глобальное исключение со всех каналов}
	
	set ccs(args,ru,exemptlist) {[global]}
	set ccs(help,ru,exemptlist) {Выводит список исключений канала, если указан параметр «global», то выводит глобальный список исключений}
	
	set ccs(args,ru,resetexempts) {}
	set ccs(help,ru,resetexempts) {Убирает с канала все исключения, которых нет в списке бота}
	
	set ccs(text,exempt,ru,#101) "Requested"
	set ccs(text,exempt,ru,#102) "Добавлено \002постоянное\002%s исключение: \037%s\037."
	set ccs(text,exempt,ru,#103) "%s (до %s)."
	set ccs(text,exempt,ru,#104) "Добавлено%s исключение: \037%s\037 на %s."
	set ccs(text,exempt,ru,#105) "Снято%s исключение: \002%s\002."
	set ccs(text,exempt,ru,#106) "Исключения \002%s\002 на \002%s\002 не существует."
	set ccs(text,exempt,ru,#107) "Requested"
	set ccs(text,exempt,ru,#108) "Добавлено \002постоянное\002 глобальное%s исключение: \037%s\037."
	set ccs(text,exempt,ru,#109) "Добавлено глобальное%s исключение: \037%s\037 на %s."
	set ccs(text,exempt,ru,#110) "Снято глобальное%s исключение: \002%s\002"
	set ccs(text,exempt,ru,#111) "Глобального исключения \002%s\002 не существует."
	set ccs(text,exempt,ru,#112) "--- Глобальный список исключений%s ---"
	set ccs(text,exempt,ru,#113) "--- Список исключений \002%s\002%s ---"
	set ccs(text,exempt,ru,#114) "*** Пуст ***"
	set ccs(text,exempt,ru,#115) "Исключение \002постоянное\002."
	set ccs(text,exempt,ru,#116) "Истекает через %s."
	set ccs(text,exempt,ru,#117) "» %s %s¤ Причина: «%s» ¤ %s ¤ Исключение добавлено %s назад ¤ Создатель: \002%s\002.%s"
	set ccs(text,exempt,ru,#118) "--- Конец списка исключений ---"
	set ccs(text,exempt,ru,#119) "Исключения, которых нет в списке бота, были удалены."
	set ccs(text,exempt,ru,#120) "\037стик\037"
	set ccs(text,exempt,ru,#121) "(маска \002%s\002)"
	set ccs(text,exempt,ru,#122) "Выставил на канале: \002%s\002 %s назад."
	set ccs(text,exempt,ru,#123) "--- Канальные исключения ---"
	set ccs(text,exempt,ru,#124) "» \002%s\002 ¤ Выставил на канале: \002%s\002 %s назад."
	
}