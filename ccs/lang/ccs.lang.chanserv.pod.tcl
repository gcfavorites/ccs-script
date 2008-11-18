
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chanserv"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,csop) {[����]}
	set ccs(help,pod,csop) {����� \002����\002�, ���� ���� ��������, �� ����� ��� ����� �������}
	
	set ccs(args,pod,csdeop) {[����]}
	set ccs(help,pod,csdeop) {�������� \002����\002�, ���� ���� ��������, �� �������� ��� ����� �������}
	
	set ccs(args,pod,cshop) {[����]}
	set ccs(help,pod,cshop) {����� ���� \002����\002�, ���� ���� ��������, �� ����� ���� ��� ����� �������}
	
	set ccs(args,pod,csdehop) {[����]}
	set ccs(help,pod,csdehop) {��������� ���� � \002����\002�, ���� ���� ��������, �� ���������� �������������� ����� �������}
	
	set ccs(args,pod,csvoice) {[����]}
	set ccs(help,pod,csvoice) {����� ���� \002����\002�, ���� ���� ��������, �� ����� ���� ��� ����� �������}
	
	set ccs(args,pod,csdevoice) {[����]}
	set ccs(help,pod,csdevoice) {��������� ���� � \002����\002�, ���� ���� ��������, �� ��������� ���� � ��� ����� �������}
	
}