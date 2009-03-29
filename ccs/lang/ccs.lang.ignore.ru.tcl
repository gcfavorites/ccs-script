
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"ignore"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,addignore) {<nick/host> [�����] [�������]}
	set ccs(help,ru,addignore) {��������� ����� �� \002nick\002 ��� \002host\002 (nick!ident@host). ����� ����������� � �������, ���� ����� �� �������, �� ����������� ����� - 1 ����}
	
	set ccs(args,ru,delignore) {<host>}
	set ccs(help,ru,delignore) {������� ����� \002host\002}
	
	set ccs(args,ru,ignorelist) {}
	set ccs(help,ru,ignorelist) {������� ������ �������}
	
	set ccs(text,ignore,ru,#101) "Requested"
	set ccs(text,ignore,ru,#102) "�������� �����: \037%s\037 �� %s."
	set ccs(text,ignore,ru,#103) "�������� \002����������\002 �����: \037%s\037."
	set ccs(text,ignore,ru,#104) "���� �����: \002%s\002."
	set ccs(text,ignore,ru,#105) "������ \002%s\002 �� ����������."
	set ccs(text,ignore,ru,#106) "--- ���������� ��������� ---"
	set ccs(text,ignore,ru,#107) "����� \002����������\002."
	set ccs(text,ignore,ru,#108) "�������� ����� %s."
	set ccs(text,ignore,ru,#109) "� %s � �������: �%s� � %s � ����� �������� %s ����� � ���������: \002%s\002."
	set ccs(text,ignore,ru,#110) "*** ���� ***"
	set ccs(text,ignore,ru,#111) "--- ����� ���������� ---"
	
	
}