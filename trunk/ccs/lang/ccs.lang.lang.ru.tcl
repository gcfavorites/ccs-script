
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"lang"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,langlist) {[mod]}
	set ccs(help,ru,langlist) {���������� ������ ������������� ������ ��� �������}
	
	set ccs(args,ru,chansetlang) {<lang/default>}
	set ccs(help,ru,chansetlang) {���������� ���� �� ��������� ��� ������. ���� ������� \002default\002 ���� ����� �������.}
	
	set ccs(args,ru,chlang) {<nick/hand> <lang>}
	set ccs(help,ru,chlang) {���������� ���� �� ��������� ��� ���������� ����. ���� ������� \002default\002 ���� ����� �������.}
	
	set ccs(text,lang,ru,#101) "��� ��������� ������ ������������� ������ ������� ���� �� �������: \002%s\002."
	set ccs(text,lang,ru,#102) "������: \002%s\002, v%s \[%s\] by %s"
	set ccs(text,lang,ru,#103) " - ����: \002%s\002, v%s \[%s\] by %s"
	set ccs(text,lang,ru,#104) "���� \002%s\002 �� ������ �� ��� ������ ������, ���������� ������� ���� ��: \002%s\002."
	set ccs(text,lang,ru,#105) "���� ��� ������ \002%s\002 �������."
	set ccs(text,lang,ru,#106) "���� ��� ������ \002%s\002 ��������� �� \002%s\002."
	set ccs(text,lang,ru,#107) "���� ��� %s �������."
	set ccs(text,lang,ru,#108) "���� ��� %s ��������� �� \002%s\002."
	set ccs(text,lang,ru,#109) "�������� ����� ��� ������ \002%s\002 �� �����������."
	set ccs(text,lang,ru,#110) "�������� ����� ��� ������ \002%s\002 ����������� �� \002%s\002."
	set ccs(text,lang,ru,#111) "�������� ����� ��� %s �� �����������."
	set ccs(text,lang,ru,#112) "�������� ����� ��� %s ����������� �� \002%s\002."
	
}