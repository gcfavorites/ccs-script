
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chan"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang channels {}
	set_text -type help -- $_lang channels {������� ������ ��������}
	set_text -type help2 -- $_lang channels {
		{������� ������ ��������, �� ������� ����� ��� (��� ������ �� ������ � ���������� ������� �� ��)}
	}
	
	set_text -type args -- $_lang chanadd {<�����>}
	set_text -type help -- $_lang chanadd {�������� \002�����\002}
	
	set_text -type args -- $_lang chandel {<�����>}
	set_text -type help -- $_lang chandel {������� \002�����\002 ������}
	
	set_text -type args -- $_lang rejoin {}
	set_text -type help -- $_lang rejoin {����� ������� ���� ��������� �� �����}
	
	set_text -type args -- $_lang chanset {<[+/-]��������> [���������]}
	set_text -type help -- $_lang chanset {�������� \002��������\002 ������ (��������, �+bitch� ��� �flood-chan 5:10�). ������ ������� �chanset� � �������}
	
	set_text -type args -- $_lang chaninfo {[��������]}
	set_text -type help -- $_lang chaninfo {������������� \002��������\002 ������. ���� �������� ��������, �� ����� �������� ��� ���������}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #101 "������: %s."
	set_text $_lang $_name #102 "����� \002%s\002 ����� ������."
	set_text $_lang $_name #103 "����� \002%s\002 ���������."
	set_text $_lang $_name #104 "����� \002%s\002 ���������� �� ����, ����� �����."
	set_text $_lang $_name #105 "����� \002%s\002 ������� ���������� � ������� ���� ������� � �������� ������� (�� ������ ��������� +inactive)."
	set_text $_lang $_name #106 "��������� \002%s\002 ����������!"
	set_text $_lang $_name #107 "�������� ����� ������ \002%s\002"
	set_text $_lang $_name #108 "��������� ����� ������: \002%s\002"
	set_text $_lang $_name #109 "�������� ��������� \002%s\002 ������ �� \"\002%s\002\""
	set_text $_lang $_name #110 "��������� ��������� \002%s\002 ������: \002%s\002"
	
}