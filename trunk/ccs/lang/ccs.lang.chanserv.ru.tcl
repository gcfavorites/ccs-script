
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chanserv"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,csop) {[nick]}
	set ccs(help,ru,csop) {����� \002nick\002, ���� ��� �� ������, �� ����� ��� ����� ChanServ}
	
	set ccs(args,ru,csdeop) {[nick]}
	set ccs(help,ru,csdeop) {������� \002nick\002, ���� ��� �� ������, �� ������� ��� ����� ChanServ}
	
	set ccs(args,ru,cshop) {[nick]}
	set ccs(help,ru,cshop) {������ \002nick\002, ���� ��� �� ������, �� ������ ��� ����� ChanServ}
	
	set ccs(args,ru,csdehop) {[nick]}
	set ccs(help,ru,csdehop) {������� ���� � \002nick\002, ���� ��� �� ������, �� ������� ���� � ��� ����� ChanServ}
	
	set ccs(args,ru,csvoice) {[nick]}
	set ccs(help,ru,csvoice) {��� ���� \002nick\002�, ���� ��� �� ������, �� ��� ���� ��� ����� ChanServ}
	
	set ccs(args,ru,csdevoice) {[nick]}
	set ccs(help,ru,csdevoice) {�������� ���� � \002nick\002�, ���� ��� �� ������, �� �������� ���� � ��� ����� ChanServ}
	
}