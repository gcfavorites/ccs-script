
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"bots"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang bots {}
	set_text -type help -- $_lang bots {Выводид списак ботафф, каторыи прилинкофаны к тикущиму}
	
	set_text -type args -- $_lang botattr {<юзир/хэндл> <+флаги/-флаги>}
	set_text -type help -- $_lang botattr {Изминйаид флаги ботафф}
	
	set_text -type args -- $_lang chaddr {<юзир/хэндл> <адрис[:порд бота[/порт юзирафф]]>}
	set_text -type help -- $_lang chaddr {Изминильнах адрис и порд бота}
	
	set_text -type args -- $_lang addbot {<хэндл> <адрис[:порд бота[/порт юзирафф]]> [хост]}
	set_text -type help -- $_lang addbot {Прибобахать бота в юзирлист. Если парты нипраписаны - будит присвоин порт паумолчанийу 3333. Если порд юзирафф ниуказан, то он будит равнйацца парду ботафф}
	
	set_text -type args -- $_lang delbot {<юзир/хэндл>}
	set_text -type help -- $_lang delbot {Стередьнах бота ис юзирлиста}
	
	set_text -type args -- $_lang chaddr {<юзир/хэндл> <адрис[:порд бота[/порт юзирафф]]>}
	set_text -type help -- $_lang chaddr {Изменяет адрис и порд бота}
	
	set_text -type args -- $_lang chbotpass {<юзир/хэндл> [пассвард]}
	set_text -type help -- $_lang chbotpass {Изменяет/ачищает пассвард бота}
	
	set_text $_lang $_name #101 "Каличистфо ботафф ф BotNet'и: \002%s\002. Брефно ботнэта:"
	set_text $_lang $_name #102 "Каличистфо ботафф ф BotNet'и: \002%s\002."
	set_text $_lang $_name #103 "Тикущий BotNet: %s"
	set_text $_lang $_name #104 "Бот %s был стерднах из юзирлиста бота."
	set_text $_lang $_name #105 "Бот %s ужэ есть в юзирлисте. Сцоси болд скотина!"
	set_text $_lang $_name #106 "Бот \002%s\002 был зобабахан с прапискай \002%s\002 и хостом \002%s\002."
	set_text $_lang $_name #107 "Ниудалось дабаведь бота \002%s\002."
	set_text $_lang $_name #108 "Длйа бота %s изминйон адрис (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set_text $_lang $_name #109 "Новыйенах флаги для %s: \002%s\002"
	
}