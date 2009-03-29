
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"ignore"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,addignore) {<����/����> [������] [�� �� ��� ���?]}
	set ccs(help,pod,addignore) {���������� \002����\002� ��� \002����\002 (nick!ident@host). ������ ����������� � �������, ���� ������ ���������, �� ������������ ������ - 1 ����}
	
	set ccs(args,pod,delignore) {<����>}
	set ccs(help,pod,delignore) {����� ����� � \002����\002�}
	
	set ccs(args,pod,ignorelist) {}
	set ccs(help,pod,ignorelist) {������� ������ ��������}
	
	set ccs(text,ignore,pod,#101) "������"
	set ccs(text,ignore,pod,#102) "��������� �����: \037%s\037 �� %s."
	set ccs(text,ignore,pod,#103) "��������� \002����������\002 �����: \037%s\037."
	set ccs(text,ignore,pod,#104) "���� �����: \002%s\002."
	set ccs(text,ignore,pod,#105) "������ \002%s\002 ���������."
	set ccs(text,ignore,pod,#106) "--- ���������� ���� �������� ---"
	set ccs(text,ignore,pod,#107) "����� \002����������\002."
	set ccs(text,ignore,pod,#108) "�������� ����� %s."
	set ccs(text,ignore,pod,#109) "� %s � ���������: �%s� � %s � ����� ���������� %s ����� � ��������������: \002%s\002."
	set ccs(text,ignore,pod,#110) "*** ���������� ***"
	set ccs(text,ignore,pod,#111) "--- �������� ���������� ---"
	
	
}