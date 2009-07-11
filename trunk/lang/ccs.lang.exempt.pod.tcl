
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"exempt"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang exempt {<����/����> [�����] [�� �� ��� ���?] [stick]}
	set_text -type help -- $_lang exempt {�������� ����������� �� \002����\002� ��� \002����\002 (nick!ident@host) �� ������. ������ ����������� � �������, ���� ������ ���������, �� ��� �������� �� ��������� �exempt-time� ������. ���� � ��������� ������� \002stick\002, �� ����������� ����� ����� ����������� ��� ��� ������.}
	
	set_text -type args -- $_lang unexempt {<����>}
	set_text -type help -- $_lang unexempt {�������� ����������� � ������}
	
	set_text -type args -- $_lang gexempt {<����/����> [�����] [�� �� ��� ���?] [stick]}
	set_text -type help -- $_lang gexempt {�������� ����������� �� \002����\002� ��� \002����\002 (nick!ident@host) ��������� (�� ���� �������, ��� ���� ���). ������ ����������� � �������, ���� ������ ���������, �� ������������ ������ - 1 ����. ���� � ��������� ������� \002stick\002, �� ����������� ����� ����� ����������� ��� ��� ������.}
	
	set_text -type args -- $_lang gunexempt {<����>}
	set_text -type help -- $_lang gunexempt {����� ����������� ����������� �� ���� ��������}
	
	set_text -type args -- $_lang exemptlist {[global]}
	set_text -type help -- $_lang exemptlist {������� ������ ���������� ������, ���� ������ �������� �global�, �� ������� ���������� ������ ����������}
	
	set_text -type args -- $_lang resetexempts {}
	set_text -type help -- $_lang resetexempts {���������� � ������ ��� �����������, ������� ��� � ������ ����}
	
	set_text $_lang $_name #101 "�� �������: ��� ���� � ������!"
	set_text $_lang $_name #102 "���������� \002�����������\002%s �����������: \037%s\037."
	set_text $_lang $_name #103 "%s (�� %s)."
	set_text $_lang $_name #104 "����������%s �����������: \037%s\037 �� %s."
	set_text $_lang $_name #105 "���������%s �����������: \002%s\002."
	set_text $_lang $_name #106 "����������� \002%s\002 �� \002%s\002 ���������! ������ �������!"
	set_text $_lang $_name #107 "�� �������: ��� ���� � ������!"
	set_text $_lang $_name #108 "���������� \002�����������\002 ����������%s �����������: \037%s\037."
	set_text $_lang $_name #109 "���������� �����������%s �����������: \037%s\037 �� %s."
	set_text $_lang $_name #110 "��������� �����������%s �����������: \002%s\002"
	set_text $_lang $_name #111 "����������� ����������� \002%s\002 ����������."
	set_text $_lang $_name #112 "--- ���������� ������ ����������%s ---"
	set_text $_lang $_name #113 "--- ������ ���������� \002%s\002%s ---"
	set_text $_lang $_name #114 "*** ��������� ***"
	set_text $_lang $_name #115 "����������� \002�����������\002."
	set_text $_lang $_name #116 "�������� ����� %s."
	set_text $_lang $_name #117 "� %s %s� ���������: �%s� � %s � ����������� ���������� %s ����� � �������������: \002%s\002.%s"
	set_text $_lang $_name #118 "--- �������� ������ ���������� ---"
	set_text $_lang $_name #119 "�����������, ������� ��� � ������ ����, ���� ���������."
	set_text $_lang $_name #120 "\037����\037"
	set_text $_lang $_name #121 "(����� \002%s\002)"
	set_text $_lang $_name #122 "��������� �� ������: \002%s\002 %s �����."
	set_text $_lang $_name #123 "--- ��������� ����������� ---"
	set_text $_lang $_name #124 "� \002%s\002 � ��������� �� ������: \002%s\002 %s �����."
	
}