
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"bots"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,bots) {}
	set ccs(help,pod,bots) {������� ������ ������, ������� ������������ � ��������}
	
	set ccs(args,pod,botattr) {<����/�����> <+�����/-�����>}
	set ccs(help,pod,botattr) {��������� ����� ������}
	
	set ccs(args,pod,chaddr) {<����/�����> <�����[:���� ����[/���� �������]]>}
	set ccs(help,pod,chaddr) {����������� ����� � ���� ����}
	
	set ccs(args,pod,addbot) {<�����> <�����[:���� ����[/���� �������]]> [����]}
	set ccs(help,pod,addbot) {����������� ���� � ��������. ���� ����� ����������� - ����� �������� ���� ������������ 3333. ���� ���� ������� ��������, �� �� ����� ��������� ����� ������}
	
	set ccs(args,pod,delbot) {<����/�����>}
	set ccs(help,pod,delbot) {���������� ���� �� ���������}
	
	set ccs(args,pod,chaddr) {<����/�����> <�����[:���� ����[/���� �������]]>}
	set ccs(help,pod,chaddr) {�������� ����� � ���� ����}
	
	set ccs(args,pod,chbotpass) {<����/�����> [��������]}
	set ccs(help,pod,chbotpass) {��������/������� �������� ����}
	
	set ccs(text,bots,pod,#101) "���������� ������ � BotNet'�: \002%s\002. ������ �������:"
	set ccs(text,bots,pod,#102) "���������� ������ � BotNet'�: \002%s\002."
	set ccs(text,bots,pod,#103) "������� BotNet: %s"
	set ccs(text,bots,pod,#104) "��� %s ��� �������� �� ��������� ����."
	set ccs(text,bots,pod,#105) "��� %s ��� ���� � ���������. ����� ���� �������!"
	set ccs(text,bots,pod,#106) "��� \002%s\002 ��� ��������� � ��������� \002%s\002 � ������ \002%s\002."
	set ccs(text,bots,pod,#107) "��������� �������� ���� \002%s\002."
	set ccs(text,bots,pod,#108) "���� ���� %s �������� ����� (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set ccs(text,bots,pod,#109) "��������� ����� ��� %s: \002%s\002"
	
}