
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ban"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.3" \
				"27-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,ban) {<nick/host> [�����] [�������] [stick]}
	set ccs(help,ru,ban) {���������� ���}
	set ccs(help2,ru,ban) {
		{����� \002nick\002 ��� \002host\002 (nick!ident@host) � ������.}
		{����� ����������� � �������, ���� ����� �� �������, �� ����� ������ �� ��������� �ban-time� ������.}
		{���� � ��������� ������� \002stick\002, �� ��� ����� ����� ������������ ��� ��� ������.}
	}
	
	set ccs(args,ru,unban) {<hostmask>}
	set ccs(help,ru,unban) {������� ��� \002host\002 � ������.}
	
	set ccs(args,ru,gban) {<nick/host> [�����] [�������] [stick]}
	set ccs(help,ru,gban) {���������� ���������� ���}
	set ccs(help2,ru,gban) {
		{����� \002nick\002 ��� \002host\002 (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���).}
		{����� ����������� � �������, ���� ����� �� �������, �� ����� - 1 ����.}
		{���� � ��������� ������� \002stick\002, �� ��� ����� ����� ������������ ��� ��� ������.}
	}
	
	set ccs(args,ru,gunban) {<hostmask>}
	set ccs(help,ru,gunban) {������� ���������� ��� \002host\002 �� ���� �������}
	
	set ccs(args,ru,banlist) {[mask] [global]}
	set ccs(help,ru,banlist) {������� ������� ������, ���� ������ �������� \002global\002, �� ������� ���������� �������}
	
	set ccs(args,ru,resetbans) {}
	set ccs(help,ru,resetbans) {������� � ������ ��� ����, ������� ��� � �������� ����}
	
	set ccs(text,ban,ru,#101) "Requested"
	set ccs(text,ban,ru,#102) "�������� \002����������\002%s ���: \037%s\037."
	set ccs(text,ban,ru,#103) "��������%s ���: \037%s\037 �� \002%s\002."
	set ccs(text,ban,ru,#104) "%s (�� %s)."
	set ccs(text,ban,ru,#105) "\037����\037"
	set ccs(text,ban,ru,#106) "����%s ���: \002%s\002."
	set ccs(text,ban,ru,#107) "���� \002%s\002 �� \002%s\002 �� ����������."
	set ccs(text,ban,ru,#108) "Requested"
	set ccs(text,ban,ru,#109) "�������� \002����������\002 ����������%s ���: \037%s\037."
	set ccs(text,ban,ru,#110) "�������� ����������%s ���: \037%s\037 �� %s."
	set ccs(text,ban,ru,#111) "���� ����������%s ���: \002%s\002"
	set ccs(text,ban,ru,#112) "����������� ���� \002%s\002 �� ����������."
	set ccs(text,ban,ru,#113) "--- ���������� �������%s ---"
	set ccs(text,ban,ru,#114) "--- ������� \002%s\002%s ---"
	set ccs(text,ban,ru,#115) "*** ���� ***"
	set ccs(text,ban,ru,#116) "(����� \002%s\002)"
	set ccs(text,ban,ru,#117) "��� \002����������\002."
	set ccs(text,ban,ru,#118) "�������� ����� %s."
	set ccs(text,ban,ru,#119) "%s. � \002%s\002%s � �������: �%s� � %s � ��� �������� %s ����� � ���������: \002%s\002.%s"
	set ccs(text,ban,ru,#120) "--- ����� �������� ---"
	set ccs(text,ban,ru,#121) "����, ������� ��� � �������� ����, ���� �������."
	set ccs(text,ban,ru,#122) "������������ ���� ����� ��� \002%s\002, ���������: \002%s\002."
	set ccs(text,ban,ru,#123) "�������� �� ������: \002%s\002 %s �����."
	set ccs(text,ban,ru,#124) "--- ��������� ���� ---"
	set ccs(text,ban,ru,#125) "� \002%s\002 � �������� �� ������: \002%s\002 %s �����."
	
}