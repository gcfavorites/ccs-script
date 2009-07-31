
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chan"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.1" \
				"25-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang channels {}
	set_text -type help -- $_lang channels {������� ������ �������}
	set_text -type help2 -- $_lang channels {
		{������� ������ �������, �� ������� ����� ��� (��� ������ �� ������ � ���������� ������������� �� ���)}
	}
	
	set_text -type args -- $_lang chanadd {<�����>}
	set_text -type help -- $_lang chanadd {��������� \002�����\002}
	
	set_text -type args -- $_lang chandel {<�����>}
	set_text -type help -- $_lang chandel {������� \002�����\002}
	
	set_text -type args -- $_lang rejoin {}
	set_text -type help -- $_lang rejoin {��� ������� ���� ��������� �� �����}
	
	set_text -type args -- $_lang chanset {<[+/-]��������> [��������]}
	set_text -type help -- $_lang chanset {��������� ���������� ������}
	set_text -type help2 -- $_lang chanset {
		{��������� ���������� ������ (��������, �+bitch� ��� �flood-chan 5:10�). ������ ������� �chanset� � �������.}
	}
	
	set_text -type args -- $_lang chaninfo {[��������]}
	set_text -type help -- $_lang chaninfo {�������� ���������� ������}
	set_text -type help2 -- $_lang chaninfo {
		{�������� ���������� ������. ���� �������� �� ������, �� ����� �������� ��� ���������. �������� �������� �����, ��������� �������������� ������� * � ?.}
	}
	
	set_text -type args -- $_lang chansave {<���_�����> [���_�������]}
	set_text -type help -- $_lang chansave {���������� �������� �������� ������ � ����}
	set_text -type help2 -- $_lang chansave {
		{���������� �������� �������� ������ � ����. ��� �������� ����� ����� ������� ����� ��������� ������ �� ��������� � �����, ������� �������� � �������.}
	}
	
	set_text -type args -- $_lang chanload {<���_�����> [���_�������]}
	set_text -type help -- $_lang chanload {�������������� �������� �� ����� ��� �������� ������}
	set_text -type help2 -- $_lang chanload {
		{�������������� �������� �� ����� ��� �������� ������. ��� �������� ����� ����� ������� ����� ������������� ������ �� ��������� � �����, ������� �������� � �������.}
	}
	
	set_text -type args -- $_lang chancopy {<�����_��������> [���_�������]}
	set_text -type help -- $_lang chancopy {����������� �������� �������� ������ �� ���������}
	set_text -type help2 -- $_lang chancopy {
		{����������� �������� �������� ������ �� ���������. ��� �������� ����� ����� ������� ����� ����������� ������ �� ��������� � �����, ������� �������� � �������.}
	}
	
	set_text -type args -- $_lang templateadd {<���_�������> <��������1 ��������2 ...>}
	set_text -type help -- $_lang templateadd {���������� � ������ ������ ����������}
	
	set_text -type args -- $_lang templatedel {<���_�������> <��������1 ��������2 ...>}
	set_text -type help -- $_lang templatedel {�������� �� ������� ������ ����������}
	
	set_text -type args -- $_lang templatelist {<���_�������>}
	set_text -type help -- $_lang templatelist {�������� ������ ���������� � �������}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #101 "������: %s."
	set_text $_lang $_name #102 "����� \002%s\002 ������."
	set_text $_lang $_name #103 "����� \002%s\002 ��������."
	set_text $_lang $_name #104 "����� \002%s\002 �� �������� �� ����."
	set_text $_lang $_name #105 "����� \002%s\002 �������� ���������� � �� ����� ���� ����� � ������� ������� (�� ������ ��������� +inactive)."
	set_text $_lang $_name #106 "��������� \002%s\002 �� ����������!"
	set_text $_lang $_name #107 "���� ������ ������� �� \002%s\002"
	set_text $_lang $_name #108 "�������� ����� ������: \002%s\002"
	set_text $_lang $_name #109 "�������� \002%s\002 ������ ������� �� \"\002%s\002\""
	set_text $_lang $_name #110 "�������� ��������� \002%s\002 ������: \"\002%s\002\""
	set_text $_lang $_name #111 "��������� ������ \002%s\002 ��������� � ����� \"\002%s\002\""
	set_text $_lang $_name #112 "��������� ������ \002%s\002 ��������� � ����� \"\002%s\002\" ��������� ������ \"\002%s\002\""
	set_text $_lang $_name #113 "��������� ������ \002%s\002 ������������� �� ����� \"\002%s\002\""
	set_text $_lang $_name #114 "��������� ������ \002%s\002 ������������� �� ����� \"\002%s\002\" ��������� ������ \"\002%s\002\""
	set_text $_lang $_name #115 "��������� ������ \002%s\002 �������� ������������� �� ����� \"\002%s\002\", ������ �� �������������� ����������: \002%s\002"
	set_text $_lang $_name #116 "��������� ������ \002%s\002 �������� ������������� �� ����� \"\002%s\002\" ��������� ������ \"\002%s\002\", ������ �� �������������� ����������: \002%s\002"
	set_text $_lang $_name #117 "��������� ������ \002%s\002 ����������� �� \002%s\002"
	set_text $_lang $_name #118 "��������� ������ \002%s\002 ����������� �� \002%s\002 ��������� ������ \"\002%s\002\""
	set_text $_lang $_name #119 "����� \"\002%s\002\" � ����������� �� ����������."
	set_text $_lang $_name #120 "����� \"\002%s\002\" ������� �� ����������."
	set_text $_lang $_name #121 "���� ����� ���������� ��� ������ � ������ \"\002%s\002\"; %s."
	set_text $_lang $_name #122 "���� ���������� ��� �������� �� ������� \"\002%s\002\"; %s."
	set_text $_lang $_name #123 "� ������ \"\002%s\002\" �������� ����� ���������; %s."
	set_text $_lang $_name #124 "�� ������� \"\002%s\002\" ���� ������� ���������; %s."
	set_text $_lang $_name #125 "�����: \002%s\002"
	set_text $_lang $_name #126 "���������: \002%s\002"
	set_text $_lang $_name #127 "������: \002%s\002"
	set_text $_lang $_name #128 "���������: \002%s\002"
	set_text $_lang $_name #129 "�������������: \002%s\002"
	set_text $_lang $_name #130 "������ ���������� � ������� \"\002%s\002\": \002%s\002."
	set_text $_lang $_name #131 "�������������� ������ ����������: \002%s\002."
	set_text $_lang $_name #132 "�������� �����: %s"
	set_text $_lang $_name #133 "�������� ��������� \002%s\002: %s"
	
}