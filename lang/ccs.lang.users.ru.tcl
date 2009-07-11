
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"users"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang adduser {<nick> [host]}
	set_text -type help -- $_lang adduser {��������� ������������ � �������� ����, ���� �������� \002host\002 �� ������, �� ��� ���� ���� *!?ident@*.host (������� ������ �������������� �� ������), ���� �������� \002host\002 ������, �� ������� ������������ �� ������ �� �����������}
	
	set_text -type args -- $_lang deluser {<nick>}
	set_text -type help -- $_lang deluser {������� \002nick\002 �� ���������. ��������: ����� ������� ������������, �� ������ ���� ���� ��� �������� �� ���� �������, �� ������� �� �������� (�� ���� ���� �� +o �� #chan1, � �� ��� �� +m, �� ������� ������������ �� �������)}
	
	set_text -type args -- $_lang addhost {<nick|handle> <host>}
	set_text -type help -- $_lang addhost {��������� \002host\002 ������������ � ����� \002nick\002 ��� ������� \002handle\002}
	
	set_text -type args -- $_lang delhost {<nick|handle> <host>|<-m hostmask>}
	set_text -type help -- $_lang delhost {������� ��������� \002host\002 ������������}
	set_text -type help2 -- $_lang delhost {
		{������� ��������� \002host\002 ������������.}
		{�������� ������������� �����, ��� �������� ����� -m. ������� \002* ? [ ] \\002 - ����� �������������� ��� �������� �����. ����� ������������ ������ ������� ��� ������� ���������� ���������� ������������ ������ �������� ������ \002\\002}
		{\002-m *\002 - ������� ��� �����}
	}
	
	set_text -type args -- $_lang chattr {<nick> <+flags|-flags> [global]}
	set_text -type help -- $_lang chattr {�������� ����� ������������, ���� ������ �������� \002global\002, �� �������� ���������� �����}
	
	set_text -type args -- $_lang userlist {[-f gflags|lflags] [-h hostmask]}
	set_text -type help -- $_lang userlist {���������� ������ �������������, �� ���������, �� ����� ����������}
	set_text -type help2 -- $_lang userlist {
		{���������� ������ �������������, �� ���������, �� ����� ����������.}
		{�������� ������������� ������� �� �����, ��� �������� ����� -h. ������� \002* ? [ ] \\002 - ����� �������������� ��� �������� �����. ����� ������������ ������ ������� ��� ������� ���������� ���������� ������������ ������ �������� ������ \002\\002}
	}
	
	set_text -type args -- $_lang match {[-h hostmask]}
	set_text -type help -- $_lang match {���������� ������ �������������, �� ���������� �����, ��������������� �� ��������� ���������.}
	set_text -type help2 -- $_lang match {
		{���������� ������ �������������, �� ���������� �����, ��������������� �� ��������� ���������.}
		{������� \002* ? [ ] \\002 - ����� �������������� ��� �������� �����. ����� ������������ ������ ������� ��� ������� ���������� ���������� ������������ ������ �������� ������ \002\\002}
	}
	
	set_text -type args -- $_lang resetpass {<nick>}
	set_text -type help -- $_lang resetpass {���������� ������ ������������ (������������ ������ ���������� ������ ������ �� ������� /msg %botnick pass <�����_������>}
	
	set_text -type args -- $_lang chhandle {<oldnick> <newnick>}
	set_text -type help -- $_lang chhandle {�������� ����� ����� � \002oldnick\002 �� \002newnick\002.}
	
	set_text -type args -- $_lang setinfo {<nick|hand> <text>}
	set_text -type help -- $_lang setinfo {������������� ���������� ������������, ������� ����� ����� �� ������� %pref_whois � ��� ����� ����� �� �����, � ������ +greet ������}
	
	set_text -type args -- $_lang delinfo {<nick|hand>}
	set_text -type help -- $_lang delinfo {������� ���������� ������������ \002nick|hand\002}
	
	set_text $_lang $_name #101 "� ����� �� ���� \002%s\002, ������� �� ���� ��� �������� (��� �����)."
	set_text $_lang $_name #102 "������������ \002%s\002 ��� ������� �������� � ������ \002%s\002."
	set_text $_lang $_name #103 "�� ���� ��������� � �������� ���� \002%s\002."
	set_text $_lang $_name #104 "����� ������������ �����, ��� ���� ���������� ������. ������� ��� ����� ��������: \002/msg %s pass ���_������\002."
	set_text $_lang $_name #105 "��� ������������� ������ ����, ��� ���� ����� ������ ��� ��� ������ � IRC ������������������ � ���� �������� \002/msg %s auth ���_������\002."
	set_text $_lang $_name #106 "����� ��������� ������ �� ������ ��������, ������ ������� \002%shelp\002 �� ����� �� �������, ��� ���� ���."
	set_text $_lang $_name #107 "�� ������� �������� ������������ \002%s\002."
	set_text $_lang $_name #108 "� ��� ��� ���� ������� ������������ %s."
	set_text $_lang $_name #109 "������������ %s ��� ����� �� ��������� ����."
	set_text $_lang $_name #110 "���� \002%s\002 �������� � ������������ \002%s\002."
	set_text $_lang $_name #111 "���� \002%s\002 ������ � ������������ \002%s\002."
	set_text $_lang $_name #112 "������ ���� �� ������ � ������."
	set_text $_lang $_name #113 "����� �� ��� ������ userlist (%s): %s"
	set_text $_lang $_name #114 "������������ ���� �� ��������� ����� \002%s\002 ��� \002%s\002"
	set_text $_lang $_name #115 "����� ����� ��� %s: \002%s\002"
	set_text $_lang $_name #116 "������ ��� ���� %s ������� �������."
	set_text $_lang $_name #117 "��� ������ ��� ������� %s. ���������� ��� ������ �� ������ �������� \002/msg %s pass �����_������\002."
	set_text $_lang $_name #118 "��� \002%s\002 ��� ������������."
	set_text $_lang $_name #119 "��� %s ��� ������ ����� �� \002%s\002."
	set_text $_lang $_name #120 "���������� ��� \002%s\002 �����������"
	set_text $_lang $_name #121 "���������� ��� \002%s\002 �������"
	set_text $_lang $_name #122 "�� ��������� ����� \002%s\002 �� ������� �� ������ ������������"
	
}