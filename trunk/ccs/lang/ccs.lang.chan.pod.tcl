
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"chan"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.2" \
				"28-Jul-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,channels) {}
	set ccs(help,pod,channels) {������� ������ ��������}
	set ccs(help2,pod,channels) {
		{������� ������ ��������, �� ������� ����� ��� (��� ������ �� ������ � ���������� ������� �� ��)}
	}
	
	set ccs(args,pod,chanadd) {<�����>}
	set ccs(help,pod,chanadd) {�������� \002�����\002}
	
	set ccs(args,pod,chandel) {<�����>}
	set ccs(help,pod,chandel) {������� \002�����\002 ������}
	
	set ccs(args,pod,rejoin) {}
	set ccs(help,pod,rejoin) {����� ������� ���� ��������� �� �����}
	
	set ccs(args,pod,chanset) {<[+/-]��������> [���������]}
	set ccs(help,pod,chanset) {�������� \002��������\002 ������ (��������, �+bitch� ��� �flood-chan 5:10�). ������ ������� �chanset� � �������}
	
	set ccs(args,pod,chaninfo) {[��������]}
	set ccs(help,pod,chaninfo) {������������� \002��������\002 ������. ���� �������� ��������, �� ����� �������� ��� ���������}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,chan,pod,#101) "������: %s."
	set ccs(text,chan,pod,#102) "����� \002%s\002 ����� ������."
	set ccs(text,chan,pod,#103) "����� \002%s\002 ���������."
	set ccs(text,chan,pod,#104) "����� \002%s\002 ���������� �� ����, ����� �����."
	set ccs(text,chan,pod,#105) "����� \002%s\002 ������� ���������� � ������� ���� ������� � �������� ������� (�� ������ ��������� +inactive)."
	set ccs(text,chan,pod,#106) "��������� \002%s\002 ����������!"
	set ccs(text,chan,pod,#107) "�������� ����� ������ \002%s\002"
	set ccs(text,chan,pod,#108) "��������� ����� ������: \002%s\002"
	set ccs(text,chan,pod,#109) "�������� ��������� \002%s\002 ������ �� \"\002%s\002\""
	set ccs(text,chan,pod,#110) "��������� ��������� \002%s\002 ������: \002%s\002"
	
}