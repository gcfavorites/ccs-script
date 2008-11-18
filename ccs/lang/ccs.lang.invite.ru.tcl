
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"invite"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.1" \
				"26-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,invite) {<nick/hostmask> [время] [причина] [stick]}
	set ccs(help,ru,invite) {Выставляет инвайт}
	set ccs(help2,ru,invite) {
		{Ставит инвайт nick или host (nick!ident@host) на канале.}
		{Время указывается в минутах, если время не указано, то берётся стандартное время из параметра «invite-time» канала.}
		{Если в параметре указано \002stick\002, то инвайт будет сразу возвращаться при его снятии.}
	}
	
	set ccs(args,ru,uninvite) {<hostmask>}
	set ccs(help,ru,uninvite) {Снимает инвайт с канала}
	
	set ccs(args,ru,ginvite) {<nick/hostmask> [время] [причина] [stick]}
	set ccs(help,ru,ginvite) {Выставляет глобальный инвайт}
	set ccs(help2,ru,ginvite) {
		{Ставит инвайт nick или host (nick!ident@host) глобально (на всех каналах, где есть бот).}
		{Время указывается в минутах, если время не указано, то стандартное время - 1 день.}
		{Если в параметре указано \002stick\002, то инвайт будет сразу возвращаться при его снятии}
	}
	
	set ccs(args,ru,guninvite) {<hostmask>}
	set ccs(help,ru,guninvite) {Снимает глобальный инвайт со всех каналов}
	
	set ccs(args,ru,invitelist) {[global]}
	set ccs(help,ru,invitelist) {Выводит список инвайтов канала, если указан параметр «global», то выводит глобальный список инвайтов}
	
	set ccs(args,ru,resetinvites) {}
	set ccs(help,ru,resetinvites) {Убирает с канала все инвайты, которых нет в списке бота}
	
	set ccs(text,invite,ru,#101) "Requested"
	set ccs(text,invite,ru,#102) "Добавлен \002постоянный\002%s инвайт: \037%s\037."
	set ccs(text,invite,ru,#103) "%s (до %s)."
	set ccs(text,invite,ru,#104) "Добавлен%s инвайт: \037%s\037 на %s."
	set ccs(text,invite,ru,#105) "Снят%s инвайт: \002%s\002."
	set ccs(text,invite,ru,#106) "Инвайта \002%s\002 на \002%s\002 не существует."
	set ccs(text,invite,ru,#107) "Requested"
	set ccs(text,invite,ru,#108) "Добавлен \002постоянный\002 глобальный%s инвайт: \037%s\037."
	set ccs(text,invite,ru,#109) "Добавлен глобальный%s инвайт: \037%s\037 на %s."
	set ccs(text,invite,ru,#110) "Снят глобальный%s инвайт: \002%s\002"
	set ccs(text,invite,ru,#111) "Глобального инвайта \002%s\002 не существует."
	set ccs(text,invite,ru,#112) "--- Глобальный список инвайтов%s ---"
	set ccs(text,invite,ru,#113) "--- Список инвайтов \002%s\002%s ---"
	set ccs(text,invite,ru,#114) "*** Пуст ***"
	set ccs(text,invite,ru,#115) "Инвайт \002постоянный\002."
	set ccs(text,invite,ru,#116) "Истекает через %s."
	set ccs(text,invite,ru,#117) "» %s %s¤ Причина: «%s» ¤ %s ¤ Инвайт добавлен %s назад ¤ Создатель: \002%s\002.%s"
	set ccs(text,invite,ru,#118) "--- Конец списка инвайтов ---"
	set ccs(text,invite,ru,#119) "Инвайты, которых нет в списке бота, были удалены."
	set ccs(text,invite,ru,#120) "\037стик\037"
	set ccs(text,exempt,ru,#121) "(маска \002%s\002)"
	set ccs(text,exempt,ru,#122) "Выставил на канале: \002%s\002 %s назад."
	set ccs(text,exempt,ru,#123) "--- Канальные инвайты ---"
	set ccs(text,exempt,ru,#124) "» \002%s\002 ¤ Выставил на канале: \002%s\002 %s назад."
	
}