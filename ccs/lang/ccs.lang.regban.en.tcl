if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"regban"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.3.0" \
				"18-Nov-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,regbanlist) {}
	set ccs(help,en,regbanlist) {Show the list of all regex-based bans}
	
	set ccs(args,en,regban) {<[-host {regex}] [-server {regex}] [-status {regex}] [-hops number] [-name {regex}]> [options]}
	set ccs(help,en,regban) {Add regex ban}
	set ccs(help2,en,regban) {
		{Add regex ban. Available parameters:}
		{  \002-ban [number]\002 - Action: \002ban\002. The optional parameter \002[number]\002 allows you to specify banmask template (1-9). If [number] is not specified, the default banmask value will be used.}
		{  \002-kick [{reason}]\002 - Action: \002kick\002. Reason is the optional.}
		{  \002-notify {handle1,handle2 ...} [{text}]\002 - Action: \002notice\002. When matching to banmask user joins to the channel - bot will send a notice about that to all specified users (they should be on the same channels where bot is in).}
	}
	
	set ccs(args,en,regunban) {<id>}
	set ccs(help,en,regunban) {Remove regex ban}
	
	set ccs(text,regban,en,#101) "Regex ban with \002ID: %s\002 succesfully added: %s."
	set ccs(text,regban,en,#102) "Regex ban with \002ID: %s\002 succesfully removed: %s."
	set ccs(text,regban,en,#103) "Regex ban with \002ID: %s\002 does not exist."
	set ccs(text,regban,en,#104) "--- List of the regex bans for \002%s\002 ---"
	set ccs(text,regban,en,#105) "*** Empty ***"
	set ccs(text,regban,en,#106) "--- End of regex bans list ---"
	set ccs(text,regban,en,#107) "Regex ban with \002ID: %s\002 %s: %s."
	set ccs(text,regban,en,#108) "Expression \"\002%s\002\" is not a valid regular expression."
	
} 