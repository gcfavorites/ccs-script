
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"lang"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang langlist {[mod]}
	set_text -type help -- $_lang langlist {Показывает список установленных языков для модулей}
	
	set_text -type args -- $_lang chansetlang {<lang/default>}
	set_text -type help -- $_lang chansetlang {Выставляет язык по умолчанию для канала. Если указать \002default\002 язык будет сброшен.}
	
	set_text -type args -- $_lang chlang {<nick/hand> <lang>}
	set_text -type help -- $_lang chlang {Выставляет язык по умолчанию для указанного ника. Если указать \002default\002 язык будет сброшен.}
	
	set_text $_lang $_name #101 "Для просмотра списка установленных языков укажите один из модулей: \002%s\002."
	set_text $_lang $_name #102 "Модуль: \002%s\002, v%s \[%s\] by %s"
	set_text $_lang $_name #103 " - Язык: \002%s\002, v%s \[%s\] by %s"
	set_text $_lang $_name #104 "Язык \002%s\002 не найден ни для одного модуля, необходимо указать один из: \002%s\002."
	set_text $_lang $_name #105 "Язык для канала \002%s\002 сброшен."
	set_text $_lang $_name #106 "Язык для канала \002%s\002 выставлен на \002%s\002."
	set_text $_lang $_name #107 "Язык для %s сброшен."
	set_text $_lang $_name #108 "Язык для %s выставлен на \002%s\002."
	set_text $_lang $_name #109 "Значение языка для канала \002%s\002 не установлено."
	set_text $_lang $_name #110 "Значение языка для канала \002%s\002 установлено на \002%s\002."
	set_text $_lang $_name #111 "Значение языка для %s не установлено."
	set_text $_lang $_name #112 "Значение языка для %s установлено на \002%s\002."
	
}