
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ban"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.3" \
				"27-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,ban) {<nick/host> [время] [причина] [stick]}
	set ccs(help,ru,ban) {Выставляет бан}
	set ccs(help2,ru,ban) {
		{Банит \002nick\002 или \002host\002 (nick!ident@host) с канала.}
		{Время указывается в минутах, если время не указано, то время берётся из параметра «ban-time» канала.}
		{Если в параметре указано \002stick\002, то бан будет сразу возвращаться при его снятии.}
	}
	
	set ccs(args,ru,unban) {<hostmask>}
	set ccs(help,ru,unban) {Снимает бан \002host\002 с канала.}
	
	set ccs(args,ru,gban) {<nick/host> [время] [причина] [stick]}
	set ccs(help,ru,gban) {Выставляет глобальный бан}
	set ccs(help2,ru,gban) {
		{Банит \002nick\002 или \002host\002 (nick!ident@host) глобально (на всех каналах, где есть бот).}
		{Время указывается в минутах, если время не указано, то время - 1 день.}
		{Если в параметре указано \002stick\002, то бан будет сразу возвращаться при его снятии.}
	}
	
	set ccs(args,ru,gunban) {<hostmask>}
	set ccs(help,ru,gunban) {Снимает глобальный бан \002host\002 со всех каналов}
	
	set ccs(args,ru,banlist) {[mask] [global]}
	set ccs(help,ru,banlist) {Выводит банлист канала, если указан параметр \002global\002, то выводит глобальный банлист}
	
	set ccs(args,ru,resetbans) {}
	set ccs(help,ru,resetbans) {Убирает с канала все баны, которых нет в банлисте бота}
	
	set ccs(text,ban,ru,#101) "Requested"
	set ccs(text,ban,ru,#102) "Добавлен \002постоянный\002%s бан: \037%s\037."
	set ccs(text,ban,ru,#103) "Добавлен%s бан: \037%s\037 на \002%s\002."
	set ccs(text,ban,ru,#104) "%s (до %s)."
	set ccs(text,ban,ru,#105) "\037стик\037"
	set ccs(text,ban,ru,#106) "Снят%s бан: \002%s\002."
	set ccs(text,ban,ru,#107) "Бана \002%s\002 на \002%s\002 не существует."
	set ccs(text,ban,ru,#108) "Requested"
	set ccs(text,ban,ru,#109) "Добавлен \002постоянный\002 глобальный%s бан: \037%s\037."
	set ccs(text,ban,ru,#110) "Добавлен глобальный%s бан: \037%s\037 на %s."
	set ccs(text,ban,ru,#111) "Снят глобальный%s бан: \002%s\002"
	set ccs(text,ban,ru,#112) "Глобального бана \002%s\002 не существует."
	set ccs(text,ban,ru,#113) "--- Глобальный банлист%s ---"
	set ccs(text,ban,ru,#114) "--- Банлист \002%s\002%s ---"
	set ccs(text,ban,ru,#115) "*** Пуст ***"
	set ccs(text,ban,ru,#116) "(маска \002%s\002)"
	set ccs(text,ban,ru,#117) "Бан \002постоянный\002."
	set ccs(text,ban,ru,#118) "Истекает через %s."
	set ccs(text,ban,ru,#119) "%s. » \002%s\002%s ¤ Причина: «%s» ¤ %s ¤ Бан добавлен %s назад ¤ Создатель: \002%s\002.%s"
	set ccs(text,ban,ru,#120) "--- Конец банлиста ---"
	set ccs(text,ban,ru,#121) "Баны, которых нет в банлисте бота, были удалены."
	set ccs(text,ban,ru,#122) "Недостаточно прав снять бан \002%s\002, создатель: \002%s\002."
	set ccs(text,ban,ru,#123) "Выставил на канале: \002%s\002 %s назад."
	set ccs(text,ban,ru,#124) "--- Канальные баны ---"
	set ccs(text,ban,ru,#125) "» \002%s\002 ¤ Выставил на канале: \002%s\002 %s назад."
	
}