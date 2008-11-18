
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"exempt"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.1" \
				"26-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,exempt) {<nick/host> [�����] [�������] [stick]}
	set ccs(help,ru,exempt) {������ ���������� nick ��� host (nick!ident@host) �� ������. ����� ����������� � �������, ���� ����� �� �������, �� ������ ����������� ����� �� ��������� �exempt-time� ������. ���� � ��������� ������� \002stick\002, �� ���������� ����� ����� ������������ ��� ��� ������.}
	
	set ccs(args,ru,unexempt) {<host>}
	set ccs(help,ru,unexempt) {������� ���������� � ������}
	
	set ccs(args,ru,gexempt) {<nick/host> [�����] [�������] [stick]}
	set ccs(help,ru,gexempt) {������ ���������� nick ��� host (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���). ����� ����������� � �������, ���� ����� �� �������, �� ����������� ����� - 1 ����. ���� � ��������� ������� \002stick\002, �� ���������� ����� ����� ������������ ��� ��� ������}
	
	set ccs(args,ru,gunexempt) {<host>}
	set ccs(help,ru,gunexempt) {������� ���������� ���������� �� ���� �������}
	
	set ccs(args,ru,exemptlist) {[global]}
	set ccs(help,ru,exemptlist) {������� ������ ���������� ������, ���� ������ �������� �global�, �� ������� ���������� ������ ����������}
	
	set ccs(args,ru,resetexempts) {}
	set ccs(help,ru,resetexempts) {������� � ������ ��� ����������, ������� ��� � ������ ����}
	
	set ccs(text,exempt,ru,#101) "Requested"
	set ccs(text,exempt,ru,#102) "��������� \002����������\002%s ����������: \037%s\037."
	set ccs(text,exempt,ru,#103) "%s (�� %s)."
	set ccs(text,exempt,ru,#104) "���������%s ����������: \037%s\037 �� %s."
	set ccs(text,exempt,ru,#105) "�����%s ����������: \002%s\002."
	set ccs(text,exempt,ru,#106) "���������� \002%s\002 �� \002%s\002 �� ����������."
	set ccs(text,exempt,ru,#107) "Requested"
	set ccs(text,exempt,ru,#108) "��������� \002����������\002 ����������%s ����������: \037%s\037."
	set ccs(text,exempt,ru,#109) "��������� ����������%s ����������: \037%s\037 �� %s."
	set ccs(text,exempt,ru,#110) "����� ����������%s ����������: \002%s\002"
	set ccs(text,exempt,ru,#111) "����������� ���������� \002%s\002 �� ����������."
	set ccs(text,exempt,ru,#112) "--- ���������� ������ ����������%s ---"
	set ccs(text,exempt,ru,#113) "--- ������ ���������� \002%s\002%s ---"
	set ccs(text,exempt,ru,#114) "*** ���� ***"
	set ccs(text,exempt,ru,#115) "���������� \002����������\002."
	set ccs(text,exempt,ru,#116) "�������� ����� %s."
	set ccs(text,exempt,ru,#117) "� %s %s� �������: �%s� � %s � ���������� ��������� %s ����� � ���������: \002%s\002.%s"
	set ccs(text,exempt,ru,#118) "--- ����� ������ ���������� ---"
	set ccs(text,exempt,ru,#119) "����������, ������� ��� � ������ ����, ���� �������."
	set ccs(text,exempt,ru,#120) "\037����\037"
	set ccs(text,exempt,ru,#121) "(����� \002%s\002)"
	set ccs(text,exempt,ru,#122) "�������� �� ������: \002%s\002 %s �����."
	set ccs(text,exempt,ru,#123) "--- ��������� ���������� ---"
	set ccs(text,exempt,ru,#124) "� \002%s\002 � �������� �� ������: \002%s\002 %s �����."
	
}