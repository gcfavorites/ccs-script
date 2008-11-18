
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"system"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,rehash) {}
	set ccs(help,pod,rehash) {Рихашед бота}
	
	set ccs(args,pod,restart) {}
	set ccs(help,pod,restart) {Ристартид бота}
	
	set ccs(args,pod,jump) {[сервир [порт [пароль]]]}
	set ccs(help,pod,jump) {Зоставляйед бота заканнэктицца к другому сирваку. Если парамедры ниуказаны, то будит пирихадить пасписку}
	
	set ccs(args,pod,servers) {}
	set ccs(help,pod,servers) {Вывисти списак сервирафф, на каторые бот будит подключацца в случае ниработаспасобнасти однаво из них}
	
	set ccs(args,pod,addserver) {[сервир [порт [пароль]]]}
	set ccs(help,pod,addserver) {Дабавить ф списак сервирафф новый сервир. При рихэшэ бота, списак заминяицца на праписаный ф канфиге}
	
	set ccs(args,pod,delserver) {[сервир [порт [пароль]]]}
	set ccs(help,pod,delserver) {Удалить сервир ис списка сервирофф. При рихэшэ бота списак заменяицца на праписаный ф канфиге}
	
	set ccs(args,pod,save) {}
	set ccs(help,pod,save) {Сахраненийе файлаф юзирафф/каналафф}
	
	set ccs(args,pod,reload) {}
	set ccs(help,pod,reload) {Зогруска файлафф юзирафф/каналафф}
	
	set ccs(args,pod,backup) {}
	set ccs(help,pod,backup) {Зделать ризервнуйу копийу файлафф юзирафф и каналафф}
	
	set ccs(args,pod,die) {[причина]}
	set ccs(help,pod,die) {Заиершенийе работы бота. В саапщении выхада будит указанная \002причина\002}
	
	set ccs(text,system,pod,#101) "Сахраняйунах юзирфайл..."
	set ccs(text,system,pod,#102) "Рехаш и ниибед..."
	set ccs(text,system,pod,#103) "Ристард и ниибед..."
	set ccs(text,system,pod,#104) "--- Списак сервирафф (жырным выдилин тикущий) ---"
	set ccs(text,system,pod,#105) "--- Канецнах списка сервирафф ---"
	set ccs(text,system,pod,#106) "Сервир \002%s\002 уже есть в списке сервирафф - миня нинаибеж!"
	set ccs(text,system,pod,#107) "Сервир \002%s\002 дабавлиннах в списак."
	set ccs(text,system,pod,#108) "Сервир \002%s\002 стертнах из списка сервирафф."
	set ccs(text,system,pod,#109) "Сервир \002%s\002 нинайдиннах в списки - нииби мне моск!"
	set ccs(text,system,pod,#110) "Сахраняйунах файлы юзираф и каналафф..."
	set ccs(text,system,pod,#211) "Пиризагружайу файлы юзираф и каналафф..."
	set ccs(text,system,pod,#212) "Делайу кунилингус файлам юзираф и каналафф..."
	
	
}