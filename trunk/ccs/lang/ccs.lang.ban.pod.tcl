
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ban"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.2" \
				"27-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,ban) {<юзир/хост> [времйа] [за че иво таг?] [stick]}
	set ccs(help,pod,ban) {Зобанедь юзира}
	set ccs(help2,pod,ban) {
		{Зобанедь \002юзир\002а или \002хост\002 (nick!ident@host) на канали.}
		{Времйа указываицца в менутах, если времйа ниуказано, то времйа пиздецца из параметра «ban-time» канала.}
		{Если в парамидре указано \002stick\002, то зобан будит сразу фазвращацца при иво снятии}
	}
	
	set ccs(args,pod,unban) {<хостмаска>}
	set ccs(help,pod,unban) {Снимаид зобан с \002хост\002а на канали.}
	
	set ccs(args,pod,gban) {<юзир/хост> [времйа] [за че иво таг?] [stick]}
	set ccs(help,pod,gban) {Глабальна зобанидь юзира}
	set ccs(help2,pod,gban) {
		{Зобанидь \002юзир\002а или \002хост\002 (nick!ident@host) глабальна (на фсех каналах, где есть бот).}
		{Времйа указываицца в минутах, если времйа ниуказано, то времйа - 1 день.}
		{Если в парамидре указано \002stick\002, то зобан будит сразу фазвращацца при иао снятии}
	}
	
	set ccs(args,pod,gunban) {<хостмаска>}
	set ccs(help,pod,gunban) {Снимаид глабальный зобан с \002хост\002а са фсех каналаф}
	
	set ccs(args,pod,banlist) {[mask] [global]}
	set ccs(help,pod,banlist) {Паказать лист забанаф канала, если указан парамидр \002global\002, то выводед глабальный зобанлизт}
	
	set ccs(args,pod,resetbans) {}
	set ccs(help,pod,resetbans) {Убирайед с канала фсе зобаны, каторых нет ф зобанлизте бота}
	
	set ccs(text,ban,pod,#101) "Фпезду глубако и надолга"
	set ccs(text,ban,pod,#102) "Зафигачин \002пастаянный\002%s зобан: \037%s\037."
	set ccs(text,ban,pod,#103) "Зафигачин%s зобан: \037%s\037 на \002%s\002."
	set ccs(text,ban,pod,#104) "%s (до %s)."
	set ccs(text,ban,pod,#105) "\037стик\037"
	set ccs(text,ban,pod,#106) "Удалйон%s зобан: \002%s\002."
	set ccs(text,ban,pod,#107) "Зобана \002%s\002 на \002%s\002 нихуйа нисущистфуит."
	set ccs(text,ban,pod,#108) "Пшол накуй"
	set ccs(text,ban,pod,#109) "Захриначин \002пастаянный\002 глабальный%s зобан: \037%s\037."
	set ccs(text,ban,pod,#110) "Захриначин глабальный%s зобан: \037%s\037 на %s."
	set ccs(text,ban,pod,#111) "Убидь глабальный%s зобан: \002%s\002"
	set ccs(text,ban,pod,#112) "Глабальнаво зобана \002%s\002 нихуйа нисущистфуит."
	set ccs(text,ban,pod,#113) "--- Глабальный зобанлист%s ---"
	set ccs(text,ban,pod,#114) "--- Зобанлист \002%s\002%s ---"
	set ccs(text,ban,pod,#115) "*** Нетунихуйа ***"
	set ccs(text,ban,pod,#116) "(маска \002%s\002)"
	set ccs(text,ban,pod,#117) "Зобан \002пастаянный\002."
	set ccs(text,ban,pod,#118) "Истикаит черес %s."
	set ccs(text,ban,pod,#119) "%s. » \002%s\002%s ¤ Папричине: «%s» ¤ %s ¤ Зобан захриначин %s назад ¤ Захриначильщик: \002%s\002.%s"
	set ccs(text,ban,pod,#120) "--- Канецнах зобанлиста ---"
	set ccs(text,ban,pod,#121) "Зобаны, каторых нет ф зобанлисте бота, были уничьтожыны."
	
	
}