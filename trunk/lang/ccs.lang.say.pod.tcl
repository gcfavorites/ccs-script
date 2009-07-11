
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"say"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang broadcast {[@+] <�����>}
	set_text -type help -- $_lang broadcast {������� ��������� \002�����\002 �� ��� ������}
	
	set_text -type args -- $_lang say {[@+] [act] <�����>}
	set_text -type help -- $_lang say {��������� ���������� �� �����. ��� �������� act ����� ��������� ACTION}
	
	set_text -type args -- $_lang msg {<����> [act] <�����>}
	set_text -type help -- $_lang msg {��������� ���������� ������� \002����\002�. ��� �������� act ����� ��������� ACTION}
	
	set_text -type args -- $_lang act {[@+] <����> <�����>}
	set_text -type help -- $_lang act {���������� ���������� �� ����� ����� ACTION}
	
	set_text $_lang $_name #101 "���������! � ���� ����� ������� \002%s\002. ��� ����������: %s."
	
}