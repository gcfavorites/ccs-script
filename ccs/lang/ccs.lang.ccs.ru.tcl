
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ccs"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.7" \
				"17-Nov-2008" \
				"�������� ���� ��� ������ $modname ($modlang)"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,update) {(<list> [-cur/-mod/-lang])|(<download> [-type type] [-name name] [-lang lang])|(<update>)}
	set ccs(help,ru,update) {�������������� ���������� �������, �������, �������� ������}
	set ccs(help2,ru,update) {
		{�������������� ���������� �������, �������, ������.}
		{\002list\002 - �������� ������ ����� ������. ��� �������� \002-cur\002 ����� �������� ���������� ������ ��� �������������  ������� � ������; \002-mod\002 - ����� ������ �������; \002-lang\002 - ����� ������ ������}
		{\002update\002 - ���������� ���� ����� ������������� ������� � ������}
		{\002download\002 - �������� ����� ������� � ������. ��� ���� ���������� ������� ������: \002type\002 - ��� ������������ ����� (mod, lang, scr); \002name\002 - ��� ������������ ������; \002lang\002 - ���� (����������� ������ ��� ���� lang. � ������� ����� ������������ *)}
	}
	
	set ccs(args,ru,help) {[�����]}
	set ccs(help,ru,help) {������ �� �������� ����������}
	set ccs(help2,ru,help) {
		{������ �� �������� ����������. �����:}
		{\002-a\002 �������� � ������ ����������� ������ ����������� ��� ���������� �������;}
		{\002-l\002 ���������� ������ ��������� ������ ������ ����, ������� �������� ������������;}
		{\002-�\002 �������� ��������� ����� ��� ������;}
		{\002-g ������\002 �������� ������� ������ �� ��������� ������;}
		{\002-s\002 ������� ������ ��������� ��������;}
		{��������� ������: \002%groups\002. ������: \002-l -g mode\002}
	}
	
	
	set ccs(text,ccs,ru,#101) "\002\037Channel ControlScript Help\037\002. ������: \002v%s \[%s\] by %s\002. �������� ��� ������: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002, �������� ��� ������ �������: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002. ��� ������ ���������� \002\[�han\]\002 �������� �������� ������, ���������� \002\<�han>\002 �������� ������ ����������� (������ ��� msg � dcc ������, ��� pub ������ �������� ������ \037�� ���������\037)."
	set ccs(text,ccs,ru,#102) "������������ ���� (��������: \002%s\002, ������������: \002%s\002)."
	set ccs(text,ccs,ru,#103) "��������� ������������� ������� �������������. ������������ ������� ����� �� ���� ��� � %s ���."
	set ccs(text,ccs,ru,#112) "��� ����� ��������� ��� %s. �� �� ������ ������������ ������������� � ����������� ���� �����."
	set ccs(text,ccs,ru,#114) "������������� c ����������� �����: /msg %s identauth \002\[handle\] <pass>\002"
	set ccs(text,ccs,ru,#115) "������������ ����. ������ ����� �� ���� �� ���� ����� �� ��������� � �������. �������� ��������� ����� � ������������� ����� ��������: /msg %s identauth \002<pass>\002"
	set ccs(text,ccs,ru,#116) "������������ \002%s\002 ������������ �� ���������. ������ ���������� ����� ����� ������� ���������."
	set ccs(text,ccs,ru,#117) "� ������ ������ ��� ����� ��������� � ������ �����. ���������� �����..."
	set ccs(text,ccs,ru,#118) "������������ ����."
	set ccs(text,ccs,ru,#119) "\002%s\002 ��� �� \002%s\002."
	set ccs(text,ccs,ru,#120) "�� �� ������������������� � ����, ������� �� ������ ��������� ��� �������."
	set ccs(text,ccs,ru,#121) "�������������: /msg %s auth \002���_������\002"
	set ccs(text,ccs,ru,#122) "\002%s\002 ��� ������ � ���������, �� �� �� ������������� �������� �� ������. �������� ������� � ������������ ����������� ������ � \002%s\002."
	set ccs(text,ccs,ru,#123) "� �� ����� \002%s\002 � ���������."
	set ccs(text,ccs,ru,#124) "\002%s\002 ��� ������ � ���������, �� ��� ���� �� ������������� \002%s\002. �������� ������� � ������������ ����������� ������ � \002%s\002 � \002%s\002."
	set ccs(text,ccs,ru,#125) "� �� ���� \002%s\002 ����� � �� ����� ��� � ���������."
	set ccs(text,ccs,ru,#126) "�� ������ �� ��������� ��������������������� � ���� (�� ����� � �������, ��� ���� ���)."
	set ccs(text,ccs,ru,#127) "��������, �� � �� ���� ����� ��� � ����-�����. �������� ��� ������� ���� �� ��������� � ������� � ���� ���� ������."
	set ccs(text,ccs,ru,#128) "�� ��� �� ������������������."
	set ccs(text,ccs,ru,#129) "������������� � ���� %s ���� �������."
	set ccs(text,ccs,ru,#130) "�� ��� ������������������."
	set ccs(text,ccs,ru,#131) "������������� � ���� %s ������ �������. �������� ��� ������: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002, �������� ��� ������ �������: \002pub \"%s\", msg \"%s\", dcc \"%s\"\002."
	set ccs(text,ccs,ru,#132) "������ � ���� %s �������!"
	set ccs(text,ccs,ru,#133) "�� ��� �� �� \002%s\002."
	set ccs(text,ccs,ru,#134) "\002%s\002 ��� �� �� \002%s\002."
	set ccs(text,ccs,ru,#135) "\002%s\002 �� �������� OP'�� ������ \002%s\002 (�� ��������� ����), ������� ������ ���� ��� ������ ��������� (����� ���������� � ����� \002+bitch\002)."
	set ccs(text,ccs,ru,#136) "�� ��� �� OP �� ���� ������."
	set ccs(text,ccs,ru,#137) "\002%s\002 �� �������� OP'�� �� \002%s\002."
	set ccs(text,ccs,ru,#138) "�� ��� ��� �� \002%s\002."
	set ccs(text,ccs,ru,#139) "\002%s\002 ��� ��� �� \002%s\002."
	set ccs(text,ccs,ru,#140) "�� ��� �� ��� �� ���� ������."
	set ccs(text,ccs,ru,#141) "\002%s\002 �� �������� ���'�� �� \002%s\002."
	set ccs(text,ccs,ru,#142) "�� ��� ������ ������ VOICE �� \002%s\002."
	set ccs(text,ccs,ru,#143) "\002%s\002 ��� VOICE �� \002%s\002."
	set ccs(text,ccs,ru,#144) "�� �� ��������� ������ �� \002%s\002."
	set ccs(text,ccs,ru,#145) "\002%s\002 �� �������� ������ �� \002%s\002."
	set ccs(text,ccs,ru,#166) "Saving user file..."
	set ccs(text,ccs,ru,#167) "Rehashing..."
	set ccs(text,ccs,ru,#169) "������������ %s ��� ���� � ���������."
	set ccs(text,ccs,ru,#170) "����� \002%s\002 ��� ��������."
	set ccs(text,ccs,ru,#177) "������: \002%s\002 ���� � ������, �������� ���� ��: \002%s\002."
	set ccs(text,ccs,ru,#178) "���������� ������� ������ \002-g ������\002. ������ �����: \002%s\002."
	set ccs(text,ccs,ru,#179) "������������ \002%s\002 ���������� ��� �������. ������ ���������� ����� ����� ������������ �������."
	#set ccs(text,ccs,ru,#180) " pub: \002%s %s\002"
	#set ccs(text,ccs,ru,#181) " msg: \002%s %s\002"
	#set ccs(text,ccs,ru,#182) " pub/msg: \002%s %s\002"
	#set ccs(text,ccs,ru,#183) " ������ ������: \002%s\002."
	#set ccs(text,ccs,ru,#184) " ������ �������: \002%s\002."
	set ccs(text,ccs,ru,#185) " ������: \002%s\002."
	set ccs(text,ccs,ru,#186) " ����������� ������: \002%s\002."
	#set ccs(text,ccs,ru,#187) " msg: \002%s <#�����> %s\002"
	set ccs(text,ccs,ru,#188) "%s �� �������� �����. � ���� ������ ���� ���� \002b\002."
	set ccs(text,ccs,ru,#189) "���������� ��� ������� �� �������."
	set ccs(text,ccs,ru,#190) "�������������� ������� ����� \002%s\002 ..."
	set ccs(text,ccs,ru,#191) "���������� ����� \002%s\002 ..."
	set ccs(text,ccs,ru,#192) "������ ���������� �����: %s"
	set ccs(text,ccs,ru,#193) "�������� �����: \002%s\002 ..."
	set ccs(text,ccs,ru,#194) "... �� ������� ��������� ����, ������: %s"
	set ccs(text,ccs,ru,#195) " - ��� �����: \002%s\002, ������: \002%s\002, ����: \002%s\002, ����: \002%s\002, ������� ������: \002%s\002, ����� ������: \002%s\002"
	set ccs(text,ccs,ru,#196) "��������� ������: \002%s\002, ������: \002%s\002."
	set ccs(text,ccs,ru,#197) "���������� ��������� ������� ���� ������� ����� �� ������. ���� �� ��������, ��� ������ ��������� �� �� ��������� ������, ���������� ������� ����� ����."
	set ccs(text,ccs,ru,#198) "���������� �������� ������ �� ��������� ���� Suzi Project."
	set ccs(text,ccs,ru,#199) "���������� ���� �������� ������ � ��������� cp1251."
	set ccs(text,ccs,ru,#200) "��� ������ ������ � ������������ �� ����������� ���������� ������� �����"
	set ccs(text,ccs,ru,#201) "���������� ������������ ������� \002%s <�������/all/*> \[���������\]\002"
	set ccs(text,ccs,ru,#202) "%s �� �������� �����, ������������ ��������� ���������� (���������� ���� \002U\002)."
	set ccs(text,ccs,ru,#203) "� ���� %s �� ��������� ������."
	set ccs(text,ccs,ru,#204) "��� %s �� �����������."
	set ccs(text,ccs,ru,#205) "������������ %s �� ����� ����������� ������ ��� ���� %s."
	set ccs(text,ccs,ru,#207) "������� �� �������� ����� ������."
	set ccs(text,ccs,ru,#208) "����� \002%s\002 �� �������� �� ����."
	set ccs(text,ccs,ru,#209) "�������"
	set ccs(text,ccs,ru,#210) "��������"
	set ccs(text,ccs,ru,#211) "�� ������ �� ��������� ��������������������� � ���� (���� ��������� �� ��������� �� � ����� �� �����������)."
	set ccs(text,ccs,ru,#212) "��� %s �� ���������� ������, ���������� ������ ����� �������� /msg %s pass \002���_������\002"
	set ccs(text,ccs,ru,#213) "������ ������ �����: %s"
	
}