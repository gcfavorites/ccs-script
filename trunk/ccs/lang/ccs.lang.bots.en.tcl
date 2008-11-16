
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"bots"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,bots) {}
	set ccs(help,en,bots) {Shows currently linked bots}
	
	set ccs(args,en,botattr) {<nick/handle> <+flags/-flags>}
	set ccs(help,en,botattr) {Changes bot's flags}
	
	set ccs(args,en,chaddr) {<nick/handle> <address[:bot's port[/user's port]]>}
	set ccs(help,en,chaddr) {Changes bot address and port}
	
	set ccs(args,en,addbot) {<handle> <address[:bot's port[/user's port]]> [host]}
	set ccs(help,en,addbot) {Adds bot in to a userlist. If port is not given, 3333 will be used. If user's port is not given he will be the same}
	
	set ccs(args,en,delbot) {<nick/handle>}
	set ccs(help,en,delbot) {Removes bot from userlist}
	
	set ccs(args,en,chbotpass) {<nick/handle> [pass]}
	set ccs(help,en,chbotpass) {Changes/clear a bot's password}
	
	set ccs(args,en,listauth) {<nick/handle>}
	set ccs(help,en,listauth) {}
	
	set ccs(args,en,addauth) {<nick/handle> <nickbot/handlebot> <dhandle>}
	set ccs(help,en,addauth) {}
	
	set ccs(args,en,delauth) {<nick/handle> <nickbot/handlebot>}
	set ccs(help,en,delauth) {}
	
	set ccs(text,bots,en,#101) "Current bots in BotNet'e: \002%s\002. Botnet tree:"
	set ccs(text,bots,en,#102) "Current bots in BotNet'e: \002%s\002."
	set ccs(text,bots,en,#103) "Current BotNet: %s"
	set ccs(text,bots,en,#104) "Bot %s has been removed from userlist."
	set ccs(text,bots,en,#105) "Bot %s is already exist in the userlist."
	set ccs(text,bots,en,#106) "Bot \002%s\002 has beed added. Address: \002%s\002, host: \002%s\002."
	set ccs(text,bots,en,#107) "Can't add bot \002%s\002."
	set ccs(text,bots,en,#108) "Address for bot %s has been changed (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set ccs(text,bots,en,#109) "New flags for %s: \002%s\002"
	
}