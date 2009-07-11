
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"system"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang rehash {}
	set_text -type help -- $_lang rehash {Рехешит бота}
	
	set_text -type args -- $_lang restart {}
	set_text -type help -- $_lang restart {Рестартит бота}
	
	set_text -type args -- $_lang jump {[сервер [порт [пароль]]]}
	set_text -type help -- $_lang jump {Заставляет бота законнектиться к другому серверу. Если параметры не указаны, то будет переходить по списку}
	
	set_text -type args -- $_lang servers {}
	set_text -type help -- $_lang servers {Выводит список серверов, на которые бот будет подключаться в случае неработоспособности одного из них}
	
	set_text -type args -- $_lang addserver {[сервер [порт [пароль]]]}
	set_text -type help -- $_lang addserver {Добавляет в список серверов новый сервер. При рехеше бота, список заменяется на прописанный в конфигурационном файле}
	
	set_text -type args -- $_lang delserver {[сервер [порт [пароль]]]}
	set_text -type help -- $_lang delserver {Удаляет сервер из списка серверов. При рехеше бота список заменяется на прописанный в конфигурационном файле}
	
	set_text -type args -- $_lang save {}
	set_text -type help -- $_lang save {Сохранение файлов пользователей/каналов}
	
	set_text -type args -- $_lang reload {}
	set_text -type help -- $_lang reload {Загрузка файлов пользователей/каналов}
	
	set_text -type args -- $_lang backup {}
	set_text -type help -- $_lang backup {Делает резервную копию файлов пользователей и каналов}
	
	set_text -type args -- $_lang die {[текст]}
	set_text -type help -- $_lang die {Завершение работы бота. В сообщение выхода будет указанный \002текст\002}
	
	set_text $_lang $_name #101 "Saving user file..."
	set_text $_lang $_name #102 "Rehashing..."
	set_text $_lang $_name #103 "Restart..."
	set_text $_lang $_name #104 "--- Список серверов (жирным выделен текущий) ---"
	set_text $_lang $_name #105 "--- Конец списка серверов ---"
	set_text $_lang $_name #106 "Сервер \002%s\002 уже есть в списке серверов."
	set_text $_lang $_name #107 "Сервер \002%s\002 добавлен в список."
	set_text $_lang $_name #108 "Сервер \002%s\002 удален из списке серверов."
	set_text $_lang $_name #109 "Сервер \002%s\002 не найден в списке."
	set_text $_lang $_name #110 "Saving user and chan file..."
	set_text $_lang $_name #211 "Reload user and chan file..."
	set_text $_lang $_name #212 "Backup user and chan file..."
	
	
}