
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ban"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.2" \
				"27-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,ban) {<nick/host> [expiry] [reason] [stick]}
	set ccs(help,en,ban) {Bans (and kicks if user on the chan) a selected \002nick\002 or \002host\002 (nick!ident@host) on the channel . [Expiry] is always minutes, if you not specify [expiry] will be used default value from channel «ban-time» directive. If you specify a \002stick\002, ban will be sticked on the channel.}
	
	set ccs(args,en,unban) {<host>}
	set ccs(help,en,unban) {Removes a banned \002host\002 on a channel.}
	
	set ccs(args,en,gban) {<nick/host> [expiry] [reason] [stick]}
	set ccs(help,en,gban) {Sets a global (all bot's channels will be affected) ban for given \002nick\002 or \002host\002 (nick!ident@host). [Expiry] is always minutes, if you not specify [expiry], will be used one day period. If you specify a \002stick\002, ban will be sticked on the channels.}
	
	set ccs(args,en,gunban) {<host>}
	set ccs(help,en,gunban) {Removes global banned \002host\002 from all bot's channels.}
	
	set ccs(args,en,banlist) {[mask] [global]}
	set ccs(help,en,banlist) {Output channel banlist. If you specify \002global\002 will be shown global banlist.}
	
	set ccs(args,en,resetbans) {}
	set ccs(help,en,resetbans) {Removes all channel bans that is not in the bot's banlist.}
	
	
	set ccs(text,ban,en,#101) "Requested"
	set ccs(text,ban,en,#102) "Added \002permanent\002%s ban: \037%s\037."
	set ccs(text,ban,en,#103) "Added%s ban: \037%s\037 on \002%s\002."
	set ccs(text,ban,en,#104) "%s (expires on: %s)."
	set ccs(text,ban,en,#105) "\037stick\037"
	set ccs(text,ban,en,#106) "Removed%s ban: \002%s\002."
	set ccs(text,ban,en,#107) "Ban \002%s\002 on the \002%s\002 does not exist."
	set ccs(text,ban,en,#108) "Requested"
	set ccs(text,ban,en,#109) "Adden new \002permanent\002 global%s ban: \037%s\037."
	set ccs(text,ban,en,#110) "Added new global%s ban: \037%s\037 on the %s."
	set ccs(text,ban,en,#111) "Removed global%s ban: \002%s\002"
	set ccs(text,ban,en,#112) "Global ban \002%s\002 does not exist."
	set ccs(text,ban,en,#113) "--- Global banlist%s ---"
	set ccs(text,ban,en,#114) "--- Banlist for \002%s\002%s ---"
	set ccs(text,ban,en,#115) "*** Empty ***"
	set ccs(text,ban,en,#116) "(Mask \002%s\002)"
	set ccs(text,ban,en,#117) "\002Permanent\002 ban."
	set ccs(text,ban,en,#118) "Expires after %s."
	set ccs(text,ban,en,#119) "%s. » \002%s\002%s ¤ Reason: «%s» ¤ %s ¤ Ban was added %s weeks ago ¤ Creator: \002%s\002.%s"
	set ccs(text,ban,en,#120) "--- End of banlist ---"
	set ccs(text,ban,en,#121) "All bans that's doesn't match to internal bot's banlist was removed."
	
}