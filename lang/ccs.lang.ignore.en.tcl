
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ignore"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang addignore {<nick/host> [expiry] [reason]}
	set_text -type help -- $_lang addignore {Adds given \002nick\002 or \002host\002 (nick!ident@host) in a bot's ignore list. [Expiry] is always minutes, if you not specify [expiry], will be used one day period.}
	
	set_text -type args -- $_lang delignore {<host>}
	set_text -type help -- $_lang delignore {Removes given \002host\002 from bot's ignore list.}
	
	set_text -type args -- $_lang ignorelist {}
	set_text -type help -- $_lang ignorelist {Output bot's ignore list.}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Added ignore: \037%s\037 * expires after %s."
	set_text $_lang $_name #103 "Added \002permanent\002 ignore: \037%s\037."
	set_text $_lang $_name #104 "Removed ignore: \002%s\002."
	set_text $_lang $_name #105 "Can't find \002%s\002 in the ignore list."
	set_text $_lang $_name #106 "--- Global ignorelist ---"
	set_text $_lang $_name #107 "\002Permanent\002 ignore."
	set_text $_lang $_name #108 "Expires after %s."
	set_text $_lang $_name #109 "» %s ¤ Reason: «%s» ¤ %s ¤ Added %s ago ¤ Creator: \002%s\002."
	set_text $_lang $_name #110 "*** Empty ***"
	set_text $_lang $_name #111 "--- End of ignorelist ---"
	
	
}