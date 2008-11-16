
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"chan"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.5" \
				"17-Sep-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,channels) {}
	set ccs(help,ru,channels) {������� ������ �������}
	set ccs(help2,ru,channels) {
		{������� ������ �������, �� ������� ����� ��� (��� ������ �� ������ � ���������� ������������� �� ���)}
	}
	
	set ccs(args,ru,chanadd) {<�����>}
	set ccs(help,ru,chanadd) {��������� \002�����\002}
	
	set ccs(args,ru,chandel) {<�����>}
	set ccs(help,ru,chandel) {������� \002�����\002}
	
	set ccs(args,ru,rejoin) {}
	set ccs(help,ru,rejoin) {��� ������� ���� ��������� �� �����}
	
	set ccs(args,ru,chanset) {<[+/-]��������> [��������]}
	set ccs(help,ru,chanset) {��������� ���������� ������}
	set ccs(help2,ru,chanset) {
		{��������� ���������� ������ (��������, �+bitch� ��� �flood-chan 5:10�). ������ ������� �chanset� � �������.}
	}
	
	set ccs(args,ru,chaninfo) {[��������]}
	set ccs(help,ru,chaninfo) {�������� ���������� ������}
	set ccs(help2,ru,chaninfo) {
		{�������� ���������� ������. ���� �������� �� ������, �� ����� �������� ��� ���������. �������� �������� �����, ��������� �������������� ������� * � ?.}
	}
	
	set ccs(args,ru,chansave) {<���_�����> [���_�������]}
	set ccs(help,ru,chansave) {���������� �������� �������� ������ � ����}
	set ccs(help2,ru,chansave) {
		{���������� �������� �������� ������ � ����. ��� �������� ����� ����� ������� ����� ��������� ������ �� ��������� � �����, ������� �������� � �������.}
	}
	
	set ccs(args,ru,chanload) {<���_�����> [���_�������]}
	set ccs(help,ru,chanload) {�������������� �������� �� ����� ��� �������� ������}
	set ccs(help2,ru,chanload) {
		{�������������� �������� �� ����� ��� �������� ������. ��� �������� ����� ����� ������� ����� ������������� ������ �� ��������� � �����, ������� �������� � �������.}
	}
	
	set ccs(args,ru,chancopy) {<�����_��������> [���_�������]}
	set ccs(help,ru,chancopy) {����������� �������� �������� ������ �� ���������}
	set ccs(help2,ru,chancopy) {
		{����������� �������� �������� ������ �� ���������. ��� �������� ����� ����� ������� ����� ����������� ������ �� ��������� � �����, ������� �������� � �������.}
	}
	
	set ccs(args,ru,chantemplateadd) {<���_�������> <��������1 ��������2 ...>}
	set ccs(help,ru,chantemplateadd) {���������� � ������ ������ ����������}
	
	set ccs(args,ru,chantemplatedel) {<���_�������> <��������1 ��������2 ...>}
	set ccs(help,ru,chantemplatedel) {�������� �� ������� ������ ����������}
	
	set ccs(args,ru,chantemplatelist) {<���_�������>}
	set ccs(help,ru,chantemplatelist) {�������� ������ ���������� � �������}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,chan,ru,#101) "������: %s."
	set ccs(text,chan,ru,#102) "����� \002%s\002 ������."
	set ccs(text,chan,ru,#103) "����� \002%s\002 ��������."
	set ccs(text,chan,ru,#104) "����� \002%s\002 �� �������� �� ����."
	set ccs(text,chan,ru,#105) "����� \002%s\002 �������� ���������� � �� ����� ���� ����� � ������� ������� (�� ������ ��������� +inactive)."
	set ccs(text,chan,ru,#106) "��������� \002%s\002 �� ����������!"
	set ccs(text,chan,ru,#107) "���� ������ ������� �� \002%s\002"
	set ccs(text,chan,ru,#108) "�������� ����� ������: \002%s\002"
	set ccs(text,chan,ru,#109) "�������� \002%s\002 ������ ������� �� \"\002%s\002\""
	set ccs(text,chan,ru,#110) "�������� ��������� \002%s\002 ������: \"\002%s\002\""
	set ccs(text,chan,ru,#111) "��������� ������ \002%s\002 ��������� � ����� \"\002%s\002\""
	set ccs(text,chan,ru,#112) "��������� ������ \002%s\002 ��������� � ����� \"\002%s\002\" ��������� ������ \"\002%s\002\""
	set ccs(text,chan,ru,#113) "��������� ������ \002%s\002 ������������� �� ����� \"\002%s\002\""
	set ccs(text,chan,ru,#114) "��������� ������ \002%s\002 ������������� �� ����� \"\002%s\002\" ��������� ������ \"\002%s\002\""
	set ccs(text,chan,ru,#115) "��������� ������ \002%s\002 �������� ������������� �� ����� \"\002%s\002\", ������ �� �������������� ����������: \002%s\002"
	set ccs(text,chan,ru,#116) "��������� ������ \002%s\002 �������� ������������� �� ����� \"\002%s\002\" ��������� ������ \"\002%s\002\", ������ �� �������������� ����������: \002%s\002"
	set ccs(text,chan,ru,#117) "��������� ������ \002%s\002 ����������� �� \002%s\002"
	set ccs(text,chan,ru,#118) "��������� ������ \002%s\002 ����������� �� \002%s\002 ��������� ������ \"\002%s\002\""
	set ccs(text,chan,ru,#119) "����� \"\002%s\002\" � ����������� �� ����������."
	set ccs(text,chan,ru,#120) "����� \"\002%s\002\" ������� �� ����������."
	set ccs(text,chan,ru,#121) "���� ����� ���������� ��� ������ � ������ \"\002%s\002\"; %s."
	set ccs(text,chan,ru,#122) "���� ���������� ��� �������� �� ������� \"\002%s\002\"; %s."
	set ccs(text,chan,ru,#123) "� ������ \"\002%s\002\" �������� ����� ���������; %s."
	set ccs(text,chan,ru,#124) "�� ������� \"\002%s\002\" ���� ������� ���������; %s."
	set ccs(text,chan,ru,#125) "�����: \002%s\002"
	set ccs(text,chan,ru,#126) "���������: \002%s\002"
	set ccs(text,chan,ru,#127) "������: \002%s\002"
	set ccs(text,chan,ru,#128) "���������: \002%s\002"
	set ccs(text,chan,ru,#129) "�������������: \002%s\002"
	set ccs(text,chan,ru,#130) "������ ���������� � ������� \"\002%s\002\": \002%s\002."
	set ccs(text,chan,ru,#131) "�������������� ������ ����������: \002%s\002."
	
}