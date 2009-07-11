
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ban"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang ban {<nick/host> [expiry] [reason] [stick]}
	set_text -type help -- $_lang ban {Bans (and kicks if matched user on the chan) a selected \002nick\002 or \002host\002 (nick!ident@host) on the channel . [Expiry] is always minutes, if you not specify [expiry] will be used default value from channel «ban-time» directive. If you specify a \002stick\002, ban will be sticked on the channel.}
	
	set_text -type args -- $_lang unban {<host>}
	set_text -type help -- $_lang unban {Removes a banned \002host\002 on a channel.}
	
	set_text -type args -- $_lang gban {<nick/host> [expiry] [reason] [stick]}
	set_text -type help -- $_lang gban {Sets a global (all bot's channels will be affected) ban for given \002nick\002 or \002host\002 (nick!ident@host). [Expiry] is always minutes, if you not specify [expiry], will be used one day period. If you specify a \002stick\002, ban will be sticked on the channels.}
	
	set_text -type args -- $_lang gunban {<host>}
	set_text -type help -- $_lang gunban {Removes global banned \002host\002 from all bot's channels.}
	
	set_text -type args -- $_lang banlist {[mask] [global]}
	set_text -type help -- $_lang banlist {Output channel banlist. If you specify \002global\002 will be shown global banlist.}
	
	set_text -type args -- $_lang resetbans {}
	set_text -type help -- $_lang resetbans {Removes all channel bans that is not in the bot's banlist.}
	
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Added \002permanent\002%s ban: \037%s\037."
	set_text $_lang $_name #103 "Added%s ban: \037%s\037 on \002%s\002."
	set_text $_lang $_name #104 "%s (expires on: %s)."
	set_text $_lang $_name #105 "\037stick\037"
	set_text $_lang $_name #106 "Removed%s ban: \002%s\002."
	set_text $_lang $_name #107 "Ban \002%s\002 on the \002%s\002 does not exist."
	set_text $_lang $_name #108 "Requested"
	set_text $_lang $_name #109 "Added new \002permanent\002 global%s ban: \037%s\037."
	set_text $_lang $_name #110 "Added new global%s ban: \037%s\037 on the %s."
	set_text $_lang $_name #111 "Removed global%s ban: \002%s\002"
	set_text $_lang $_name #112 "Global ban \002%s\002 does not exist."
	set_text $_lang $_name #113 "--- Global banlist%s ---"
	set_text $_lang $_name #114 "--- Banlist for \002%s\002%s ---"
	set_text $_lang $_name #115 "*** Empty ***"
	set_text $_lang $_name #116 "(Mask \002%s\002)"
	set_text $_lang $_name #117 "\002Permanent\002 ban."
	set_text $_lang $_name #118 "Expires after %s."
	set_text $_lang $_name #119 "%s. » \002%s\002%s ¤ Reason: «%s» ¤ %s ¤ Ban was added %s weeks ago ¤ Creator: \002%s\002.%s"
	set_text $_lang $_name #120 "--- End of banlist ---"
	set_text $_lang $_name #121 "All bans that's doesn't match to internal bot's banlist was removed."
	
}