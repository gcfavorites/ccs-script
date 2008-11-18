
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"link"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,link) {[via-bot] <hub-bot>}
	set ccs(help,ru,link) {Ћинкует ботов. \002hub-bot\002 главный бот(хаб) ботнета, к которому идет линковка, \002via-bot\002 промежуточный бот (указывать не об€зательно)}
	
	set ccs(args,ru,unlink) {<hub-bot>}
	set ccs(help,ru,unlink) {”дал€ет линковку к боту \002hub-bot\002}
	
	set ccs(text,link,ru,#101) "Ћинк к %s был удален."
	set ccs(text,link,ru,#102) "Ќе удалось разлинковать %s."
	set ccs(text,link,ru,#103) "%s и %s слинкованы."
	set ccs(text,link,ru,#104) "Ќе удалось слинковать %s и %s."
	set ccs(text,link,ru,#105) "%s и %s слинкованы через %s."
	
}