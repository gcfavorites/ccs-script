
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"say"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.1" \
				"19-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,broadcast) {[@+] <�����>}
	set ccs(help,ru,broadcast) {������� ��������� ��������� �� ��� ������}
	set ccs(help2,ru,broadcast) {
		{������� ��������� ��������� �� ��� ������, �� ������� �� ����� ����������� �����.}
		{��� �������� ���� \002@+\002 ����� ������ ��������� ������ ����/������. �������������� �� ����� ������.}
	}
	
	set ccs(args,ru,say) {[@+] [act] <�����>}
	set ccs(help,ru,say) {�������� ��������� �� �����}
	set ccs(help2,ru,say) {
		{�������� ��������� �� �����. ��� �������� \002act\002 ����� ���������� ACTION}
		{��� �������� ���� \002@+\002 ����� ������ ��������� ������ ����/������. �������������� �� ����� ������.}
	}
	
	set ccs(args,ru,msg) {<���> [act] <�����>}
	set ccs(help,ru,msg) {�������� ��������� � ������}
	set ccs(help2,ru,msg) {{�������� ��������� � ������. ��� �������� \002act\002 ����� ���������� ACTION}	}
	
	set ccs(args,ru,act) {[@+] <���> <�����>}
	set ccs(help,ru,act) {�������� ��������� �� ����� ����� ACTION}
	set ccs(help2,ru,act) {
		{�������� ��������� �� ����� ����� ACTION}
		{��� �������� ���� \002@+\002 ����� ������ ��������� ������ ����/������. �������������� �� ����� ������.}
	}
	
	set ccs(text,say,ru,#101) "��������! ���������� ��������� �� \002%s\002: %s."
	
}