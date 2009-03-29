
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"say"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.1" \
				"19-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,broadcast) {[@+] <текст>}
	set ccs(help,ru,broadcast) {Выводит указанное сообщение на все каналы}
	set ccs(help2,ru,broadcast) {
		{Выводит указанное сообщение на все каналы, на которых не стоит запрещающий режим.}
		{При указании мода \002@+\002 будет подано сообщения только опам/войсам. Поддерживается не всеми сетями.}
	}
	
	set ccs(args,ru,say) {[@+] [act] <текст>}
	set ccs(help,ru,say) {Отсылает сообщение на канал}
	set ccs(help2,ru,say) {
		{Отсылает сообщение на канал. При указание \002act\002 будет отсылаться ACTION}
		{При указании мода \002@+\002 будет подано сообщения только опам/войсам. Поддерживается не всеми сетями.}
	}
	
	set ccs(args,ru,msg) {<ник> [act] <текст>}
	set ccs(help,ru,msg) {Отсылает сообщение в приват}
	set ccs(help2,ru,msg) {{Отсылает сообщение в приват. При указание \002act\002 будет отсылаться ACTION}	}
	
	set ccs(args,ru,act) {[@+] <ник> <текст>}
	set ccs(help,ru,act) {Отсылает сообщение на канал через ACTION}
	set ccs(help2,ru,act) {
		{Отсылает сообщение на канал через ACTION}
		{При указании мода \002@+\002 будет подано сообщения только опам/войсам. Поддерживается не всеми сетями.}
	}
	
	set ccs(text,say,ru,#101) "Внимание! Глобальное сообщение от \002%s\002: %s."
	
}