
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"users"
set modlang		"ru"
addfileinfo lang "$modname,$modlang" \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.2" \
				"05-Jan-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,adduser) {<nick> [host]}
	set ccs(help,ru,adduser) {��������� ������������ � �������� ����, ���� �������� \002host\002 �� ������, �� ��� ���� ���� *!?ident@*.host (������� ������ �������������� �� ������), ���� �������� \002host\002 ������, �� ������� ������������ �� ������ �� �����������}
	
	set ccs(args,ru,deluser) {<nick>}
	set ccs(help,ru,deluser) {������� \002nick\002 �� ���������. ��������: ����� ������� ������������, �� ������ ���� ���� ��� �������� �� ���� �������, �� ������� �� �������� (�� ���� ���� �� +o �� #chan1, � �� ��� �� +m, �� ������� ������������ �� �������)}
	
	set ccs(args,ru,addhost) {<nick|handle> <host>}
	set ccs(help,ru,addhost) {��������� \002host\002 ������������ � ����� \002nick\002 ��� ������� \002handle\002}
	
	set ccs(args,ru,delhost) {<nick|handle> <host>|<-m hostmask>}
	set ccs(help,ru,delhost) {������� ��������� \002host\002 ������������}
	set ccs(help2,ru,delhost) {
		{������� ��������� \002host\002 ������������.}
		{�������� ������������� �����, ��� �������� ����� -m. ������� \002* ? [ ] \\002 - ����� �������������� ��� �������� �����. ����� ������������ ������ ������� ��� ������� ���������� ���������� ������������ ������ �������� ������ \002\\002}
		{\002-m *\002 - ������� ��� �����}
	}
	
	set ccs(args,ru,chattr) {<nick> <+flags|-flags> [global]}
	set ccs(help,ru,chattr) {�������� ����� ������������, ���� ������ �������� \002global\002, �� �������� ���������� �����}
	
	set ccs(args,ru,userlist) {[-f gflags|lflags] [-h hostmask]}
	set ccs(help,ru,userlist) {���������� ������ ������������� �� ����� ����������. ������ ������� userlist � TCL}
	
	set ccs(args,ru,resetpass) {<nick>}
	set ccs(help,ru,resetpass) {���������� ������ ������������ (������������ ������ ���������� ������ ������ �� ������� /msg %botnick pass <�����_������>}
	
	set ccs(args,en,chhandle) {<oldnick> <newnick>}
	set ccs(help,en,chhandle) {�������� ����� ����� � \002oldnick\002 �� \002newnick\002.}
	
	set ccs(args,ru,setinfo) {<nick|hand> <text>}
	set ccs(help,ru,setinfo) {������������� ���������� ������������, ������� ����� ����� �� ������� %pref_whois � ��� ����� ����� �� �����, � ������ +greet ������}
	
	set ccs(args,ru,delinfo) {<nick|hand>}
	set ccs(help,ru,delinfo) {������� ���������� ������������ \002nick|hand\002}
	
	set ccs(text,users,ru,#101) "� ����� �� ���� \002%s\002, ������� �� ���� ��� �������� (��� �����)."
	set ccs(text,users,ru,#102) "������������ \002%s\002 ��� ������� �������� � ������ \002%s\002."
	set ccs(text,users,ru,#103) "�� ���� ��������� � �������� ���� \002%s\002."
	set ccs(text,users,ru,#104) "����� ������������ �����, ��� ���� ���������� ������. ������� ��� ����� ��������: \002/msg %s pass ���_������\002."
	set ccs(text,users,ru,#105) "��� ������������� ������ ����, ��� ���� ����� ������ ��� ��� ������ � IRC ������������������ � ���� �������� \002/msg %s auth ���_������\002."
	set ccs(text,users,ru,#106) "����� ��������� ������ �� ������ ��������, ������ ������� \002%shelp\002 �� ����� �� �������, ��� ���� ���."
	set ccs(text,users,ru,#107) "�� ������� �������� ������������ \002%s\002."
	set ccs(text,users,ru,#108) "� ��� ��� ���� ������� ������������ %s."
	set ccs(text,users,ru,#109) "������������ %s ��� ����� �� ��������� ����."
	set ccs(text,users,ru,#110) "���� \002%s\002 �������� � ������������ \002%s\002."
	set ccs(text,users,ru,#111) "���� \002%s\002 ������ � ������������ \002%s\002."
	set ccs(text,users,ru,#112) "������ ���� �� ������ � ������."
	set ccs(text,users,ru,#113) "����� �� ��� ������ userlist (%s): %s"
	set ccs(text,users,ru,#114) "������������ ���� �� ��������� ����� \002%s\002 ��� \002%s\002"
	set ccs(text,users,ru,#115) "����� ����� ��� %s: \002%s\002"
	set ccs(text,users,ru,#116) "������ ��� ���� %s ������� �������."
	set ccs(text,users,ru,#117) "��� ������ ��� ������� %s. ���������� ��� ������ �� ������ �������� \002/msg %s pass �����_������\002."
	set ccs(text,users,ru,#118) "��� \002%s\002 ��� ������������."
	set ccs(text,users,ru,#119) "��� %s ��� ������ ����� �� \002%s\002."
	set ccs(text,users,ru,#120) "���������� ��� \002%s\002 �����������"
	set ccs(text,users,ru,#121) "���������� ��� \002%s\002 �������"
	
}