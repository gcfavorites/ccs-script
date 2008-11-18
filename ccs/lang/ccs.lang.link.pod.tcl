
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"link"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,link) {[via-bot] <hub-bot>}
	set ccs(help,pod,link) {Слинкавадь ботафф. \002hub-bot\002 - главныйнах бот (хаб) ботнета, к катораму идет лингофка, \002via-bot\002 прамижутачный бот (можна нафиг ниуказывадь)}
	
	set ccs(args,pod,unlink) {<hub-bot>}
	set ccs(help,pod,unlink) {Стередьнах линкоффку к боту \002hub-bot\002}
	
	set ccs(text,link,pod,#101) "Линг к %s был стерднах!"
	set ccs(text,link,pod,#102) "Ниудалозь разлинкафадь %s. Срочна выпедь йаду и убицца апстену!"
	set ccs(text,link,pod,#103) "%s и %s слингофаны. Пабрей пелодку па случию празнега!"
	set ccs(text,link,pod,#104) "Ниудалось слингафать %s и %s. Убейсибяапстену криварукая макака!"
	set ccs(text,link,pod,#105) "%s и %s слингофаны чериз %s."
	
}