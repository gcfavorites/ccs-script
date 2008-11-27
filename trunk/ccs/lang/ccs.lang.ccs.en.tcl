
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"ccs"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.3.1" \
				"18-Nov-2008" \
				"Language file for $modname module ($modlang)"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,update) {(<list> [-cur/-mod/-lang])|(<download> [-type type] [-name name] [-lang lang])|(<update>)}
	set ccs(help,en,update) {Check for new version of available scripts/modules.}
	set ccs(help2,en,update) {
		{Checks for new available script/module version.}
		{\002list\002 - view the list of new releases. You can specify \002-cur\002 to get the list of updates only for currently used modules and languages; \002-mod\002 to get the list of updated modules; \002-lang\002 to get the list of updated language-files.}
		{\002update\002 - update all previously installed modules and languages}
		{\002download\002 - download new modules and language-files. Note that you should specify template for the downloading file(s): \002type\002 - type of the file (mod, lang, scr); \002name\002 - name of the file; \002lang\002 - language (valid only if \002type\002 is \002lang\002). You can use general mask sybmol '*' for any type.}

	}
	
	set ccs(args,en,help) {[flags]}
	set ccs(help,en,help) {Help info for CCS-commands}
	set ccs(help2,en,help) {
		{Help info for CCS-commands. Valid flags are:}
		{\002-a\002 show minimal/required access level for the command;}
		{\002-l\002 show commands only available for you (limited by your current access level);}
		{\002-с\002 show aliases for commands;}
		{\002-g group\002 show commands by group;}
		{\002-s\002 show the list of available scripts;}
		{Valid \002groups\002 are: \002%groups\002. Example usage: \002-l -g mode\002}
	}
	
	set ccs(text,ccs,en,#101) "\002\037Channel Control Script Help system\037\002. Version: \002v%s \[%s\] by %s\002. Command prefixes: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002, command prefixes for botnet: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002. Для команд помеченных \002\[сhan\]\002 возможно указание канала, помеченных \002\<сhan>\002 указание канала обязательно (только для msg и dcc команд, для pub команд указание канала \037не требуется\037)."
	set ccs(text,ccs,en,#102) "Permission denied (command: \002%s\002, used by: \002%s\002)."
	set ccs(text,ccs,en,#103) "You're sending requests too fast. Calm down and try again after %s sec(s)."
	set ccs(text,ccs,ru,#112) "You already recognized as %s. You can't use identification with hostmask update."
	set ccs(text,ccs,ru,#114) "Autorizathion with host update: /msg %s identauth \002\[handle\] <pass>\002"
	set ccs(text,ccs,ru,#115) "Permission denied - looks like no one of your hostmask doesn't match current. You can add temporary hostmask and identify at the same time using: /msg %s identauth \002<pass>\002"
	set ccs(text,ccs,en,#116) "User \002%s\002 is protected from any changes. Only global bot owner can change his settings."
	set ccs(text,ccs,en,#117) "At this moment is going the userlists synchronization with others bots. Please try later..."
	set ccs(text,ccs,en,#118) "Permission denied."
	set ccs(text,ccs,en,#119) "\002%s\002 currently is not on the \002%s\002."
	set ccs(text,ccs,en,#120) "You are not authorized to use this command."
	set ccs(text,ccs,en,#121) "You can identify via: /msg %s auth \002your_pass\002"
	set ccs(text,ccs,en,#122) "\002%s\002 is found in the bot's userlist, but don't have any known host. Please check out the hosts for \002%s\002."
	set ccs(text,ccs,en,#123) "Can't find \002%s\002 in the bot's userlist."
	set ccs(text,ccs,en,#124) "\002%s\002 founded in bot's userlist but matching to \002%s\002. Please check out the hosts for \002%s\002 and \002%s\002."
	set ccs(text,ccs,en,#125) "Can't find \002%s\002 on IRC and in the userlist."
	set ccs(text,ccs,en,#126) "You has been automatically logged out because left all monitored channels."
	set ccs(text,ccs,en,#127) "Can't find any matches for you in my userlist. Possible that is your current host doesn't presents in the your hosts-list."
	set ccs(text,ccs,en,#128) "You're not identified."
	set ccs(text,ccs,en,#129) "Logged out nick \002%s\002."
	set ccs(text,ccs,en,#130) "You're already identified."
	set ccs(text,ccs,en,#131) "Successfuly identified as \002%s\002."
	set ccs(text,ccs,en,#132) "Wrong password for \002%s\002!"
	set ccs(text,ccs,en,#133) "You already have op status on the \002%s\002."
	set ccs(text,ccs,en,#134) "\002%s\002 already opped on the \002%s\002."
	set ccs(text,ccs,en,#135) "\002%s\002 doesn't have required access level on the \002%s\002 and can't be opped because is \002+bitch\002 mode enabled)."
	set ccs(text,ccs,en,#136) "You don't have op status."
	set ccs(text,ccs,en,#137) "\002%s\002 don't have op status on the \002%s\002."
	set ccs(text,ccs,en,#138) "You already halfopped on the \002%s\002."
	set ccs(text,ccs,en,#139) "\002%s\002 already halfopped on the \002%s\002."
	set ccs(text,ccs,en,#140) "You don't have halfop status."
	set ccs(text,ccs,en,#141) "\002%s\002 don't have halfop status on the \002%s\002."
	set ccs(text,ccs,en,#142) "You already have voiced on the \002%s\002."
	set ccs(text,ccs,en,#143) "\002%s\002 already voiced on the \002%s\002."
	set ccs(text,ccs,en,#144) "You don't have voice status on the \002%s\002."
	set ccs(text,ccs,en,#145) "\002%s\002 don't have voice status on the \002%s\002."
	set ccs(text,ccs,en,#166) "Saving user file..."
	set ccs(text,ccs,en,#167) "Rehashing..."
	set ccs(text,ccs,en,#169) "User %s is already exist."
	set ccs(text,ccs,en,#170) "Channel \002%s\002 already exist."
	set ccs(text,ccs,en,#189) "No updates for modules at this moment."
	set ccs(text,ccs,en,#190) "Renaming old file \002%s\002 ..."
	set ccs(text,ccs,en,#191) "Saving file \002%s\002 ..."
	set ccs(text,ccs,en,#192) "Unable to save file: %s"
	set ccs(text,ccs,en,#193) "Loading file: \002%s\002 ..."
	set ccs(text,ccs,en,#194) "... Unable to load file, error: %s"
	set ccs(text,ccs,en,#177) "Group \002%s\002 not found, current group list is: \002%s\002."
	set ccs(text,ccs,en,#178) "You must specify group via \002-g groupname\002. Current grouplist: \002%s\002."
	set ccs(text,ccs,en,#179) "User \002%s\002 is under protect. Only global owner's commands can affects him."
	#set ccs(text,ccs,en,#180) " pub: \002%s %s\002"
	#set ccs(text,ccs,en,#181) " msg: \002%s %s\002"
	#set ccs(text,ccs,en,#182) " pub/msg: \002%s %s\002"
	#set ccs(text,ccs,en,#183) " Aliases (chan. privmsg): \002%s\002."
	#set ccs(text,ccs,en,#184) " Aliases (privmsg): \002%s\002."
	set ccs(text,ccs,en,#185) " Aliases: \002%s\002."
	set ccs(text,ccs,en,#186) " Minimal access: \002%s\002."
	#set ccs(text,ccs,en,#187) " msg: \002%s <#chan> %s\002"
	set ccs(text,ccs,en,#188) "%s is not a bot. All bots with \002b\002 flag."
	set ccs(text,ccs,en,#195) " - Type: \002%s\002, module: \002%s\002, lang: \002%s\002, date: \002%s\002, current version: \002%s\002, new version: \002%s\002"
	set ccs(text,ccs,en,#196) "Updated files: \002%s\002, errors: \002%s\002."
	set ccs(text,ccs,en,#197) "There is a need to try again or return the files from the backup. If you think this is not in the files is not critical, needs to be done rehesh bot."
	set ccs(text,ccs,en,#198) "Only bot's with Suzi Patch can do autoupdate."
	set ccs(text,ccs,en,#199) "Only bot's with codepage cp1251 can do autoupdate"
	set ccs(text,ccs,en,#200) "You should specify channel to get help for commands of your access level"
	
}