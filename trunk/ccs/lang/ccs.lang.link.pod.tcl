
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"link"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,link) {[via-bot] <hub-bot>}
	set ccs(help,pod,link) {���������� ������. \002hub-bot\002 - ���������� ��� (���) �������, � �������� ���� ��������, \002via-bot\002 ������������� ��� (����� ����� �����������)}
	
	set ccs(args,pod,unlink) {<hub-bot>}
	set ccs(help,pod,unlink) {���������� ��������� � ���� \002hub-bot\002}
	
	set ccs(text,link,pod,#101) "���� � %s ��� ��������!"
	set ccs(text,link,pod,#102) "��������� ������������ %s. ������ ������ ���� � ������ �������!"
	set ccs(text,link,pod,#103) "%s � %s ����������. ������ ������� �� ������ ��������!"
	set ccs(text,link,pod,#104) "��������� ���������� %s � %s. ��������������� ���������� ������!"
	set ccs(text,link,pod,#105) "%s � %s ���������� ����� %s."
	
}