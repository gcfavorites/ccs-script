if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"base"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.1" \
				"03-Jun-2010" \
				"�������� ���� ��� ������ $_name ($_lang)"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang kick {<nick1,nick2,...> [�������]}
	set_text -type help -- $_lang kick {������ \002nick\002� � ������, � �������� \002�������\002 (������� ����� �� ���������)}
	
	set_text -type args -- $_lang inv {<nick>}
	set_text -type help -- $_lang inv {����������� \002nick\002a ��� ����� �� �����}
	
	set_text -type args -- $_lang topic {<�����>}
	set_text -type help -- $_lang topic {������������� ����� ������}
	
	set_text -type args -- $_lang addtopic {<�����>}
	set_text -type help -- $_lang addtopic {��������� \002�����\002 � ���� ������}
	
	set_text -type args -- $_lang ops {}
	set_text -type help -- $_lang ops {���������� ������ ���� ������}
	
	set_text -type args -- $_lang admins {}
	set_text -type help -- $_lang admins {���������� ������ ��������������� ���� (������������� � ����������� �������)}
	
	set_text -type args -- $_lang whom {}
	set_text -type help -- $_lang whom {������� ������ ������������� �� ��������� ����}
	
	set_text -type args -- $_lang whois {<nick|hand>}
	set_text -type help -- $_lang whois {������� ���������� �� \002nick|hand\002}
	
	set_text -type args -- $_lang info {[mod|scr|lang|lib|mask|flag <flag>]}
	set_text -type help -- $_lang info {����� ���������� � �������, ������������� �������, ��������, �������� ������, ����������� � ����������}
	set_text -type help2 -- $_lang info {
		{����� ���������� � �������, ������������� �������, ��������, �������� ������, ����������� � ����������}
		{\002mod/scr/lang/lib\002 - ����� ���������� �� ������������� �������/��������/�������� ������/�����������}
		{\002mask\002 - ����� ������� ��������� � �� ��������}
		{\002flag <flag>\002 - ����� ���������� �� ���������� ����������������� �����}
	}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "%s"
	set_text $_lang $_name #103 "%s // %s"
	set_text $_lang $_name #107 "��������� %s (������ �������� ���������, ������� � �������, ���� ������-��� �� ��������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set_text $_lang $_name #108 "������ ������: %s."
	set_text $_lang $_name #109 "������������� ������: %s."
	set_text $_lang $_name #110 "��������� ������: %s."
	set_text $_lang $_name #111 "������� ������: %s."
	set_text $_lang $_name #112 "������ ������: %s."
	set_text $_lang $_name #113 "�������������� ���� \002%s\002 (������ �������� ��������������, ������� � �������, ���� ������-��� �� ��������� � ������������������ �� ����, �� �� ����� ������ � �������):"
	set_text $_lang $_name #114 "���������� ������ (+f): %s."
	set_text $_lang $_name #115 "���������� �������������: %s."
	set_text $_lang $_name #116 "���������� ���������: %s."
	set_text $_lang $_name #117 "���������� �������: %s."
	set_text $_lang $_name #118 "���������� ������: %s."
	set_text $_lang $_name #119 "������������� ����: \002%s\002."
	set_text $_lang $_name #120 "������ ��� � partyline."
	set_text $_lang $_name #121 "������������ � partyline:"
	set_text $_lang $_name #122 "\002%s\002 @ %s (%s)"
	set_text $_lang $_name #123 "\002%s\002 @ %s (%s), ����� �����������: %s."
	set_text $_lang $_name #124 "����� ������."
	set_text $_lang $_name #125 "��� ����� (����������|���������): \002%s\002. �����: \002%s\002.%s"
	set_text $_lang $_name #126 "������������� ����� BotNet (����: \002%s\002)"
	set_text $_lang $_name #127 "��������������� (����: \002%s\002)"
	set_text $_lang $_name #128 "�� ���������������"
	set_text $_lang $_name #129 "������������"
	set_text $_lang $_name #130 "\002%s\002 �������� �����. ��� �����: \002%s\002. �����������: \002%s\002. ����� ����: \002%s\002, ���� ������: \002%s\002, ���� ����: \002%s\002."
	set_text $_lang $_name #131 "��� \002%s\002 ��� ������������ �� ������ \002%s\002."
	set_text $_lang $_name #132 "�����������: %s."
	set_text $_lang $_name #133 "����� ����������:"
	set_text $_lang $_name #134 "������/����� �������: \002v%s \[%s\] by %s\002"
	set_text $_lang $_name #135 "���. �������������: \002%s\002"
	set_text $_lang $_name #136 "����� �� �������: \002%s\002"
	set_text $_lang $_name #137 "OS: \002%s\002"
	set_text $_lang $_name #138 "������ IRC: \002%s\002"
	set_text $_lang $_name #139 "������ ����: \002%s\002"
	set_text $_lang $_name #140 "Suzi patch: \002%s\002"
	set_text $_lang $_name #141 "Handlen: \002%s\002"
	set_text $_lang $_name #142 "seen-nick-len: \002%s\002"
	set_text $_lang $_name #143 "���������: \002%s\002"
	set_text $_lang $_name #144 "uptime ����: \002%s\002"
	set_text $_lang $_name #145 "uptime �����������: \002%s\002"
	set_text $_lang $_name #146 "���: \002%s\002, ������ \002v%s\002 \[%s\] by %s, ������� %s, ��������: %s."
	set_text $_lang $_name #147 "������ �� �������."
	set_text $_lang $_name #148 "������� �� �������."
	set_text $_lang $_name #149 "�������� ����� �� �������."
	set_text $_lang $_name #150 "���������� �� �������."
	set_text $_lang $_name #151 "\002n|n\002 - (owner, ��������) - ������������ � ��������� �������� � ����. ��� �������� ��� ��������� �������."
	set_text $_lang $_name #152 "\002m|m\002 - (master, ������) - ������������, �������� �������� ����� ��� ������� � �������."
	set_text $_lang $_name #153 "\002t|t\002 - (botnet-master, ������ �������) - ������������, �������� �������� ������� �������."
	set_text $_lang $_name #154 "\002a|a\002 - (auto-op, ����-��������) - ������������, ������� ����� �������� ������ ��������� ��� ����� �� �����."
	set_text $_lang $_name #155 "\002o|o\002 - (op, ��������) - ������������, ������� ������ ��������� �� ���� �������."
	set_text $_lang $_name #156 "\002y|y\002 - (auto-halfop, ����-������������) - ������������, ������� ����� �������� ������ ������� ��� ����� �� �����."
	set_text $_lang $_name #157 "\002l|l\002 - (halfop, ������������) - ������������, ������� ������ ������� �� ���� �������."
	set_text $_lang $_name #158 "\002g|g\002 - (auto-voice, ��������) - ������������, ������� ����� �������� ����� (����) ��� ����� �� �����."
	set_text $_lang $_name #159 "\002v|v\002 - (voice, ����) - ������������, ������� ����� �������� ����� (����) �� ������� +autovoice."
	set_text $_lang $_name #160 "\002f|f\002 - (friend, ����) - ������������, ������� �� ����� ������ �� ���� � �.�."
	set_text $_lang $_name #161 "\002p\002 - (party, ��������) - ������������, � �������� ���� ������ � �������� (DCC)."
	set_text $_lang $_name #162 "\002q|q\002 - (quiet, �����) - ������������, ������� �� ����� �������� ����� (����) �� ������� +autovoice."
	set_text $_lang $_name #163 "\002r|r\002 - (dehalfop, ����-��������) - ������������, �������� ������ ����� ������ �������. ������ ����� ��������� �������������."
	set_text $_lang $_name #164 "\002d|d\002 - (deop, ����) - ������������, �������� ������ ����� ������ ��������� (���). ������ ����� ��������� �������������."
	set_text $_lang $_name #165 "\002k|k\002 - (auto-kick, ����-���) - ������������ ����� ������������� ������ � ������� ��� ������ �� �����."
	set_text $_lang $_name #166 "\002x\002 - (xfer, �������� ������) - ������������, �������� ��������� ����������/��������� �����."
	set_text $_lang $_name #167 "\002j\002 - (janitor, \"�������\") ������������, ������� ����� ������ ������ � �������� �������. ������ filesystem."
	set_text $_lang $_name #168 "\002c\002 - (common, \"�����\") ������������, ������� ����� � IRC � ���������� �����, � �������� ��������� �������������. �������� � ���� ������������� ���� *!some@some.host.dom ������������ ����� ������������������ �� ����."
	set_text $_lang $_name #169 "\002w|w\002 - (wasop-test) ������������, ��� �������� ����������� ���� ��������� ��� �� �� ���� �� ������ ��� +stopnethack �������."
	set_text $_lang $_name #170 "\002z|z\002 - (washalfop-test) ������������, ��� �������� ����� ���������, ��� �� �� �������� �� ������ ��� +stopnethack �������."
	set_text $_lang $_name #171 "\002e|e\002 - (nethack-exempt) ������������, �������� �� ����� ��������� ��� stopnethack ���������."
	set_text $_lang $_name #172 "\002u\002 - (unshared, �� ������) - ���������������� ������ �� ����� ������������ �� ������� ���� ������� ������."
	set_text $_lang $_name #173 "\002h\002 - (highlight, ���������) - ������������, ��� �������� ����� �������������� ���� � ������."
	set_text $_lang $_name #174 "\002b\002 - (bot, ���) - ������������, ������������ ��� ���."
	set_text $_lang $_name #175 "\002%s\002 - ������������ ���������������� �� ����. (������ CCS)"
	set_text $_lang $_name #176 "\002%s\002 - ������������ ���������������� �� ���� ����� ������. (������ CCS)"
	set_text $_lang $_name #177 "\002%s\002 - ������������, ����������� �������� ����������� ����� ������. (������ CCS)"
	set_text $_lang $_name #178 "\002%s\002 - ������������ � ������������ (����������) ������������. (������ CCS)"
	set_text $_lang $_name #179 "\002%s\002 - ������������ ������� ������ �� ���������, ������ ���������� ����� ������ �������� ��������� ������������. (������ CCS)"
	set_text $_lang $_name #180 "\002%s\002 - ������������ ������� ������ �� ������������� �������� (kick, ban ���). (������ CCS)"
	set_text $_lang $_name #181 "\002%s\002 - ��� ����������� � ������� (�������� ������ ����������) ����� �������. (������ CCS)"
	set_text $_lang $_name #182 "�������� ��� ����� \002%s\002 �� �������"
	set_text $_lang $_name #183 "locale: \002%s\002"
	
}