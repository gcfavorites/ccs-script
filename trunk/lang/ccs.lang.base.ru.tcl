if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"base"
set modlang		"ru"
addfileinfo lang "$modname,$modlang" \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.6" \
				"14-Mar-2009" \
				"�������� ���� ��� ������ $modname ($modlang)"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,kick) {<nick1,nick2,...> [�������]}
	set ccs(help,ru,kick) {������ \002nick\002� � ������, � �������� \002�������\002 (������� ����� �� ���������)}
	
	set ccs(args,ru,inv) {<nick>}
	set ccs(help,ru,inv) {����������� \002nick\002a ��� ����� �� �����}
	
	set ccs(args,ru,topic) {<�����>}
	set ccs(help,ru,topic) {������������� ����� ������}
	
	set ccs(args,ru,addtopic) {<�����>}
	set ccs(help,ru,addtopic) {��������� \002�����\002 � ���� ������}
	
	set ccs(args,ru,ops) {}
	set ccs(help,ru,ops) {���������� ������ ���� ������}
	
	set ccs(args,ru,admins) {}
	set ccs(help,ru,admins) {���������� ������ ��������������� ���� (������������� � ����������� �������)}
	
	set ccs(args,ru,whom) {}
	set ccs(help,ru,whom) {������� ������ ������������� �� ��������� ����}
	
	set ccs(args,ru,whois) {<nick|hand>}
	set ccs(help,ru,whois) {������� ���������� �� \002nick|hand\002}
	
	set ccs(args,ru,info) {[mod|scr|lang|mask]}
	set ccs(help,ru,info) {����� ���������� � �������, ������������� �������, ��������, �������� ������ � ��������� ����������}
	set ccs(help2,ru,info) {
		{����� ���������� � �������, ������������� �������, ��������, �������� ������ � ��������� ����������}
		{���� ������� \002mod/scr/lang\002 �� ����� ������ ���������� �� ������������� �������/��������/�������� ������}
		{���� ������� \002mask\002 �� ����� ������� ������ ���������� ������� ���������}
	}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,base,ru,#101) "Requested"
	set ccs(text,base,ru,#102) "%s"
	set ccs(text,base,ru,#103) "%s // %s"
	set ccs(text,base,ru,#107) "��������� %s (������ �������� ���������, ������� � �������, ���� ������-��� �� ��������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set ccs(text,base,ru,#108) "������ ������: %s."
	set ccs(text,base,ru,#109) "������������� ������: %s."
	set ccs(text,base,ru,#110) "��������� ������: %s."
	set ccs(text,base,ru,#111) "������� ������: %s."
	set ccs(text,base,ru,#112) "������ ������: %s."
	set ccs(text,base,ru,#113) "�������������� ���� \002%s\002 (������ �������� ��������������, ������� � �������, ���� ������-��� �� ��������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set ccs(text,base,ru,#114) "���������� ������ (+f): %s."
	set ccs(text,base,ru,#115) "���������� �������������: %s."
	set ccs(text,base,ru,#116) "���������� ���������: %s."
	set ccs(text,base,ru,#117) "���������� �������: %s."
	set ccs(text,base,ru,#118) "���������� ������: %s."
	set ccs(text,base,ru,#119) "������������� ����: \002%s\002."
	set ccs(text,base,ru,#120) "������ ��� � partyline."
	set ccs(text,base,ru,#121) "������������ � partyline:"
	set ccs(text,base,ru,#122) "\002%s\002 @ %s (%s)"
	set ccs(text,base,ru,#123) "\002%s\002 @ %s (%s), ����� �����������: %s."
	set ccs(text,base,ru,#124) "����� ������."
	set ccs(text,base,ru,#125) "��� ����� (����������|���������): \002%s\002. �����: \002%s\002.%s"
	set ccs(text,base,ru,#126) "������������� ����� BotNet (����: \002%s\002)"
	set ccs(text,base,ru,#127) "��������������� (����: \002%s\002)"
	set ccs(text,base,ru,#128) "�� ���������������"
	set ccs(text,base,ru,#129) "������������"
	set ccs(text,base,ru,#130) "\002%s\002 �������� �����. ��� �����: \002%s\002. �����������: \002%s\002. ����� ����: \002%s\002, ���� ������: \002%s\002, ���� ����: \002%s\002."
	set ccs(text,base,ru,#131) "��� \002%s\002 ��� ������������ �� ������ \002%s\002."
	set ccs(text,base,ru,#132) "�����������: %s."
	set ccs(text,base,ru,#133) "����� ����������:"
	set ccs(text,base,ru,#134) "������/����� �������: \002v%s \[%s\] by %s\002"
	set ccs(text,base,ru,#135) "���. �������������: \002%s\002"
	set ccs(text,base,ru,#136) "����� �� �������: \002%s\002"
	set ccs(text,base,ru,#137) "OS: \002%s\002"
	set ccs(text,base,ru,#138) "������ IRC: \002%s\002"
	set ccs(text,base,ru,#139) "������ ����: \002%s\002"
	set ccs(text,base,ru,#140) "Suzi patch: \002%s\002"
	set ccs(text,base,ru,#141) "Handlen: \002%s\002"
	set ccs(text,base,ru,#142) "seen-nick-len: \002%s\002"
	set ccs(text,base,ru,#143) "���������: \002%s\002"
	set ccs(text,base,ru,#144) "uptime ����: \002%s\002"
	set ccs(text,base,ru,#145) "uptime �����������: \002%s\002"
	set ccs(text,base,ru,#146) "���: \002%s\002, ������ \002v%s\002 \[%s\] by %s, ������� %s, ��������: %s."
	set ccs(text,base,ru,#147) "������ �� �������."
	set ccs(text,base,ru,#148) "������� �� �������."
	set ccs(text,base,ru,#149) "�������� ����� �� �������."
	set ccs(text,base,ru,#150) "���������� �� �������."
	
}