
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"regban"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang regbanlist {}
	set_text -type help -- $_lang regbanlist {Просмотр списка регулярных банов}
	
	set_text -type args -- $_lang regban {<[-host {rege}] [-server {rege}] [-status {rege}] [-hops number] [-name {rege}]> [options]}
	set_text -type help -- $_lang regban {Выставление регулярного бана}
	set_text -type help2 -- $_lang regban {
		{Выставление регулярного бана. Доступные опции:}
		{  \002-ban [number]\002 - Действие бан. Возможно указание маски бана, если маска бана не указана, то берется значение по умолчанию для канала. (список хостмаскок можно посмотреть командой \002%pref_info mask\002)}
		{  \002-kick [{reason}]\002 - Действие кик. Указание причины не обязательно.}
		{  \002-notify {handle1,handle2 ...} [{text}]\002 - Действие нотис. Отправляется нотис перечисленным хендлам/никам с указанным сообщением. Пользователь должен сидеть на одном из канале, где сидит бот.}
		{Примечание: если существует выполнимое условие с единственной указанной опцией \002-host\002 то условия с остальными опциями не будут проверяться.}
	}
	
	set_text -type args -- $_lang regunban {<id>}
	set_text -type help -- $_lang regunban {Удаление регулярного бана}
	
	set_text -type args -- $_lang regbanaction {}
	set_text -type help -- $_lang regbanaction {Тестирование регбанов для всего канала, с выполнением всех действий}
	
	set_text -type args -- $_lang regbantest {}
	set_text -type help -- $_lang regbantest {Тестирование регбанов для всего канала, с выполнением действия "notify" запрашиваемому}
	
	set_text $_lang $_name #101 "Регулярный бан \002ID: %s\002 добавлен: %s."
	set_text $_lang $_name #102 "Регулярный бан \002ID: %s\002 удален: %s."
	set_text $_lang $_name #103 "Регулярный бан \002ID: %s\002 не существует."
	set_text $_lang $_name #104 "--- Список регулярных банов \002%s\002 ---"
	set_text $_lang $_name #105 "*** Пуст ***"
	set_text $_lang $_name #106 "--- Конец списка регулярных банов ---"
	set_text $_lang $_name #107 "Регулярный бан \002ID: %s\002 %s: %s."
	set_text $_lang $_name #108 "Регулярное выражение \"\002%s\002\" не являеться корректным."
	
}