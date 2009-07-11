
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"link"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang link {[via-bot] <hub-bot>}
	set_text -type help -- $_lang link {Links the bots. The \002hub-bot\002 is a main botnet hub, to which there will be a link, \002via-bot\002 - intermediate bot (optional)}
	
	set_text -type args -- $_lang unlink {<hub-bot>}
	set_text -type help -- $_lang unlink {Unlink from \002hub-bot\002}
	
	set_text $_lang $_name #101 "Link to %s has been removed."
	set_text $_lang $_name #102 "Unable to unlink %s."
	set_text $_lang $_name #103 "%s and %s is linked."
	set_text $_lang $_name #104 "Unable to link %s with %s."
	set_text $_lang $_name #105 "%s and %s is liked up via %s."
	
}