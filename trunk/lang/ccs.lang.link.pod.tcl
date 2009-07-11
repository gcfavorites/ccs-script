
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"link"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang link {[via-bot] <hub-bot>}
	set_text -type help -- $_lang link {Слинкавадь ботафф. \002hub-bot\002 - главныйнах бот (хаб) ботнета, к катораму идет лингофка, \002via-bot\002 прамижутачный бот (можна нафиг ниуказывадь)}
	
	set_text -type args -- $_lang unlink {<hub-bot>}
	set_text -type help -- $_lang unlink {Стередьнах линкоффку к боту \002hub-bot\002}
	
	set_text $_lang $_name #101 "Линг к %s был стерднах!"
	set_text $_lang $_name #102 "Ниудалозь разлинкафадь %s. Срочна выпедь йаду и убицца апстену!"
	set_text $_lang $_name #103 "%s и %s слингофаны. Пабрей пелодку па случию празнега!"
	set_text $_lang $_name #104 "Ниудалось слингафать %s и %s. Убейсибяапстену криварукая макака!"
	set_text $_lang $_name #105 "%s и %s слингофаны чериз %s."
	
}