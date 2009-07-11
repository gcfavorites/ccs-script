
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ccs"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009" \
				"Language file for $_name module ($_lang)"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang update {(<list> [-type type] [-name name] [-lang lang])|(<download> [-type type] [-name name] [-lang lang])|(<update>)}
	set_text -type help -- $_lang update {Check for new version of available scripts/modules.}
	set_text -type help2 -- $_lang update {
		{Checks for new available script/module version.}
		{\002list\002 - view the list of new releases. You can specify \002-cur\002 to get the list of updates only for currently used modules and languages; \002-mod\002 to get the list of updated modules; \002-lang\002 to get the list of updated language-files.}
		{\002update\002 - update all previously installed modules and languages}
		{\002download\002 - download new modules and language-files. Note that you should specify template for the downloading file(s): \002type\002 - type of the file (mod, lang, scr); \002name\002 - name of the file; \002lang\002 - language (valid only if \002type\002 is \002lang\002). You can use general mask sybmol '*' for any type.}

	}
	
	set_text -type args -- $_lang help {[flags]}
	set_text -type help -- $_lang help {Help info for CCS-commands}
	set_text -type help2 -- $_lang help {
		{Help info for CCS-commands. Valid flags are:}
		{\002-a\002 show minimal/required access level for the command;}
		{\002-l\002 show commands only available for you (limited by your current access level);}
		{\002-с\002 show aliases for commands;}
		{\002-g group\002 show commands by group;}
		{\002-s\002 show the list of available scripts;}
		{Valid \002groups\002 are: \002%groups\002. Example usage: \002-l -g mode\002}
	}
	
	set_text $_lang $_name #101 "\002\037Channel Control Script Help system\037\002. Version: \002v%s \[%s\] by %s\002. Command prefixes: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002, command prefixes for botnet: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002. Для команд помеченных \002\[сhan\]\002 возможно указание канала, помеченных \002\<сhan>\002 указание канала обязательно (только для msg и dcc команд, для pub команд указание канала \037не требуется\037)."
	set_text $_lang $_name #102 "Permission denied (command: \002%s\002, used by: \002%s\002)."
	set_text $_lang $_name #103 "You're sending requests too fast. Calm down and try again after %s sec(s)."
	set_text $_lang $_name #112 "You already recognized as %s. You can't use identification with hostmask update."
	set_text $_lang $_name #114 "Autorizathion with host update: /msg %s identauth \002\[handle\] <pass>\002"
	set_text $_lang $_name #115 "Permission denied - looks like no one of your hostmask doesn't match current. You can add temporary hostmask and identify at the same time using: /msg %s identauth \002<pass>\002"
	set_text $_lang $_name #116 "User \002%s\002 is protected from any changes. Only global bot owner can change his settings."
	set_text $_lang $_name #117 "At this moment is going the userlists synchronization with others bots. Please try later..."
	set_text $_lang $_name #118 "Permission denied."
	set_text $_lang $_name #119 "\002%s\002 currently is not on the \002%s\002."
	set_text $_lang $_name #120 "You are not authorized to use this command."
	set_text $_lang $_name #121 "You can identify via: /msg %s auth \002your_pass\002"
	set_text $_lang $_name #122 "\002%s\002 is found in the bot's userlist, but don't have any known host. Please check out the hosts for \002%s\002."
	set_text $_lang $_name #123 "Can't find \002%s\002 in the bot's userlist."
	set_text $_lang $_name #124 "\002%s\002 founded in bot's userlist but matching to \002%s\002. Please check out the hosts for \002%s\002 and \002%s\002."
	set_text $_lang $_name #125 "Can't find \002%s\002 on IRC and in the userlist."
	set_text $_lang $_name #126 "You has been automatically logged out because left all monitored channels."
	set_text $_lang $_name #127 "Can't find any matches for you in my userlist. Possible that is your current host doesn't presents in the your hosts-list."
	set_text $_lang $_name #128 "You're not identified."
	set_text $_lang $_name #129 "Logged out nick \002%s\002."
	set_text $_lang $_name #130 "You're already identified."
	set_text $_lang $_name #131 "Successfuly identified as \002%s\002."
	set_text $_lang $_name #132 "Wrong password for \002%s\002!"
	set_text $_lang $_name #133 "You already have op status on the \002%s\002."
	set_text $_lang $_name #134 "\002%s\002 already opped on the \002%s\002."
	set_text $_lang $_name #135 "\002%s\002 doesn't have required access level on the \002%s\002 and can't be opped because is \002+bitch\002 mode enabled)."
	set_text $_lang $_name #136 "You don't have op status."
	set_text $_lang $_name #137 "\002%s\002 don't have op status on the \002%s\002."
	set_text $_lang $_name #138 "You already halfopped on the \002%s\002."
	set_text $_lang $_name #139 "\002%s\002 already halfopped on the \002%s\002."
	set_text $_lang $_name #140 "You don't have halfop status."
	set_text $_lang $_name #141 "\002%s\002 don't have halfop status on the \002%s\002."
	set_text $_lang $_name #142 "You already have voiced on the \002%s\002."
	set_text $_lang $_name #143 "\002%s\002 already voiced on the \002%s\002."
	set_text $_lang $_name #144 "You don't have voice status on the \002%s\002."
	set_text $_lang $_name #145 "\002%s\002 don't have voice status on the \002%s\002."
	set_text $_lang $_name #166 "Saving user file..."
	set_text $_lang $_name #167 "Rehashing..."
	set_text $_lang $_name #169 "User %s is already exist."
	set_text $_lang $_name #170 "Channel \002%s\002 already exist."
	set_text $_lang $_name #189 "No updates for modules at this moment."
	set_text $_lang $_name #190 "Renaming old file \002%s\002 ..."
	set_text $_lang $_name #191 "Saving file \002%s\002 ..."
	set_text $_lang $_name #192 "Unable to save file: %s"
	set_text $_lang $_name #193 "Loading file: \002%s\002 ..."
	set_text $_lang $_name #194 "... Unable to load file, error: %s"
	set_text $_lang $_name #177 "Group \002%s\002 not found, current group list is: \002%s\002."
	set_text $_lang $_name #178 "You must specify group via \002-g groupname\002. Current grouplist: \002%s\002."
	set_text $_lang $_name #179 "User \002%s\002 is under protect. Only global owner's commands can affects him."
	#set_text $_lang $_name #180 " pub: \002%s %s\002"
	#set_text $_lang $_name #181 " msg: \002%s %s\002"
	#set_text $_lang $_name #182 " pub/msg: \002%s %s\002"
	#set_text $_lang $_name #183 " Aliases (chan. privmsg): \002%s\002."
	#set_text $_lang $_name #184 " Aliases (privmsg): \002%s\002."
	set_text $_lang $_name #185 "Aliases: \002%s\002."
	set_text $_lang $_name #186 "Minimal access: \002%s\002."
	#set_text $_lang $_name #187 " msg: \002%s <#chan> %s\002"
	set_text $_lang $_name #188 "%s is not a bot. All bots with \002b\002 flag."
	set_text $_lang $_name #195 " - Type: \002%s\002, module: \002%s\002, date: \002%s\002, current version: \002%s\002, new version: \002%s\002"
	set_text $_lang $_name #196 "Updated files: \002%s\002, errors: \002%s\002."
	set_text $_lang $_name #197 "Hmm... looks like something is wrong. Try to use command again or restore files from backup. If you are assured that the error isn't critical or operation doesn't damaged core files just \002rehash\002 the bot manually."
	#set_text $_lang $_name #198 "Autoupdate feature available for bots with Suzi Patch only."
	#set_text $_lang $_name #199 "Autoupdate feature available for bots wich uses cp1251 internal encoding."
	set_text $_lang $_name #200 "You should specify channel to get help for commands of your access level."
	
}