
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"say"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"19-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,broadcast) {[@+] <�����>}
	set ccs(help,pod,broadcast) {������� ��������� \002�����\002 �� ��� ������}
	
	set ccs(args,pod,say) {[@+] [act] <�����>}
	set ccs(help,pod,say) {��������� ���������� �� �����. ��� �������� act ����� ��������� ACTION}
	
	set ccs(args,pod,msg) {<����> [act] <�����>}
	set ccs(help,pod,msg) {��������� ���������� ������� \002����\002�. ��� �������� act ����� ��������� ACTION}
	
	set ccs(args,pod,act) {[@+] <����> <�����>}
	set ccs(help,pod,act) {���������� ���������� �� ����� ����� ACTION}
	
	set ccs(text,say,pod,#101) "���������! � ���� ����� ������� \002%s\002. ��� ����������: %s."
	
}