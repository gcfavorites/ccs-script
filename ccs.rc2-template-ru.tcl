if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]"; return}
####################################################################################################
# ������ ���� ���� ��������� � ccs.tcl � �� ������� ��������������� �����������, ��� �� �� ��������
# ������������. �������� ����� ���������� �������������, ������ �� �������� ccs.tcl
# ������ ������������ ��������� ���������� ��������� ��������. �� ���� �� ���� ����� ���������� �
# ��������� ��������� ���������� ������� ��� ���������� ��� ������. ��� �� ����� ������ � ��� ������
# ���� ���� ����������� ���������, ���� ���������, �������.
# �� ��������� ��� ������� ����������������, ���� ���������� �������� �����, �� �������� ������� �
# ���� ����� ����������� "#", � �������� �� �������.
####################################################################################################
# �������� ������� ����� ���������� ����� ���������� ������.
####################################################################################################


	################################################################################################
	# ��������� DNS �������. ��������� ��������� ������ � ������ ������������� ����������
	# ccs.lib.dns.tcl. ������� ����������������� � ������ ������ ��������� ������ � ������ ����
	# �������� �� ��������� �� �������� �����������. ��� Unix ������ IP ����� NS �������
	# ������������ �������������. ��������� DNS ������� �� �������� ������� ������ �� ��������� TCP,
	# ��� ������� ���� �������� ������� ���������� ����� tcludp ��� ceptcl. ����� ����������
	# ��������� ������, DNS ������� ����� ������������� ������������ �������� UDP.
	# ����� tcludp ����� ������� � http://sourceforge.net/project/showfiles.php?group_id=75201
	#dns::configure -nameserver 172.17.7.1
	#dns::configure -port 53
	#dns::configure -timeout 10000
	#dns::configure -protocol tcp
