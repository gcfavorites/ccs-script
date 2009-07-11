
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chanserv"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang csop {[nick]}
	set_text -type help -- $_lang csop {����� \002nick\002, ���� ��� �� ������, �� ����� ��� ����� ChanServ}
	
	set_text -type args -- $_lang csdeop {[nick]}
	set_text -type help -- $_lang csdeop {������� \002nick\002, ���� ��� �� ������, �� ������� ��� ����� ChanServ}
	
	set_text -type args -- $_lang cshop {[nick]}
	set_text -type help -- $_lang cshop {������ \002nick\002, ���� ��� �� ������, �� ������ ��� ����� ChanServ}
	
	set_text -type args -- $_lang csdehop {[nick]}
	set_text -type help -- $_lang csdehop {������� ���� � \002nick\002, ���� ��� �� ������, �� ������� ���� � ��� ����� ChanServ}
	
	set_text -type args -- $_lang csvoice {[nick]}
	set_text -type help -- $_lang csvoice {��� ���� \002nick\002�, ���� ��� �� ������, �� ��� ���� ��� ����� ChanServ}
	
	set_text -type args -- $_lang csdevoice {[nick]}
	set_text -type help -- $_lang csdevoice {�������� ���� � \002nick\002�, ���� ��� �� ������, �� �������� ���� � ��� ����� ChanServ}
	
}