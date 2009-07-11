
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"lang"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang langlist {[mod]}
	set_text -type help -- $_lang langlist {���������� ������ ������������� ������ ��� �������}
	
	set_text -type args -- $_lang chansetlang {<lang/default>}
	set_text -type help -- $_lang chansetlang {���������� ���� �� ��������� ��� ������. ���� ������� \002default\002 ���� ����� �������.}
	
	set_text -type args -- $_lang chlang {<nick/hand> <lang>}
	set_text -type help -- $_lang chlang {���������� ���� �� ��������� ��� ���������� ����. ���� ������� \002default\002 ���� ����� �������.}
	
	set_text $_lang $_name #101 "��� ��������� ������ ������������� ������ ������� ���� �� �������: \002%s\002."
	set_text $_lang $_name #102 "������: \002%s\002, v%s \[%s\] by %s"
	set_text $_lang $_name #103 " - ����: \002%s\002, v%s \[%s\] by %s"
	set_text $_lang $_name #104 "���� \002%s\002 �� ������ �� ��� ������ ������, ���������� ������� ���� ��: \002%s\002."
	set_text $_lang $_name #105 "���� ��� ������ \002%s\002 �������."
	set_text $_lang $_name #106 "���� ��� ������ \002%s\002 ��������� �� \002%s\002."
	set_text $_lang $_name #107 "���� ��� %s �������."
	set_text $_lang $_name #108 "���� ��� %s ��������� �� \002%s\002."
	set_text $_lang $_name #109 "�������� ����� ��� ������ \002%s\002 �� �����������."
	set_text $_lang $_name #110 "�������� ����� ��� ������ \002%s\002 ����������� �� \002%s\002."
	set_text $_lang $_name #111 "�������� ����� ��� %s �� �����������."
	set_text $_lang $_name #112 "�������� ����� ��� %s ����������� �� \002%s\002."
	
}