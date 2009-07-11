
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"users"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang adduser {<����> [����]}
	set_text -type help -- $_lang adduser {��������� \002����\002� � �������� ����, ���� �������� \002����\002 ��������, �� ��� ���� ���� *!?ident@*.host (������� ������ ������������� �� ������), ���� �������� \002����\002 ������, �� �������� ����� �� ������ �������������}
	
	set_text -type args -- $_lang deluser {<����>}
	set_text -type help -- $_lang deluser {������� \002����\002� �� ���������. �����������: ���� ������� �����, �� ������ ���� ���� ��� �������� �� ���� �������, �� ������� �� �������� (������ ���� �� +o �� #chan1, � �� ��� �� +m, �� ������� ����� ��������)}
	
	set_text -type args -- $_lang addhost {<����|�����> <����>}
	set_text -type help -- $_lang addhost {�������� \002����\002 ����� � ����� \002����\002 ��� ������� \002�����\002}
	
	set_text -type args -- $_lang delhost {<����|�����> <����>|<-m ���������>}
	set_text -type help -- $_lang delhost {������� ��������� \002����\002 �����. �������� ������������� �����. * - ������� ��� �����}
	
	set_text -type args -- $_lang chattr {<����> <+����|-����> [global]}
	set_text -type help -- $_lang chattr {�������� ����� \002����\002�, ���� ������ �������� \002global\002, �� �������� ����������� �����}
	
	set_text -type args -- $_lang userlist {[-f ������|������] [-h ����]}
	set_text -type help -- $_lang userlist {���������� ������ ������� �� ����� ����������. ������ ������� userlist � TCL}
	
	set_text -type args -- $_lang resetpass {<����>}
	set_text -type help -- $_lang resetpass {���������� ������ ����� (���� ������ ���������� ������ ������ �� ������� /msg %botnick pass <����� ������>}
	
	set_text -type args -- $_lang chhandle {<old����> <new����>}
	set_text -type help -- $_lang chhandle {��������� ����� ����� � \002old����\002 �� \002new����\002.}
	
	set_text -type args -- $_lang setinfo {<����|����> <�����>}
	set_text -type help -- $_lang setinfo {���������� ����������� �����, ������� ����� ����� �� ������� %pref_whois � ��� ����� ����� �� �����, � ������ +greet ������}
	
	set_text -type args -- $_lang delinfo {<����|����>}
	set_text -type help -- $_lang delinfo {���������� ����������� ����� \002����|����\002}
	
	set_text $_lang $_name #101 "������������ \002%s\002, ������ ��� ����������� (��� �����)."
	set_text $_lang $_name #102 "���� \002%s\002 ��� ������� ���������� � ������ \002%s\002."
	set_text $_lang $_name #103 "� ������� ������� ����� ��������. ���� ����� \002%s\002 � ������."
	set_text $_lang $_name #104 "���� ���� ������ - ��������� ������ ��������: \002/msg %s pass ���_������\002."
	set_text $_lang $_name #105 "���� ������ ������� - ���� ����������! ��� ������ ��� ��� ������ � IRC ����������������� � ����� ��������� \002/msg %s auth ���_������\002."
	set_text $_lang $_name #106 "����� ���������� ������ �� ������ ����������, �� ������ �������� �������\002%shelp\002 �� ����� �� ��������, ��� �� ����."
	set_text $_lang $_name #107 "���� \002%s\002 ����� ����� - ����� ���!"
	set_text $_lang $_name #108 "����� ���� �������! ������ ��������� %s."
	set_text $_lang $_name #109 "�������� � ����� ���� %s."
	set_text $_lang $_name #110 "���� \002%s\002 ������ � ����� \002%s\002 ����������� �������."
	set_text $_lang $_name #111 "���� \002%s\002 �������� � ����� \002%s\002."
	set_text $_lang $_name #112 "������ ������� �������� � ������."
	set_text $_lang $_name #113 "����� �� ������ userlist (%s): %s"
	set_text $_lang $_name #114 "������� �� ���������� ����� \002%s\002 ���� \002%s\002 - ����� ���� ������!"
	set_text $_lang $_name #115 "��������� ����� ��� %s: \002%s\002"
	set_text $_lang $_name #116 "������ ���� ����� %s ��������!"
	set_text $_lang $_name #117 "���� ������ ������� ������� ������ %s. �������� ��� ������ �������� \002/msg %s pass �����_������\002."
	set_text $_lang $_name #118 "���� \002%s\002 ��� ������������."
	set_text $_lang $_name #119 "���� %s ��� ������ ����� �� \002%s\002."
	set_text $_lang $_name #120 "����������� ���� \002%s\002 ����������"
	set_text $_lang $_name #121 "����������� ���� \002%s\002 ���������"
	
}