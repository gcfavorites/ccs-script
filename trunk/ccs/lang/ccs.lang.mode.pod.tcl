
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"mode"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"14-Aug-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,op) {[����1,����2,...]}
	set ccs(help,pod,op) {������ \002����\002�, ���� ��� ����� ��������, �� ����� ���}
	
	set ccs(args,pod,deop) {[����1,����2,...]}
	set ccs(help,pod,deop) {�������� \002����\002�, ���� ��� ����� ��������, �� ������� ���}
	
	set ccs(args,pod,hop) {[����1,����2,...]}
	set ccs(help,pod,hop) {������ \002����\002�, ���� ��� ����� ��������, �� ������ ���}
	
	set ccs(args,pod,dehop) {[����1,����2,...]}
	set ccs(help,pod,dehop) {������� ���� � \002����\002�, ���� ��� ����� ��������, �� ������� ���� � ���}
	
	set ccs(args,pod,voice) {[����1,����2,...]}
	set ccs(help,pod,voice) {����� ���� \002����\002�, ���� ��� ����� ��������, �� ����� ���� ���}
	
	set ccs(args,pod,devoice) {[����1,����2,...]}
	set ccs(help,pod,devoice) {�������� ���� � \002����\002�, ���� ��� ����� ��������, �� �������� ���� � ���}
	
	set ccs(args,pod,allvoice) {}
	set ccs(help,pod,allvoice) {��c����� ���� ����� �� ������}
	
	set ccs(args,pod,alldevoice) {}
	set ccs(help,pod,alldevoice) {������� �� ���� ����� �� ������}
	
	set ccs(args,pod,mode) {<[+/-]���> [���������]}
	set ccs(help,pod,mode) {�������� ����� ������ (��������, �%pref_mode +l 1�)}
	
	
	
}