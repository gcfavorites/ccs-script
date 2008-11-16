
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"users"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"30-Jul-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,adduser) {<����> [����]}
	set ccs(help,pod,adduser) {��������� \002����\002� � �������� ����, ���� �������� \002����\002 ��������, �� ��� ���� ���� *!?ident@*.host (������� ������ ������������� �� ������), ���� �������� \002����\002 ������, �� �������� ����� �� ������ �������������}
	
	set ccs(args,pod,deluser) {<����>}
	set ccs(help,pod,deluser) {������� \002����\002� �� ���������. �����������: ���� ������� �����, �� ������ ���� ���� ��� �������� �� ���� �������, �� ������� �� �������� (������ ���� �� +o �� #chan1, � �� ��� �� +m, �� ������� ����� ��������)}
	
	set ccs(args,pod,addhost) {<����/�����> <����>}
	set ccs(help,pod,addhost) {�������� \002����\002 ����� � ����� \002����\002 ��� ������� \002�����\002}
	
	set ccs(args,pod,delhost) {<����/�����> <����>}
	set ccs(help,pod,delhost) {������� ��������� \002����\002 �����. �������� ������������� �����. * - ������� ��� �����}
	
	set ccs(args,pod,chattr) {<����> <+����/-����> [global]}
	set ccs(help,pod,chattr) {�������� ����� \002����\002�, ���� ������ �������� \002global\002, �� �������� ����������� �����}
	
	set ccs(args,pod,userlist) {[-f -|�����/�����] [-h ����]}
	set ccs(help,pod,userlist) {���������� ������ ������� �� ����� ����������. ������ ������� userlist � TCL}
	
	set ccs(args,pod,resetpass) {<����>}
	set ccs(help,pod,resetpass) {���������� ������ ����� (���� ������ ���������� ������ ������ �� ������� /msg %botnick pass <����� ������>}
	
	set ccs(args,en,chhandle) {<old����> <new����>}
	set ccs(help,en,chhandle) {��������� ����� ����� � \002old����\002 �� \002new����\002.}
	
	set ccs(args,pod,setinfo) {<����/����> <�����>}
	set ccs(help,pod,setinfo) {���������� ����������� �����, ������� ����� ����� �� ������� %pref_whois � ��� ����� ����� �� �����, � ������ +greet ������}
	
	set ccs(args,pod,delinfo) {<����/����>}
	set ccs(help,pod,delinfo) {���������� ����������� ����� \002����/����\002}
	
	set ccs(text,users,pod,#101) "������������ \002%s\002, ������ ��� ����������� (��� �����)."
	set ccs(text,users,pod,#102) "���� \002%s\002 ��� ������� ���������� � ������ \002%s\002."
	set ccs(text,users,pod,#103) "� ������� ������� ����� ��������. ���� ����� \002%s\002 � ������."
	set ccs(text,users,pod,#104) "���� ���� ������ - ��������� ������ ��������: \002/msg %s pass ���_������\002."
	set ccs(text,users,pod,#105) "���� ������ ������� - ���� ����������! ��� ������ ��� ��� ������ � IRC ����������������� � ����� ��������� \002/msg %s auth ���_������\002."
	set ccs(text,users,pod,#106) "����� ���������� ������ �� ������ ����������, �� ������ �������� �������\002%shelp\002 �� ����� �� ��������, ��� �� ����."
	set ccs(text,users,pod,#107) "���� \002%s\002 ����� ����� - ����� ���!"
	set ccs(text,users,pod,#108) "����� ���� �������! ������ ��������� %s."
	set ccs(text,users,pod,#109) "�������� � ����� ���� %s."
	set ccs(text,users,pod,#110) "���� \037%s\037 ������ � ����� \002%s\002 ����������� �������."
	set ccs(text,users,pod,#111) "���� \002%s\002 �������� � ����� \002%s\002."
	set ccs(text,users,pod,#112) "������ ������� �������� � ������."
	set ccs(text,users,pod,#113) "����� �� ������ userlist (%s): %s"
	set ccs(text,users,pod,#114) "������� �� ���������� ����� \002%s\002 ���� \002%s\002 - ����� ���� ������!"
	set ccs(text,users,pod,#115) "��������� ����� ��� %s: \002%s\002"
	set ccs(text,users,pod,#116) "������ ���� ����� %s ��������!"
	set ccs(text,users,pod,#117) "���� ������ ������� ������� ������ %s. �������� ��� ������ �������� \002/msg %s pass �����_������\002."
	set ccs(text,users,pod,#118) "���� \002%s\002 ��� ������������."
	set ccs(text,users,pod,#119) "���� %s ��� ������ ����� �� \002%s\002."
	set ccs(text,users,pod,#120) "����������� ���� \002%s\002 ����������"
	set ccs(text,users,pod,#121) "����������� ���� \002%s\002 ���������"
	
}