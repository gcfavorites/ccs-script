
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"system"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {

	set_text -type args -- $_lang rehash {}
	set_text -type help -- $_lang rehash {Rehash bot's config file(s).}
	
	set_text -type args -- $_lang restart {}
	set_text -type help -- $_lang restart {Restarts the bot.}
	
	set_text -type args -- $_lang jump {[server [port [pass]]]}
	set_text -type help -- $_lang jump {Tells bot connect to given server. If you do not specify optional values, will be used servers list from bot's config file}

	set_text -type args -- $_lang servers {}
	set_text -type help -- $_lang servers {Output bot's servers list}
	
	set_text -type args -- $_lang addserver {[server [port [pass]]]}
	set_text -type help -- $_lang addserver {Adds new server (with given port and pass) to a bot's servers list. Note that added servers will be removed after REHASH/RESTART}
	
	set_text -type args -- $_lang delserver {[server [port [pass]]]}
	set_text -type help -- $_lang delserver {Removes server from bot's servers list. Note that config-defined servers list will be restored after REHASH/RESTART}
	
	set_text -type args -- $_lang save {}
	set_text -type help -- $_lang save {Saves channels/users DBs}
	
	set_text -type args -- $_lang reload {}
	set_text -type help -- $_lang reload {Reloads channels/users DBs}
	
	set_text -type args -- $_lang backup {}
	set_text -type help -- $_lang backup {Backups channels/users DBs}
	
	set_text -type args -- $_lang die {[text]}
	set_text -type help -- $_lang die {Shutdown the bot. Specified \002text\002 will be used as quit-message.}
	
	set_text $_lang $_name #101 "Saving user file..."
	set_text $_lang $_name #102 "Rehashing..."
	set_text $_lang $_name #103 "Restart..."
	set_text $_lang $_name #104 "--- Servers list (bold mean current) ---"
	set_text $_lang $_name #105 "--- End of servers list ---"
	set_text $_lang $_name #106 "Server \002%s\002 already exist in the servers list"
	set_text $_lang $_name #107 "Server \002%s\002 has been added to server list."
	set_text $_lang $_name #108 "Server \002%s\002 has been removed from servers list."
	set_text $_lang $_name #109 "Server \002%s\002 does not exist."
	set_text $_lang $_name #110 "Saving user and chan files..."
	set_text $_lang $_name #111 "Reloading user and chan files..."
	set_text $_lang $_name #112 "Backuping user and chan files..."


}