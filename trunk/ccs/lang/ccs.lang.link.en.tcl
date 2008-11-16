
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"link"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,link) {[via-bot] <hub-bot>}
	set ccs(help,en,link) {Links the bots. The \002hub-bot\002 is a main botnet hub, to which there will be a link, \002via-bot\002 - intermediate bot (optional)}
	
	set ccs(args,en,unlink) {<hub-bot>}
	set ccs(help,en,unlink) {Unlink from \002hub-bot\002}
	
	set ccs(text,link,en,#101) "Link to %s has been removed."
	set ccs(text,link,en,#102) "Unable to unlink %s."
	set ccs(text,link,en,#103) "%s and %s is linked."
	set ccs(text,link,en,#104) "Unable to link %s with %s."
	set ccs(text,link,en,#105) "%s and %s is liked up via %s."
	
}