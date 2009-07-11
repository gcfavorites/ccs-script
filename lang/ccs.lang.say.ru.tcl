
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"say"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang broadcast {[@+] <�����>}
	set_text -type help -- $_lang broadcast {������� ��������� ��������� �� ��� ������}
	set_text -type help2 -- $_lang broadcast {
		{������� ��������� ��������� �� ��� ������, �� ������� �� ����� ����������� �����.}
		{��� �������� ���� \002@+\002 ����� ������ ��������� ������ ����/������. �������������� �� ����� ������.}
	}
	
	set_text -type args -- $_lang say {[@+] [act] <�����>}
	set_text -type help -- $_lang say {�������� ��������� �� �����}
	set_text -type help2 -- $_lang say {
		{�������� ��������� �� �����. ��� �������� \002act\002 ����� ���������� ACTION}
		{��� �������� ���� \002@+\002 ����� ������ ��������� ������ ����/������. �������������� �� ����� ������.}
	}
	
	set_text -type args -- $_lang msg {<���> [act] <�����>}
	set_text -type help -- $_lang msg {�������� ��������� � ������}
	set_text -type help2 -- $_lang msg {{�������� ��������� � ������. ��� �������� \002act\002 ����� ���������� ACTION}	}
	
	set_text -type args -- $_lang act {[@+] <���> <�����>}
	set_text -type help -- $_lang act {�������� ��������� �� ����� ����� ACTION}
	set_text -type help2 -- $_lang act {
		{�������� ��������� �� ����� ����� ACTION}
		{��� �������� ���� \002@+\002 ����� ������ ��������� ������ ����/������. �������������� �� ����� ������.}
	}
	
	set_text $_lang $_name #101 "��������! ���������� ��������� �� \002%s\002: %s."
	
}