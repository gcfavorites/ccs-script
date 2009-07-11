
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"mode"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang op {[nick1,nick2,...]}
	set_text -type help -- $_lang op {����� \002nick\002, ���� ��� �� ������, �� ����� ���}
	
	set_text -type args -- $_lang deop {[nick1,nick2,...]}
	set_text -type help -- $_lang deop {������� \002nick\002, ���� ��� �� ������, �� ������� ���}
	
	set_text -type args -- $_lang hop {[nick1,nick2,...]}
	set_text -type help -- $_lang hop {������ \002nick\002, ���� ��� �� ������, �� ������ ���}
	
	set_text -type args -- $_lang dehop {[nick1,nick2,...]}
	set_text -type help -- $_lang dehop {������� ���� � \002nick\002, ���� ��� �� ������, �� ������� ���� � ���}
	
	set_text -type args -- $_lang voice {[nick1,nick2,...]}
	set_text -type help -- $_lang voice {��� ���� \002nick\002�, ���� ��� �� ������, �� ��� ���� ���}
	
	set_text -type args -- $_lang devoice {[nick1,nick2,...]}
	set_text -type help -- $_lang devoice {�������� ���� � \002nick\002�, ���� ��� �� ������, �� �������� ���� � ���}
	
	set_text -type args -- $_lang allvoice {}
	set_text -type help -- $_lang allvoice {������ ���� ����� �� ������}
	
	set_text -type args -- $_lang alldevoice {}
	set_text -type help -- $_lang alldevoice {������� �� ���� ����� �� ������}
	
	set_text -type args -- $_lang mode {<[+/-]mode> [args]}
	set_text -type help -- $_lang mode {�������� ����� ������ (��������, �%pref_mode +l 1�)}
	
	set_text $_lang $_name #101 "� ���� ���� ������� ��������� ��� ���������� �������."
	
}