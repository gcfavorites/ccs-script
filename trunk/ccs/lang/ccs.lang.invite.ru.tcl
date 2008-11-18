
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"invite"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.1" \
				"26-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,invite) {<nick/hostmask> [�����] [�������] [stick]}
	set ccs(help,ru,invite) {���������� ������}
	set ccs(help2,ru,invite) {
		{������ ������ nick ��� host (nick!ident@host) �� ������.}
		{����� ����������� � �������, ���� ����� �� �������, �� ������ ����������� ����� �� ��������� �invite-time� ������.}
		{���� � ��������� ������� \002stick\002, �� ������ ����� ����� ������������ ��� ��� ������.}
	}
	
	set ccs(args,ru,uninvite) {<hostmask>}
	set ccs(help,ru,uninvite) {������� ������ � ������}
	
	set ccs(args,ru,ginvite) {<nick/hostmask> [�����] [�������] [stick]}
	set ccs(help,ru,ginvite) {���������� ���������� ������}
	set ccs(help2,ru,ginvite) {
		{������ ������ nick ��� host (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���).}
		{����� ����������� � �������, ���� ����� �� �������, �� ����������� ����� - 1 ����.}
		{���� � ��������� ������� \002stick\002, �� ������ ����� ����� ������������ ��� ��� ������}
	}
	
	set ccs(args,ru,guninvite) {<hostmask>}
	set ccs(help,ru,guninvite) {������� ���������� ������ �� ���� �������}
	
	set ccs(args,ru,invitelist) {[global]}
	set ccs(help,ru,invitelist) {������� ������ �������� ������, ���� ������ �������� �global�, �� ������� ���������� ������ ��������}
	
	set ccs(args,ru,resetinvites) {}
	set ccs(help,ru,resetinvites) {������� � ������ ��� �������, ������� ��� � ������ ����}
	
	set ccs(text,invite,ru,#101) "Requested"
	set ccs(text,invite,ru,#102) "�������� \002����������\002%s ������: \037%s\037."
	set ccs(text,invite,ru,#103) "%s (�� %s)."
	set ccs(text,invite,ru,#104) "��������%s ������: \037%s\037 �� %s."
	set ccs(text,invite,ru,#105) "����%s ������: \002%s\002."
	set ccs(text,invite,ru,#106) "������� \002%s\002 �� \002%s\002 �� ����������."
	set ccs(text,invite,ru,#107) "Requested"
	set ccs(text,invite,ru,#108) "�������� \002����������\002 ����������%s ������: \037%s\037."
	set ccs(text,invite,ru,#109) "�������� ����������%s ������: \037%s\037 �� %s."
	set ccs(text,invite,ru,#110) "���� ����������%s ������: \002%s\002"
	set ccs(text,invite,ru,#111) "����������� ������� \002%s\002 �� ����������."
	set ccs(text,invite,ru,#112) "--- ���������� ������ ��������%s ---"
	set ccs(text,invite,ru,#113) "--- ������ �������� \002%s\002%s ---"
	set ccs(text,invite,ru,#114) "*** ���� ***"
	set ccs(text,invite,ru,#115) "������ \002����������\002."
	set ccs(text,invite,ru,#116) "�������� ����� %s."
	set ccs(text,invite,ru,#117) "� %s %s� �������: �%s� � %s � ������ �������� %s ����� � ���������: \002%s\002.%s"
	set ccs(text,invite,ru,#118) "--- ����� ������ �������� ---"
	set ccs(text,invite,ru,#119) "�������, ������� ��� � ������ ����, ���� �������."
	set ccs(text,invite,ru,#120) "\037����\037"
	set ccs(text,exempt,ru,#121) "(����� \002%s\002)"
	set ccs(text,exempt,ru,#122) "�������� �� ������: \002%s\002 %s �����."
	set ccs(text,exempt,ru,#123) "--- ��������� ������� ---"
	set ccs(text,exempt,ru,#124) "� \002%s\002 � �������� �� ������: \002%s\002 %s �����."
	
}