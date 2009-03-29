
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"exempt"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"26-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,exempt) {<����/����> [�����] [�� �� ��� ���?] [stick]}
	set ccs(help,pod,exempt) {�������� ����������� �� \002����\002� ��� \002����\002 (nick!ident@host) �� ������. ������ ����������� � �������, ���� ������ ���������, �� ��� �������� �� ��������� �exempt-time� ������. ���� � ��������� ������� \002stick\002, �� ����������� ����� ����� ����������� ��� ��� ������.}
	
	set ccs(args,pod,unexempt) {<����>}
	set ccs(help,pod,unexempt) {�������� ����������� � ������}
	
	set ccs(args,pod,gexempt) {<����/����> [�����] [�� �� ��� ���?] [stick]}
	set ccs(help,pod,gexempt) {�������� ����������� �� \002����\002� ��� \002����\002 (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���). ������ ����������� � �������, ���� ������ ���������, �� ������������ ������ - 1 ����. ���� � ��������� ������� \002stick\002, �� ����������� ����� ����� ����������� ��� ��� ������.}
	
	set ccs(args,pod,gunexempt) {<����>}
	set ccs(help,pod,gunexempt) {����� ����������� ����������� �� ���� ��������}
	
	set ccs(args,pod,exemptlist) {[global]}
	set ccs(help,pod,exemptlist) {������� ������ ���������� ������, ���� ������ �������� �global�, �� ������� ���������� ������ ����������}
	
	set ccs(args,pod,resetexempts) {}
	set ccs(help,pod,resetexempts) {���������� � ������ ��� �����������, ������� ��� � ������ ����}
	
	set ccs(text,exempt,pod,#101) "�� �������: ��� ���� � ������!"
	set ccs(text,exempt,pod,#102) "���������� \002�����������\002%s �����������: \037%s\037."
	set ccs(text,exempt,pod,#103) "%s (�� %s)."
	set ccs(text,exempt,pod,#104) "����������%s �����������: \037%s\037 �� %s."
	set ccs(text,exempt,pod,#105) "���������%s �����������: \002%s\002."
	set ccs(text,exempt,pod,#106) "����������� \002%s\002 �� \002%s\002 ���������! ������ �������!"
	set ccs(text,exempt,pod,#107) "�� �������: ��� ���� � ������!"
	set ccs(text,exempt,pod,#108) "���������� \002�����������\002 ����������%s �����������: \037%s\037."
	set ccs(text,exempt,pod,#109) "���������� �����������%s �����������: \037%s\037 �� %s."
	set ccs(text,exempt,pod,#110) "��������� �����������%s �����������: \002%s\002"
	set ccs(text,exempt,pod,#111) "����������� ����������� \002%s\002 ����������."
	set ccs(text,exempt,pod,#112) "--- ���������� ������ ����������%s ---"
	set ccs(text,exempt,pod,#113) "--- ������ ���������� \002%s\002%s ---"
	set ccs(text,exempt,pod,#114) "*** ��������� ***"
	set ccs(text,exempt,pod,#115) "����������� \002�����������\002."
	set ccs(text,exempt,pod,#116) "�������� ����� %s."
	set ccs(text,exempt,pod,#117) "� %s %s� ���������: �%s� � %s � ����������� ���������� %s ����� � �������������: \002%s\002.%s"
	set ccs(text,exempt,pod,#118) "--- �������� ������ ���������� ---"
	set ccs(text,exempt,pod,#119) "�����������, ������� ��� � ������ ����, ���� ���������."
	set ccs(text,exempt,pod,#120) "\037����\037"
	set ccs(text,exempt,pod,#121) "(����� \002%s\002)"
	set ccs(text,exempt,pod,#122) "��������� �� ������: \002%s\002 %s �����."
	set ccs(text,exempt,pod,#123) "--- ��������� ����������� ---"
	set ccs(text,exempt,pod,#124) "� \002%s\002 � ��������� �� ������: \002%s\002 %s �����."
	
}