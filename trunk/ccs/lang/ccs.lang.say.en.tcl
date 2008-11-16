
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"say"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.1" \
				"19-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,broadcast) {[@+] <message>}
	set ccs(help,en,broadcast) {Sends a global mesage to all bot's channels}
	
	set ccs(args,en,say) {[@+] [act] <message>}
	set ccs(help,en,say) {Sends given <message> to channel. If you specify [act] <message> will be treated as ACTION}
	
	set ccs(args,en,msg) {<nick> [act] <message>}
	set ccs(help,en,msg) {Sends given <message> to nick. If you specify [act] <message> will be treated as ACTION}
	
	set ccs(args,en,act) {[@+] <nick> <message>}
	set ccs(help,en,act) {Sends ACTION message to channel}
	
	set ccs(text,say,en,#101) "Global message from \002%s\002: %s."
	
}