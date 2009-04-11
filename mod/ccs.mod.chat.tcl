##################################################################################################################
## ������ ��� ������ DCC �������� �� ����. �� ������� vindi ;)
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chat"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"������ DCC ���������� ���� � ��������."

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# ���� �� �������� ����� ������������� DCC �������. ���� ���� 0, �� ����� ������������� ����� �������� ������
	set ccs(dccport)		0
	
	#############################################################################################################
	# IP �����, ����� ������� ����� ������������� �������, ���� ���� �������� ������ IP ����� ����� ������� ��
	# �������
	set ccs(dccip)			""
	
	cconfigure chat -add 1 -group "other" -flags {p} -block 5 -usechan 0 \
		-alias {%pref_chat} \
		-regexp {{^$} {}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,traf,en,#101) "Stats about \002%s\002 not found. Valid group are: \002IRC, BotNet, Partyline, Transfer, Misc, Total."
	
	proc cmd_chat {} {
		importvars [list onick ochan obot snick shand schan command]
		variable ccs
		
		set port $ccs(dccport)
		if {$port == 0} {
			foreach _ [dcclist] {
				if {[lindex $_ 3] == "TELNET"} {
					set port [string trim [string map [list lstn ""] [lindex $_ 4]]]
					break
				}
			}
		}
		if {$port == 0} {put_msg [sprintf chat #101];return 0}
		
		if {$ccs(dccip) == ""} {set ip [myip]} else {set ip $ccs(dccip)}
		
		putserv "PRIVMSG $snick :\001DCC CHAT chat $ip $port\001"
		
	}
	
}