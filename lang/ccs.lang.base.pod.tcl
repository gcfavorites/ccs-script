
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"base"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009" \
				"Языковой файл для модуля $_name ($_lang)"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang kick {<юзир1,юзир2,...> [за че иво таг?]}
	set_text -type help -- $_lang kick {Паслать \002юзир\002ов фпезду с канала, с пречинай \002за че иво таг?\002 (пречину можна ниуказывадь)}
	
	set_text -type args -- $_lang inv {<юзир>}
	set_text -type help -- $_lang inv {Приглашенийе \002юзир\002а для фхода на канал}
	
	set_text -type args -- $_lang topic {<текст>}
	set_text -type help -- $_lang topic {Зобобахать топиг на канале}
	
	set_text -type args -- $_lang addtopic {<текст>}
	set_text -type help -- $_lang addtopic {Дабобахать \002текст\002 к топигу канала}
	
	set_text -type args -- $_lang ops {}
	set_text -type help -- $_lang ops {Паказать списак опафф канала}
	
	set_text -type args -- $_lang admins {}
	set_text -type help -- $_lang admins {Паказать списак Админафф бота (юзирафф с глабальныме флагоми)}
	
	set_text -type args -- $_lang whom {}
	set_text -type help -- $_lang whom {Вывисти списак юзирафф из патилайна бота}
	
	set_text -type args -- $_lang whois {<юзир/хэнд>}
	set_text -type help -- $_lang whois {Выводит инфармацийу па \002юизр/хэнл\002}
	
	set_text -type args -- $_lang info {[mod/lang/scr]}
	set_text -type help -- $_lang info {Выдадь инфармацийу а системи и акружении пирименных}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #103 "Фпезду"
	set_text $_lang $_name #102 "%s"
	set_text $_lang $_name #103 "%s // %s"
	set_text $_lang $_name #107 "Апиратары %s (жырным выдилины апиратары, каторыйе в анлайни, если анлайн-ник нисавпадаит с заригистрираванным на боте, то он будит указан ф скопках):"
	set_text $_lang $_name #108 "Друзьйа канала: %s."
	set_text $_lang $_name #109 "ПолуАпиратары канала: %s."
	set_text $_lang $_name #110 "Апиратары канала: %s."
	set_text $_lang $_name #111 "Мастира канала: %s."
	set_text $_lang $_name #112 "Овниры канала: %s."
	set_text $_lang $_name #113 "Администратары бота \002%s\002 (жырным выдилины администратары, каторыйе в анлайни, если анлайн-ник нисавпадаит с заригистрираванным на боте, то он будит указан ф скопках):"
	set_text $_lang $_name #114 "Глабальныйе Друзьйа (+f): %s."
	set_text $_lang $_name #115 "Глабальныйе ПолуАпиратары: %s."
	set_text $_lang $_name #116 "Глабальныйе Апиратары: %s."
	set_text $_lang $_name #117 "Глабальныйе Мастира: %s."
	set_text $_lang $_name #118 "Глабальныйе Овниры: %s."
	set_text $_lang $_name #119 "Администратар бота: \002%s\002."
	set_text $_lang $_name #120 "Нетудоманикаво в partyline."
	set_text $_lang $_name #121 "Юзиры в partyline:"
	set_text $_lang $_name #122 "\002%s\002 @ %s (%s)"
	set_text $_lang $_name #123 "\002%s\002 @ %s (%s), времйа быздэйствийа: %s."
	set_text $_lang $_name #124 "Канецнах списка."
	set_text $_lang $_name #125 "Иво флаги (глабальныйе|лакальныйе): \002%s\002. Хосты: \002%s\002.%s"
	set_text $_lang $_name #126 "афтаризираван чириз BotNet (Боты: \002%s\002)"
	set_text $_lang $_name #127 "афтаризирафалсйа (Ники: \002%s\002)"
	set_text $_lang $_name #128 "нихуйа ниафтаризиравалсйа"
	set_text $_lang $_name #129 "пирманенднойа"
	set_text $_lang $_name #130 "\002%s\002 ивляеца ботам. Иво флаги: \002%s\002. Занимаица трах-трах с: \002%s\002. Праписка: \002%s\002, писта для юзирафф: \002%s\002, писта для ботафф: \002%s\002."
	set_text $_lang $_name #131 "Ник \002%s\002 уже прысуцтвуйет на канали \002%s\002."
	set_text $_lang $_name #132 "Афтаризацийа: %s."
	set_text $_lang $_name #133 "Общайа инфармацийа нах:"
	set_text $_lang $_name #134 "версийа/автар скрипта: \002v%s \[%s\] by %s\002"
	set_text $_lang $_name #135 "количистфо юзираф: \002%s\002"
	set_text $_lang $_name #136 "время на сервиври: \002%s\002"
	set_text $_lang $_name #137 "Опирационная система: \002%s\002"
	set_text $_lang $_name #138 "сервир IRC: \002%s\002"
	set_text $_lang $_name #139 "версийа бота: \002%s\002"
	set_text $_lang $_name #140 "Suzi patch (Сузе патчь): \002%s\002"
	set_text $_lang $_name #141 "Handlen: \002%s\002"
	set_text $_lang $_name #142 "seen-nick-len: \002%s\002"
	set_text $_lang $_name #143 "кадировка: \002%s\002"
	set_text $_lang $_name #144 "uptime бота: \002%s\002"
	set_text $_lang $_name #145 "бот балтаицца фсети: \002%s\002"
	
}