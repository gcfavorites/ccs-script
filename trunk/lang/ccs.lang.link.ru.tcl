
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"link"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang link {[via-bot] <hub-bot>}
	set_text -type help -- $_lang link {Ћинкует ботов. \002hub-bot\002 главный бот(хаб) ботнета, к которому идет линковка, \002via-bot\002 промежуточный бот (указывать не об€зательно)}
	
	set_text -type args -- $_lang unlink {<hub-bot>}
	set_text -type help -- $_lang unlink {”дал€ет линковку к боту \002hub-bot\002}
	
	set_text $_lang $_name #101 "Ћинк к %s был удален."
	set_text $_lang $_name #102 "Ќе удалось разлинковать %s."
	set_text $_lang $_name #103 "%s и %s слинкованы."
	set_text $_lang $_name #104 "Ќе удалось слинковать %s и %s."
	set_text $_lang $_name #105 "%s и %s слинкованы через %s."
	
}