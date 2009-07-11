
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"invite"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang invite {<nick/hostmask> [�����] [�������] [stick]}
	set_text -type help -- $_lang invite {���������� ������}
	set_text -type help2 -- $_lang invite {
		{������ ������ nick ��� host (nick!ident@host) �� ������.}
		{����� ����������� � �������, ���� ����� �� �������, �� ������ ����������� ����� �� ��������� �invite-time� ������.}
		{���� � ��������� ������� \002stick\002, �� ������ ����� ����� ������������ ��� ��� ������.}
	}
	
	set_text -type args -- $_lang uninvite {<hostmask>}
	set_text -type help -- $_lang uninvite {������� ������ � ������}
	
	set_text -type args -- $_lang ginvite {<nick/hostmask> [�����] [�������] [stick]}
	set_text -type help -- $_lang ginvite {���������� ���������� ������}
	set_text -type help2 -- $_lang ginvite {
		{������ ������ nick ��� host (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���).}
		{����� ����������� � �������, ���� ����� �� �������, �� ����������� ����� - 1 ����.}
		{���� � ��������� ������� \002stick\002, �� ������ ����� ����� ������������ ��� ��� ������}
	}
	
	set_text -type args -- $_lang guninvite {<hostmask>}
	set_text -type help -- $_lang guninvite {������� ���������� ������ �� ���� �������}
	
	set_text -type args -- $_lang invitelist {[global]}
	set_text -type help -- $_lang invitelist {������� ������ �������� ������, ���� ������ �������� �global�, �� ������� ���������� ������ ��������}
	
	set_text -type args -- $_lang resetinvites {}
	set_text -type help -- $_lang resetinvites {������� � ������ ��� �������, ������� ��� � ������ ����}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "�������� \002����������\002%s ������: \037%s\037."
	set_text $_lang $_name #103 "%s (�� %s)."
	set_text $_lang $_name #104 "��������%s ������: \037%s\037 �� %s."
	set_text $_lang $_name #105 "����%s ������: \002%s\002."
	set_text $_lang $_name #106 "������� \002%s\002 �� \002%s\002 �� ����������."
	set_text $_lang $_name #107 "Requested"
	set_text $_lang $_name #108 "�������� \002����������\002 ����������%s ������: \037%s\037."
	set_text $_lang $_name #109 "�������� ����������%s ������: \037%s\037 �� %s."
	set_text $_lang $_name #110 "���� ����������%s ������: \002%s\002"
	set_text $_lang $_name #111 "����������� ������� \002%s\002 �� ����������."
	set_text $_lang $_name #112 "--- ���������� ������ ��������%s ---"
	set_text $_lang $_name #113 "--- ������ �������� \002%s\002%s ---"
	set_text $_lang $_name #114 "*** ���� ***"
	set_text $_lang $_name #115 "������ \002����������\002."
	set_text $_lang $_name #116 "�������� ����� %s."
	set_text $_lang $_name #117 "� %s %s� �������: �%s� � %s � ������ �������� %s ����� � ���������: \002%s\002.%s"
	set_text $_lang $_name #118 "--- ����� ������ �������� ---"
	set_text $_lang $_name #119 "�������, ������� ��� � ������ ����, ���� �������."
	set_text $_lang $_name #120 "\037����\037"
	set_text $_lang $_name #121 "(����� \002%s\002)"
	set_text $_lang $_name #122 "�������� �� ������: \002%s\002 %s �����."
	set_text $_lang $_name #123 "--- ��������� ������� ---"
	set_text $_lang $_name #124 "� \002%s\002 � �������� �� ������: \002%s\002 %s �����."
	
}