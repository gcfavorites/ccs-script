
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"mode"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang op {[����1,����2,...]}
	set_text -type help -- $_lang op {������ \002����\002�, ���� ��� ����� ��������, �� ����� ���}
	
	set_text -type args -- $_lang deop {[����1,����2,...]}
	set_text -type help -- $_lang deop {�������� \002����\002�, ���� ��� ����� ��������, �� ������� ���}
	
	set_text -type args -- $_lang hop {[����1,����2,...]}
	set_text -type help -- $_lang hop {������ \002����\002�, ���� ��� ����� ��������, �� ������ ���}
	
	set_text -type args -- $_lang dehop {[����1,����2,...]}
	set_text -type help -- $_lang dehop {������� ���� � \002����\002�, ���� ��� ����� ��������, �� ������� ���� � ���}
	
	set_text -type args -- $_lang voice {[����1,����2,...]}
	set_text -type help -- $_lang voice {����� ���� \002����\002�, ���� ��� ����� ��������, �� ����� ���� ���}
	
	set_text -type args -- $_lang devoice {[����1,����2,...]}
	set_text -type help -- $_lang devoice {�������� ���� � \002����\002�, ���� ��� ����� ��������, �� �������� ���� � ���}
	
	set_text -type args -- $_lang allvoice {}
	set_text -type help -- $_lang allvoice {��c����� ���� ����� �� ������}
	
	set_text -type args -- $_lang alldevoice {}
	set_text -type help -- $_lang alldevoice {������� �� ���� ����� �� ������}
	
	set_text -type args -- $_lang mode {<[+/-]���> [���������]}
	set_text -type help -- $_lang mode {�������� ����� ������ (��������, �%pref_mode +l 1�)}
	
}