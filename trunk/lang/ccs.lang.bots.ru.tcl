
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"bots"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,bots) {}
	set ccs(help,ru,bots) {Выводит список ботов, прилинкованных к текущему}
	
	set ccs(args,ru,botattr) {<ник/хендл> <+flags/-flags>}
	set ccs(help,ru,botattr) {Изменяет флаги ботов}
	
	set ccs(args,ru,chaddr) {<ник/хендл> <адресс[:порт бота[/порт юзеров]]>}
	set ccs(help,ru,chaddr) {Изменяет адрес и порт бота}
	
	set ccs(args,ru,addbot) {<хендл> <адресс[:порт бота[/порт юзеров]]> [хост]}
	set ccs(help,ru,addbot) {Добавляет бота в юзерлист. Если порты не прописаны будет присвоен порт по умолчанию 3333. Если порт юзеров не указан то он будет равняться порту ботов}
	
	set ccs(args,ru,delbot) {<ник/хендл>}
	set ccs(help,ru,delbot) {Удаляет бота из юзерлиста}
	
	set ccs(args,ru,chaddr) {<ник/хендл> <адресс[:порт бота[/порт юзеров]]>}
	set ccs(help,ru,chaddr) {Изменяет адресс и порты бота}
	
	set ccs(args,ru,chbotpass) {<ник/хендл> [пароль]}
	set ccs(help,ru,chbotpass) {Изменяет/очищает пароль бота}
	
	set ccs(text,bots,ru,#101) "Количество ботов в BotNet'e: \002%s\002. Дерево ботнета:"
	set ccs(text,bots,ru,#102) "Количество ботов в BotNet'e: \002%s\002."
	set ccs(text,bots,ru,#103) "Текущий BotNet: %s"
	set ccs(text,bots,ru,#104) "Бот %s был удалён из юзерлиста бота."
	set ccs(text,bots,ru,#105) "Бот %s уже есть в юзерлисте."
	set ccs(text,bots,ru,#106) "Бот \002%s\002 был успешно добавлен с адресом \002%s\002 и хостом \002%s\002."
	set ccs(text,bots,ru,#107) "Не удалось добавить бота \002%s\002."
	set ccs(text,bots,ru,#108) "Для бота %s изменен адрес (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set ccs(text,bots,ru,#109) "Новые флаги для %s: \002%s\002"
	set ccs(text,bots,ru,#110) "Новый пароль для бота %s установлен."
	set ccs(text,bots,ru,#111) "Пароль для бота %s сброшен."
	set ccs(text,bots,ru,#112) "Список соответсвий авторизации %s: %s"
	set ccs(text,bots,ru,#113) "Список соответсвий авторизации %s пуст."
	set ccs(text,bots,ru,#114) "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] уже существует."
	set ccs(text,bots,ru,#115) "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] изменено на \[bot: %s, handle: \002%s\002\]."
	set ccs(text,bots,ru,#116) "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] добавлено."
	set ccs(text,bots,ru,#117) "Cоответствие авторизации \[bot: %s, handle: \002%s\002\] уже прописано для %s."
	set ccs(text,bots,ru,#118) "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] удалено."
	set ccs(text,bots,ru,#119) "Для %s соответствие авторизации \[bot: %s\] не найдено."
	
}