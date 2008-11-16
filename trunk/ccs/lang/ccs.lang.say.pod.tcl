
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"say"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"19-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,broadcast) {[@+] <текст>}
	set ccs(help,pod,broadcast) {Высрадь указанный \002текст\002 на фсе каналы}
	
	set ccs(args,pod,say) {[@+] [act] <текст>}
	set ccs(help,pod,say) {Атсылайед саапщенийе на канал. При указании act будет атсылацца ACTION}
	
	set ccs(args,pod,msg) {<юзир> [act] <текст>}
	set ccs(help,pod,msg) {Атсылайед саапщенийе фпревад \002юзир\002у. При указании act будит атсылацца ACTION}
	
	set ccs(args,pod,act) {[@+] <юзир> <текст>}
	set ccs(help,pod,act) {Атсцылайед саапщенийе на канал чириз ACTION}
	
	set ccs(text,say,pod,#101) "АХТУНГНАХ! С Вами будит пиздеть \002%s\002. Иво саапщенийе: %s."
	
}