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
# �������� ������� ����� ���������� �� �������� �������, ��������, ���������, ������. � ������ �����
# ����� ��������� �������� ����� ���� �������, ��������, ���������, ������.
####################################################################################################


	################################################################################################
	# ���������, ���������� �������� ������ "ban" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,ban) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "base" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,base) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "bots" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,bots) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "chan" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,chan) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "chanserv" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,chanserv) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "chat" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,chat) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "exempt" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,exempt) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "fixstick" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,fixstick) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "ignore" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,ignore) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "invite" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,invite) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "lang" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,lang) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "link" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,link) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "logs" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,logs) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "mode" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,mode) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "rebind" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,rebind) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "regban" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,regban) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "say" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,say) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "system" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,system) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "traf" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,traf) 0
	
	################################################################################################
	# ���������, ���������� �������� ������ "users" (0 - ���������, 1 - ��������)
	#set ccs(mod,name,users) 0
	
	################################################################################################
	# ���������, ���������� �������� ������� "whoisip" (0 - ���������, 1 - ��������)
	#set ccs(scr,name,whoisip) 0

	################################################################################################
	# ���������, ���������� �������� ������� "mslaps" (0 - ���������, 1 - ��������)
	#set ccs(scr,name,mslaps) 0


	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "ban" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ban,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "ban" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ban,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "ban" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ban,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "base" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,base,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "base" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,base,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "base" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,base,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "bots" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,bots,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "bots" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,bots,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "bots" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,bots,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "ccs" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ccs,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "ccs" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ccs,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "ccs" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ccs,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "chan" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chan,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "chan" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chan,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "chan" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chan,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "chanserv" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chanserv,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "chanserv" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chanserv,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "chanserv" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chanserv,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "chat" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chat,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "chat" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chat,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "chat" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,chat,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "exempt" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,exempt,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "exempt" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,exempt,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "exempt" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,exempt,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "ignore" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ignore,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "ignore" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ignore,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "ignore" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,ignore,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "invite" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,invite,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "lang" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,lang,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "lang" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,lang,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "link" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,link,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "link" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,link,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "link" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,link,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "mode" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,mode,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "mode" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,mode,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "mode" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,mode,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "regban" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,regban,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "regban" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,regban,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "say" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,say,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "say" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,say,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "say" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,say,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "system" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,system,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "system" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,system,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "system" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,system,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "traf" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,traf,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "traf" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,traf,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "traf" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,traf,ru) 0

	################################################################################################
	# ���������, ���������� �������� ����� "en" ��� ������ "users" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,users,en) 0

	################################################################################################
	# ���������, ���������� �������� ����� "pod" ��� ������ "users" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,users,pod) 0

	################################################################################################
	# ���������, ���������� �������� ����� "ru" ��� ������ "users" (0 - ���������, 1 - ��������)
	#set ccs(lang,name,users,ru) 0
