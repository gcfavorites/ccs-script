
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"bots"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang bots {}
	set_text -type help -- $_lang bots {������� ������ ������, ������� ������������ � ��������}
	
	set_text -type args -- $_lang botattr {<����/�����> <+�����/-�����>}
	set_text -type help -- $_lang botattr {��������� ����� ������}
	
	set_text -type args -- $_lang chaddr {<����/�����> <�����[:���� ����[/���� �������]]>}
	set_text -type help -- $_lang chaddr {����������� ����� � ���� ����}
	
	set_text -type args -- $_lang addbot {<�����> <�����[:���� ����[/���� �������]]> [����]}
	set_text -type help -- $_lang addbot {����������� ���� � ��������. ���� ����� ����������� - ����� �������� ���� ������������ 3333. ���� ���� ������� ��������, �� �� ����� ��������� ����� ������}
	
	set_text -type args -- $_lang delbot {<����/�����>}
	set_text -type help -- $_lang delbot {���������� ���� �� ���������}
	
	set_text -type args -- $_lang chaddr {<����/�����> <�����[:���� ����[/���� �������]]>}
	set_text -type help -- $_lang chaddr {�������� ����� � ���� ����}
	
	set_text -type args -- $_lang chbotpass {<����/�����> [��������]}
	set_text -type help -- $_lang chbotpass {��������/������� �������� ����}
	
	set_text $_lang $_name #101 "���������� ������ � BotNet'�: \002%s\002. ������ �������:"
	set_text $_lang $_name #102 "���������� ������ � BotNet'�: \002%s\002."
	set_text $_lang $_name #103 "������� BotNet: %s"
	set_text $_lang $_name #104 "��� %s ��� �������� �� ��������� ����."
	set_text $_lang $_name #105 "��� %s ��� ���� � ���������. ����� ���� �������!"
	set_text $_lang $_name #106 "��� \002%s\002 ��� ��������� � ��������� \002%s\002 � ������ \002%s\002."
	set_text $_lang $_name #107 "��������� �������� ���� \002%s\002."
	set_text $_lang $_name #108 "���� ���� %s �������� ����� (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set_text $_lang $_name #109 "��������� ����� ��� %s: \002%s\002"
	
}