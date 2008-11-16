
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"system"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,rehash) {}
	set ccs(help,ru,rehash) {Рехешит бота}
	
	set ccs(args,ru,restart) {}
	set ccs(help,ru,restart) {Рестартит бота}
	
	set ccs(args,ru,jump) {[сервер [порт [пароль]]]}
	set ccs(help,ru,jump) {Заставляет бота законнектиться к другому серверу. Если параметры не указаны, то будет переходить по списку}
	
	set ccs(args,ru,servers) {}
	set ccs(help,ru,servers) {Выводит список серверов, на которые бот будет подключаться в случае неработоспособности одного из них}
	
	set ccs(args,ru,addserver) {[сервер [порт [пароль]]]}
	set ccs(help,ru,addserver) {Добавляет в список серверов новый сервер. При рехеше бота, список заменяется на прописанный в конфигурационном файле}
	
	set ccs(args,ru,delserver) {[сервер [порт [пароль]]]}
	set ccs(help,ru,delserver) {Удаляет сервер из списка серверов. При рехеше бота список заменяется на прописанный в конфигурационном файле}
	
	set ccs(args,ru,save) {}
	set ccs(help,ru,save) {Сохранение файлов пользователей/каналов}
	
	set ccs(args,ru,reload) {}
	set ccs(help,ru,reload) {Загрузка файлов пользователей/каналов}
	
	set ccs(args,ru,backup) {}
	set ccs(help,ru,backup) {Делает резервную копию файлов пользователей и каналов}
	
	set ccs(args,ru,die) {[текст]}
	set ccs(help,ru,die) {Завершение работы бота. В сообщение выхода будет указанный \002текст\002}
	
	set ccs(text,system,ru,#101) "Saving user file..."
	set ccs(text,system,ru,#102) "Rehashing..."
	set ccs(text,system,ru,#103) "Restart..."
	set ccs(text,system,ru,#104) "--- Список серверов (жирным выделен текущий) ---"
	set ccs(text,system,ru,#105) "--- Конец списка серверов ---"
	set ccs(text,system,ru,#106) "Сервер \002%s\002 уже есть в списке серверов."
	set ccs(text,system,ru,#107) "Сервер \002%s\002 добавлен в список."
	set ccs(text,system,ru,#108) "Сервер \002%s\002 удален из списке серверов."
	set ccs(text,system,ru,#109) "Сервер \002%s\002 не найден в списке."
	set ccs(text,system,ru,#110) "Saving user and chan file..."
	set ccs(text,system,ru,#211) "Reload user and chan file..."
	set ccs(text,system,ru,#212) "Backup user and chan file..."
	
	
}