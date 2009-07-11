
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"system"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang rehash {}
	set_text -type help -- $_lang rehash {Рихашед бота}
	
	set_text -type args -- $_lang restart {}
	set_text -type help -- $_lang restart {Ристартид бота}
	
	set_text -type args -- $_lang jump {[сервир [порт [пароль]]]}
	set_text -type help -- $_lang jump {Зоставляйед бота заканнэктицца к другому сирваку. Если парамедры ниуказаны, то будит пирихадить пасписку}
	
	set_text -type args -- $_lang servers {}
	set_text -type help -- $_lang servers {Вывисти списак сервирафф, на каторые бот будит подключацца в случае ниработаспасобнасти однаво из них}
	
	set_text -type args -- $_lang addserver {[сервир [порт [пароль]]]}
	set_text -type help -- $_lang addserver {Дабавить ф списак сервирафф новый сервир. При рихэшэ бота, списак заминяицца на праписаный ф канфиге}
	
	set_text -type args -- $_lang delserver {[сервир [порт [пароль]]]}
	set_text -type help -- $_lang delserver {Удалить сервир ис списка сервирофф. При рихэшэ бота списак заменяицца на праписаный ф канфиге}
	
	set_text -type args -- $_lang save {}
	set_text -type help -- $_lang save {Сахраненийе файлаф юзирафф/каналафф}
	
	set_text -type args -- $_lang reload {}
	set_text -type help -- $_lang reload {Зогруска файлафф юзирафф/каналафф}
	
	set_text -type args -- $_lang backup {}
	set_text -type help -- $_lang backup {Зделать ризервнуйу копийу файлафф юзирафф и каналафф}
	
	set_text -type args -- $_lang die {[причина]}
	set_text -type help -- $_lang die {Заиершенийе работы бота. В саапщении выхада будит указанная \002причина\002}
	
	set_text $_lang $_name #101 "Сахраняйунах юзирфайл..."
	set_text $_lang $_name #102 "Рехаш и ниибед..."
	set_text $_lang $_name #103 "Ристард и ниибед..."
	set_text $_lang $_name #104 "--- Списак сервирафф (жырным выдилин тикущий) ---"
	set_text $_lang $_name #105 "--- Канецнах списка сервирафф ---"
	set_text $_lang $_name #106 "Сервир \002%s\002 уже есть в списке сервирафф - миня нинаибеж!"
	set_text $_lang $_name #107 "Сервир \002%s\002 дабавлиннах в списак."
	set_text $_lang $_name #108 "Сервир \002%s\002 стертнах из списка сервирафф."
	set_text $_lang $_name #109 "Сервир \002%s\002 нинайдиннах в списки - нииби мне моск!"
	set_text $_lang $_name #110 "Сахраняйунах файлы юзираф и каналафф..."
	set_text $_lang $_name #211 "Пиризагружайу файлы юзираф и каналафф..."
	set_text $_lang $_name #212 "Делайу кунилингус файлам юзираф и каналафф..."
	
	
}