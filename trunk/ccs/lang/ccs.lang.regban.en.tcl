if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"regban"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,regbanlist) {}
	set ccs(help,ru,regbanlist) {Show the list of all regex-based bans}
	
	set ccs(args,ru,regban) {<[-host {rege}] [-server {rege}] [-status {rege}] [-hops number] [-name {rege}]> [options]}
	set ccs(help,ru,regban) {����������� ����������� ����}
	set ccs(help2,ru,regban) {
		{����������� ����������� ����. ��������� �����:}
		{  \002-ban [number]\002 - �������� ���. �������� �������� ����� ����, ���� ����� ���� �� �������, �� ������� �������� �� ��������� ��� ������.}
		{  \002-kick [{reason}]\002 - �������� ���. �������� ������� �� �����������.}
		{  \002-notify {handle1,handle2 ...} [{text}]\002 - �������� �����. ������������ ����� ������������� �������/����� � ��������� ����������. ������������ ������ ������ �� ����� �� ������, ��� ����� ���.}
		{����������: ���� ���������� ���������� ������� � ������������ ��������� ������ \002-host\002 �� ������� � ���������� ������� �� ����� �����������.}
	}
	
	set ccs(args,ru,regunban) {<id>}
	set ccs(help,ru,regunban) {�������� ����������� ����}
	
	set ccs(text,regban,ru,#101) "���������� ��� \002ID: %s\002 ��������: %s."
	set ccs(text,regban,ru,#102) "���������� ��� \002ID: %s\002 ������: %s."
	set ccs(text,regban,ru,#103) "���������� ��� \002ID: %s\002 �� ����������."
	set ccs(text,regban,ru,#104) "--- ������ ���������� ����� \002%s\002 ---"
	set ccs(text,regban,ru,#105) "*** ���� ***"
	set ccs(text,regban,ru,#106) "--- ����� ������ ���������� ����� ---"
	set ccs(text,regban,ru,#107) "���������� ��� \002ID: %s\002 %s: %s."
	set ccs(text,regban,ru,#108) "���������� ��������� \"\002%s\002\" �� ��������� ����������."
	
} 