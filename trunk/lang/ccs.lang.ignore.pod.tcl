
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ignore"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang addignore {<юзир/хост> [времйа] [за че иво таг?]}
	set_text -type help -- $_lang addignore {Заигноредь \002юзир\002а или \002хост\002 (nick!ident@host). Времйа указываицца ф минутах, если времйа ниуказано, то стандартнайе времйа - 1 день}
	
	set_text -type args -- $_lang delignore {<хост>}
	set_text -type help -- $_lang delignore {Снядь игнор с \002хост\002а}
	
	set_text -type args -- $_lang ignorelist {}
	set_text -type help -- $_lang ignorelist {Вывести списак игнорафф}
	
	set_text $_lang $_name #101 "Фпезду"
	set_text $_lang $_name #102 "Зобобахан игнор: \037%s\037 на %s."
	set_text $_lang $_name #103 "Зобобахан \002пастаянный\002 игнор: \037%s\037."
	set_text $_lang $_name #104 "Снят игнор: \002%s\002."
	set_text $_lang $_name #105 "Игнора \002%s\002 нихуйанед."
	set_text $_lang $_name #106 "--- Глабальный лист игнорафф ---"
	set_text $_lang $_name #107 "Игнор \002пастаянный\002."
	set_text $_lang $_name #108 "Истикаид черис %s."
	set_text $_lang $_name #109 "» %s ¤ Папричине: «%s» ¤ %s ¤ Игнор захриначин %s назад ¤ Захриначильщик: \002%s\002."
	set_text $_lang $_name #110 "*** Нетунихуйа ***"
	set_text $_lang $_name #111 "--- Канецнах игнорлиста ---"
	
	
}