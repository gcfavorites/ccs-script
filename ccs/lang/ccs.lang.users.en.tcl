
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"users"
set modlang		"en"
addfileinfo lang "$modname,$modlang" \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.1" \
				"23-Mar-2009"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,adduser) {<nick> [host]}
	set ccs(help,en,adduser) {Adds new user in to a bot's userlist, if you do not specify \002host\002, hostmask *!?ident@*.host will be used (in this case user must be on the channel).}
	
	set ccs(args,en,deluser) {<nick>}
	set ccs(help,en,deluser) {Removes given \002nick\002 from bot's userlist. Note: to delete a user from userlist your añcess level must be greater than access level of the specified user (so, if you have +o flag on the #chan1, and specified user have +m - you can't delete him).}
	
	set ccs(args,en,addhost) {<nick|handle> <host>}
	set ccs(help,en,addhost) {Adds given \002host\002 to the specified \002nick\002 or \002handle\002}
	
	set ccs(args,en,delhost) {<nick|handle> <host>|<-m hostmask>}
	set ccs(help,en,delhost) {Removes given \002host\002 from user's hosts list.}
	set ccs(help2,en,delhost) {
		{Removes given \002host\002 from user's hosts list.}
		{Wildcards are allowed if you have specified -m key. Symbols like \002* ? [ ] \\002 can be used when specify the mask. To use these symblos 'as is' you need to put a '\002\\002' before every of them.}
		{\002-m *\002 - removes all host from list}
	}

	set ccs(args,en,chattr) {<nick> <+flags|-flags> [global]}
	set ccs(help,en,chattr) {Adds/removes user's flags. You can specify \002global\002 to change a global user's flags.}
	
	set ccs(args,en,userlist) {[-f gflags|lflags] [-h hostmask]}
	set ccs(help,en,userlist) {Shows a list of all bot users which have a given flags or/and hostmask. Works is the same as 'userlist' TCL-command}
		set ccs(help2,en,userlist) {
		{Shows a list of all bot users which have a given flags or/and hostmask.}
		{Wildcards in the hostmask are allowed if you have specified -h key. Symbols like \002* ? [ ] \\002 can be used when specify the mask. To use these symblos 'as is' you need to put a '\002\\002' before every of them.}
	}

	set ccs(args,en,match) {[-h hostmask]}
	set ccs(help,en,match) {Shows a list of channel users matching specified hostmask.}
	set ccs(help2,en,match) {
		{Shows a list of channel users matching specified hostmask.}
		{Symbols like \002* ? [ ] \\002 can be used when specify the mask. To use these symblos 'as is' you need to put a '\002\\002' before every of them.}

	set ccs(args,en,resetpass) {<nick>}
	set ccs(help,en,resetpass) {Clears user's password (that mean he can set new password via /msg %botnick pass <new_pass>).}
	
	set ccs(args,en,chhandle) {<oldnick> <newnick>}
	set ccs(help,en,chhandle) {Changes the handle of a user.}
	
	set ccs(args,en,setinfo) {<nick|hand> <text>}
	set ccs(help,en,setinfo) {Sets user info (greet), that will be shown via %pref_whois and/or when user joins to a channel (the second one only works if flag +greet enabled)}
	
	set ccs(args,en,delinfo) {<nick|hand>}
	set ccs(help,en,delinfo) {Removes user's info (greet) \002nick|hand\002}
	
	set ccs(text,users,en,#101) "Can't find \002%s\002 on the monitored channels, so, can't do a host lookup (specify the host manually)"
	set ccs(text,users,en,#102) "User \002%s\002 has been added with host \002%s\002."
	set ccs(text,users,en,#103) "You has been added in to \002%s\002's userlist."
	set ccs(text,users,en,#104) "You must setup your password first. The command is: \002/msg %s pass your_pass\002."
	set ccs(text,users,en,#105) "To get access for the bot's commands you must be identified via \002/msg %s auth your_pass\002."
	set ccs(text,users,en,#106) "For more information type \002%shelp\002 on the channels where is bot located."
	set ccs(text,users,en,#107) "Sorry, failure while add \002%s\002"
	set ccs(text,users,en,#108) "You don't have permissions to delete user %s."
	set ccs(text,users,en,#109) "User %s has been removed from bot's userlist."
	set ccs(text,users,en,#110) "Hostmask \002%s\002 has been added for \002%s\002."
	set ccs(text,users,en,#111) "Hostmask \002%s\002 has been deleted from \002%s\002's hostslist"
	set ccs(text,users,en,#112) "No one host matches to specified hostmask."
	set ccs(text,users,en,#113) "List of users with (%s): %s"
	set ccs(text,users,en,#114) "You don't have permissions to change flag \002%s\002 for \002%s\002"
	set ccs(text,users,en,#115) "New flags for %s: \002%s\002"
	set ccs(text,users,en,#116) "Password for nick %s has beed cleared."
	set ccs(text,users,en,#117) "Your password has been cleared, %s. Now you can re-set password via \002/msg %s pass your_pass\002."
	set ccs(text,users,en,#118) "Someone is already using \002%s\002."
	set ccs(text,users,en,#119) "Handle for %s has been changed to \002%s\002."
	set ccs(text,users,en,#120) "New INFO has been set for \002%s\002"
	set ccs(text,users,en,#121) "INFO for \002%s\002 has been deleted"
	set ccs(text,users,en,#122) "No users matching \002%s\002 found."

	
}