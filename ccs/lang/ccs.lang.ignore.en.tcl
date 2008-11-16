
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ignore"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,addignore) {<nick/host> [expiry] [reason]}
	set ccs(help,en,addignore) {Adds given \002nick\002 or \002host\002 (nick!ident@host) in a bot's ignore list. [Expiry] is always minutes, if you not specify [expiry], will be used one day period.}
	
	set ccs(args,en,delignore) {<host>}
	set ccs(help,en,delignore) {Removes given \002host\002 from bot's ignore list.}
	
	set ccs(args,en,ignorelist) {}
	set ccs(help,en,ignorelist) {Output bot's ignore list.}
	
	set ccs(text,ignore,en,#101) "Requested"
	set ccs(text,ignore,en,#102) "Added ignore: \037%s\037 * expires after %s."
	set ccs(text,ignore,en,#103) "Added \002permanent\002 ignore: \037%s\037."
	set ccs(text,ignore,en,#104) "Removed ignore: \002%s\002."
	set ccs(text,ignore,en,#105) "Can't find \002%s\002 in the ignore list."
	set ccs(text,ignore,en,#106) "--- Global ignorelist ---"
	set ccs(text,ignore,en,#107) "\002Permanent\002 ignore."
	set ccs(text,ignore,en,#108) "Expires after %s."
	set ccs(text,ignore,en,#109) "» %s ¤ Reason: «%s» ¤ %s ¤ Added %s ago ¤ Creator: \002%s\002."
	set ccs(text,ignore,en,#110) "*** Empty ***"
	set ccs(text,ignore,en,#111) "--- End of ignorelist ---"
	
	
}