if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]"; return}
##################################################################################################################
# ������ ���� ���� ��������� � ccs.tcl � �� ������� ��������������� �����������, ��� �� �� ��������
# ������������. �������� ����� ���������� �������������, ������ �� �������� ccs.tcl
# ������ ������������ ��������� ���������� ��������� ��������. �� ���� �� ���� ����� ���������� � ���������
# ��������� ���������� ������� ��� ���������� ��� ������. ��� �� ����� ������ � ��� ������ ���� ���� �����������
# ���������, ���� ���������, �������.
# �� ��������� ��� ������� ����������������, ���� ���������� �������� �����, �� �������� ������� � ���� �����
# ����������� "#", � �������� �� �������.
##################################################################################################################
# �������� ������� ����� ���������� ����� �������� ������� � �� �������� ��������. � ������ �����
# ����� �������������� ����� ���� ��������� ��� ���������� �������, ���� ��������� �������� ����� ���� ��������.
##################################################################################################################


	#############################################################################################################
	# ���������, ���������� �������� ������� "whoisip" (0 - ���������, 1 - ��������)
	#set ccs(scr,name,whoisip) 0
	
	
	#############################################################################################################
	# ��������� ������ ban                                                                                      #
	#############################################################################################################
	
	#############################################################################################################
	# ���������� � ������� ���� ����/����� ������ ����. (0 - ���, 1 - ��)
	#set ccs(bandate)		1
	
	#############################################################################################################
	# ��������� ��� ������ ���� ������� ������� ����, ��� �������� ���.
	#   0 - ����� ��� ����� ����� ��� ������� ����
	#   1 - ����� ��� ����� ����� ������� � ������� ������� ������������ ��� ��� ��������
	#   2 - ����� ��� ����� ������� ����������� ��� ��� � �������� �������
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-unban_level
	#set ccs(unban_level)	0
	
	#############################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� �����. �������� ����� ����
	# �������������� ������������ ���������� ����� ccs-banmask.
	# ��������� ��������:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#set ccs(banmask)		4
	
	
	#############################################################################################################
	# ��������� ������ base                                                                                     #
	#############################################################################################################
	
	#############################################################################################################
	# ���������� � ��������� ���� ������������ ��������� �������. (0 - ���, 1 - ��). �������� ����� ����
	# �������������� ������������ ���������� ����� ccs-vkickuser
	#set ccs(vkickuser)			0
	
	#############################################################################################################
	# ���������� ��� ����� ������ ������������ ��������� �������. (0 - ���, 1 - ��). �������� ����� ����
	# �������������� ������������ ���������� ����� ccs-vtopicuser
	#set ccs(vtopicuser)			1
	
	
	#############################################################################################################
	# ��������� ������ bots                                                                                     #
	#############################################################################################################
	
	#############################################################################################################
	# ��������� ����� ������� � ���� ������ (1 - ���������, 0 - ���������). �� ������������� �������� ��� �����
	# ��� ������������ �� ������� �������� �� ������ � ��� ������� ��������.
	#set ccs(botnettree)			1
	
	#############################################################################################################
	# ����� � �������������, ���������� �������� ������ �����������.
	#set ccs(time_botauth_check)		900000
	
	#############################################################################################################
	# ����� � �������������, � ������� �������� ����� ������ �� ���� ��� �������� �����������.
	#set ccs(time_botauth_receive)	10000
	
	
	#############################################################################################################
	# ��������� ������ chan                                                                                     #
	#############################################################################################################
	
	#############################################################################################################
	# ���� � ����� ������ ���������� �������� �������. %s � ����� ����� ������� �� ��� ��������.
	#set ccs(chansetfile)		"$ccs(datadir)/ccs.chanset.%s.dat"
	
	#############################################################################################################
	# ���� � ����� ������ ���������� �������� �������� �������. %s � ����� ����� ������� �� ��� �������.
	#set ccs(chantemplatefile)	"$ccs(datadir)/ccs.chantemplate.%s.dat"
	
	#############################################################################################################
	# ��������� ������ ����� �������� � bak ���������� (1 - ��, 0 - ���)
	#set ccs(bakchanset)		1
	
	
	#############################################################################################################
	# ��������� ������ chanserv                                                                                 #
	#############################################################################################################
	
	#############################################################################################################
	# ������ �������� ���������� ������
	#set ccs(chanserv,op)		"PRIVMSG ChanServ :OP %chan %nick"
	#set ccs(chanserv,deop)		"PRIVMSG ChanServ :DEOP %chan %nick"
	#set ccs(chanserv,hop)		"PRIVMSG ChanServ :HALFOP %chan %nick"
	#set ccs(chanserv,dehop)		"PRIVMSG ChanServ :DEHALFOP %chan %nick"
	#set ccs(chanserv,voice)		"PRIVMSG ChanServ :VOICE %chan %nick"
	#set ccs(chanserv,devoice)	"PRIVMSG ChanServ :DEVOICE %chan %nick"
	
	#set ccs(chanserv,op)		"ChanServ OP %chan %nick"
	#set ccs(chanserv,deop)		"ChanServ DEOP %chan %nick"
	#set ccs(chanserv,hop)		"ChanServ HALFOP %chan %nick"
	#set ccs(chanserv,dehop)		"ChanServ DEHALFOP %chan %nick"
	#set ccs(chanserv,voice)		"ChanServ VOICE %chan %nick"
	#set ccs(chanserv,devoice)	"ChanServ DEVOICE %chan %nick"
	
	
	#############################################################################################################
	# ��������� ������ chat                                                                                     #
	#############################################################################################################
	
	#############################################################################################################
	# ���� �� �������� ����� ������������� DCC �������. ���� ���� 0, �� ����� ������������� ����� �������� ������
	#set ccs(dccport)		0
	
	#############################################################################################################
	# IP �����, ����� ������� ����� ������������� �������, ���� ���� �������� ������ IP ����� ����� ������� ��
	# �������
	#set ccs(dccip)			""
	
	
	#############################################################################################################
	# ��������� ������ exempt                                                                                   #
	#############################################################################################################
	
	#############################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� ����������. �������� �����
	# ���� �������������� ������������ ���������� ����� ccs-exemptmask.
	# ��������� ��������:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#set ccs(exemptmask)		4
	
	
	#############################################################################################################
	# ��������� ������ ignore                                                                                   #
	#############################################################################################################
	
	#############################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� ������. �������� ����� ����
	# �������������� ������������ ���������� ����� ccs-ignoremask.
	# ��������� ��������:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#set ccs(ignoremask)			4
	
	
	#############################################################################################################
	# ��������� ������ invite                                                                                   #
	#############################################################################################################
	
	#############################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� �������. �������� ����� ����
	# �������������� ������������ ���������� ����� ccs-invitemask.
	# ��������� ��������:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#set ccs(invitemask)		4
	
	
	#############################################################################################################
	# ��������� ������ logs                                                                                     #
	#############################################################################################################
	
	#############################################################################################################
	# ��� ����� � ���� ������� �����. �� ��������� � ����� �� �������� � ������ ccs.log
	#set ccs(logsfile)			"$ccs(datadir)/ccs.log"
	
	#############################################################################################################
	# ������������ ������� ���������, ������� ���������� ���������� � ��� ����
	#set ccs(logslevel)			3
	
	
	#############################################################################################################
	# ��������� ������ regban                                                                                   #
	#############################################################################################################
	
	#############################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� �����. �������� ����� ����
	# �������������� ������������ ���������� ����� ccs-banmask.
	# ��������� ��������:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#set ccs(banmask)			4
	
	#############################################################################################################
	# �������, ���� ����� ���������� ������ ����� ����� ����������, ��� ���� �������� $ccs(scrdir) �����
	# ��������������� ��������, ��� ���������� �������� ������.
	#set ccs(regbanfile)			"$ccs(datadir)/ccs.regban.dat"
	
	#############################################################################################################
	# ����� � ������������ � ������� �������� ������� ������������ WHO �������. ������� ������� ����� ������
	# �������� �� ����� �������� ������������ ����������. ������� ��������� �������� ����� ���������� ������ �� 
	# �������.
	#set ccs(regbanwhohash)		10000
	
	
	#############################################################################################################
	# ��������� ������ users                                                                                    #
	#############################################################################################################
	
	#############################################################################################################
	# ��������, ������� ���������� �����, �� ������� ����� ����������� ����� ������������. ������������ ��������
	# ����� � �����, ����� ��, ��� � ��� �������� ����� ����.
	#set ccs(addusermask)		4
	
	#############################################################################################################
	# ��������� �������� ������ �������������� � ���������� ������� � ��� ������, ���� �� ������, �� �������
	# ����������� �����, ����� �� ��������� ��������� ����. �� ���� ���� ���������� .whois ���������� ����� ��
	# ����� ������� ��� �� ��� �� ������������ ������ X ��� ���� ��������� ����� ���������� ������ LAST �� ��
	# ���� ������ � ���� ���������� ����� (� ���� FLAGS ����� "-")
	#set ccs(deluserchanrec)		1
	
	#############################################################################################################
	# ������ ���� ������� �� �������������� ������.
	
	# n - �������� ��� ����� - ������������ � ��������� �������� � ����. ��� �������� ��� ��������� �������.
	#set ccs(flag,global,n)		{}
	#set ccs(flag,local,n)		{n m}
	# m - ������ (master) - ������������, �������� �������� ����� ��� ������� � �������.
	#set ccs(flag,global,m)		{n}
	#set ccs(flag,local,m)		{n|n m}
	# t - ������-������ (botnet-master) - ������������, �������� �������� ������� �������.
	#set ccs(flag,global,t)		{n m}
	# a - ������ (���) (auto-op) - ������������, ������� ����� �������� ������ ��������� ��� ����� �� �����.
	#set ccs(flag,global,a)		{n m}
	#set ccs(flag,local,a)		{n|n m|m}
	# o - �������� (��) (op) - ������������, ������� ������ ��������� �� ���� �������
	#set ccs(flag,global,o)		{n m}
	#set ccs(flag,local,o)		{n|n m|m}
	# y - ���������� (auto-halfop) - ������������, ������� ����� �������� ������ ������� ��� ����� �� �����
	#set ccs(flag,global,y)		{n m o}
	#set ccs(flag,local,y)		{n|n m|m o|o}
	# l - ������ (halfop) - ������������, ������� ������ ������� �� ���� �������.
	#set ccs(flag,global,l)		{n m o}
	#set ccs(flag,local,l)		{n|n m|m o|o}
	# g - �������� (�����) (auto-voice) - ������������, ������� ����� �������� ����� (����) ��� ����� �� �����
	#set ccs(flag,global,g)		{n m o l}
	#set ccs(flag,local,g)		{n|n m|m o|o l|l}
	# v - ����� (����) (voice) - ������������, ������� ����� �������� ����� (����) �� ������� +autovoice
	#set ccs(flag,global,v)		{n m o l}
	#set ccs(flag,local,v)		{n|n m|m o|o l|l}
	# f - ���� (friend) - ������������, ������� �� ����� ������ �� ���� � �.�.
	#set ccs(flag,global,f)		{n m o l}
	#set ccs(flag,local,f)		{n|n m|m o|o l|l}
	# p - �������� (party) - ������������, � �������� ���� ������ � �������� (DCC)
	#set ccs(flag,global,p)		{n}
	# q - ����� (quiet) - ������������, ������� �� ����� �������� ����� (����) �� ������� +autovoice
	#set ccs(flag,global,q)		{n m o l}
	#set ccs(flag,local,q)		{n|n m|m o|o l|l}
	# r - �������� (dehalfop) - ������������, �������� ������ ����� ������ �������. ������ ����� ��������� �������������.
	#set ccs(flag,global,r)		{n m o}
	#set ccs(flag,local,r)		{n|n m|m o|o}
	# d - ���� (deop) - ������������, �������� ������ ����� ������ ��������� (���). ������ ����� ��������� �������������.
	#set ccs(flag,global,d)		{n m}
	#set ccs(flag,local,d)		{n|n m|m}
	# k - ������� (����) (auto-kick) - ������������ ����� ������������� ������ � ������� ��� ������ �� �����
	#set ccs(flag,global,k)		{n m}
	#set ccs(flag,local,k)		{n|n m|m}
	# x - �������� ������ (xfer) - ������������, �������� ��������� ����������/��������� �����.
	#set ccs(flag,global,x)		{n m}
	# j - (janitor) ������������, ������� ����� ������ ������ � �������� �������. ������ filesystem
	#set ccs(flag,global,j)		{n m}
	# c - (common) ������������, ������� ����� � IRC � ���������� �����, � �������� ��������� �������������. �������� � ���� ������������� ���� *!some@some.host.dom ������������ ����� ������������������ �� ����.
	#set ccs(flag,global,c)		{n m}
	# w (wasop-test) ������������, ��� �������� ����������� ���� ��������� ��� �� �� ���� �� ������ ��� +stopnethack �������
	#set ccs(flag,global,w)		{n m}
	#set ccs(flag,local,w)		{n|n m|m}
	# z (washalfop-test) ������������, ��� �������� ����� ���������, ��� �� �� �������� �� ������ ��� +stopnethack �������
	#set ccs(flag,global,z)		{n m}
	#set ccs(flag,local,z)		{n|n m|m}
	# e (nethack-exempt) ������������, �������� �� ����� ��������� ��� stopnethack ���������
	#set ccs(flag,global,e)		{n m}
	#set ccs(flag,local,e)		{n|n m|m}
	# u - �� ������ (unshared) - ���������������� ������ �� ����� ������������ �� ������� ���� ������� ������.
	#set ccs(flag,global,u)		{n m t}
	# h - ��������� (highlight) - ������������, ��� �������� ����� �������������� ���� � ������
	#set ccs(flag,global,h)		{n m}
	
	#set ccs(flag,global,Q)		{n}
	#set ccs(flag,global,B)		{n}
	#set ccs(flag,global,P)		{n}
	#set ccs(flag,global,L)		{n}
	#set ccs(flag,global,H)		{n}
	#set ccs(flag,local,H)		{n}














