
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"say"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang broadcast {[@+] <текст>}
	set_text -type help -- $_lang broadcast {Выводит указанное сообщение на все каналы}
	set_text -type help2 -- $_lang broadcast {
		{Выводит указанное сообщение на все каналы, на которых не стоит запрещающий режим.}
		{При указании мода \002@+\002 будет подано сообщения только опам/войсам. Поддерживается не всеми сетями.}
	}
	
	set_text -type args -- $_lang say {[@+] [act] <текст>}
	set_text -type help -- $_lang say {Отсылает сообщение на канал}
	set_text -type help2 -- $_lang say {
		{Отсылает сообщение на канал. При указание \002act\002 будет отсылаться ACTION}
		{При указании мода \002@+\002 будет подано сообщения только опам/войсам. Поддерживается не всеми сетями.}
	}
	
	set_text -type args -- $_lang msg {<ник> [act] <текст>}
	set_text -type help -- $_lang msg {Отсылает сообщение в приват}
	set_text -type help2 -- $_lang msg {{Отсылает сообщение в приват. При указание \002act\002 будет отсылаться ACTION}	}
	
	set_text -type args -- $_lang act {[@+] <ник> <текст>}
	set_text -type help -- $_lang act {Отсылает сообщение на канал через ACTION}
	set_text -type help2 -- $_lang act {
		{Отсылает сообщение на канал через ACTION}
		{При указании мода \002@+\002 будет подано сообщения только опам/войсам. Поддерживается не всеми сетями.}
	}
	
	set_text $_lang $_name #101 "Внимание! Глобальное сообщение от \002%s\002: %s."
	
}