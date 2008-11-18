
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"system"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,rehash) {}
	set ccs(help,pod,rehash) {������� ����}
	
	set ccs(args,pod,restart) {}
	set ccs(help,pod,restart) {��������� ����}
	
	set ccs(args,pod,jump) {[������ [���� [������]]]}
	set ccs(help,pod,jump) {����������� ���� ������������� � ������� �������. ���� ��������� ���������, �� ����� ���������� ��������}
	
	set ccs(args,pod,servers) {}
	set ccs(help,pod,servers) {������� ������ ���������, �� ������� ��� ����� ����������� � ������ ������������������� ������ �� ���}
	
	set ccs(args,pod,addserver) {[������ [���� [������]]]}
	set ccs(help,pod,addserver) {�������� � ������ ��������� ����� ������. ��� ������ ����, ������ ���������� �� ���������� � �������}
	
	set ccs(args,pod,delserver) {[������ [���� [������]]]}
	set ccs(help,pod,delserver) {������� ������ �� ������ ���������. ��� ������ ���� ������ ���������� �� ���������� � �������}
	
	set ccs(args,pod,save) {}
	set ccs(help,pod,save) {����������� ������ �������/��������}
	
	set ccs(args,pod,reload) {}
	set ccs(help,pod,reload) {�������� ������� �������/��������}
	
	set ccs(args,pod,backup) {}
	set ccs(help,pod,backup) {������� ���������� ������ ������� ������� � ��������}
	
	set ccs(args,pod,die) {[�������]}
	set ccs(help,pod,die) {����������� ������ ����. � ��������� ������ ����� ��������� \002�������\002}
	
	set ccs(text,system,pod,#101) "������������ ��������..."
	set ccs(text,system,pod,#102) "����� � ������..."
	set ccs(text,system,pod,#103) "������� � ������..."
	set ccs(text,system,pod,#104) "--- ������ ��������� (������ ������� �������) ---"
	set ccs(text,system,pod,#105) "--- �������� ������ ��������� ---"
	set ccs(text,system,pod,#106) "������ \002%s\002 ��� ���� � ������ ��������� - ���� ��������!"
	set ccs(text,system,pod,#107) "������ \002%s\002 ����������� � ������."
	set ccs(text,system,pod,#108) "������ \002%s\002 �������� �� ������ ���������."
	set ccs(text,system,pod,#109) "������ \002%s\002 ����������� � ������ - ����� ��� ����!"
	set ccs(text,system,pod,#110) "������������ ����� ������ � ��������..."
	set ccs(text,system,pod,#211) "������������� ����� ������ � ��������..."
	set ccs(text,system,pod,#212) "������ ���������� ������ ������ � ��������..."
	
	
}