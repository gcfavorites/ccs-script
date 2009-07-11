if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"regban"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang regbanlist {}
	set_text -type help -- $_lang regbanlist {Show the list of all regex-based bans}
	
	set_text -type args -- $_lang regban {<[-host {regex}] [-server {regex}] [-status {regex}] [-hops number] [-name {regex}]> [options]}
	set_text -type help -- $_lang regban {Add regex ban}
	set_text -type help2 -- $_lang regban {
		{Add regex ban. Available parameters:}
		{  \002-ban [number]\002 - Action: \002ban\002. The optional parameter \002[number]\002 allows you to specify banmask template (1-9). If [number] is not specified, the default banmask value will be used.}
		{  \002-kick [{reason}]\002 - Action: \002kick\002. Reason is the optional.}
		{  \002-notify {handle1,handle2 ...} [{text}]\002 - Action: \002notice\002. When matching to banmask user joins to the channel - bot will send a notice about that to all specified users (they should be on the same channels where bot is in).}
	}
	
	set_text -type args -- $_lang regunban {<id>}
	set_text -type help -- $_lang regunban {Remove regex ban}
	
	set_text $_lang $_name #101 "Regex ban with \002ID: %s\002 succesfully added: %s."
	set_text $_lang $_name #102 "Regex ban with \002ID: %s\002 succesfully removed: %s."
	set_text $_lang $_name #103 "Regex ban with \002ID: %s\002 does not exist."
	set_text $_lang $_name #104 "--- List of the regex bans for \002%s\002 ---"
	set_text $_lang $_name #105 "*** Empty ***"
	set_text $_lang $_name #106 "--- End of regex bans list ---"
	set_text $_lang $_name #107 "Regex ban with \002ID: %s\002 %s: %s."
	set_text $_lang $_name #108 "Expression \"\002%s\002\" is not a valid regular expression."
	
} 