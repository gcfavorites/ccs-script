
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"exempt"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"26-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,exempt) {<юзир/хост> [время] [за че иво таг?] [stick]}
	set ccs(help,pod,exempt) {Замутидь изключенийе на \002юзир\002а или \002хост\002 (nick!ident@host) на канале. Времйа указываицца ф минутох, если времйа ниуказана, то ано пистецца из парамидра «exempt-time» канала. Если ф парамидре указано \002stick\002, то изключенийе будит сразу фазфращацца при иво снятии.}
	
	set ccs(args,pod,unexempt) {<хост>}
	set ccs(help,pod,unexempt) {Снядьнах изключенийе с конала}
	
	set ccs(args,pod,gexempt) {<юзир/хост> [время] [за че иво таг?] [stick]}
	set ccs(help,pod,gexempt) {Замутидь изключенийе на \002юзир\002а или \002хост\002 (nick!ident@host) глабальна (на фсех каналах, где езть бот). Времйа указываицца в минутох, если времйа ниуказана, то стандартнайе времйа - 1 день. Если ф парамидре указано \002stick\002, то изключенийе будит сразу фазфращацца при иво снятии.}
	
	set ccs(args,pod,gunexempt) {<хост>}
	set ccs(help,pod,gunexempt) {Снядь глабальнайе изключенийе са фсех каналафф}
	
	set ccs(args,pod,exemptlist) {[global]}
	set ccs(help,pod,exemptlist) {Выводид списак изключений канала, если указан парамидр «global», то выводит глабальный списак изключеней}
	
	set ccs(args,pod,resetexempts) {}
	set ccs(help,pod,resetexempts) {Стередьнах с конала фсе изключенийа, каторых нед ф списки бота}
	
	set ccs(text,exempt,pod,#101) "Па причине: так нада и ниибед!"
	set ccs(text,exempt,pod,#102) "Зобабахано \002пастайанайе\002%s изключенийе: \037%s\037."
	set ccs(text,exempt,pod,#103) "%s (до %s)."
	set ccs(text,exempt,pod,#104) "Зобабахано%s изключенийе: \037%s\037 на %s."
	set ccs(text,exempt,pod,#105) "Стердонах%s изключенийе: \002%s\002."
	set ccs(text,exempt,pod,#106) "Изключенийа \002%s\002 на \002%s\002 нихуйанед! Пратри ачкинах!"
	set ccs(text,exempt,pod,#107) "Па причине: так нада и ниибед!"
	set ccs(text,exempt,pod,#108) "Зобабахано \002пастойанайе\002 глабальнае%s изключенийе: \037%s\037."
	set ccs(text,exempt,pod,#109) "Зобабахано глабальнайе%s изключенийе: \037%s\037 на %s."
	set ccs(text,exempt,pod,#110) "Стердонах глабальнайе%s изключенийе: \002%s\002"
	set ccs(text,exempt,pod,#111) "Глабальнава изключенийа \002%s\002 нетунихуйа."
	set ccs(text,exempt,pod,#112) "--- Глабальный списак изключений%s ---"
	set ccs(text,exempt,pod,#113) "--- Списак изключений \002%s\002%s ---"
	set ccs(text,exempt,pod,#114) "*** Нихуйанед ***"
	set ccs(text,exempt,pod,#115) "Изключенийе \002пастайанайе\002."
	set ccs(text,exempt,pod,#116) "Истикаит чириз %s."
	set ccs(text,exempt,pod,#117) "» %s %s¤ Папричине: «%s» ¤ %s ¤ Изключенийе зобабахано %s назад ¤ Зобабахальщик: \002%s\002.%s"
	set ccs(text,exempt,pod,#118) "--- Канецнах списка изключений ---"
	set ccs(text,exempt,pod,#119) "Изключенийа, каторых нед ф списки бота, были стерданых."
	set ccs(text,exempt,pod,#120) "\037стик\037"
	set ccs(text,exempt,pod,#121) "(маско \002%s\002)"
	set ccs(text,exempt,pod,#122) "Зобабахал на конале: \002%s\002 %s назад."
	set ccs(text,exempt,pod,#123) "--- Кональные изключенийа ---"
	set ccs(text,exempt,pod,#124) "» \002%s\002 ¤ Зобабахал на конале: \002%s\002 %s назад."
	
}