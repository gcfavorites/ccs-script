if {[namespace current] == "::"} {putlog "\002\00304You shouldn't do just source [info script]"; return}
##################################################################################################################
# This file goes along with the main css.tcl file and loaded automatically if exist in the same folder where 
# css.tcl is (tho this file is not required by script itself).
# File contain so-called "first-set-of-script-settings" and it's main goal to make CCS settings system much
# simplier and easier. So, for example, when you did a script update all your settings will no be lost, because
# they is stored in the custom file and not in the script file body itself. Also, it is pretty useful for your
# own procedures, commands, etc (and main file stays untouched and unmodified).
# By default, every option is commented, so, if you want to change the value you need to uncomment it (by removing
# symbol '#' before directive).
##################################################################################################################
# Note that this settings template is loaded AFTER ccs-modules, custom ccs-scripts, css-libs and languages.
# So, that's allow you to customize some settings of the script (like ops privs and auth methods, etc).
##################################################################################################################
# !!! Do not forget to rename this template-file in to ccs.rc1.tcl (so, you need just remove "-template-EN"
# part from the filename) !!!
##################################################################################################################


# List of the commands params (#cmd_configure):
#
# -group
#   binds command availability to specified group (string);
#
# -use
#   enable/disable command (1 - enable, 0 - disable, default value 1
#   even if parameter is not defined);
#
# -use_auth
#   command usage requires authenfication (1 - enable, 0 - disable,
#   defaul value 1 even if parameter is not defined);
#
# -use_chan
#   defines that command will use channel name for some operations (public usage).
#   If command with -use_chan flag used via PM it will ask to specify a channel name
#   (defaul value 1 even if parameter is not defined);
#      0 - channel name is not used;
#      1 - channel name required;
#      2 - channel name or "*" required;
#      3 - channel name is not required;
#
# -flags
#   ����� ������� � �������. ���� ����� ����������� ����� ������������ �����, ��� ����� ��������
#   ����������� �������, ��� ��� ���������� �������������, ��� � ��� ���������. ���� �� ����
#   ����������� ����� ������, �� ������������ ������� ������ ������ ������������ � ����������
#   �������. (�������������� �����: %v - ��� ���� ������������ ������ �������������� � ��������);
#
# -alias
#   ������ ������ �� ������� ��� ����� ����������� ��� ������������� ������ ������� "%pref_" �����
#   �������� �� ������� �� ���������.
#
# -block
#   �������������� �������� ���������� ������������� ������� �� �������. �������� ����� � ��������,
#   ����� ������� ����� �������� ��������� ���������� �������.
#
# -regexp
#   ���������� ���������, ���������� ������ � ���������� �������������� ���������
#
# -override_level
#   ��������������� ������ ������� ����� ��� ���������� �������. ���� � ����� �� ������� ����
#   (������: � ������ ���� ��� ������� �������� �������� ����), �� ���� ��������� ����� �������
#   ������� ������� ������������. ������ ����������� ������� ���� ����������� ������������ �������:
#      0 - ���� ������� ����
#      1 - ��������� ���� l
#      2 - ��������� ���� o
#      3 - ��������� ���� m
#      4 - ��������� ���� n
#      5 - ���������� ���� l
#      6 - ���������� ���� o
#      7 - ���������� ���� m
#      8 - ���������� ���� n
#      9 - ������������ ����� ("set owner" � �������)
#   �� ������������� ���������� �������� ����� ��������� ������ ������ ������� �� ������ ����������
#   � ��������� -flags
####################################################################################################
# ��������� �������� ���������:
#      1: *!user@host
#      2: *!*user@host
#      3: *!*@host
#      4: *!*user@*.host
#      5: *!*@*.host
#      6: nick!user@host
#      7: nick!*user@host
#      8: nick!*@host
#      9: nick!*user@*.host
#     10: nick!*@*.host
####################################################################################################


	################################################################################################
	# �������� ���������                                                                           #
	################################################################################################
	
	################################################################################################
	# �������� ��� ������ ����������. pub - �����, msg - ������, dcc - ��������.
	# ������������� �������� "." ��� ��������� �� ��������.
	configure -prefix_pub				"$"
	configure -prefix_msg				"."
	configure -prefix_dcc				"."
	
	################################################################################################
	# �������� ��� ������ ���������� ������������ ����� �������. pub - �����, msg - ������,
	# dcc - ��������. !��������! ������� ��� ��������� �� ����� ���������. ���� ���� ��������
	# �������, �� ������� �� ����� ���������. ������������� �������� "." ��� ��������� �� ��������.
	#configure -prefix_botnet_pub		"!!"
	#configure -prefix_botnet_msg		"!!"
	#configure -prefix_botnet_dcc		"!!"
	
	################################################################################################
	# ������ ������ �� ��������� ��� ���������� ������. �������� ����� ���� ��������������
	# ������������ ���������� ����� ccs-default_lang � ���������� ������������. ������ �������� �
	# ������ ����� ���������� ���������, ��������� - ����������.
	configure -default_lang				{en ru}
	
	################################################################################################
	# ����, �������������� ������� ����� � ������ � ���������. �������� ��� ������� ����� +F ��
	# ����, ����� ��� ����� �������� �� ���� (0 - ��������, 1 - ������).
	configure -fast						0
	
	################################################################################################
	# ������������ ���������� ����� ���������� �������, ��� ���������� ������� �������� ���������
	# ����� ���������� � ������
	configure -max_notice				10
	
	################################################################################################
	# ����� ������ ��������� � ���������� ��������. ���� ��������� ����� ��������� �����������
	# ���������� ��� IRCd, �� ��� ����� ��������� �� ��������� ���������.
	configure -msg_len					400
	
	################################################################################################
	# ������������ ����� ������ � IRC ����. ����� ��� ��������� ���������� ��������� ����.
	configure -identlen					10
	
	################################################################################################
	# ��������� ����� ����� ������ �� ������� (1 - ������ �� �������, 0 - ����� � �� �������)
	configure -help_group				0
	
	################################################################################################
	# ������� ������� (1 - ����� �������� ����������; 2, 3, ... - ����� �������������� ����������)
	configure -debug					2
	
	################################################################################################
	# �������� �� ���������, ������� ����������, ������ �� ������ �������� �� ���� ������� (0 - ���,
	# 1 - ��). �������� ����� ���� �������������� ������������ ���������� ����� ccs-on_chan
	configure -on_chan					1
	
	################################################################################################
	# �������� �� ���������, ������� ���������� ����� �������� �����, ��� �� �������, ������
	# �������������� ��� ������. (0 - ����� �����, 1 - �������). ��� �� �������� ���������� �����
	# �������� ����� ������ �������������� ��� ������ ������ � ������ � ��������. �������� �����
	# ���� �������������� ������������ ���������� ����� ccs-usecolors
	configure -usecolors				1
	
	################################################################################################
	# ����� � �������������, � ������� �������� ���������� ����������� �����, ���� �� �� ����� ��
	# ����� ����� �����������.
	configure -time_auth_notonchan		300000
	
	################################################################################################
	# ����� � �������������, � ������� �������� ���������� ����������� ����� ����� ��������� ������.
	configure -time_auth_part			3000
	
	################################################################################################
	# �������, ���� ����� ���������� ������ ����� ����� ����������, ��� ���� �������� $dir_ccs �����
	# ��������������� ��������, ��� ���������� �������� ������.
	configure -dir_bak					"$dir_ccs/bak"
	
	################################################################################################
	# �������, ������ ����� �������� ����� ccs.lang.*.tcl, ��� ���� �������� $dir_ccs �����
	# ��������������� ��������, ��� ���������� �������� ������.
	configure -dir_lang					"$dir_ccs/lang"
	
	################################################################################################
	# �������, ������ ����� �������� ����� ccs.mod.*.tcl, ��� ���� �������� $dir_ccs �����
	# ��������������� ��������, ��� ���������� �������� ������.
	configure -dir_mod					"$dir_ccs/mod"
	
	################################################################################################
	# �������, ������ ����� �������� ����� ccs.scr.*.tcl, ��� ���� �������� $dir_ccs �����
	# ��������������� ��������, ��� ���������� �������� ������.
	configure -dir_scr					"$dir_ccs/scr"
	
	################################################################################################
	# �������, ������ ����� �������� ����� ccs.lib.*.tcl, ��� ���� �������� $dir_ccs �����
	# ��������������� ��������, ��� ���������� �������� ������.
	configure -dir_lib					"$dir_ccs/lib"
	
	################################################################################################
	# �������, ��� ����� �������� ����� ������, ��� ���� �������� $dir_ccs ����� ���������������
	# ��������, ��� ���������� �������� ������.
	configure -dir_data					"$dir_ccs/data"
	
	################################################################################################
	# ����� �������������. ������ �� ���������� �������� ��.
	# ���� ����������� �� ��������������� ������������
	configure -flag_auth				"Q"
	# ���� ����������� �� ��������������� ������������ ����� ������
	configure -flag_auth_botnet			"B"
	# ��������� ����, ����������� �� �������� ����������� ������������ ����� ������
	configure -flag_botnet_check		"O"
	# ������������ (����������) �����������, �� ��������� ������ �����������
	configure -flag_auth_perm			"P"
	# ���� ������ ������������ �� ���������, ������ ���������� ����� ������ �������� ���������
	# ������������ (�����, �����)
	configure -flag_locked				"L"
	# ���� ������ ������������ �� ������������� �������� (kick, ban ���). (�� ���� ������ ������,
	# � ������ ���� �������� ������������� �� �� ������)
	configure -flag_protect				"H|H"
	# ���� ��� ����� ����������� � ������� (�������� ������ ����������) ����� �������
	configure -flag_cmd_bot				"U"
	
	################################################################################################
	# ����������� ���� ������� � ��������� �������.
	configure -permission_secret_chan	"m|-"
	
	#cmd_configure update -group "system" -flags {n} -block 5 -alias {%pref_updateccs %pref_ccsupdate}
	#cmd_configure help -group "info" -use_botnet 0 -block 3 -flags {%v} -alias {%pref_helps}
	
	
	################################################################################################
	# ��������� ������ ban                                                                         #
	################################################################################################
	
	################################################################################################
	# ���������� � ������� ���� ����/����� ������ ����. (0 - ���, 1 - ��)
	configure -bandate					1
	
	################################################################################################
	# ��������� ��� ������ ���� ������� ������� ����, ��� �������� ���.
	#   0 - ����� ��� ����� ����� ��� ������� ����
	#   1 - ����� ��� ����� ����� ������� � ������� ������� ������������ ��� ��� ��������
	#   2 - ����� ��� ����� ������� ����������� ��� ��� � �������� �������
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-unban_level
	configure -unban_level				0
	
	################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� �����.
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-banmask.
	configure -banmask					4
	
	#cmd_configure ban -group "ban" -flags {o|o} -block 1 -alias {%pref_ban}
	#cmd_configure unban -group "ban" -flags {o|o} -block 1 -alias {%pref_unban}
	#cmd_configure gban -group "ban" -flags {o} -block 1 -alias {%pref_gban}
	#cmd_configure gunban -group "ban" -flags {o} -block 1 -alias {%pref_gunban}
	#cmd_configure banlist -group "ban" -flags {o|o} -block 3 -alias {%pref_banlist %pref_bans}
	#cmd_configure resetbans -group "ban" -flags {o|o} -block 5 -alias {%pref_resetbans}
	
	
	################################################################################################
	# ��������� ������ base                                                                        #
	################################################################################################
	
	################################################################################################
	# ���������� � ��������� ���� ������������ ��������� �������. (0 - ���, 1 - ��).
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-vkickuser
	configure -vkickuser				0
	
	################################################################################################
	# ���������� ��� ����� ������ ������������ ��������� �������. (0 - ���, 1 - ��).
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-vtopicuser
	configure -vtopicuser				1
	
	#cmd_configure kick -group "mode" -flags {o|o} -block 1 -alias {%pref_kick}
	#cmd_configure inv -group "other" -flags {m|m} -block 5 -alias {%pref_inv}
	#cmd_configure topic -group "chan" -flags {o|o T|T} -block 3 -alias {%pref_topic}
	#cmd_configure addtopic -group "chan" -flags {o|o T|T} -block 5 -alias {%pref_addtopic %pref_��������}
	#cmd_configure ops -group "info" -flags {-|-} -block 5 -use_botnet 0 -alias {%pref_ops}
	#cmd_configure admins -group "info" -flags {-|-} -block 5 -use_botnet 0 -alias {%pref_admins}
	#cmd_configure whom -group "info" -flags {p} -block 5 -use_botnet 0 -alias {%pref_whom}
	#cmd_configure whois -group "user" -flags {%v} -block 2 -alias {%pref_whois}
	#cmd_configure info -group "info" -flags {%v} -block 5 -alias {%pref_info}
	
	
	################################################################################################
	# ��������� ������ bots                                                                        #
	################################################################################################
	
	################################################################################################
	# ��������, ������� ���������� �����, �� ������� ����� ����������� ����� ����.
	configure -addbotmask				4
	
	################################################################################################
	# ��������� ����� ������� � ���� ������ (1 - ���������, 0 - ���������). �� �������������
	# �������� ��� ����� ��� ������������ �� ������� �������� �� ������ � ��� ������� ��������.
	configure -botnettree				0
	
	################################################################################################
	# ����� � �������������, ���������� �������� ������ �����������.
	configure -time_botauth_check		900000
	
	################################################################################################
	# ����� � �������������, � ������� �������� ����� ������ �� ���� ��� �������� �����������.
	configure -time_botauth_receive		10000
	
	################################################################################################
	# ���������, � ������� ����� ������������/����������� ��������� ����� ������, ��������� ���
	# �������������, ���� � ������� ���� �������� � ������ ���������. UTF �� ��������������.
	configure -botnet_encoding			""
	
	################################################################################################
	# ����� ���� ����������� ���������. ���������� ��� ���� ����� ����������� ���������� ���������
	# �� ��������������. � ������ ���� ������ ���������� ������������ ����� ����� (� �������
	# ��������� ������ ��������� ���������� ���������), ������� ��������� ��� ��������.
	configure -botnet_lencode			3
	
	################################################################################################
	# ����� ������ ������ ��������� ����������� ����� ������.
	configure -botnet_lensend			300
	
	################################################################################################
	# ������������ ���������� ����������/�������� ������� ��� ������ ���������. �������������
	# ������������ ������.
	configure -botnet_maxsend			100
	
	################################################################################################
	# ����� � ������������� � ������� �������� ������� ������� ��������� �� �������.
	configure -botnet_timesend		5000
	
	#cmd_configure bots -group "botnet" -flags {%v} -block 5 -use_botnet 0 -alias {%pref_bots}
	#cmd_configure botattr -group "botnet" -flags {mt} -block 2 -alias {%pref_botattr}
	#cmd_configure chaddr -group "botnet" -flags {mt} -block 2 -alias {%pref_chaddr}
	#cmd_configure addbot -group "botnet" -flags {mt} -block 3 -alias {%pref_addbot}
	#cmd_configure delbot -group "botnet" -flags {mt} -block 3 -alias {%pref_delbot}
	#cmd_configure chbotpass -group "botnet" -flags {mt} -block 3 -alias {%pref_chbotpass}
	#cmd_configure listauth -group "botnet" -flags {mt} -block 3 -alias {%pref_listauth}
	#cmd_configure addauth -group "botnet" -flags {mt} -block 3 -alias {%pref_addauth}
	#cmd_configure delauth -group "botnet" -flags {mt} -block 3 -alias {%pref_delauth}
	
	
	################################################################################################
	# ��������� ������ chan                                                                        #
	################################################################################################
	
	################################################################################################
	# ���� � ����� ������ ���������� �������� �������. %s � ����� ����� ������� �� ��� ��������.
	configure -chansetfile				"$options(dir_data)/ccs.chanset.%s.dat"
	
	################################################################################################
	# ���� � ����� ������ ���������� �������� �������� �������. %s � ����� ����� ������� �� ���
	# �������.
	configure -chantemplatefile			"$options(dir_data)/ccs.chantemplate.%s.dat"
	
	################################################################################################
	# ��������� ������ ����� �������� � bak ���������� (1 - ��, 0 - ���)
	configure -bakchanset				1
	
	#cmd_configure channels -group "chan" -flags {o|o} -block 5 -alias {%pref_channels}
	#cmd_configure chanadd -group "chan" -flags {n} -block 3 -alias {%pref_chanadd %pref_addchan}
	#cmd_configure chandel -group "chan" -flags {n} -block 3 -alias {%pref_chandel %pref_delchan}
	#cmd_configure rejoin -group "chan" -flags {m|m} -block 3 -alias {%pref_rejoin}
	#cmd_configure chanset -group "chan" -flags {n|n} -block 1 -alias {%pref_set %pref_chanset}
	#cmd_configure chaninfo -group "chan" -flags {n|n} -block 5 -alias {%pref_chaninfo}
	#cmd_configure chansave -group "chan" -flags {n|n} -block 5 -alias {%pref_chansave}
	#cmd_configure chanload -group "chan" -flags {n|n} -block 5 -alias {%pref_chanload}
	#cmd_configure chancopy -group "chan" -flags {n|n} -block 5 -alias {%pref_chancopy}
	#cmd_configure chantemplateadd -group "chan" -flags {n|n} -block 5 -alias {%pref_templateadd}
	#cmd_configure chantemplatedel -group "chan" -flags {n|n} -block 5 -alias {%pref_templatedel}
	#cmd_configure chantemplatelist -group "chan" -flags {n|n} -block 5 -alias {%pref_templatelist}
	
	
	################################################################################################
	# ��������� ������ chanserv                                                                    #
	################################################################################################
	
	################################################################################################
	# ������ �������� ���������� ������
	#set chanserv(op)		"PRIVMSG ChanServ :OP %chan %nick"
	#set chanserv(deop)		"PRIVMSG ChanServ :DEOP %chan %nick"
	#set chanserv(hop)		"PRIVMSG ChanServ :HALFOP %chan %nick"
	#set chanserv(dehop)		"PRIVMSG ChanServ :DEHALFOP %chan %nick"
	#set chanserv(voice)		"PRIVMSG ChanServ :VOICE %chan %nick"
	#set chanserv(devoice)	"PRIVMSG ChanServ :DEVOICE %chan %nick"
	
	#set chanserv(op)		"ChanServ OP %chan %nick"
	#set chanserv(deop)		"ChanServ DEOP %chan %nick"
	#set chanserv(hop)		"ChanServ HALFOP %chan %nick"
	#set chanserv(dehop)		"ChanServ DEHALFOP %chan %nick"
	#set chanserv(voice)		"ChanServ VOICE %chan %nick"
	#set chanserv(devoice)	"ChanServ DEVOICE %chan %nick"
	
	#cmd_configure csop -group "chanserv" -flags {o|o} -block 1 -alias {%pref_csop}
	#cmd_configure csdeop -group "chanserv" -flags {o|o} -block 1 -alias {%pref_csdeop}
	#cmd_configure cshop -group "chanserv" -flags {l|l} -use 0 -block 1 -alias {%pref_cshop}
	#cmd_configure csdehop -group "chanserv" -flags {l|l} -use 0 -block 1 -alias {%pref_csdehop}
	#cmd_configure csvoice -group "chanserv" -flags {v|v o|o} -block 1 -alias {%pref_csvoice}
	#cmd_configure csdevoice -group "chanserv" -flags {v|v o|o} -block 1 -alias {%pref_csdevoice}
	
	
	################################################################################################
	# ��������� ������ chat                                                                        #
	################################################################################################
	
	################################################################################################
	# ���� �� �������� ����� ������������� DCC �������. ���� ���� 0, �� ����� ������������� �����
	# �������� ������
	configure -dccport					4321
	
	################################################################################################
	# IP �����, ����� ������� ����� ������������� �������, ���� ���� �������� ������ IP ����� �����
	# ������� �� �������
	#configure -dccip					""
	
	#cmd_configure chat -group "other" -flags {p} -block 5 -alias {%pref_chat}
	
	
	################################################################################################
	# ��������� ������ exempt                                                                      #
	################################################################################################
	
	################################################################################################
	# ���������� � ������� ����/����� ������ ����������. (0 - ���, 1 - ��)
	configure -exemptdate				1
	
	################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� ����������.
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-exemptmask.
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
	configure -exemptmask				4
	
	#cmd_configure exempt -group "exempt" -flags {o|o} -block 1 -alias {%pref_exempt}
	#cmd_configure unexempt -group "exempt" -flags {o|o} -block 1 -use_botnet 0 -alias {%pref_unexempt}
	#cmd_configure gexempt -group "exempt" -flags {o} -block 1 -alias {%pref_gexempt}
	#cmd_configure gunexempt -group "exempt" -flags {o} -block 1 -alias {%pref_gunexempt}
	#cmd_configure exemptlist -group "exempt" -flags {o|o} -block 5 -alias {%pref_exemptlist %pref_exempts}
	#cmd_configure resetexempts -group "exempt" -flags {o|o} -block 5 -alias {%pref_resetexempts}
	
	
	################################################################################################
	# ��������� ������ ignore                                                                      #
	################################################################################################
	
	################################################################################################
	# ���������� � ������� ����/����� ������ ������. (0 - ���, 1 - ��)
	configure -ignoredate				1
	
	################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� ������.
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-ignoremask.
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
	configure -ignoremask				4
	
	#cmd_configure addignore -group "other" -flags {o} -block 3 -alias {%pref_addignore %pref_+ignore}
	#cmd_configure delignore -group "other" -flags {o} -block 1 -alias {%pref_delignore %pref_-ignore}
	#cmd_configure ignorelist -group "other" -flags {m} -block 3 -alias {%pref_ignorelist %pref_ignores}
	
	
	################################################################################################
	# ��������� ������ invite                                                                      #
	################################################################################################
	
	################################################################################################
	# ���������� � ������� ����/����� ������ �������. (0 - ���, 1 - ��)
	configure -invitedate				1
	
	################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� �������.
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-invitemask.
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
	configure -invitemask				4
	
	#cmd_configure invite -group "invite" -flags {o|o} -block 1 -alias {%pref_invite}
	#cmd_configure uninvite -group "invite" -flags {o|o} -block 1 -alias {%pref_uninvite}
	#cmd_configure ginvite -group "invite" -flags {o} -block 1 -alias {%pref_ginvite}
	#cmd_configure guninvite -group "invite" -flags {o} -block 1 -alias {%pref_guninvite}
	#cmd_configure invitelist -group "invite" -flags {o|o} -block 3 -alias {%pref_invitelist %pref_invites}
	#cmd_configure resetinvites -group "invite" -flags {o|o} -block 5 -alias {%pref_resetinvites}
	
	
	################################################################################################
	# ��������� ������ lang                                                                        #
	################################################################################################
	
	#cmd_configure langlist -group "lang" -flags {%v} -block 3 -alias {%pref_langlist}
	#cmd_configure chansetlang -group "lang" -flags {m|m} -block 3 -alias {%pref_chansetlang}
	#cmd_configure chlang -group "lang" -flags {m} -block 3 -alias {%pref_chlang}
	
	
	################################################################################################
	# ��������� ������ link                                                                        #
	################################################################################################
	
	#cmd_configure link -group "botnet" -flags {nt} -block 5 -alias {%pref_link}
	#cmd_configure unlink -group "botnet" -flags {nt} -block 5 -alias {%pref_unlink %pref_dellink}
	
	
	################################################################################################
	# ��������� ������ logs                                                                        #
	################################################################################################
	
	################################################################################################
	# ��� ����� � ���� ������� �����. �� ��������� � ����� �� �������� � ������ ccs.log
	configure -logsfile					"$options(dir_data)/ccs.log"
	
	################################################################################################
	# ������������ ������� ���������, ������� ���������� ���������� � ��� ����
	configure -logslevel				3
	
	
	################################################################################################
	# ��������� ������ mode                                                                        #
	################################################################################################
	
	#cmd_configure op -group "mode" -flags {o|o} -block 1 -alias {%pref_op}
	#cmd_configure deop -group "mode" -flags {o|o} -block 1 -alias {%pref_deop}
	#cmd_configure hop -group "mode" -flags {l|l} -use 0 -block 1 -alias {%pref_hop}
	#cmd_configure dehop -group "mode" -flags {l|l} -use 0 -block 1 -alias {%pref_dehop}
	#cmd_configure voice -group "mode" -flags {v|v o|o} -block 1 -alias {%pref_voice}
	#cmd_configure devoice -group "mode" -flags {v|v o|o} -block 1 -alias {%pref_devoice}
	#cmd_configure allvoice -group "mode" -flags {m|m} -block 5 -alias {%pref_allvoice}
	#cmd_configure alldevoice -group "mode" -flags {m|m} -block 1 -alias {%pref_alldevoice}
	#cmd_configure mode -group "mode" -flags {o|o} -alias {%pref_mode}
	
	
	################################################################################################
	# ��������� ������ rebind                                                                      #
	################################################################################################
	
	################################################################################################
	# ��������, ��������������, ��������������� ����������� ��������� ������ ����.
	#          -1 - �������� ������������ �����;
	#           1 - �������������� ������������ �����;
	#         ��� - �������� ������������ ����� � �������� ������ � ���������������� ������;
	#  n/a(�����) - �� ������� ����.
	set rebind(addhost)	"1"
	#set rebind(die)	"-1"
	#set rebind(go)		"-1"
	set rebind(hello)	"-1"
	#set rebind(help)	"-1"
	#set rebind(ident)	"1"
	#set rebind(info)	"-1"
	#set rebind(invite)	"-1"
	#set rebind(jump)	"-1"
	#set rebind(key)	"-1"
	#set rebind(memory)	"-1"
	#set rebind(op)		"-1"
	#set rebind(halfop)	"-1"
	set rebind(pass)	""
	#set rebind(rehash)	"-1"
	#set rebind(reset)	"-1"
	#set rebind(save)	"-1"
	#set rebind(status)	"-1"
	#set rebind(voice)	"-1"
	#set rebind(who)	"-1"
	#set rebind(whois)	"-1"
	
	
	################################################################################################
	# ��������� ������ regban                                                                      #
	################################################################################################
	
	################################################################################################
	# �������� �� ���������, ������� ���������� ����� �� ��������� ��� ����������� �����.
	# �������� ����� ���� �������������� ������������ ���������� ����� ccs-banmask.
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
	configure -banmask					4
	
	################################################################################################
	# �������, ���� ����� ���������� ������ ����� ����� ����������, ��� ���� ��������
	# $options(dir_data) ����� ��������������� ��������, ��� ���������� �������� ������.
	configure -regbanfile				"$options(dir_data)/ccs.regban.dat"
	
	################################################################################################
	# ����� � ������������ � ������� �������� ������� ������������ WHO �������. ������� �������
	# ����� ������ �������� �� ����� �������� ������������ ����������. ������� ��������� ��������
	# ����� ���������� ������ �� �������.
	configure -regbanwhohash			10000
	
	#cmd_configure regbanlist -group "regban" -flags {o} -block 3 -alias {%pref_regbanlist}
	#cmd_configure regban -group "regban" -flags {o} -block 3 -alias {%pref_regban %pref_addregban %pref_regbanadd}
	#cmd_configure regunban -group "regban" -flags {o} -block 3 -alias {%pref_regunban %pref_delregban %pref_unregban %pref_regbandel}
	#cmd_configure regbantest -group "regban" -flags {o} -block 5 -alias {%pref_regbantest %pref_testregban}
	#cmd_configure regbanaction -group "regban" -flags {o} -block 5 -alias {%pref_regbanaction %pref_actionregban}
	
	
	################################################################################################
	# ��������� ������ say                                                                         #
	################################################################################################
	
	#cmd_configure broadcast -group "other" -flags {o} -block 10 -alias {%pref_broadcast}
	#cmd_configure say -group "other" -flags {m} -block 3 -alias {%pref_say}
	#cmd_configure msg -group "other" -flags {m} -block 3 -alias {%pref_msg}
	#cmd_configure act -group "other" -flags {m} -block 3 -alias {%pref_act}
	
	
	################################################################################################
	# ��������� ������ system                                                                      #
	################################################################################################
	
	#cmd_configure servers -group "system" -flags {m} -block 5 -alias {%pref_servers}
	#cmd_configure addserver -group "system" -flags {m} -block 1 -alias {%pref_addserver}
	#cmd_configure delserver -group "system" -flags {m} -block 1 -alias {%pref_delserver}
	#cmd_configure save -group "system" -flags {m} -block 3 -alias {%pref_save}
	#cmd_configure reload -group "system" -flags {m} -block 3 -alias {%pref_reload}
	#cmd_configure backup -group "system" -flags {m} -block 3 -alias {%pref_backup}
	#cmd_configure die -group "system" -flags {n} -use_chan 0 -alias {%pref_die}
	#cmd_configure rehash -group "system" -flags {m} -block 5 -alias {%pref_rehash}
	#cmd_configure restart -group "system" -flags {m} -use_chan 0 -alias {%pref_restart}
	#cmd_configure jump -group "system" -flags {m} -block 5 -alias {%pref_jump}
	
	
	################################################################################################
	# ��������� ������ system                                                                      #
	################################################################################################
	
	#cmd_configure traf -group "info" -flags {%v} -block 3 -alias {%pref_traf}
	
	
	################################################################################################
	# ��������� ������ users                                                                       #
	################################################################################################
	
	################################################################################################
	# ��������, ������� ���������� �����, �� ������� ����� ����������� ����� ������������.
	# ������������ �������� ����� � �����, ����� ��, ��� � ��� �������� ����� ����.
	configure -addusermask				9
	
	################################################################################################
	# ��������� �������� ������ �������������� � ���������� ������� � ��� ������, ���� �� ������,
	# �� ������� ����������� �����, ����� �� ��������� ��������� ����. �� ���� ���� ����������
	# .whois ���������� ����� �� ����� ������� ��� �� ��� �� ������������ ������ X ��� ����
	# ��������� ����� ���������� ������ LAST �� �� ���� ������ � ���� ���������� �����
	# (� ���� FLAGS ����� "-")
	configure -deluserchanrec			0
	
	################################################################################################
	# ������ ���� ������� �� �������������� ������.
	
	# n - �������� ��� ����� - ������������ � ��������� �������� � ����. ��� �������� ��� ��������� �������.
	set permission_flag(global,n)		{}
	set permission_flag(local,n)		{n m}
	# m - ������ (master) - ������������, �������� �������� ����� ��� ������� � �������.
	set permission_flag(global,m)		{n}
	set permission_flag(local,m)		{n|n m}
	# t - ������-������ (botnet-master) - ������������, �������� �������� ������� �������.
	set permission_flag(global,t)		{n m}
	# a - ������ (���) (auto-op) - ������������, ������� ����� �������� ������ ��������� ��� ����� �� �����.
	set permission_flag(global,a)		{n m}
	set permission_flag(local,a)		{n|n m|m}
	# o - �������� (��) (op) - ������������, ������� ������ ��������� �� ���� �������
	set permission_flag(global,o)		{n m}
	set permission_flag(local,o)		{n|n m|m}
	# y - ���������� (auto-halfop) - ������������, ������� ����� �������� ������ ������� ��� ����� �� �����
	set permission_flag(global,y)		{n m o}
	set permission_flag(local,y)		{n|n m|m o|o}
	# l - ������ (halfop) - ������������, ������� ������ ������� �� ���� �������.
	set permission_flag(global,l)		{n m o}
	set permission_flag(local,l)		{n|n m|m o|o}
	# g - �������� (�����) (auto-voice) - ������������, ������� ����� �������� ����� (����) ��� ����� �� �����
	set permission_flag(global,g)		{n m o l}
	set permission_flag(local,g)		{n|n m|m o|o l|l}
	# v - ����� (����) (voice) - ������������, ������� ����� �������� ����� (����) �� ������� +autovoice
	set permission_flag(global,v)		{n m o l}
	set permission_flag(local,v)		{n|n m|m o|o l|l}
	# f - ���� (friend) - ������������, ������� �� ����� ������ �� ���� � �.�.
	set permission_flag(global,f)		{n m o l}
	set permission_flag(local,f)		{n|n m|m o|o l|l}
	# p - �������� (party) - ������������, � �������� ���� ������ � �������� (DCC)
	set permission_flag(global,p)		{n}
	# q - ����� (quiet) - ������������, ������� �� ����� �������� ����� (����) �� ������� +autovoice
	set permission_flag(global,q)		{n m o l}
	set permission_flag(local,q)		{n|n m|m o|o l|l}
	# r - �������� (dehalfop) - ������������, �������� ������ ����� ������ �������. ������ ����� ��������� �������������.
	set permission_flag(global,r)		{n m o}
	set permission_flag(local,r)		{n|n m|m o|o}
	# d - ���� (deop) - ������������, �������� ������ ����� ������ ��������� (���). ������ ����� ��������� �������������.
	set permission_flag(global,d)		{n m}
	set permission_flag(local,d)		{n|n m|m}
	# k - ������� (����) (auto-kick) - ������������ ����� ������������� ������ � ������� ��� ������ �� �����
	set permission_flag(global,k)		{n m}
	set permission_flag(local,k)		{n|n m|m}
	# x - �������� ������ (xfer) - ������������, �������� ��������� ����������/��������� �����.
	set permission_flag(global,x)		{n m}
	# j - (janitor) ������������, ������� ����� ������ ������ � �������� �������. ������ filesystem
	set permission_flag(global,j)		{n m}
	# c - (common) ������������, ������� ����� � IRC � ���������� �����, � �������� ��������� �������������. �������� � ���� ������������� ���� *!some@some.host.dom ������������ ����� ������������������ �� ����.
	set permission_flag(global,c)		{n m}
	# w (wasop-test) ������������, ��� �������� ����������� ���� ��������� ��� �� �� ���� �� ������ ��� +stopnethack �������
	set permission_flag(global,w)		{n m}
	set permission_flag(local,w)		{n|n m|m}
	# z (washalfop-test) ������������, ��� �������� ����� ���������, ��� �� �� �������� �� ������ ��� +stopnethack �������
	set permission_flag(global,z)		{n m}
	set permission_flag(local,z)		{n|n m|m}
	# e (nethack-exempt) ������������, �������� �� ����� ��������� ��� stopnethack ���������
	set permission_flag(global,e)		{n m}
	set permission_flag(local,e)		{n|n m|m}
	# u - �� ������ (unshared) - ���������������� ������ �� ����� ������������ �� ������� ���� ������� ������.
	set permission_flag(global,u)		{n m t}
	# h - ��������� (highlight) - ������������, ��� �������� ����� �������������� ���� � ������
	set permission_flag(global,h)		{n m}
	
	set permission_flag(global,Q)		{n}
	set permission_flag(global,B)		{n}
	set permission_flag(global,P)		{n}
	set permission_flag(global,L)		{n}
	set permission_flag(global,H)		{n}
	set permission_flag(local,H)		{n}
	
	cmd_configure adduser -group "user" -flags {m} -block 3 -alias {%pref_adduser}
	cmd_configure deluser -group "user" -flags {m} -block 3 -alias {%pref_deluser}
	cmd_configure addhost -group "user" -flags {m} -block 1 -alias {%pref_addmask %pref_addhost %pref_+host}
	cmd_configure delhost -group "user" -flags {m} -block 1 -alias {%pref_clearhosts %pref_delhost %pref_-host}
	cmd_configure chattr -group "user" -flags {n|n m|m o|o l|l} -block 1 -alias {%pref_chattr}
	cmd_configure userlist -group "user" -flags {o} -block 5 -alias {%pref_userlist}
	cmd_configure resetpass -group "user" -flags {m} -block 3 -alias {%pref_resetpass}
	cmd_configure chhandle -group "user" -flags {m} -block 3 -alias {%pref_chhandle}
	cmd_configure setinfo -group "user" -flags {m|m} -block 3 -alias {%pref_setinfo}
	cmd_configure delinfo -group "user" -flags {m|m} -block 1 -alias {%pref_delinfo}
	cmd_configure match -group "user" -flags {lf|lf} -block 5 -alias {%pref_match}
	
	
	################################################################################################
	# ��������� ������� whoisip                                                                    #
	################################################################################################
	
	################################################################################################
	# ����� � ������������ � ������� �������� ������� ������.
	# Request timeout (period within we should wait for answer)
	configure -whoisip_timeout			20000
	
	################################################################################################
	# ������ ��������� ����������.
	# Output info entries.
	configure -whoisip_info {
		country person address city stateprov postalcode e-mail
	}
	
	################################################################################################
	# ����� ��������� DNS ��������. 
	# 1 - ��������� ������ ���� DNS (dns.so), ��� ���� ����� �� �������� ��������� �������, �����
	#     ���: ������ ��������� IPv6, ��������� ������� NS ��������, MX ������, ������������ ���;
	# 2 - ��������� ���������� ccs.lib.dns.tcl, ��� � ������ ���������� ����� DNS ������ ��������
	#     ������� �� ��������� TCP, ���� ����������� ��������� ������ ��������������� UDP �������.
	configure -mode_dns_reply			2
	
	#cmd_configure whoisip -group "info" -flags {-|-} -block 5 -use_botnet 0 -alias {%pref_whoisip}


