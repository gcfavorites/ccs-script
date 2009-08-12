
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"base"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009" \
				"Language-file for module $_name ($_lang)"

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

	set_text -type args -- $_lang info {[mod|scr|lang|lib|mask|flag <flag>]}
	set_text -type help -- $_lang info {Shows detailed system/bot info and ccs-related info about: installed modules, scripts, lang-files, libs and variables}
	set_text -type help2 -- $_lang info {
		{Shows detailed system/bot info and ccs-related info about: installed modules, scripts, lang-files, libs and variables}
		{\002mod/scr/lang/lib\002 - shows info about modules/scripts/lang-files/libs and variables only (you can choose)}
		{\002mask\002 - shows hostmask-templates and it's unique number}
		{\002flag <flag>\002 - shows detailed info about specified flag}
}

	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "%s"
	set_text $_lang $_name #103 "%s // %s"
	set_text $_lang $_name #107 "Operators %s (bold mean online, if current online nick doesn't match registered handle, nick will be enclosed with '()'):"
	set_text $_lang $_name #108 "Channel friends: %s."
	set_text $_lang $_name #109 "Channel halfops: %s."
	set_text $_lang $_name #110 "Channel ops: %s."
	set_text $_lang $_name #111 "Channel masters: %s."
	set_text $_lang $_name #112 "Channel owners: %s."
	set_text $_lang $_name #113 "\002%s\002's admins (bold mean online,  if current online nick doesn't match registered handle, nick will be enclosed with '()'):"
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
	set_text $_lang $_name #146 "Name: \002%s\002, version \002v%s\002 \[%s\] by %s, enabled?: %s, description: %s."
	set_text $_lang $_name #147 "No modules found."
	set_text $_lang $_name #148 "No custom scripts found."
	set_text $_lang $_name #149 "No lang-files found."
	set_text $_lang $_name #150 "No ccs-libs found."
	set_text $_lang $_name #151 "\002n|n\002 - (owner, owner) - user has absolute control. Only give this flag to people you trust completely."
	set_text $_lang $_name #152 "\002m|m\002 - (master, master) - user has access to almost every feature of the bot."
	set_text $_lang $_name #153 "\002t|t\002 - (botnet-master, botnet-master) - user has access to all features dealing with the botnet."
	set_text $_lang $_name #154 "\002a|a\002 - (auto-op, auto-op) - user is opped automatically upon joining a channel."
	set_text $_lang $_name #155 "\002o|o\002 - (op, op) - user has op access to all of the bot's channels."
	set_text $_lang $_name #156 "\002y|y\002 - (auto-halfop, auto-halfop) - user is halfopped automatically upon joining a channel."
	set_text $_lang $_name #157 "\002l|l\002 - (halfop, halfop) - user has halfop access to all of the bot's channels."
	set_text $_lang $_name #158 "\002g|g\002 - (auto-voice, autovoice) - user is voiced automatically upon joining a channel."
	set_text $_lang $_name #159 "\002v|v\002 - (voice, voice) - user gets +v automatically on +autovoice channels."
	set_text $_lang $_name #160 "\002f|f\002 - (friend, friend) - user is not punished for flooding, etc."
	set_text $_lang $_name #161 "\002p\002 - (party, partyline) - user has access to the partyline (DCC)."
	set_text $_lang $_name #162 "\002q|q\002 - (quiet, quiet) - user does not get voice on +autovoice channels."
	set_text $_lang $_name #163 "\002r|r\002 - (dehalfop, autodehalfop) - user cannot gain halfops on any of the bot's channels."
	set_text $_lang $_name #164 "\002d|d\002 - (deop, autodeop) - user cannot gain ops on any of the bot's channels."
	set_text $_lang $_name #165 "\002k|k\002 - (auto-kick, akick) - user is kicked and banned automatically."
	set_text $_lang $_name #166 "\002x\002 - (xfer, file transfer) - user has access to the file transfer area of the bot (if it exists) and can send and receive files to/from the bot."
	set_text $_lang $_name #167 "\002j\002 - (janitor, janitor) - user can perform maintenance in the file area of the bot (if it exists) -- like a \"master\" of the file area. Janitors have complete access to the filesystem."
	set_text $_lang $_name #168 "\002c\002 - (common, \"common host\") - this marks a user who is connecting from a public site from which any number of people can use IRC. The user will now be recognized by NICKNAME."
	set_text $_lang $_name #169 "\002w|w\002 - (wasop-test) - user needs wasop test for +stopnethack procedure."
	set_text $_lang $_name #170 "\002z|z\002 - (washalfop-test) - user needs washalfop test for +stopnethack procedure."
	set_text $_lang $_name #171 "\002e|e\002 - (nethack-exempt) - user is exempted from stopnethack protection."
	set_text $_lang $_name #172 "\002u\002 - (unshared, unshared userentry) - user record is not sent to other bots."
	set_text $_lang $_name #173 "\002h\002 - (highlight, highlight) - use bold text in help/text files."
	set_text $_lang $_name #174 "\002b\002 - (bot, bot) - user is a bot."
	set_text $_lang $_name #175 "\002%s\002 - user identified on bot. (custom CCS flag)"
	set_text $_lang $_name #176 "\002%s\002 - user identified on bot via botnet. (custom CCS flag)"
	set_text $_lang $_name #177 "\002%s\002 - user whose authorization via botnet will be checked strictly. (custom CCS flag)"
	set_text $_lang $_name #178 "\002%s\002 - user has a permanent authorization. (custom CCS flag)"
	set_text $_lang $_name #179 "\002%s\002 - user's handle has a protection from changes and only global bot owner can change his flags. (custom CCS flag)"
	set_text $_lang $_name #180 "\002%s\002 - user has a protection from some commands, like kick, ban, etc... (custom CCS flag)"
	set_text $_lang $_name #181 "\002%s\002 - defines bots who can share actions via botnet (can send/accept ccs-commands via botnet). (custom CCS flag)"
	set_text $_lang $_name #182 "No description for flag \002%s\002 found."

}