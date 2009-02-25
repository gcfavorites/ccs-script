
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"regban"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.1" \
				"25-Feb-2009"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,regbanlist) {}
	set ccs(help,ru,regbanlist) {Просмотр списка регулярных банов}
	
	set ccs(args,ru,regban) {<[-host {rege}] [-server {rege}] [-status {rege}] [-hops number] [-name {rege}]> [options]}
	set ccs(help,ru,regban) {Выставление регулярного бана}
	set ccs(help2,ru,regban) {
		{Выставление регулярного бана. Доступные опции:}
		{  \002-ban [number]\002 - Действие бан. Возможно указание маски бана, если маска бана не указана, то берется значение по умолчанию для канала. (список хостмаскок можно посмотреть командой \002%pref_info mask\002)}
		{  \002-kick [{reason}]\002 - Действие кик. Указание причины не обязательно.}
		{  \002-notify {handle1,handle2 ...} [{text}]\002 - Действие нотис. Отправляется нотис перечисленным хендлам/никам с указанным сообщением. Пользователь должен сидеть на одном из канале, где сидит бот.}
		{Примечание: если существует выполнимое условие с единственной указанной опцией \002-host\002 то условия с остальными опциями не будут проверяться.}
	}
	
	set ccs(args,ru,regunban) {<id>}
	set ccs(help,ru,regunban) {Удаление регулярного бана}
	
	set ccs(args,ru,regbanaction) {}
	set ccs(help,ru,regbanaction) {Тестирование регбанов для всего канала, с выполнением всех действий}
	
	set ccs(args,ru,regbantest) {}
	set ccs(help,ru,regbantest) {Тестирование регбанов для всего канала, с выполнением действия "notify" запрашиваемому}
	
	set ccs(text,regban,ru,#101) "Регулярный бан \002ID: %s\002 добавлен: %s."
	set ccs(text,regban,ru,#102) "Регулярный бан \002ID: %s\002 удален: %s."
	set ccs(text,regban,ru,#103) "Регулярный бан \002ID: %s\002 не существует."
	set ccs(text,regban,ru,#104) "--- Список регулярных банов \002%s\002 ---"
	set ccs(text,regban,ru,#105) "*** Пуст ***"
	set ccs(text,regban,ru,#106) "--- Конец списка регулярных банов ---"
	set ccs(text,regban,ru,#107) "Регулярный бан \002ID: %s\002 %s: %s."
	set ccs(text,regban,ru,#108) "Регулярное выражение \"\002%s\002\" не являеться корректным."
	
}