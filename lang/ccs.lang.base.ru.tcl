if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"base"
set modlang		"ru"
addfileinfo lang "$modname,$modlang" \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.6" \
				"14-Mar-2009" \
				"Языковой файл для модуля $modname ($modlang)"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,kick) {<nick1,nick2,...> [причина]}
	set ccs(help,ru,kick) {Кикает \002nick\002и с канала, с причиной \002причина\002 (причину можно не указывать)}
	
	set ccs(args,ru,inv) {<nick>}
	set ccs(help,ru,inv) {Приглашение \002nick\002a для входа на канал}
	
	set ccs(args,ru,topic) {<текст>}
	set ccs(help,ru,topic) {Устанавливает топик канала}
	
	set ccs(args,ru,addtopic) {<текст>}
	set ccs(help,ru,addtopic) {Добавляет \002текст\002 к теме канала}
	
	set ccs(args,ru,ops) {}
	set ccs(help,ru,ops) {Показывает список опов канала}
	
	set ccs(args,ru,admins) {}
	set ccs(help,ru,admins) {Показывает список Администраторов бота (пользователей с глобальными флагами)}
	
	set ccs(args,ru,whom) {}
	set ccs(help,ru,whom) {Выводит список пользователей из патилайна бота}
	
	set ccs(args,ru,whois) {<nick|hand>}
	set ccs(help,ru,whois) {Выводит информацию по \002nick|hand\002}
	
	set ccs(args,ru,info) {[mod|scr|lang|mask]}
	set ccs(help,ru,info) {Выдаёт информацию о системе, установленных модулях, скриптах, языковых файлах и окружених переменных}
	set ccs(help2,ru,info) {
		{Выдаёт информацию о системе, установленных модулях, скриптах, языковых файлах и окружених переменных}
		{Если указать \002mod/scr/lang\002 то будет выдана информация об установленных модулях/скриптах/языковых файлах}
		{Если указать \002mask\002 то будет выведен список порядковых номеров хостмасок}
	}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,base,ru,#101) "Requested"
	set ccs(text,base,ru,#102) "%s"
	set ccs(text,base,ru,#103) "%s // %s"
	set ccs(text,base,ru,#107) "Операторы %s (жирным выделены операторы, которые в онлайне, если онлайн-ник не совпадает с зарегистрированным на боте, то он будет указан в скобках):"
	set ccs(text,base,ru,#108) "Друзья канала: %s."
	set ccs(text,base,ru,#109) "Полуоператоры канала: %s."
	set ccs(text,base,ru,#110) "Операторы канала: %s."
	set ccs(text,base,ru,#111) "Мастера канала: %s."
	set ccs(text,base,ru,#112) "Овнеры канала: %s."
	set ccs(text,base,ru,#113) "Администраторы бота \002%s\002 (жирным выделены администраторы, которые в онлайне, если онлайн-ник не совпадает с зарегистрированным на боте, то он будет указан в скобках):"
	set ccs(text,base,ru,#114) "Глобальные друзья (+f): %s."
	set ccs(text,base,ru,#115) "Глобальные Полуоператоры: %s."
	set ccs(text,base,ru,#116) "Глобальные Операторы: %s."
	set ccs(text,base,ru,#117) "Глобальные Мастера: %s."
	set ccs(text,base,ru,#118) "Глобальные Овнеры: %s."
	set ccs(text,base,ru,#119) "Администратор бота: \002%s\002."
	set ccs(text,base,ru,#120) "Никого нет в partyline."
	set ccs(text,base,ru,#121) "Пользователи в partyline:"
	set ccs(text,base,ru,#122) "\002%s\002 @ %s (%s)"
	set ccs(text,base,ru,#123) "\002%s\002 @ %s (%s), время бездействия: %s."
	set ccs(text,base,ru,#124) "Конец списка."
	set ccs(text,base,ru,#125) "Его флаги (глобальные|локальные): \002%s\002. Хосты: \002%s\002.%s"
	set ccs(text,base,ru,#126) "авторизирован через BotNet (Боты: \002%s\002)"
	set ccs(text,base,ru,#127) "авторизировался (Ники: \002%s\002)"
	set ccs(text,base,ru,#128) "не авторизировался"
	set ccs(text,base,ru,#129) "перманентная"
	set ccs(text,base,ru,#130) "\002%s\002 является ботом. Его флаги: \002%s\002. Прилинкован: \002%s\002. Адрес бота: \002%s\002, порт юзеров: \002%s\002, порт бота: \002%s\002."
	set ccs(text,base,ru,#131) "Ник \002%s\002 уже присутствует на канале \002%s\002."
	set ccs(text,base,ru,#132) "Авторизация: %s."
	set ccs(text,base,ru,#133) "Общая информация:"
	set ccs(text,base,ru,#134) "версия/автор скрипта: \002v%s \[%s\] by %s\002"
	set ccs(text,base,ru,#135) "кол. пользователей: \002%s\002"
	set ccs(text,base,ru,#136) "время на сервере: \002%s\002"
	set ccs(text,base,ru,#137) "OS: \002%s\002"
	set ccs(text,base,ru,#138) "сервер IRC: \002%s\002"
	set ccs(text,base,ru,#139) "версия бота: \002%s\002"
	set ccs(text,base,ru,#140) "Suzi patch: \002%s\002"
	set ccs(text,base,ru,#141) "Handlen: \002%s\002"
	set ccs(text,base,ru,#142) "seen-nick-len: \002%s\002"
	set ccs(text,base,ru,#143) "кодировка: \002%s\002"
	set ccs(text,base,ru,#144) "uptime бота: \002%s\002"
	set ccs(text,base,ru,#145) "uptime подключения: \002%s\002"
	set ccs(text,base,ru,#146) "Имя: \002%s\002, версия \002v%s\002 \[%s\] by %s, включен %s, описание: %s."
	set ccs(text,base,ru,#147) "Модули не найдены."
	set ccs(text,base,ru,#148) "Скрипты не найдены."
	set ccs(text,base,ru,#149) "Языковые файлы не найдены."
	set ccs(text,base,ru,#150) "Библиотеки не найдены."
	
}