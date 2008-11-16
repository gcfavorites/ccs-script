
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"bots"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,bots) {}
	set ccs(help,pod,bots) {Выводид списак ботафф, каторыи прилинкофаны к тикущиму}
	
	set ccs(args,pod,botattr) {<юзир/хэндл> <+флаги/-флаги>}
	set ccs(help,pod,botattr) {Изминйаид флаги ботафф}
	
	set ccs(args,pod,chaddr) {<юзир/хэндл> <адрис[:порд бота[/порт юзирафф]]>}
	set ccs(help,pod,chaddr) {Изминильнах адрис и порд бота}
	
	set ccs(args,pod,addbot) {<хэндл> <адрис[:порд бота[/порт юзирафф]]> [хост]}
	set ccs(help,pod,addbot) {Прибобахать бота в юзирлист. Если парты нипраписаны - будит присвоин порт паумолчанийу 3333. Если порд юзирафф ниуказан, то он будит равнйацца парду ботафф}
	
	set ccs(args,pod,delbot) {<юзир/хэндл>}
	set ccs(help,pod,delbot) {Стередьнах бота ис юзирлиста}
	
	set ccs(args,pod,chaddr) {<юзир/хэндл> <адрис[:порд бота[/порт юзирафф]]>}
	set ccs(help,pod,chaddr) {Изменяет адрис и порд бота}
	
	set ccs(args,pod,chbotpass) {<юзир/хэндл> [пассвард]}
	set ccs(help,pod,chbotpass) {Изменяет/ачищает пассвард бота}
	
	set ccs(text,bots,pod,#101) "Каличистфо ботафф ф BotNet'и: \002%s\002. Брефно ботнэта:"
	set ccs(text,bots,pod,#102) "Каличистфо ботафф ф BotNet'и: \002%s\002."
	set ccs(text,bots,pod,#103) "Тикущий BotNet: %s"
	set ccs(text,bots,pod,#104) "Бот %s был стерднах из юзирлиста бота."
	set ccs(text,bots,pod,#105) "Бот %s ужэ есть в юзирлисте. Сцоси болд скотина!"
	set ccs(text,bots,pod,#106) "Бот \002%s\002 был зобабахан с прапискай \002%s\002 и хостом \002%s\002."
	set ccs(text,bots,pod,#107) "Ниудалось дабаведь бота \002%s\002."
	set ccs(text,bots,pod,#108) "Длйа бота %s изминйон адрис (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set ccs(text,bots,pod,#109) "Новыйенах флаги для %s: \002%s\002"
	
}