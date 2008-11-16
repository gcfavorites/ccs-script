
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"system"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,rehash) {}
	set ccs(help,ru,rehash) {������� ����}
	
	set ccs(args,ru,restart) {}
	set ccs(help,ru,restart) {��������� ����}
	
	set ccs(args,ru,jump) {[������ [���� [������]]]}
	set ccs(help,ru,jump) {���������� ���� �������������� � ������� �������. ���� ��������� �� �������, �� ����� ���������� �� ������}
	
	set ccs(args,ru,servers) {}
	set ccs(help,ru,servers) {������� ������ ��������, �� ������� ��� ����� ������������ � ������ ������������������� ������ �� ���}
	
	set ccs(args,ru,addserver) {[������ [���� [������]]]}
	set ccs(help,ru,addserver) {��������� � ������ �������� ����� ������. ��� ������ ����, ������ ���������� �� ����������� � ���������������� �����}
	
	set ccs(args,ru,delserver) {[������ [���� [������]]]}
	set ccs(help,ru,delserver) {������� ������ �� ������ ��������. ��� ������ ���� ������ ���������� �� ����������� � ���������������� �����}
	
	set ccs(args,ru,save) {}
	set ccs(help,ru,save) {���������� ������ �������������/�������}
	
	set ccs(args,ru,reload) {}
	set ccs(help,ru,reload) {�������� ������ �������������/�������}
	
	set ccs(args,ru,backup) {}
	set ccs(help,ru,backup) {������ ��������� ����� ������ ������������� � �������}
	
	set ccs(args,ru,die) {[�����]}
	set ccs(help,ru,die) {���������� ������ ����. � ��������� ������ ����� ��������� \002�����\002}
	
	set ccs(text,system,ru,#101) "Saving user file..."
	set ccs(text,system,ru,#102) "Rehashing..."
	set ccs(text,system,ru,#103) "Restart..."
	set ccs(text,system,ru,#104) "--- ������ �������� (������ ������� �������) ---"
	set ccs(text,system,ru,#105) "--- ����� ������ �������� ---"
	set ccs(text,system,ru,#106) "������ \002%s\002 ��� ���� � ������ ��������."
	set ccs(text,system,ru,#107) "������ \002%s\002 �������� � ������."
	set ccs(text,system,ru,#108) "������ \002%s\002 ������ �� ������ ��������."
	set ccs(text,system,ru,#109) "������ \002%s\002 �� ������ � ������."
	set ccs(text,system,ru,#110) "Saving user and chan file..."
	set ccs(text,system,ru,#211) "Reload user and chan file..."
	set ccs(text,system,ru,#212) "Backup user and chan file..."
	
	
}