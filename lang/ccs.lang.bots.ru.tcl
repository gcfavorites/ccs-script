
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"bots"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang bots {[tree]}
	set_text -type help -- $_lang bots {������� ������ �����, �������������� � ��������}
	
	set_text -type args -- $_lang botattr {<���/�����> <+flags/-flags>}
	set_text -type help -- $_lang botattr {�������� ����� �����}
	
	set_text -type args -- $_lang chaddr {<���/�����> <������[:���� ����[/���� ������]]>}
	set_text -type help -- $_lang chaddr {�������� ����� � ���� ����}
	
	set_text -type args -- $_lang addbot {<�����> <������[:���� ����[/���� ������]]> [����]}
	set_text -type help -- $_lang addbot {��������� ���� � ��������. ���� ����� �� ��������� ����� �������� ���� �� ��������� 3333. ���� ���� ������ �� ������ �� �� ����� ��������� ����� �����}
	
	set_text -type args -- $_lang delbot {<���/�����>}
	set_text -type help -- $_lang delbot {������� ���� �� ���������}
	
	set_text -type args -- $_lang chaddr {<���/�����> <������[:���� ����[/���� ������]]>}
	set_text -type help -- $_lang chaddr {�������� ������ � ����� ����}
	
	set_text -type args -- $_lang chbotpass {<���/�����> [������]}
	set_text -type help -- $_lang chbotpass {��������/������� ������ ����}
	
	set_text -type args -- $_lang listauth {<���/�����>}
	set_text -type help -- $_lang listauth {����������� ������ ������������� ������������}
	
	set_text -type args -- $_lang addauth {<���/�����> <������/��������> <�����>}
	set_text -type help -- $_lang addauth {����������� ������������ ����� ������� � ��������� �����}
	
	set_text -type args -- $_lang delauth {<���/�����> <������/��������>}
	set_text -type help -- $_lang delauth {������� ������������� ������������ ����� ������� � ��������� �����}
	
	set_text $_lang $_name #101 "���������� ����� � BotNet'e: \002%s\002. ������ �������:"
	set_text $_lang $_name #102 "���������� ����� � BotNet'e: \002%s\002."
	set_text $_lang $_name #103 "������� BotNet: %s"
	set_text $_lang $_name #104 "��� %s ��� ����� �� ��������� ����."
	set_text $_lang $_name #105 "��� %s ��� ���� � ���������."
	set_text $_lang $_name #106 "��� \002%s\002 ��� ������� �������� � ������� \002%s\002 � ������ \002%s\002."
	set_text $_lang $_name #107 "�� ������� �������� ���� \002%s\002."
	set_text $_lang $_name #108 "��� ���� %s ������� ����� (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set_text $_lang $_name #109 "����� ����� ��� %s: \002%s\002"
	set_text $_lang $_name #110 "����� ������ ��� ���� %s ����������."
	set_text $_lang $_name #111 "������ ��� ���� %s �������."
	set_text $_lang $_name #112 "������ ����������� ����������� %s: %s"
	set_text $_lang $_name #113 "������ ����������� ����������� %s ����."
	set_text $_lang $_name #114 "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] ��� ����������."
	set_text $_lang $_name #115 "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] �������� �� \[bot: %s, handle: \002%s\002\]."
	set_text $_lang $_name #116 "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] ���������."
	set_text $_lang $_name #117 "C����������� ����������� \[bot: %s, handle: \002%s\002\] ��� ��������� ��� %s."
	set_text $_lang $_name #118 "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] �������."
	set_text $_lang $_name #119 "��� %s ������������ ����������� \[bot: %s\] �� �������."
	
}