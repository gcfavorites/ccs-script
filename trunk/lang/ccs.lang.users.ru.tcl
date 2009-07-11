
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"users"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang adduser {<nick> [host]}
	set_text -type help -- $_lang adduser {Добавляет пользователя в юзерлист бота, если параметр \002host\002 не указан, то бот берёт хост *!?ident@*.host (человек должен присутствовать на канале), если параметр \002host\002 указан, то наличие пользователя на канале не обязательно}
	
	set_text -type args -- $_lang deluser {<nick>}
	set_text -type help -- $_lang deluser {Удаляет \002nick\002 из юзерлиста. Внимание: чтобы удалить пользователя, Вы должны быть выше его акцессом на всех каналах, на которых он прописан (то есть если он +o на #chan1, а Вы там не +m, то удалить пользователя не удастся)}
	
	set_text -type args -- $_lang addhost {<nick|handle> <host>}
	set_text -type help -- $_lang addhost {Добавляет \002host\002 пользователю с ником \002nick\002 или хендлом \002handle\002}
	
	set_text -type args -- $_lang delhost {<nick|handle> <host>|<-m hostmask>}
	set_text -type help -- $_lang delhost {Удаляет выбранный \002host\002 пользователя}
	set_text -type help2 -- $_lang delhost {
		{Удаляет выбранный \002host\002 пользователя.}
		{Возможно использование масок, при указании ключа -m. Символы \002* ? [ ] \\002 - могут использоваться для указания маски. Чтобы использовать данные символы для точного совпадения необходимо экранировать каждый символом знаком \002\\002}
		{\002-m *\002 - удаляет все хосты}
	}
	
	set_text -type args -- $_lang chattr {<nick> <+flags|-flags> [global]}
	set_text -type help -- $_lang chattr {Изменяет флаги пользователя, если указан параметр \002global\002, то изменяет глобальные флаги}
	
	set_text -type args -- $_lang userlist {[-f gflags|lflags] [-h hostmask]}
	set_text -type help -- $_lang userlist {Показывает список пользователей, из юзерлиста, по Вашим параметрам}
	set_text -type help2 -- $_lang userlist {
		{Показывает список пользователей, из юзерлиста, по Вашим параметрам.}
		{Возможно использование фильтра по маске, при указании ключа -h. Символы \002* ? [ ] \\002 - могут использоваться для указания маски. Чтобы использовать данные символы для точного совпадения необходимо экранировать каждый символом знаком \002\\002}
	}
	
	set_text -type args -- $_lang match {[-h hostmask]}
	set_text -type help -- $_lang match {Показывает список пользователей, из канального листа, отфильтрованных по указанной хостмаски.}
	set_text -type help2 -- $_lang match {
		{Показывает список пользователей, из канального листа, отфильтрованных по указанной хостмаски.}
		{Символы \002* ? [ ] \\002 - могут использоваться для указания маски. Чтобы использовать данные символы для точного совпадения необходимо экранировать каждый символом знаком \002\\002}
	}
	
	set_text -type args -- $_lang resetpass {<nick>}
	set_text -type help -- $_lang resetpass {Сбрасывает пароль пользователю (пользователь сможет установить пароль заново по командн /msg %botnick pass <новый_пароль>}
	
	set_text -type args -- $_lang chhandle {<oldnick> <newnick>}
	set_text -type help -- $_lang chhandle {Изменяет хендл юзера с \002oldnick\002 на \002newnick\002.}
	
	set_text -type args -- $_lang setinfo {<nick|hand> <text>}
	set_text -type help -- $_lang setinfo {Устанавливает информацию пользователя, которая будет видна по команде %pref_whois и при входе юзера на канал, в случае +greet режима}
	
	set_text -type args -- $_lang delinfo {<nick|hand>}
	set_text -type help -- $_lang delinfo {Удаляет информацию пользователя \002nick|hand\002}
	
	set_text $_lang $_name #101 "Я нигде не вижу \002%s\002, поэтому не могу его добавить (нет хоста)."
	set_text $_lang $_name #102 "Пользователь \002%s\002 был успешно добавлен с хостом \002%s\002."
	set_text $_lang $_name #103 "Вы были добавлены в юзерлист бота \002%s\002."
	set_text $_lang $_name #104 "Чтобы пользоваться ботом, Вам надо установить пароль. Сделать это можно командой: \002/msg %s pass ваш_пароль\002."
	set_text $_lang $_name #105 "Для использования команд бота, Вам надо будет каждый раз при заходе в IRC идентифицироваться к нему командой \002/msg %s auth ваш_пароль\002."
	set_text $_lang $_name #106 "Более подробную помощь Вы можете получить, набрав команду \002%shelp\002 на любом из каналов, где есть бот."
	set_text $_lang $_name #107 "Не удалось добавить пользователя \002%s\002."
	set_text $_lang $_name #108 "У Вас нет прав удалять пользователя %s."
	set_text $_lang $_name #109 "Пользователь %s был удалён из юзерлиста бота."
	set_text $_lang $_name #110 "Хост \002%s\002 добавлен к пользователю \002%s\002."
	set_text $_lang $_name #111 "Хост \002%s\002 удален у пользователя \002%s\002."
	set_text $_lang $_name #112 "Ниодин хост не совпал с маской."
	set_text $_lang $_name #113 "Ответ на ваш запрос userlist (%s): %s"
	set_text $_lang $_name #114 "Недостаточно прав на изменение флага \002%s\002 для \002%s\002"
	set_text $_lang $_name #115 "Новые флаги для %s: \002%s\002"
	set_text $_lang $_name #116 "Пароль для ника %s успешно сброшен."
	set_text $_lang $_name #117 "Ваш пароль был сброшен %s. Установить его заново вы можете командой \002/msg %s pass новый_пароль\002."
	set_text $_lang $_name #118 "Ник \002%s\002 уже используется."
	set_text $_lang $_name #119 "Для %s был сменен хендл на \002%s\002."
	set_text $_lang $_name #120 "Информация для \002%s\002 установлена"
	set_text $_lang $_name #121 "Информация для \002%s\002 удалена"
	set_text $_lang $_name #122 "По указанной маске \002%s\002 не найдено ни одного пользователя"
	
}