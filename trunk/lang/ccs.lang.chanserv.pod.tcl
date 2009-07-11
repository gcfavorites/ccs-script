
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chanserv"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang csop {[����]}
	set_text -type help -- $_lang csop {����� \002����\002�, ���� ���� ��������, �� ����� ��� ����� �������}
	
	set_text -type args -- $_lang csdeop {[����]}
	set_text -type help -- $_lang csdeop {�������� \002����\002�, ���� ���� ��������, �� �������� ��� ����� �������}
	
	set_text -type args -- $_lang cshop {[����]}
	set_text -type help -- $_lang cshop {����� ���� \002����\002�, ���� ���� ��������, �� ����� ���� ��� ����� �������}
	
	set_text -type args -- $_lang csdehop {[����]}
	set_text -type help -- $_lang csdehop {��������� ���� � \002����\002�, ���� ���� ��������, �� ���������� �������������� ����� �������}
	
	set_text -type args -- $_lang csvoice {[����]}
	set_text -type help -- $_lang csvoice {����� ���� \002����\002�, ���� ���� ��������, �� ����� ���� ��� ����� �������}
	
	set_text -type args -- $_lang csdevoice {[����]}
	set_text -type help -- $_lang csdevoice {��������� ���� � \002����\002�, ���� ���� ��������, �� ��������� ���� � ��� ����� �������}
	
}