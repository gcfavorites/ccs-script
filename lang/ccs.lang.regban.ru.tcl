
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"regban"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang regbanlist {}
	set_text -type help -- $_lang regbanlist {�������� ������ ���������� �����}
	
	set_text -type args -- $_lang regban {<[-host {rege}] [-server {rege}] [-status {rege}] [-hops number] [-name {rege}]> [options]}
	set_text -type help -- $_lang regban {����������� ����������� ����}
	set_text -type help2 -- $_lang regban {
		{����������� ����������� ����. ��������� �����:}
		{  \002-ban [number]\002 - �������� ���. �������� �������� ����� ����, ���� ����� ���� �� �������, �� ������� �������� �� ��������� ��� ������. (������ ���������� ����� ���������� �������� \002%pref_info mask\002)}
		{  \002-kick [{reason}]\002 - �������� ���. �������� ������� �� �����������.}
		{  \002-notify {handle1,handle2 ...} [{text}]\002 - �������� �����. ������������ ����� ������������� �������/����� � ��������� ����������. ������������ ������ ������ �� ����� �� ������, ��� ����� ���.}
		{����������: ���� ���������� ���������� ������� � ������������ ��������� ������ \002-host\002 �� ������� � ���������� ������� �� ����� �����������.}
	}
	
	set_text -type args -- $_lang regunban {<id>}
	set_text -type help -- $_lang regunban {�������� ����������� ����}
	
	set_text -type args -- $_lang regbanaction {}
	set_text -type help -- $_lang regbanaction {������������ �������� ��� ����� ������, � ����������� ���� ��������}
	
	set_text -type args -- $_lang regbantest {}
	set_text -type help -- $_lang regbantest {������������ �������� ��� ����� ������, � ����������� �������� "notify" ��������������}
	
	set_text $_lang $_name #101 "���������� ��� \002ID: %s\002 ��������: %s."
	set_text $_lang $_name #102 "���������� ��� \002ID: %s\002 ������: %s."
	set_text $_lang $_name #103 "���������� ��� \002ID: %s\002 �� ����������."
	set_text $_lang $_name #104 "--- ������ ���������� ����� \002%s\002 ---"
	set_text $_lang $_name #105 "*** ���� ***"
	set_text $_lang $_name #106 "--- ����� ������ ���������� ����� ---"
	set_text $_lang $_name #107 "���������� ��� \002ID: %s\002 %s: %s."
	set_text $_lang $_name #108 "���������� ��������� \"\002%s\002\" �� ��������� ����������."
	
}