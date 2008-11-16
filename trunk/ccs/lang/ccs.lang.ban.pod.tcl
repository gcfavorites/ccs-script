
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ban"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.2" \
				"27-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,ban) {<����/����> [������] [�� �� ��� ���?] [stick]}
	set ccs(help,pod,ban) {�������� �����}
	set ccs(help2,pod,ban) {
		{�������� \002����\002� ��� \002����\002 (nick!ident@host) �� ������.}
		{������ ����������� � �������, ���� ������ ���������, �� ������ �������� �� ��������� �ban-time� ������.}
		{���� � ��������� ������� \002stick\002, �� ����� ����� ����� ����������� ��� ��� ������}
	}
	
	set ccs(args,pod,unban) {<���������>}
	set ccs(help,pod,unban) {������� ����� � \002����\002� �� ������.}
	
	set ccs(args,pod,gban) {<����/����> [������] [�� �� ��� ���?] [stick]}
	set ccs(help,pod,gban) {��������� �������� �����}
	set ccs(help2,pod,gban) {
		{�������� \002����\002� ��� \002����\002 (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���).}
		{������ ����������� � �������, ���� ������ ���������, �� ������ - 1 ����.}
		{���� � ��������� ������� \002stick\002, �� ����� ����� ����� ����������� ��� ��� ������}
	}
	
	set ccs(args,pod,gunban) {<���������>}
	set ccs(help,pod,gunban) {������� ���������� ����� � \002����\002� �� ���� �������}
	
	set ccs(args,pod,banlist) {[mask] [global]}
	set ccs(help,pod,banlist) {�������� ���� ������� ������, ���� ������ �������� \002global\002, �� ������� ���������� ���������}
	
	set ccs(args,pod,resetbans) {}
	set ccs(help,pod,resetbans) {�������� � ������ ��� ������, ������� ��� � ���������� ����}
	
	set ccs(text,ban,pod,#101) "������ ������� � �������"
	set ccs(text,ban,pod,#102) "��������� \002����������\002%s �����: \037%s\037."
	set ccs(text,ban,pod,#103) "���������%s �����: \037%s\037 �� \002%s\002."
	set ccs(text,ban,pod,#104) "%s (�� %s)."
	set ccs(text,ban,pod,#105) "\037����\037"
	set ccs(text,ban,pod,#106) "�������%s �����: \002%s\002."
	set ccs(text,ban,pod,#107) "������ \002%s\002 �� \002%s\002 ������ ������������."
	set ccs(text,ban,pod,#108) "���� �����"
	set ccs(text,ban,pod,#109) "���������� \002����������\002 ����������%s �����: \037%s\037."
	set ccs(text,ban,pod,#110) "���������� ����������%s �����: \037%s\037 �� %s."
	set ccs(text,ban,pod,#111) "����� ����������%s �����: \002%s\002"
	set ccs(text,ban,pod,#112) "����������� ������ \002%s\002 ������ ������������."
	set ccs(text,ban,pod,#113) "--- ���������� ���������%s ---"
	set ccs(text,ban,pod,#114) "--- ��������� \002%s\002%s ---"
	set ccs(text,ban,pod,#115) "*** ���������� ***"
	set ccs(text,ban,pod,#116) "(����� \002%s\002)"
	set ccs(text,ban,pod,#117) "����� \002����������\002."
	set ccs(text,ban,pod,#118) "�������� ����� %s."
	set ccs(text,ban,pod,#119) "%s. � \002%s\002%s � ���������: �%s� � %s � ����� ���������� %s ����� � ��������������: \002%s\002.%s"
	set ccs(text,ban,pod,#120) "--- �������� ���������� ---"
	set ccs(text,ban,pod,#121) "������, ������� ��� � ���������� ����, ���� �����������."
	
	
}