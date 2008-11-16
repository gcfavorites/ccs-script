
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"base"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.3" \
				"11-Nov-2008" \
				"языковой файл дл€ модул€ $modname ($modlang)"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,kick) {<nick1,nick2,...> [reason]}
	set ccs(help,en,kick) {Kicks \002nick\002's from channel with given \002reason\002 (reason is optional)}
	
	set ccs(args,en,inv) {<nick>}
	set ccs(help,en,inv) {Invites given \002nick\002 to the channel.}
	
	set ccs(args,en,topic) {<text>}
	set ccs(help,en,topic) {Sets topic on the channel}
	
	set ccs(args,en,addtopic) {<text>}
	set ccs(help,en,addtopic) {Adds \002text\002 to a channel topic}
	
	set ccs(args,en,ops) {}
	set ccs(help,en,ops) {List all users with flag +o for the channel.}
	
	set ccs(args,en,admins) {}
	set ccs(help,en,admins) {Output bot's administrators (users with global flags).}
	
	set ccs(args,en,whom) {}
	set ccs(help,en,whom) {Output current partyline users.}
	
	set ccs(args,en,whois) {<nick/hand>}
	set ccs(help,en,whois) {Shows info about given \002nick/hand\002}
	
	set ccs(args,en,info) {[mod/lang/scr]}
	set ccs(help,en,info) {Shows detailed system/bot info}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,base,en,#101) "Requested"
	set ccs(text,base,en,#102) "%s"
	set ccs(text,base,en,#103) "%s // %s"
	set ccs(text,base,en,#107) "Operators %s (bold mean online, if current online nick doesn't match registered handle, nick will be enclosed with '()'):"
	set ccs(text,base,en,#108) "Friends channel: %s."
	set ccs(text,base,en,#109) "Halfops channel: %s."
	set ccs(text,base,en,#110) "Ops channel: %s."
	set ccs(text,base,en,#111) "Masters channel: %s."
	set ccs(text,base,en,#112) "Owners channel: %s."
	set ccs(text,base,en,#113) "Bot's admins \002%s\002 (bold mean online,  if current online nick doesn't match registered handle, nick will be enclosed with '()'):"
	set ccs(text,base,en,#114) "Global friends (+f|-): %s."
	set ccs(text,base,en,#115) "Global halfops: %s."
	set ccs(text,base,en,#116) "Global ops: %s."
	set ccs(text,base,en,#117) "Global masters: %s."
	set ccs(text,base,en,#118) "Global owners: %s."
	set ccs(text,base,en,#119) "Permanent owner: \002%s\002."
	set ccs(text,base,en,#120) "Partyline is empty."
	set ccs(text,base,en,#121) "Partyline users:"
	set ccs(text,base,en,#122) "\002%s\002 @ %s (%s)"
	set ccs(text,base,en,#123) "\002%s\002 @ %s (%s), idle time: %s."
	set ccs(text,base,en,#124) "End of list."
	set ccs(text,base,en,#125) "Flags (global|local): \002%s\002. Hosts: \002%s\002.%s"
	set ccs(text,base,en,#126) "identified via BotNet (Bots: \002%s\002)"
	set ccs(text,base,en,#127) "identified (Nicks: \002%s\002)"
	set ccs(text,base,en,#128) "not identified"
	set ccs(text,base,en,#129) "permid"
	set ccs(text,base,en,#130) "\002%s\002 is a bot. He have flags: \002%s\002. Linked up: \002%s\002. Bot address: \002%s\002, port for users: \002%s\002, port for bots: \002%s\002."
	set ccs(text,base,en,#131) "User \002%s\002 is already on the \002%s\002."
	set ccs(text,base,en,#132) "ID-status: %s."
	set ccs(text,base,en,#133) "General info:"
	set ccs(text,base,en,#134) "version/author scripts: \002v%s \[%s\] by %s\002"
	set ccs(text,base,en,#135) "Users: \002%s\002"
	set ccs(text,base,en,#136) "Local date: \002%s\002"
	set ccs(text,base,en,#137) "OS: \002%s\002"
	set ccs(text,base,en,#138) "ServerName: \002%s\002"
	set ccs(text,base,en,#139) "Bot's version: \002%s\002"
	set ccs(text,base,en,#140) "Suzi patch: \002%s\002"
	set ccs(text,base,en,#141) "Handlen: \002%s\002"
	set ccs(text,base,en,#142) "Seennick-len: \002%s\002"
	set ccs(text,base,en,#143) "Codepage: \002%s\002"
	set ccs(text,base,en,#144) "Bot's uptime: \002%s\002"
	set ccs(text,base,en,#145) "Connected: \002%s\002"
	
}