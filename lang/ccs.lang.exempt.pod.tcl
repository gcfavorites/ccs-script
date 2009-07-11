
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"exempt"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang exempt {<юзир/хост> [время] [за че иво таг?] [stick]}
	set_text -type help -- $_lang exempt {Замутидь изключенийе на \002юзир\002а или \002хост\002 (nick!ident@host) на канале. Времйа указываицца ф минутох, если времйа ниуказана, то ано пистецца из парамидра «exempt-time» канала. Если ф парамидре указано \002stick\002, то изключенийе будит сразу фазфращацца при иво снятии.}
	
	set_text -type args -- $_lang unexempt {<хост>}
	set_text -type help -- $_lang unexempt {Снядьнах изключенийе с конала}
	
	set_text -type args -- $_lang gexempt {<юзир/хост> [время] [за че иво таг?] [stick]}
	set_text -type help -- $_lang gexempt {Замутидь изключенийе на \002юзир\002а или \002хост\002 (nick!ident@host) глабальна (на фсех каналах, где езть бот). Времйа указываицца в минутох, если времйа ниуказана, то стандартнайе времйа - 1 день. Если ф парамидре указано \002stick\002, то изключенийе будит сразу фазфращацца при иво снятии.}
	
	set_text -type args -- $_lang gunexempt {<хост>}
	set_text -type help -- $_lang gunexempt {Снядь глабальнайе изключенийе са фсех каналафф}
	
	set_text -type args -- $_lang exemptlist {[global]}
	set_text -type help -- $_lang exemptlist {Выводид списак изключений канала, если указан парамидр «global», то выводит глабальный списак изключеней}
	
	set_text -type args -- $_lang resetexempts {}
	set_text -type help -- $_lang resetexempts {Стередьнах с конала фсе изключенийа, каторых нед ф списки бота}
	
	set_text $_lang $_name #101 "Па причине: так нада и ниибед!"
	set_text $_lang $_name #102 "Зобабахано \002пастайанайе\002%s изключенийе: \037%s\037."
	set_text $_lang $_name #103 "%s (до %s)."
	set_text $_lang $_name #104 "Зобабахано%s изключенийе: \037%s\037 на %s."
	set_text $_lang $_name #105 "Стердонах%s изключенийе: \002%s\002."
	set_text $_lang $_name #106 "Изключенийа \002%s\002 на \002%s\002 нихуйанед! Пратри ачкинах!"
	set_text $_lang $_name #107 "Па причине: так нада и ниибед!"
	set_text $_lang $_name #108 "Зобабахано \002пастойанайе\002 глабальнае%s изключенийе: \037%s\037."
	set_text $_lang $_name #109 "Зобабахано глабальнайе%s изключенийе: \037%s\037 на %s."
	set_text $_lang $_name #110 "Стердонах глабальнайе%s изключенийе: \002%s\002"
	set_text $_lang $_name #111 "Глабальнава изключенийа \002%s\002 нетунихуйа."
	set_text $_lang $_name #112 "--- Глабальный списак изключений%s ---"
	set_text $_lang $_name #113 "--- Списак изключений \002%s\002%s ---"
	set_text $_lang $_name #114 "*** Нихуйанед ***"
	set_text $_lang $_name #115 "Изключенийе \002пастайанайе\002."
	set_text $_lang $_name #116 "Истикаит чириз %s."
	set_text $_lang $_name #117 "» %s %s¤ Папричине: «%s» ¤ %s ¤ Изключенийе зобабахано %s назад ¤ Зобабахальщик: \002%s\002.%s"
	set_text $_lang $_name #118 "--- Канецнах списка изключений ---"
	set_text $_lang $_name #119 "Изключенийа, каторых нед ф списки бота, были стерданых."
	set_text $_lang $_name #120 "\037стик\037"
	set_text $_lang $_name #121 "(маско \002%s\002)"
	set_text $_lang $_name #122 "Зобабахал на конале: \002%s\002 %s назад."
	set_text $_lang $_name #123 "--- Кональные изключенийа ---"
	set_text $_lang $_name #124 "» \002%s\002 ¤ Зобабахал на конале: \002%s\002 %s назад."
	
}