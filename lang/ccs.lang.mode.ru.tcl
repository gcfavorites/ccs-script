
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"mode"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.2" \
				"14-Aug-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,op) {[nick1,nick2,...]}
	set ccs(help,ru,op) {����� \002nick\002, ���� ��� �� ������, �� ����� ���}
	
	set ccs(args,ru,deop) {[nick1,nick2,...]}
	set ccs(help,ru,deop) {������� \002nick\002, ���� ��� �� ������, �� ������� ���}
	
	set ccs(args,ru,hop) {[nick1,nick2,...]}
	set ccs(help,ru,hop) {������ \002nick\002, ���� ��� �� ������, �� ������ ���}
	
	set ccs(args,ru,dehop) {[nick1,nick2,...]}
	set ccs(help,ru,dehop) {������� ���� � \002nick\002, ���� ��� �� ������, �� ������� ���� � ���}
	
	set ccs(args,ru,voice) {[nick1,nick2,...]}
	set ccs(help,ru,voice) {��� ���� \002nick\002�, ���� ��� �� ������, �� ��� ���� ���}
	
	set ccs(args,ru,devoice) {[nick1,nick2,...]}
	set ccs(help,ru,devoice) {�������� ���� � \002nick\002�, ���� ��� �� ������, �� �������� ���� � ���}
	
	set ccs(args,ru,allvoice) {}
	set ccs(help,ru,allvoice) {������ ���� ����� �� ������}
	
	set ccs(args,ru,alldevoice) {}
	set ccs(help,ru,alldevoice) {������� �� ���� ����� �� ������}
	
	set ccs(args,ru,mode) {<[+/-]mode> [args]}
	set ccs(help,ru,mode) {�������� ����� ������ (��������, �%pref_mode +l 1�)}
	
	set ccs(text,mode,ru,#101) "� ���� ���� ������� ��������� ��� ���������� �������."
	
}