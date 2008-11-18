
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"link"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,link) {[via-bot] <hub-bot>}
	set ccs(help,ru,link) {������� �����. \002hub-bot\002 ������� ���(���) �������, � �������� ���� ��������, \002via-bot\002 ������������� ��� (��������� �� �����������)}
	
	set ccs(args,ru,unlink) {<hub-bot>}
	set ccs(help,ru,unlink) {������� �������� � ���� \002hub-bot\002}
	
	set ccs(text,link,ru,#101) "���� � %s ��� ������."
	set ccs(text,link,ru,#102) "�� ������� ������������ %s."
	set ccs(text,link,ru,#103) "%s � %s ����������."
	set ccs(text,link,ru,#104) "�� ������� ���������� %s � %s."
	set ccs(text,link,ru,#105) "%s � %s ���������� ����� %s."
	
}