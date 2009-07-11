
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"link"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang link {[via-bot] <hub-bot>}
	set_text -type help -- $_lang link {������� �����. \002hub-bot\002 ������� ���(���) �������, � �������� ���� ��������, \002via-bot\002 ������������� ��� (��������� �� �����������)}
	
	set_text -type args -- $_lang unlink {<hub-bot>}
	set_text -type help -- $_lang unlink {������� �������� � ���� \002hub-bot\002}
	
	set_text $_lang $_name #101 "���� � %s ��� ������."
	set_text $_lang $_name #102 "�� ������� ������������ %s."
	set_text $_lang $_name #103 "%s � %s ����������."
	set_text $_lang $_name #104 "�� ������� ���������� %s � %s."
	set_text $_lang $_name #105 "%s � %s ���������� ����� %s."
	
}