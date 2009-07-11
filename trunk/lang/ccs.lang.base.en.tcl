
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"base"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009" \
				"языковой файл дл€ модул€ $_name ($_lang)"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang kick {<nick1,nick2,...> [reason]}
	set_text -type help -- $_lang kick {Kicks \002nick\002's from channel with given \002reason\002 (reason is optional)}
	
	set_text -type args -- $_lang inv {<nick>}
	set_text -type help -- $_lang inv {Invites given \002nick\002 to the channel.}
	
	set_text -type args -- $_lang topic {<text>}
	set_text -type help -- $_lang topic {Sets topic on the channel}
	
	set_text -type args -- $_lang addtopic {<text>}
	set_text -type help -- $_lang addtopic {Adds \002text\002 to a channel topic}
	
	set_text -type args -- $_lang ops {}
	set_text -type help -- $_lang ops {List all users with flag +o for the channel.}
	
	set_text -type args -- $_lang admins {}
	set_text -type help -- $_lang admins {Output bot's administrators (users with global flags).}
	
	set_text -type args -- $_lang whom {}
	set_text -type help -- $_lang whom {Output current partyline users.}
	
	set_text -type args -- $_lang whois {<nick/hand>}
	set_text -type help -- $_lang whois {Shows info about given \002nick/hand\002}
	
	set_text -type args -- $_lang info {[mod/lang/scr]}
	set_text -type help -- $_lang info {Shows detailed system/bot info}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "%s"
	set_text $_lang $_name #103 "%s // %s"
	set_text $_lang $_name #107 "Operators %s (bold mean online, if current online nick doesn't match registered handle, nick will be enclosed with '()'):"
	set_text $_lang $_name #108 "Friends channel: %s."
	set_text $_lang $_name #109 "Halfops channel: %s."
	set_text $_lang $_name #110 "Ops channel: %s."
	set_text $_lang $_name #111 "Masters channel: %s."
	set_text $_lang $_name #112 "Owners channel: %s."
	set_text $_lang $_name #113 "Bot's admins \002%s\002 (bold mean online,  if current online nick doesn't match registered handle, nick will be enclosed with '()'):"
	set_text $_lang $_name #114 "Global friends (+f|-): %s."
	set_text $_lang $_name #115 "Global halfops: %s."
	set_text $_lang $_name #116 "Global ops: %s."
	set_text $_lang $_name #117 "Global masters: %s."
	set_text $_lang $_name #118 "Global owners: %s."
	set_text $_lang $_name #119 "Permanent owner: \002%s\002."
	set_text $_lang $_name #120 "Partyline is empty."
	set_text $_lang $_name #121 "Partyline users:"
	set_text $_lang $_name #122 "\002%s\002 @ %s (%s)"
	set_text $_lang $_name #123 "\002%s\002 @ %s (%s), idle time: %s."
	set_text $_lang $_name #124 "End of list."
	set_text $_lang $_name #125 "Flags (global|local): \002%s\002. Hosts: \002%s\002.%s"
	set_text $_lang $_name #126 "identified via BotNet (Bots: \002%s\002)"
	set_text $_lang $_name #127 "identified (Nicks: \002%s\002)"
	set_text $_lang $_name #128 "not identified"
	set_text $_lang $_name #129 "permid"
	set_text $_lang $_name #130 "\002%s\002 is a bot. He have flags: \002%s\002. Linked up: \002%s\002. Bot address: \002%s\002, port for users: \002%s\002, port for bots: \002%s\002."
	set_text $_lang $_name #131 "User \002%s\002 is already on the \002%s\002."
	set_text $_lang $_name #132 "ID-status: %s."
	set_text $_lang $_name #133 "General info:"
	set_text $_lang $_name #134 "version/author scripts: \002v%s \[%s\] by %s\002"
	set_text $_lang $_name #135 "Users: \002%s\002"
	set_text $_lang $_name #136 "Local date: \002%s\002"
	set_text $_lang $_name #137 "OS: \002%s\002"
	set_text $_lang $_name #138 "ServerName: \002%s\002"
	set_text $_lang $_name #139 "Bot's version: \002%s\002"
	set_text $_lang $_name #140 "Suzi patch: \002%s\002"
	set_text $_lang $_name #141 "Handlen: \002%s\002"
	set_text $_lang $_name #142 "Seennick-len: \002%s\002"
	set_text $_lang $_name #143 "Codepage: \002%s\002"
	set_text $_lang $_name #144 "Bot's uptime: \002%s\002"
	set_text $_lang $_name #145 "Connected: \002%s\002"
	
}