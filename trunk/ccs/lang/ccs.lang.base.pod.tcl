
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"base"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.3" \
				"11-Nov-2008" \
				"Языковой файл для модуля $modname ($modlang)"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,kick) {<юзир1,юзир2,...> [за че иво таг?]}
	set ccs(help,pod,kick) {Паслать \002юзир\002ов фпезду с канала, с пречинай \002за че иво таг?\002 (пречину можна ниуказывадь)}
	
	set ccs(args,pod,inv) {<юзир>}
	set ccs(help,pod,inv) {Приглашенийе \002юзир\002а для фхода на канал}
	
	set ccs(args,pod,topic) {<текст>}
	set ccs(help,pod,topic) {Зобобахать топиг на канале}
	
	set ccs(args,pod,addtopic) {<текст>}
	set ccs(help,pod,addtopic) {Дабобахать \002текст\002 к топигу канала}
	
	set ccs(args,pod,ops) {}
	set ccs(help,pod,ops) {Паказать списак опафф канала}
	
	set ccs(args,pod,admins) {}
	set ccs(help,pod,admins) {Паказать списак Админафф бота (юзирафф с глабальныме флагоми)}
	
	set ccs(args,pod,whom) {}
	set ccs(help,pod,whom) {Вывисти списак юзирафф из патилайна бота}
	
	set ccs(args,pod,whois) {<юзир/хэнд>}
	set ccs(help,pod,whois) {Выводит инфармацийу па \002юизр/хэнл\002}
	
	set ccs(args,pod,info) {[mod/lang/scr]}
	set ccs(help,pod,info) {Выдадь инфармацийу а системи и акружении пирименных}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,base,pod,#103) "Фпезду"
	set ccs(text,base,pod,#102) "%s"
	set ccs(text,base,pod,#103) "%s // %s"
	set ccs(text,base,pod,#107) "Апиратары %s (жырным выдилины апиратары, каторыйе в анлайни, если анлайн-ник нисавпадаит с заригистрираванным на боте, то он будит указан ф скопках):"
	set ccs(text,base,pod,#108) "Друзьйа канала: %s."
	set ccs(text,base,pod,#109) "ПолуАпиратары канала: %s."
	set ccs(text,base,pod,#110) "Апиратары канала: %s."
	set ccs(text,base,pod,#111) "Мастира канала: %s."
	set ccs(text,base,pod,#112) "Овниры канала: %s."
	set ccs(text,base,pod,#113) "Администратары бота \002%s\002 (жырным выдилины администратары, каторыйе в анлайни, если анлайн-ник нисавпадаит с заригистрираванным на боте, то он будит указан ф скопках):"
	set ccs(text,base,pod,#114) "Глабальныйе Друзьйа (+f): %s."
	set ccs(text,base,pod,#115) "Глабальныйе ПолуАпиратары: %s."
	set ccs(text,base,pod,#116) "Глабальныйе Апиратары: %s."
	set ccs(text,base,pod,#117) "Глабальныйе Мастира: %s."
	set ccs(text,base,pod,#118) "Глабальныйе Овниры: %s."
	set ccs(text,base,pod,#119) "Администратар бота: \002%s\002."
	set ccs(text,base,pod,#120) "Нетудоманикаво в partyline."
	set ccs(text,base,pod,#121) "Юзиры в partyline:"
	set ccs(text,base,pod,#122) "\002%s\002 @ %s (%s)"
	set ccs(text,base,pod,#123) "\002%s\002 @ %s (%s), времйа быздэйствийа: %s."
	set ccs(text,base,pod,#124) "Канецнах списка."
	set ccs(text,base,pod,#125) "Иво флаги (глабальныйе|лакальныйе): \002%s\002. Хосты: \002%s\002.%s"
	set ccs(text,base,pod,#126) "афтаризираван чириз BotNet (Боты: \002%s\002)"
	set ccs(text,base,pod,#127) "афтаризирафалсйа (Ники: \002%s\002)"
	set ccs(text,base,pod,#128) "нихуйа ниафтаризиравалсйа"
	set ccs(text,base,pod,#129) "пирманенднойа"
	set ccs(text,base,pod,#130) "\002%s\002 ивляеца ботам. Иво флаги: \002%s\002. Занимаица трах-трах с: \002%s\002. Праписка: \002%s\002, писта для юзирафф: \002%s\002, писта для ботафф: \002%s\002."
	set ccs(text,base,pod,#131) "Ник \002%s\002 уже прысуцтвуйет на канали \002%s\002."
	set ccs(text,base,pod,#132) "Афтаризацийа: %s."
	set ccs(text,base,pod,#133) "Общайа инфармацийа нах:"
	set ccs(text,base,pod,#134) "версийа/автар скрипта: \002v%s \[%s\] by %s\002"
	set ccs(text,base,pod,#135) "количистфо юзираф: \002%s\002"
	set ccs(text,base,pod,#136) "время на сервиври: \002%s\002"
	set ccs(text,base,pod,#137) "Опирационная система: \002%s\002"
	set ccs(text,base,pod,#138) "сервир IRC: \002%s\002"
	set ccs(text,base,pod,#139) "версийа бота: \002%s\002"
	set ccs(text,base,pod,#140) "Suzi patch (Сузе патчь): \002%s\002"
	set ccs(text,base,pod,#141) "Handlen: \002%s\002"
	set ccs(text,base,pod,#142) "seen-nick-len: \002%s\002"
	set ccs(text,base,pod,#143) "кадировка: \002%s\002"
	set ccs(text,base,pod,#144) "uptime бота: \002%s\002"
	set ccs(text,base,pod,#145) "бот балтаицца фсети: \002%s\002"
	
}