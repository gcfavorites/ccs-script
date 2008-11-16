
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"base"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.3" \
				"11-Nov-2008" \
				"�������� ���� ��� ������ $modname ($modlang)"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,kick) {<����1,����2,...> [�� �� ��� ���?]}
	set ccs(help,pod,kick) {������� \002����\002�� ������ � ������, � �������� \002�� �� ��� ���?\002 (������� ����� �����������)}
	
	set ccs(args,pod,inv) {<����>}
	set ccs(help,pod,inv) {������������ \002����\002� ��� ����� �� �����}
	
	set ccs(args,pod,topic) {<�����>}
	set ccs(help,pod,topic) {���������� ����� �� ������}
	
	set ccs(args,pod,addtopic) {<�����>}
	set ccs(help,pod,addtopic) {���������� \002�����\002 � ������ ������}
	
	set ccs(args,pod,ops) {}
	set ccs(help,pod,ops) {�������� ������ ����� ������}
	
	set ccs(args,pod,admins) {}
	set ccs(help,pod,admins) {�������� ������ �������� ���� (������� � ����������� �������)}
	
	set ccs(args,pod,whom) {}
	set ccs(help,pod,whom) {������� ������ ������� �� ��������� ����}
	
	set ccs(args,pod,whois) {<����/����>}
	set ccs(help,pod,whois) {������� ����������� �� \002����/����\002}
	
	set ccs(args,pod,info) {[mod/lang/scr]}
	set ccs(help,pod,info) {������ ����������� � ������� � ��������� ����������}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,base,pod,#103) "������"
	set ccs(text,base,pod,#102) "%s"
	set ccs(text,base,pod,#103) "%s // %s"
	set ccs(text,base,pod,#107) "��������� %s (������ �������� ���������, �������� � �������, ���� ������-��� ����������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set ccs(text,base,pod,#108) "������� ������: %s."
	set ccs(text,base,pod,#109) "������������� ������: %s."
	set ccs(text,base,pod,#110) "��������� ������: %s."
	set ccs(text,base,pod,#111) "������� ������: %s."
	set ccs(text,base,pod,#112) "������ ������: %s."
	set ccs(text,base,pod,#113) "�������������� ���� \002%s\002 (������ �������� ��������������, �������� � �������, ���� ������-��� ����������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set ccs(text,base,pod,#114) "����������� ������� (+f): %s."
	set ccs(text,base,pod,#115) "����������� �������������: %s."
	set ccs(text,base,pod,#116) "����������� ���������: %s."
	set ccs(text,base,pod,#117) "����������� �������: %s."
	set ccs(text,base,pod,#118) "����������� ������: %s."
	set ccs(text,base,pod,#119) "������������� ����: \002%s\002."
	set ccs(text,base,pod,#120) "�������������� � partyline."
	set ccs(text,base,pod,#121) "����� � partyline:"
	set ccs(text,base,pod,#122) "\002%s\002 @ %s (%s)"
	set ccs(text,base,pod,#123) "\002%s\002 @ %s (%s), ������ ������������: %s."
	set ccs(text,base,pod,#124) "�������� ������."
	set ccs(text,base,pod,#125) "��� ����� (�����������|����������): \002%s\002. �����: \002%s\002.%s"
	set ccs(text,base,pod,#126) "������������� ����� BotNet (����: \002%s\002)"
	set ccs(text,base,pod,#127) "���������������� (����: \002%s\002)"
	set ccs(text,base,pod,#128) "������ ������������������"
	set ccs(text,base,pod,#129) "�������������"
	set ccs(text,base,pod,#130) "\002%s\002 ������� �����. ��� �����: \002%s\002. ��������� ����-���� �: \002%s\002. ��������: \002%s\002, ����� ��� �������: \002%s\002, ����� ��� ������: \002%s\002."
	set ccs(text,base,pod,#131) "��� \002%s\002 ��� ������������ �� ������ \002%s\002."
	set ccs(text,base,pod,#132) "������������: %s."
	set ccs(text,base,pod,#133) "������ ����������� ���:"
	set ccs(text,base,pod,#134) "�������/����� �������: \002v%s \[%s\] by %s\002"
	set ccs(text,base,pod,#135) "���������� ������: \002%s\002"
	set ccs(text,base,pod,#136) "����� �� ��������: \002%s\002"
	set ccs(text,base,pod,#137) "������������ �������: \002%s\002"
	set ccs(text,base,pod,#138) "������ IRC: \002%s\002"
	set ccs(text,base,pod,#139) "������� ����: \002%s\002"
	set ccs(text,base,pod,#140) "Suzi patch (���� �����): \002%s\002"
	set ccs(text,base,pod,#141) "Handlen: \002%s\002"
	set ccs(text,base,pod,#142) "seen-nick-len: \002%s\002"
	set ccs(text,base,pod,#143) "���������: \002%s\002"
	set ccs(text,base,pod,#144) "uptime ����: \002%s\002"
	set ccs(text,base,pod,#145) "��� ��������� �����: \002%s\002"
	
}