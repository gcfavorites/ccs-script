
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"invite"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang invite {<nick/hostmask> [expiry] [reason] [stick]}
	set_text -type help -- $_lang invite {Adds a channel invite}
	set_text -type help2 -- $_lang invite {
		{Sets a channel invite for specified nick or hostmask (nick!ident@host).}
		{[Expiry] is always minutes, if you do not specify [expiry] - will be used default value from channel «invite-time» directive.}
		{If you specify a \002stick\002, invite will be sticked on the channel.}
	}
	
	set_text -type args -- $_lang uninvite {<hostmask>}
	set_text -type help -- $_lang uninvite {Removes an invite from a channel}
	
	set_text -type args -- $_lang ginvite {<nick/hostmask> [expiry] [reason] [stick]}
	set_text -type help -- $_lang ginvite {Adds a global invite}
	set_text -type help2 -- $_lang ginvite {
		{Sets a global (all bot's channels will be affected) invite for given \002nick\002 or \002host\002 (nick!ident@host).}
		{[expiry] is always minutes, if you do not specify [expiry], will be used one day period. }
		{If you specify a \002stick\002, ban will be sticked on the channels.}
	}
	
	set_text -type args -- $_lang guninvite {<hostmask>}
	set_text -type help -- $_lang guninvite {Removes a global invite from invite list}
	
	set_text -type args -- $_lang invitelist {[global]}
	set_text -type help -- $_lang invitelist {Lists all channel invites, use «global» to get global invite list.}
	
	set_text -type args -- $_lang resetinvites {}
	set_text -type help -- $_lang resetinvites {Removes all channel invite that is not in the bot's internal invite list.}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Added \002permanent\002%s invite: \037%s\037."
	set_text $_lang $_name #103 "%s (äî %s)."
	set_text $_lang $_name #104 "Added%s invite: \037%s\037 íà %s."
	set_text $_lang $_name #105 "Ñíÿò%s invite: \002%s\002."
	set_text $_lang $_name #106 "Invite \002%s\002 on the channel \002%s\002 does not exist."
	set_text $_lang $_name #107 "Requested"
	set_text $_lang $_name #108 "Added \002permanent\002 global%s invite: \037%s\037."
	set_text $_lang $_name #109 "Added global%s invite: \037%s\037 íà %s."
	set_text $_lang $_name #110 "Removed global%s invite: \002%s\002"
	set_text $_lang $_name #111 "Global invite \002%s\002 does not exist."
	set_text $_lang $_name #112 "--- Global invite list%s ---"
	set_text $_lang $_name #113 "--- Invite list for \002%s\002%s ---"
	set_text $_lang $_name #114 "*** Empty ***"
	set_text $_lang $_name #115 "\002permanent\002 invite."
	set_text $_lang $_name #116 "Expires after %s."
	set_text $_lang $_name #117 "» %s %s¤ Reason: «%s» ¤ %s ¤ invite was added %s ago ¤ Creator: \002%s\002.%s"
	set_text $_lang $_name #118 "--- End of invite list ---"
	set_text $_lang $_name #119 "All invites that's doesn't match to internal bot's invitelist has been removed." 
	set_text $_lang $_name #120 "\037stick\037"
	set_text $_lang $_name #121 "(mask \002%s\002)"
	set_text $_lang $_name #122 "Set by: \002%s\002 %s ago."
	set_text $_lang $_name #123 "--- Channel-side invite ---"
	set_text $_lang $_name #124 "» \002%s\002 ¤ Set by: \002%s\002 %s ago."
	
}