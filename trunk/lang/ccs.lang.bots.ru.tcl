
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"bots"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang bots {[tree]}
	set_text -type help -- $_lang bots {Выводит список ботов, прилинкованных к текущему}
	
	set_text -type args -- $_lang botattr {<ник/хендл> <+flags/-flags>}
	set_text -type help -- $_lang botattr {Изменяет флаги ботов}
	
	set_text -type args -- $_lang chaddr {<ник/хендл> <адресс[:порт бота[/порт юзеров]]>}
	set_text -type help -- $_lang chaddr {Изменяет адрес и порт бота}
	
	set_text -type args -- $_lang addbot {<хендл> <адресс[:порт бота[/порт юзеров]]> [хост]}
	set_text -type help -- $_lang addbot {Добавляет бота в юзерлист. Если порты не прописаны будет присвоен порт по умолчанию 3333. Если порт юзеров не указан то он будет равняться порту ботов}
	
	set_text -type args -- $_lang delbot {<ник/хендл>}
	set_text -type help -- $_lang delbot {Удаляет бота из юзерлиста}
	
	set_text -type args -- $_lang chaddr {<ник/хендл> <адресс[:порт бота[/порт юзеров]]>}
	set_text -type help -- $_lang chaddr {Изменяет адресс и порты бота}
	
	set_text -type args -- $_lang chbotpass {<ник/хендл> [пароль]}
	set_text -type help -- $_lang chbotpass {Изменяет/очищает пароль бота}
	
	set_text -type args -- $_lang listauth {<ник/хендл>}
	set_text -type help -- $_lang listauth {Просмотреть список сопостовлений пользователя}
	
	set_text -type args -- $_lang addauth {<ник/хендл> <ботник/ботхендл> <хендл>}
	set_text -type help -- $_lang addauth {Сопоставить пользователя между текущим и выбранным ботом}
	
	set_text -type args -- $_lang delauth {<ник/хендл> <ботник/ботхендл>}
	set_text -type help -- $_lang delauth {Удалить сопоставление пользователя между текущим и выбранным ботом}
	
	set_text $_lang $_name #101 "Количество ботов в BotNet'e: \002%s\002. Дерево ботнета:"
	set_text $_lang $_name #102 "Количество ботов в BotNet'e: \002%s\002."
	set_text $_lang $_name #103 "Текущий BotNet: %s"
	set_text $_lang $_name #104 "Бот %s был удалён из юзерлиста бота."
	set_text $_lang $_name #105 "Бот %s уже есть в юзерлисте."
	set_text $_lang $_name #106 "Бот \002%s\002 был успешно добавлен с адресом \002%s\002 и хостом \002%s\002."
	set_text $_lang $_name #107 "Не удалось добавить бота \002%s\002."
	set_text $_lang $_name #108 "Для бота %s изменен адрес (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set_text $_lang $_name #109 "Новые флаги для %s: \002%s\002"
	set_text $_lang $_name #110 "Новый пароль для бота %s установлен."
	set_text $_lang $_name #111 "Пароль для бота %s сброшен."
	set_text $_lang $_name #112 "Список соответсвий авторизации %s: %s"
	set_text $_lang $_name #113 "Список соответсвий авторизации %s пуст."
	set_text $_lang $_name #114 "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] уже существует."
	set_text $_lang $_name #115 "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] изменено на \[bot: %s, handle: \002%s\002\]."
	set_text $_lang $_name #116 "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] добавлено."
	set_text $_lang $_name #117 "Cоответствие авторизации \[bot: %s, handle: \002%s\002\] уже прописано для %s."
	set_text $_lang $_name #118 "Для %s соответствие авторизации \[bot: %s, handle: \002%s\002\] удалено."
	set_text $_lang $_name #119 "Для %s соответствие авторизации \[bot: %s\] не найдено."
	
}