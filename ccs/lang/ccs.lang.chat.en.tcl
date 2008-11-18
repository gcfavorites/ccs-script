
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chat"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,chat) {}
	set ccs(help,en,chat) {Tells bot send a DCC-chat request to you}
	
}