
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"ignore"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang addignore {<nick/host> [�����] [�������]}
	set_text -type help -- $_lang addignore {��������� ����� �� \002nick\002 ��� \002host\002 (nick!ident@host). ����� ����������� � �������, ���� ����� �� �������, �� ����������� ����� - 1 ����}
	
	set_text -type args -- $_lang delignore {<host>}
	set_text -type help -- $_lang delignore {������� ����� \002host\002}
	
	set_text -type args -- $_lang ignorelist {}
	set_text -type help -- $_lang ignorelist {������� ������ �������}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "�������� �����: \037%s\037 �� %s."
	set_text $_lang $_name #103 "�������� \002����������\002 �����: \037%s\037."
	set_text $_lang $_name #104 "���� �����: \002%s\002."
	set_text $_lang $_name #105 "������ \002%s\002 �� ����������."
	set_text $_lang $_name #106 "--- ���������� ��������� ---"
	set_text $_lang $_name #107 "����� \002����������\002."
	set_text $_lang $_name #108 "�������� ����� %s."
	set_text $_lang $_name #109 "� %s � �������: �%s� � %s � ����� �������� %s ����� � ���������: \002%s\002."
	set_text $_lang $_name #110 "*** ���� ***"
	set_text $_lang $_name #111 "--- ����� ���������� ---"
	
	
}