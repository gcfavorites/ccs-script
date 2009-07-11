
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"base"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009" \
				"�������� ���� ��� ������ $_name ($_lang)"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang kick {<����1,����2,...> [�� �� ��� ���?]}
	set_text -type help -- $_lang kick {������� \002����\002�� ������ � ������, � �������� \002�� �� ��� ���?\002 (������� ����� �����������)}
	
	set_text -type args -- $_lang inv {<����>}
	set_text -type help -- $_lang inv {������������ \002����\002� ��� ����� �� �����}
	
	set_text -type args -- $_lang topic {<�����>}
	set_text -type help -- $_lang topic {���������� ����� �� ������}
	
	set_text -type args -- $_lang addtopic {<�����>}
	set_text -type help -- $_lang addtopic {���������� \002�����\002 � ������ ������}
	
	set_text -type args -- $_lang ops {}
	set_text -type help -- $_lang ops {�������� ������ ����� ������}
	
	set_text -type args -- $_lang admins {}
	set_text -type help -- $_lang admins {�������� ������ �������� ���� (������� � ����������� �������)}
	
	set_text -type args -- $_lang whom {}
	set_text -type help -- $_lang whom {������� ������ ������� �� ��������� ����}
	
	set_text -type args -- $_lang whois {<����/����>}
	set_text -type help -- $_lang whois {������� ����������� �� \002����/����\002}
	
	set_text -type args -- $_lang info {[mod/lang/scr]}
	set_text -type help -- $_lang info {������ ����������� � ������� � ��������� ����������}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #103 "������"
	set_text $_lang $_name #102 "%s"
	set_text $_lang $_name #103 "%s // %s"
	set_text $_lang $_name #107 "��������� %s (������ �������� ���������, �������� � �������, ���� ������-��� ����������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set_text $_lang $_name #108 "������� ������: %s."
	set_text $_lang $_name #109 "������������� ������: %s."
	set_text $_lang $_name #110 "��������� ������: %s."
	set_text $_lang $_name #111 "������� ������: %s."
	set_text $_lang $_name #112 "������ ������: %s."
	set_text $_lang $_name #113 "�������������� ���� \002%s\002 (������ �������� ��������������, �������� � �������, ���� ������-��� ����������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set_text $_lang $_name #114 "����������� ������� (+f): %s."
	set_text $_lang $_name #115 "����������� �������������: %s."
	set_text $_lang $_name #116 "����������� ���������: %s."
	set_text $_lang $_name #117 "����������� �������: %s."
	set_text $_lang $_name #118 "����������� ������: %s."
	set_text $_lang $_name #119 "������������� ����: \002%s\002."
	set_text $_lang $_name #120 "�������������� � partyline."
	set_text $_lang $_name #121 "����� � partyline:"
	set_text $_lang $_name #122 "\002%s\002 @ %s (%s)"
	set_text $_lang $_name #123 "\002%s\002 @ %s (%s), ������ ������������: %s."
	set_text $_lang $_name #124 "�������� ������."
	set_text $_lang $_name #125 "��� ����� (�����������|����������): \002%s\002. �����: \002%s\002.%s"
	set_text $_lang $_name #126 "������������� ����� BotNet (����: \002%s\002)"
	set_text $_lang $_name #127 "���������������� (����: \002%s\002)"
	set_text $_lang $_name #128 "������ ������������������"
	set_text $_lang $_name #129 "�������������"
	set_text $_lang $_name #130 "\002%s\002 ������� �����. ��� �����: \002%s\002. ��������� ����-���� �: \002%s\002. ��������: \002%s\002, ����� ��� �������: \002%s\002, ����� ��� ������: \002%s\002."
	set_text $_lang $_name #131 "��� \002%s\002 ��� ������������ �� ������ \002%s\002."
	set_text $_lang $_name #132 "������������: %s."
	set_text $_lang $_name #133 "������ ����������� ���:"
	set_text $_lang $_name #134 "�������/����� �������: \002v%s \[%s\] by %s\002"
	set_text $_lang $_name #135 "���������� ������: \002%s\002"
	set_text $_lang $_name #136 "����� �� ��������: \002%s\002"
	set_text $_lang $_name #137 "������������ �������: \002%s\002"
	set_text $_lang $_name #138 "������ IRC: \002%s\002"
	set_text $_lang $_name #139 "������� ����: \002%s\002"
	set_text $_lang $_name #140 "Suzi patch (���� �����): \002%s\002"
	set_text $_lang $_name #141 "Handlen: \002%s\002"
	set_text $_lang $_name #142 "seen-nick-len: \002%s\002"
	set_text $_lang $_name #143 "���������: \002%s\002"
	set_text $_lang $_name #144 "uptime ����: \002%s\002"
	set_text $_lang $_name #145 "��� ��������� �����: \002%s\002"
	
}