
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"system"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,servers) {}
	set ccs(help,en,servers) {Output bot's servers list}
	
	set ccs(args,en,addserver) {[server [port [pass]]]}
	set ccs(help,en,addserver) {Adds new server (with given port and pass) to a bot's servers list. Note that added servers will be removed after REHASH/RESTART}
	
	set ccs(args,en,delserver) {[server [port [pass]]]}
	set ccs(help,en,delserver) {Removes server from bot's servers list. Note that config-defined servers list will be restored after REHASH/RESTART}
	
	set ccs(args,en,save) {}
	set ccs(help,en,save) {Saves channels/users DBs}
	
	set ccs(args,en,reload) {}
	set ccs(help,en,reload) {Reloads channels/users DBs}
	
	set ccs(args,en,backup) {}
	set ccs(help,en,backup) {Backups channels/users DBs}
	
	set ccs(args,en,die) {[text]}
	set ccs(help,en,die) {Shutdown the bot. Specified \002текст\002 will be used as quit-message.}
	
	set ccs(args,en,rehash) {}
	set ccs(help,en,rehash) {Rehash bot's config file(s).}
	
	set ccs(args,en,restart) {}
	set ccs(help,en,restart) {Restarts the bot.}
	
	set ccs(args,en,jump) {[server [port [pass]]]}
	set ccs(help,en,jump) {Tells bot connect to given server. If you do not specify optional values, will be used servers list from bot's config file}
	
	set ccs(text,system,en,#101) "Saving user file..."
	set ccs(text,system,en,#102) "Rehashing..."
	set ccs(text,system,en,#103) "Restart..."
	set ccs(text,system,en,#104) "--- Servers list (bold mean current) ---"
	set ccs(text,system,en,#105) "--- End of servers list ---"
	set ccs(text,system,en,#106) "Server \002%s\002 is already exist in the servers list"
	set ccs(text,system,en,#107) "Server \002%s\002 has been added to server list."
	set ccs(text,system,en,#108) "Server \002%s\002 has been removed from servers list."
	set ccs(text,system,en,#109) "Server \002%s\002 does not exist."
	set ccs(text,system,en,#110) "Saving user and chan files..."
	set ccs(text,system,en,#111) "Reloading user and chan files..."
	set ccs(text,system,en,#112) "Backuping user and chan files..."
	
}