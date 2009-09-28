
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ban"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.1" \
				"24-Sep-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang ban {<nick/host> [�����] [�������] [stick]}
	set_text -type help -- $_lang ban {���������� ���}
	set_text -type help2 -- $_lang ban {
		{����� \002nick\002 ��� \002host\002 (nick!ident@host) � ������.}
		{����� ����������� � �������, ���� ����� �� �������, �� ����� ������ �� ��������� �ban-time� ������.}
		{���� � ��������� ������� \002stick\002, �� ��� ����� ����� ������������ ��� ��� ������.}
	}
	
	set_text -type args -- $_lang unban {<hostmask>}
	set_text -type help -- $_lang unban {������� ��� \002host\002 � ������.}
	
	set_text -type args -- $_lang gban {<nick/host> [�����] [�������] [stick]}
	set_text -type help -- $_lang gban {���������� ���������� ���}
	set_text -type help2 -- $_lang gban {
		{����� \002nick\002 ��� \002host\002 (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���).}
		{����� ����������� � �������, ���� ����� �� �������, �� ����� - 1 ����.}
		{���� � ��������� ������� \002stick\002, �� ��� ����� ����� ������������ ��� ��� ������.}
	}
	
	set_text -type args -- $_lang gunban {<hostmask>}
	set_text -type help -- $_lang gunban {������� ���������� ��� \002host\002 �� ���� �������}
	
	set_text -type args -- $_lang banlist {[mask] [global]}
	set_text -type help -- $_lang banlist {������� ������� ������, ���� ������ �������� \002global\002, �� ������� ���������� �������}
	
	set_text -type args -- $_lang resetbans {}
	set_text -type help -- $_lang resetbans {������� � ������ ��� ����, ������� ��� � �������� ����}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "�������� \002����������\002%s ���: \037%s\037."
	set_text $_lang $_name #103 "��������%s ���: \037%s\037 �� \002%s\002."
	set_text $_lang $_name #104 "%s (�� %s)."
	set_text $_lang $_name #105 "\037����\037"
	set_text $_lang $_name #106 "����%s ���: \002%s\002."
	set_text $_lang $_name #107 "���� \002%s\002 �� \002%s\002 �� ����������."
	set_text $_lang $_name #108 "Requested"
	set_text $_lang $_name #109 "�������� \002����������\002 ����������%s ���: \037%s\037."
	set_text $_lang $_name #110 "�������� ����������%s ���: \037%s\037 �� %s."
	set_text $_lang $_name #111 "���� ����������%s ���: \002%s\002"
	set_text $_lang $_name #112 "����������� ���� \002%s\002 �� ����������."
	set_text $_lang $_name #113 "--- ���������� �������%s ---"
	set_text $_lang $_name #114 "--- ������� \002%s\002%s ---"
	set_text $_lang $_name #115 "*** ���� ***"
	set_text $_lang $_name #116 "(����� \002%s\002)"
	set_text $_lang $_name #117 "��� \002����������\002."
	set_text $_lang $_name #118 "�������� ����� %s."
	set_text $_lang $_name #119 "%s. � \002%s\002%s � �������: �%s� � %s � ��� �������� %s ����� (%s) � ���������: \002%s\002.%s"
	set_text $_lang $_name #120 "--- ����� �������� ---"
	set_text $_lang $_name #121 "����, ������� ��� � �������� ����, ���� �������."
	set_text $_lang $_name #122 "������������ ���� ����� ��� \002%s\002, ���������: \002%s\002."
	set_text $_lang $_name #123 "�������� �� ������: \002%s\002 %s ����� (%s)."
	set_text $_lang $_name #124 "--- ��������� ���� ---"
	set_text $_lang $_name #125 "� \002%s\002 � �������� �� ������: \002%s\002 %s ����� (%s)."
	
}