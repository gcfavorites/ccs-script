
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ban"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang ban {<юзир/хост> [времйа] [за че иво таг?] [stick]}
	set_text -type help -- $_lang ban {Зобанедь юзира}
	set_text -type help2 -- $_lang ban {
		{Зобанедь \002юзир\002а или \002хост\002 (nick!ident@host) на канали.}
		{Времйа указываицца в менутах, если времйа ниуказано, то времйа пиздецца из параметра «ban-time» канала.}
		{Если в парамидре указано \002stick\002, то зобан будит сразу фазвращацца при иво снятии}
	}
	
	set_text -type args -- $_lang unban {<хостмаска>}
	set_text -type help -- $_lang unban {Снимаид зобан с \002хост\002а на канали.}
	
	set_text -type args -- $_lang gban {<юзир/хост> [времйа] [за че иво таг?] [stick]}
	set_text -type help -- $_lang gban {Глабальна зобанидь юзира}
	set_text -type help2 -- $_lang gban {
		{Зобанидь \002юзир\002а или \002хост\002 (nick!ident@host) глабальна (на фсех каналах, где есть бот).}
		{Времйа указываицца в минутах, если времйа ниуказано, то времйа - 1 день.}
		{Если в парамидре указано \002stick\002, то зобан будит сразу фазвращацца при иао снятии}
	}
	
	set_text -type args -- $_lang gunban {<хостмаска>}
	set_text -type help -- $_lang gunban {Снимаид глабальный зобан с \002хост\002а са фсех каналаф}
	
	set_text -type args -- $_lang banlist {[mask] [global]}
	set_text -type help -- $_lang banlist {Паказать лист забанаф канала, если указан парамидр \002global\002, то выводед глабальный зобанлизт}
	
	set_text -type args -- $_lang resetbans {}
	set_text -type help -- $_lang resetbans {Убирайед с канала фсе зобаны, каторых нет ф зобанлизте бота}
	
	set_text $_lang $_name #101 "Фпезду глубако и надолга"
	set_text $_lang $_name #102 "Зафигачин \002пастаянный\002%s зобан: \037%s\037."
	set_text $_lang $_name #103 "Зафигачин%s зобан: \037%s\037 на \002%s\002."
	set_text $_lang $_name #104 "%s (до %s)."
	set_text $_lang $_name #105 "\037стик\037"
	set_text $_lang $_name #106 "Удалйон%s зобан: \002%s\002."
	set_text $_lang $_name #107 "Зобана \002%s\002 на \002%s\002 нихуйа нисущистфуит."
	set_text $_lang $_name #108 "Пшол накуй"
	set_text $_lang $_name #109 "Захриначин \002пастаянный\002 глабальный%s зобан: \037%s\037."
	set_text $_lang $_name #110 "Захриначин глабальный%s зобан: \037%s\037 на %s."
	set_text $_lang $_name #111 "Убидь глабальный%s зобан: \002%s\002"
	set_text $_lang $_name #112 "Глабальнаво зобана \002%s\002 нихуйа нисущистфуит."
	set_text $_lang $_name #113 "--- Глабальный зобанлист%s ---"
	set_text $_lang $_name #114 "--- Зобанлист \002%s\002%s ---"
	set_text $_lang $_name #115 "*** Нетунихуйа ***"
	set_text $_lang $_name #116 "(маска \002%s\002)"
	set_text $_lang $_name #117 "Зобан \002пастаянный\002."
	set_text $_lang $_name #118 "Истикаит черес %s."
	set_text $_lang $_name #119 "%s. » \002%s\002%s ¤ Папричине: «%s» ¤ %s ¤ Зобан захриначин %s назад ¤ Захриначильщик: \002%s\002.%s"
	set_text $_lang $_name #120 "--- Канецнах зобанлиста ---"
	set_text $_lang $_name #121 "Зобаны, каторых нет ф зобанлисте бота, были уничьтожыны."
	
	
}