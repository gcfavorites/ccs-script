if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"users"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang adduser {<nick> [host]}
	set_text -type help -- $_lang adduser {Adds new user in to a bot's userlist, if you do not specify \002host\002, hostmask *!?ident@*.host will be used (in this case user must be on the channel).}
	
	set_text -type args -- $_lang deluser {<nick>}
	set_text -type help -- $_lang deluser {Removes given \002nick\002 from bot's userlist. Note: to delete a user from userlist your añcess level must be greater than access level of the specified user (so, if you have +o flag on the #chan1, and specified user have +m - you can't delete him).}
	
	set_text -type args -- $_lang addhost {<nick|handle> <host>}
	set_text -type help -- $_lang addhost {Adds given \002host\002 to the specified \002nick\002 or \002handle\002}
	
	set_text -type args -- $_lang delhost {<nick|handle> <host>|<-m hostmask>}
	set_text -type help -- $_lang delhost {Removes given \002host\002 from user's hosts list.}
	set_text -type help2 -- $_lang delhost {
		{Removes given \002host\002 from user's hosts list.}
		{Wildcards are allowed if you have specified -m key. Symbols like \002* ? [ ] \\002 can be used when specify the mask. To use these symblos 'as is' you need to put a '\002\\002' before every of them.}
		{\002-m *\002 - removes all host from list}
	}

	set_text -type args -- $_lang chattr {<nick> <+flags|-flags> [global]}
	set_text -type help -- $_lang chattr {Adds/removes user's flags. You can specify \002global\002 to change a global user's flags.}
	
	set_text -type args -- $_lang userlist {[-f gflags|lflags] [-h hostmask]}
	set_text -type help -- $_lang userlist {Shows a list of all bot users which have a given flags or/and hostmask. Works is the same as 'userlist' TCL-command}
		set_text -type help2 -- $_lang userlist {
		{Shows a list of all bot users which have a given flags or/and hostmask.}
		{Wildcards in the hostmask are allowed if you have specified -h key. Symbols like \002* ? [ ] \\002 can be used when specify the mask. To use these symblos 'as is' you need to put a '\002\\002' before every of them.}
	}

	set_text -type args -- $_lang match {[-h hostmask]}
	set_text -type help -- $_lang match {Shows a list of channel users matching specified hostmask.}
	set_text -type help2 -- $_lang match {
		{Shows a list of channel users matching specified hostmask.}
		{Symbols like \002* ? [ ] \\002 can be used when specify the mask. To use these symblos 'as is' you need to put a '\002\\002' before every of them.}
	}
	
	set_text -type args -- $_lang resetpass {<nick>}
	set_text -type help -- $_lang resetpass {Clears user's password (that mean he can set new password via /msg %botnick pass <new_pass>).}
	
	set_text -type args -- $_lang chhandle {<oldnick> <newnick>}
	set_text -type help -- $_lang chhandle {Changes the handle of a user.}
	
	set_text -type args -- $_lang setinfo {<nick|hand> <text>}
	set_text -type help -- $_lang setinfo {Sets user info (greet), that will be shown via %pref_whois and/or when user joins to a channel (the second one only works if flag +greet enabled)}
	
	set_text -type args -- $_lang delinfo {<nick|hand>}
	set_text -type help -- $_lang delinfo {Removes user's info (greet) \002nick|hand\002}
	
	set_text $_lang $_name #101 "Can't find \002%s\002 on the monitored channels, so, can't do a host lookup (specify the host manually)"
	set_text $_lang $_name #102 "User \002%s\002 has been added with host \002%s\002."
	set_text $_lang $_name #103 "You has been added in to \002%s\002's userlist."
	set_text $_lang $_name #104 "You must setup your password first. The command is: \002/msg %s pass your_pass\002."
	set_text $_lang $_name #105 "To get access for the bot's commands you must be identified via \002/msg %s auth your_pass\002."
	set_text $_lang $_name #106 "For more information type \002%shelp\002 on the channels where is bot located."
	set_text $_lang $_name #107 "Sorry, failure while add \002%s\002"
	set_text $_lang $_name #108 "You don't have permissions to delete user %s."
	set_text $_lang $_name #109 "User %s has been removed from bot's userlist."
	set_text $_lang $_name #110 "Hostmask \002%s\002 has been added for \002%s\002."
	set_text $_lang $_name #111 "Hostmask \002%s\002 has been deleted from \002%s\002's hostslist"
	set_text $_lang $_name #112 "No one host matches to specified hostmask."
	set_text $_lang $_name #113 "List of users with (%s): %s"
	set_text $_lang $_name #114 "You don't have permissions to change flag \002%s\002 for \002%s\002"
	set_text $_lang $_name #115 "New flags for %s: \002%s\002"
	set_text $_lang $_name #116 "Password for nick %s has beed cleared."
	set_text $_lang $_name #117 "Your password has been cleared, %s. Now you can re-set password via \002/msg %s pass your_pass\002."
	set_text $_lang $_name #118 "Someone is already using \002%s\002."
	set_text $_lang $_name #119 "Handle for %s has been changed to \002%s\002."
	set_text $_lang $_name #120 "New INFO has been set for \002%s\002"
	set_text $_lang $_name #121 "INFO for \002%s\002 has been deleted"
	set_text $_lang $_name #122 "No users matching \002%s\002 found."
	
}