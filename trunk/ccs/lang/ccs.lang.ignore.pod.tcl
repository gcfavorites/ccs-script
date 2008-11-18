
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"ignore"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,addignore) {<юзир/хост> [времйа] [за че иво таг?]}
	set ccs(help,pod,addignore) {Заигноредь \002юзир\002а или \002хост\002 (nick!ident@host). Времйа указываицца ф минутах, если времйа ниуказано, то стандартнайе времйа - 1 день}
	
	set ccs(args,pod,delignore) {<хост>}
	set ccs(help,pod,delignore) {Снядь игнор с \002хост\002а}
	
	set ccs(args,pod,ignorelist) {}
	set ccs(help,pod,ignorelist) {Вывести списак игнорафф}
	
	set ccs(text,ignore,pod,#101) "Фпезду"
	set ccs(text,ignore,pod,#102) "Зобобахан игнор: \037%s\037 на %s."
	set ccs(text,ignore,pod,#103) "Зобобахан \002пастаянный\002 игнор: \037%s\037."
	set ccs(text,ignore,pod,#104) "Снят игнор: \002%s\002."
	set ccs(text,ignore,pod,#105) "Игнора \002%s\002 нихуйанед."
	set ccs(text,ignore,pod,#106) "--- Глабальный лист игнорафф ---"
	set ccs(text,ignore,pod,#107) "Игнор \002пастаянный\002."
	set ccs(text,ignore,pod,#108) "Истикаид черис %s."
	set ccs(text,ignore,pod,#109) "» %s ¤ Папричине: «%s» ¤ %s ¤ Игнор захриначин %s назад ¤ Захриначильщик: \002%s\002."
	set ccs(text,ignore,pod,#110) "*** Нетунихуйа ***"
	set ccs(text,ignore,pod,#111) "--- Канецнах игнорлиста ---"
	
	
}