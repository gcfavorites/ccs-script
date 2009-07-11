
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"say"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang broadcast {[@+] <message>}
	set_text -type help -- $_lang broadcast {Sends a global mesage to all bot's channels}
	
	set_text -type args -- $_lang say {[@+] [act] <message>}
	set_text -type help -- $_lang say {Sends given <message> to channel. If you specify [act] <message> will be treated as ACTION}
	
	set_text -type args -- $_lang msg {<nick> [act] <message>}
	set_text -type help -- $_lang msg {Sends given <message> to nick. If you specify [act] <message> will be treated as ACTION}
	
	set_text -type args -- $_lang act {[@+] <nick> <message>}
	set_text -type help -- $_lang act {Sends ACTION message to channel}
	
	set_text $_lang $_name #101 "Global message from \002%s\002: %s."
	
}