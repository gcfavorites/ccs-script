
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"users"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.1" \
				"30-Jul-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,adduser) {<nick> [host]}
	set ccs(help,en,adduser) {Adds new user in to a bot's userlist, if you do not specify \002host\002, hostmask *!?ident@*.host will be used (in this case user must be on the channel).}
	
	set ccs(args,en,deluser) {<nick>}
	set ccs(help,en,deluser) {Removes given \002nick\002 from bot's userlist. Note: to delete a user from userlist your añcess level must be greater than access level of the specified user (so, if you have +o flag on the #chan1, and specified user have +m - you can't delete him).}
	
	set ccs(args,en,addhost) {<nick/handle> <host>}
	set ccs(help,en,addhost) {Adds given \002host\002 to the specified \002nick\002 or \002handle\002}
	
	set ccs(args,en,delhost) {<nick/handle> <host>}
	set ccs(help,en,delhost) {Removes given \002host\002 from user's hosts list. Wildcards are allowed. You can use * to remove all hosts.}
	
	set ccs(args,en,chattr) {<nick> <+flags/-flags> [global]}
	set ccs(help,en,chattr) {Adds/removes user's flags. You can specify \002global\002 to change a global user's flags.}
	
	set ccs(args,en,userlist) {[-f -|flags/flags] [-h hostmask]}
	set ccs(help,en,userlist) {Lists all bot's users which have a given flags or/and hostmask. Works is the same as 'userlist' TCL-command}
	
	set ccs(args,en,resetpass) {<nick>}
	set ccs(help,en,resetpass) {Clears user's password (that mean he can set new password via /msg %botnick pass <new_pass>).}
	
	set ccs(args,en,chhandle) {<oldnick> <newnick>}
	set ccs(help,en,chhandle) {Changes the handle of a user.}
	
	set ccs(args,en,setinfo) {<nick/hand> <text>}
	set ccs(help,en,setinfo) {Sets user info (greet), that will be shown via %pref_whois and/or when user joins to a channel (the second one only works if flag +greet enabled)}
	
	set ccs(args,en,delinfo) {<nick/hand>}
	set ccs(help,en,delinfo) {Removes user's info (greet) \002nick/hand\002}
	
	set ccs(text,users,en,#101) "Can't find \002%s\002 on the monitored channels, so, can't do a host lookup (specify the host manually)"
	set ccs(text,users,en,#102) "User \002%s\002 has been added with host \002%s\002."
	set ccs(text,users,en,#103) "You has been added in to \002%s\002's userlist."
	set ccs(text,users,en,#104) "You must setup password first. Command is: \002/msg %s pass your_pass\002."
	set ccs(text,users,en,#105) "For access to bot commands you must be identified via \002/msg %s auth your_pass\002."
	set ccs(text,users,en,#106) "For more information type \002%shelp\002 on the channels where is bot located."
	set ccs(text,users,en,#107) "Sorry, adding user \002%s\002 failed"
	set ccs(text,users,en,#108) "You don't have permissions to delete user %s."
	set ccs(text,users,en,#109) "User %s has been removed from bot's userlist."
	set ccs(text,users,en,#110) "Hostmask \037%s\037 has been added for \002%s\002."
	set ccs(text,users,en,#111) "Hostmask \002%s\002 has been deleted from \002%s\002's hostslist"
	set ccs(text,users,en,#112) "No one host matches to specified hostmask."
	set ccs(text,users,en,#113) "List users with (%s): %s"
	set ccs(text,users,en,#114) "You don't have permissions to change flag \002%s\002 for \002%s\002"
	set ccs(text,users,en,#115) "New flags for %s: \002%s\002"
	set ccs(text,users,en,#116) "Password for nick %s has beed cleared."
	set ccs(text,users,en,#117) "Your password has been cleared, %s. Now you can re-set password via \002/msg %s pass your_pass\002."
	set ccs(text,users,en,#118) "Somebody is already using \002%s\002."
	set ccs(text,users,en,#119) "Handle %s changed to \002%s\002."
	set ccs(text,users,en,#120) "No info set for \002%s\002"
	set ccs(text,users,en,#121) "Info for \002%s\002 has been deleted"
	
}