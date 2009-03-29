
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"lang"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,langlist) {[mod]}
	set ccs(help,ru,langlist) {Показывает список установленных языков для модулей}
	
	set ccs(args,ru,chansetlang) {<lang/default>}
	set ccs(help,ru,chansetlang) {Выставляет язык по умолчанию для канала. Если указать \002default\002 язык будет сброшен.}
	
	set ccs(args,ru,chlang) {<nick/hand> <lang>}
	set ccs(help,ru,chlang) {Выставляет язык по умолчанию для указанного ника. Если указать \002default\002 язык будет сброшен.}
	
	set ccs(text,lang,ru,#101) "Для просмотра списка установленных языков укажите один из модулей: \002%s\002."
	set ccs(text,lang,ru,#102) "Модуль: \002%s\002, v%s \[%s\] by %s"
	set ccs(text,lang,ru,#103) " - Язык: \002%s\002, v%s \[%s\] by %s"
	set ccs(text,lang,ru,#104) "Язык \002%s\002 не найден ни для одного модуля, необходимо указать один из: \002%s\002."
	set ccs(text,lang,ru,#105) "Язык для канала \002%s\002 сброшен."
	set ccs(text,lang,ru,#106) "Язык для канала \002%s\002 выставлен на \002%s\002."
	set ccs(text,lang,ru,#107) "Язык для %s сброшен."
	set ccs(text,lang,ru,#108) "Язык для %s выставлен на \002%s\002."
	set ccs(text,lang,ru,#109) "Значение языка для канала \002%s\002 не установлено."
	set ccs(text,lang,ru,#110) "Значение языка для канала \002%s\002 установлено на \002%s\002."
	set ccs(text,lang,ru,#111) "Значение языка для %s не установлено."
	set ccs(text,lang,ru,#112) "Значение языка для %s установлено на \002%s\002."
	
}