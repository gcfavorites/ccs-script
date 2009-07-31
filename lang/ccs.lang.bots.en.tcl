if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"bots"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru>" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang bots {[tree]}
	set_text -type help -- $_lang bots {Shows a list of bots linked to current}
	
	set_text -type args -- $_lang botattr {<nick/handle> <+flags/-flags>}
	set_text -type help -- $_lang botattr {Changes bot's flags}
	
	set_text -type args -- $_lang chaddr {<nick/handle> <address[:bot_port[/user_port]]>}
	set_text -type help -- $_lang chaddr {Changes the bot's address and port.}
	
	set_text -type args -- $_lang addbot {<handle> <address[:bot_port[/user_port]]> [host]}
	set_text -type help -- $_lang addbot {Adds bot into userlist. ≈сли порты не прописаны будет присвоен порт по умолчанию 3333. ≈сли порт юзеров не указан то он будет равн€тьс€ порту ботов}
	
	set_text -type args -- $_lang delbot {<nick/handle>}
	set_text -type help -- $_lang delbot {Removes a bot from userlist.}
	
	set_text -type args -- $_lang chbotpass {<nick/handle> [пароль]}
	set_text -type help -- $_lang chbotpass {Changes/removes bot's password.}
	
	set_text -type args -- $_lang listauth {<nick/handle>}
	set_text -type help -- $_lang listauth {Shows user's auth-comparison l}
	
	set_text -type args -- $_lang addauth {<nick/handle> <botnick/bothandle> <handle>}
	set_text -type help -- $_lang addauth {Comapre user's credentials between this bot and specified one.}
	
	set_text -type args -- $_lang delauth {<nick/handle> <botnick/bothandle>}
	set_text -type help -- $_lang delauth {Remove user's comrasion between this bot and specified one.}
	
	set_text $_lang $_name #101 "Numbers of bots in BotNet: \002%s\002. BotNet tree:"
	set_text $_lang $_name #102 "Numbers of bots in BotNet: \002%s\002."
	set_text $_lang $_name #103 "Current BotNet: %s"
	set_text $_lang $_name #104 "Bot %s have been sucessfully removed from userlist."
	set_text $_lang $_name #105 "Bot %s already exist in userlist."
	set_text $_lang $_name #106 "Bot \002%s\002 with address \002%s\002 and hostmask \002%s\002 have been sucessfully aded into userlist."
	set_text $_lang $_name #107 "Unable to add bot \002%s\002."
	set_text $_lang $_name #108 "Address for bot %s have been changed (address: \002%s\002, bot_port: \002%s\002, user_port: \002%s\002)."
	set_text $_lang $_name #109 "New flags for %s: \002%s\002"
	set_text $_lang $_name #110 "Sucessfully changed password for bot %s."
	set_text $_lang $_name #111 "Password for bot %s have been cleared."
	set_text $_lang $_name #112 "—писок соответсвий авторизации %s: %s"
	set_text $_lang $_name #113 "—писок соответсвий авторизации %s пуст."
	set_text $_lang $_name #114 "ƒл€ %s соответствие авторизации \[bot: %s, handle: \002%s\002\] уже существует."
	set_text $_lang $_name #115 "ƒл€ %s соответствие авторизации \[bot: %s, handle: \002%s\002\] изменено на \[bot: %s, handle: \002%s\002\]."
	set_text $_lang $_name #116 "ƒл€ %s соответствие авторизации \[bot: %s, handle: \002%s\002\] добавлено."
	set_text $_lang $_name #117 "Cоответствие авторизации \[bot: %s, handle: \002%s\002\] уже прописано дл€ %s."
	set_text $_lang $_name #118 "ƒл€ %s соответствие авторизации \[bot: %s, handle: \002%s\002\] удалено."
	set_text $_lang $_name #119 "ƒл€ %s соответствие авторизации \[bot: %s\] не найдено."
	
}