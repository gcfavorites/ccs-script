
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"bots"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,bots) {}
	set ccs(help,ru,bots) {������� ������ �����, �������������� � ��������}
	
	set ccs(args,ru,botattr) {<���/�����> <+flags/-flags>}
	set ccs(help,ru,botattr) {�������� ����� �����}
	
	set ccs(args,ru,chaddr) {<���/�����> <������[:���� ����[/���� ������]]>}
	set ccs(help,ru,chaddr) {�������� ����� � ���� ����}
	
	set ccs(args,ru,addbot) {<�����> <������[:���� ����[/���� ������]]> [����]}
	set ccs(help,ru,addbot) {��������� ���� � ��������. ���� ����� �� ��������� ����� �������� ���� �� ��������� 3333. ���� ���� ������ �� ������ �� �� ����� ��������� ����� �����}
	
	set ccs(args,ru,delbot) {<���/�����>}
	set ccs(help,ru,delbot) {������� ���� �� ���������}
	
	set ccs(args,ru,chaddr) {<���/�����> <������[:���� ����[/���� ������]]>}
	set ccs(help,ru,chaddr) {�������� ������ � ����� ����}
	
	set ccs(args,ru,chbotpass) {<���/�����> [������]}
	set ccs(help,ru,chbotpass) {��������/������� ������ ����}
	
	set ccs(text,bots,ru,#101) "���������� ����� � BotNet'e: \002%s\002. ������ �������:"
	set ccs(text,bots,ru,#102) "���������� ����� � BotNet'e: \002%s\002."
	set ccs(text,bots,ru,#103) "������� BotNet: %s"
	set ccs(text,bots,ru,#104) "��� %s ��� ����� �� ��������� ����."
	set ccs(text,bots,ru,#105) "��� %s ��� ���� � ���������."
	set ccs(text,bots,ru,#106) "��� \002%s\002 ��� ������� �������� � ������� \002%s\002 � ������ \002%s\002."
	set ccs(text,bots,ru,#107) "�� ������� �������� ���� \002%s\002."
	set ccs(text,bots,ru,#108) "��� ���� %s ������� ����� (address: \002%s\002, bot port: \002%s\002, user port: \002%s\002)."
	set ccs(text,bots,ru,#109) "����� ����� ��� %s: \002%s\002"
	set ccs(text,bots,ru,#110) "����� ������ ��� ���� %s ����������."
	set ccs(text,bots,ru,#111) "������ ��� ���� %s �������."
	set ccs(text,bots,ru,#112) "������ ����������� ����������� %s: %s"
	set ccs(text,bots,ru,#113) "������ ����������� ����������� %s ����."
	set ccs(text,bots,ru,#114) "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] ��� ����������."
	set ccs(text,bots,ru,#115) "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] �������� �� \[bot: %s, handle: \002%s\002\]."
	set ccs(text,bots,ru,#116) "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] ���������."
	set ccs(text,bots,ru,#117) "C����������� ����������� \[bot: %s, handle: \002%s\002\] ��� ��������� ��� %s."
	set ccs(text,bots,ru,#118) "��� %s ������������ ����������� \[bot: %s, handle: \002%s\002\] �������."
	set ccs(text,bots,ru,#119) "��� %s ������������ ����������� \[bot: %s\] �� �������."
	
}