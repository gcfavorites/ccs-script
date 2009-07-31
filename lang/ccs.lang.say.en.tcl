
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"say"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang broadcast {[@+] <message>}
	set_text -type help -- $_lang broadcast {Sends a global mesage to all bot's channels}
	set_text -type help2 -- $_lang broadcast {
		{Sends a global mesage to all bot's channels.}
		{You can specify \002@+\002 to send a message for ops/voices only. Note that not all IRCds supports this feature correctly.}
	}
	
	set_text -type args -- $_lang say {[@+] [act] <message>}
	set_text -type help -- $_lang say {Sends given <message> to channel. If you specify [act] <message> will be treated as ACTION}
	set_text -type help2 -- $_lang say {
		{Sends given <message> on the channel. If you specify [act] <message> will be treated as ACTION}
		{You can specify \002@+\002 to send a message for ops/voices only. Note that not all IRCds supports this feature correctly.}
	}

	set_text -type args -- $_lang msg {<nick> [act] <message>}
	set_text -type help -- $_lang msg {Sends given <message> to the nick. If you specify [act] <message> will be treated as ACTION}
	set_text -type help2 -- $_lang msg {{Sends given <message> to the nick. If you specify [act] <message> will be treated as ACTION}}

	set_text -type args -- $_lang act {[@+] <nick> <message>}
	set_text -type help -- $_lang act {Sends ACTION message to channel}
	set_text -type help2 -- $_lang act {
		{Sends ACTION message to channel}
		{You can specify \002@+\002 to send a message for ops/voices only. Note that not all IRCds supports this feature correctly.}
	}

	set_text $_lang $_name #101 "!!! Global message from \002%s\002: %s."
	
}