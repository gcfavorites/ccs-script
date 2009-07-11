
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"system"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang rehash {}
	set_text -type help -- $_lang rehash {������� ����}
	
	set_text -type args -- $_lang restart {}
	set_text -type help -- $_lang restart {��������� ����}
	
	set_text -type args -- $_lang jump {[������ [���� [������]]]}
	set_text -type help -- $_lang jump {���������� ���� �������������� � ������� �������. ���� ��������� �� �������, �� ����� ���������� �� ������}
	
	set_text -type args -- $_lang servers {}
	set_text -type help -- $_lang servers {������� ������ ��������, �� ������� ��� ����� ������������ � ������ ������������������� ������ �� ���}
	
	set_text -type args -- $_lang addserver {[������ [���� [������]]]}
	set_text -type help -- $_lang addserver {��������� � ������ �������� ����� ������. ��� ������ ����, ������ ���������� �� ����������� � ���������������� �����}
	
	set_text -type args -- $_lang delserver {[������ [���� [������]]]}
	set_text -type help -- $_lang delserver {������� ������ �� ������ ��������. ��� ������ ���� ������ ���������� �� ����������� � ���������������� �����}
	
	set_text -type args -- $_lang save {}
	set_text -type help -- $_lang save {���������� ������ �������������/�������}
	
	set_text -type args -- $_lang reload {}
	set_text -type help -- $_lang reload {�������� ������ �������������/�������}
	
	set_text -type args -- $_lang backup {}
	set_text -type help -- $_lang backup {������ ��������� ����� ������ ������������� � �������}
	
	set_text -type args -- $_lang die {[�����]}
	set_text -type help -- $_lang die {���������� ������ ����. � ��������� ������ ����� ��������� \002�����\002}
	
	set_text $_lang $_name #101 "Saving user file..."
	set_text $_lang $_name #102 "Rehashing..."
	set_text $_lang $_name #103 "Restart..."
	set_text $_lang $_name #104 "--- ������ �������� (������ ������� �������) ---"
	set_text $_lang $_name #105 "--- ����� ������ �������� ---"
	set_text $_lang $_name #106 "������ \002%s\002 ��� ���� � ������ ��������."
	set_text $_lang $_name #107 "������ \002%s\002 �������� � ������."
	set_text $_lang $_name #108 "������ \002%s\002 ������ �� ������ ��������."
	set_text $_lang $_name #109 "������ \002%s\002 �� ������ � ������."
	set_text $_lang $_name #110 "Saving user and chan file..."
	set_text $_lang $_name #211 "Reload user and chan file..."
	set_text $_lang $_name #212 "Backup user and chan file..."
	
	
}