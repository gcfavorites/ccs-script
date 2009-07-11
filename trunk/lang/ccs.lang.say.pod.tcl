
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"say"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang broadcast {[@+] <текст>}
	set_text -type help -- $_lang broadcast {Высрадь указанный \002текст\002 на фсе каналы}
	
	set_text -type args -- $_lang say {[@+] [act] <текст>}
	set_text -type help -- $_lang say {Атсылайед саапщенийе на канал. При указании act будет атсылацца ACTION}
	
	set_text -type args -- $_lang msg {<юзир> [act] <текст>}
	set_text -type help -- $_lang msg {Атсылайед саапщенийе фпревад \002юзир\002у. При указании act будит атсылацца ACTION}
	
	set_text -type args -- $_lang act {[@+] <юзир> <текст>}
	set_text -type help -- $_lang act {Атсцылайед саапщенийе на канал чириз ACTION}
	
	set_text $_lang $_name #101 "АХТУНГНАХ! С Вами будит пиздеть \002%s\002. Иво саапщенийе: %s."
	
}