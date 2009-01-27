
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"users"
set modlang		"ru"
addfileinfo lang "$modname,$modlang" \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.2" \
				"05-Jan-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,adduser) {<nick> [host]}
	set ccs(help,ru,adduser) {Добавляет пользователя в юзерлист бота, если параметр \002host\002 не указан, то бот берёт хост *!?ident@*.host (человек должен присутствовать на канале), если параметр \002host\002 указан, то наличие пользователя на канале не обязательно}
	
	set ccs(args,ru,deluser) {<nick>}
	set ccs(help,ru,deluser) {Удаляет \002nick\002 из юзерлиста. Внимание: чтобы удалить пользователя, Вы должны быть выше его акцессом на всех каналах, на которых он прописан (то есть если он +o на #chan1, а Вы там не +m, то удалить пользователя не удастся)}
	
	set ccs(args,ru,addhost) {<nick|handle> <host>}
	set ccs(help,ru,addhost) {Добавляет \002host\002 пользователю с ником \002nick\002 или хендлом \002handle\002}
	
	set ccs(args,ru,delhost) {<nick|handle> <host>|<-m hostmask>}
	set ccs(help,ru,delhost) {Удаляет выбранный \002host\002 пользователя}
	set ccs(help2,ru,delhost) {
		{Удаляет выбранный \002host\002 пользователя.}
		{Возможно использование масок, при указании ключа -m. Символы \002* ? [ ] \\002 - могут использоваться для указания маски. Чтобы использовать данные символы для точного совпадения необходимо экранировать каждый символом знаком \002\\002}
		{\002-m *\002 - удаляет все хосты}
	}
	
	set ccs(args,ru,chattr) {<nick> <+flags|-flags> [global]}
	set ccs(help,ru,chattr) {Изменяет флаги пользователя, если указан параметр \002global\002, то изменяет глобальные флаги}
	
	set ccs(args,ru,userlist) {[-f gflags|lflags] [-h hostmask]}
	set ccs(help,ru,userlist) {Показывает список пользователей по Вашим параметрам. Аналог функции userlist в TCL}
	
	set ccs(args,ru,resetpass) {<nick>}
	set ccs(help,ru,resetpass) {Сбрасывает пароль пользователю (пользователь сможет установить пароль заново по командн /msg %botnick pass <новый_пароль>}
	
	set ccs(args,en,chhandle) {<oldnick> <newnick>}
	set ccs(help,en,chhandle) {Изменяет хендл юзера с \002oldnick\002 на \002newnick\002.}
	
	set ccs(args,ru,setinfo) {<nick|hand> <text>}
	set ccs(help,ru,setinfo) {Устанавливает информацию пользователя, которая будет видна по команде %pref_whois и при входе юзера на канал, в случае +greet режима}
	
	set ccs(args,ru,delinfo) {<nick|hand>}
	set ccs(help,ru,delinfo) {Удаляет информацию пользователя \002nick|hand\002}
	
	set ccs(text,users,ru,#101) "Я нигде не вижу \002%s\002, поэтому не могу его добавить (нет хоста)."
	set ccs(text,users,ru,#102) "Пользователь \002%s\002 был успешно добавлен с хостом \002%s\002."
	set ccs(text,users,ru,#103) "Вы были добавлены в юзерлист бота \002%s\002."
	set ccs(text,users,ru,#104) "Чтобы пользоваться ботом, Вам надо установить пароль. Сделать это можно командой: \002/msg %s pass ваш_пароль\002."
	set ccs(text,users,ru,#105) "Для использования команд бота, Вам надо будет каждый раз при заходе в IRC идентифицироваться к нему командой \002/msg %s auth ваш_пароль\002."
	set ccs(text,users,ru,#106) "Более подробную помощь Вы можете получить, набрав команду \002%shelp\002 на любом из каналов, где есть бот."
	set ccs(text,users,ru,#107) "Не удалось добавить пользователя \002%s\002."
	set ccs(text,users,ru,#108) "У Вас нет прав удалять пользователя %s."
	set ccs(text,users,ru,#109) "Пользователь %s был удалён из юзерлиста бота."
	set ccs(text,users,ru,#110) "Хост \002%s\002 добавлен к пользователю \002%s\002."
	set ccs(text,users,ru,#111) "Хост \002%s\002 удален у пользователя \002%s\002."
	set ccs(text,users,ru,#112) "Ниодин хост не совпал с маской."
	set ccs(text,users,ru,#113) "Ответ на ваш запрос userlist (%s): %s"
	set ccs(text,users,ru,#114) "Недостаточно прав на изменение флага \002%s\002 для \002%s\002"
	set ccs(text,users,ru,#115) "Новые флаги для %s: \002%s\002"
	set ccs(text,users,ru,#116) "Пароль для ника %s успешно сброшен."
	set ccs(text,users,ru,#117) "Ваш пароль был сброшен %s. Установить его заново вы можете командой \002/msg %s pass новый_пароль\002."
	set ccs(text,users,ru,#118) "Ник \002%s\002 уже используется."
	set ccs(text,users,ru,#119) "Для %s был сменен хендл на \002%s\002."
	set ccs(text,users,ru,#120) "Информация для \002%s\002 установлена"
	set ccs(text,users,ru,#121) "Информация для \002%s\002 удалена"
	
}