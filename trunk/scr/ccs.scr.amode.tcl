####################################################################################################
## ������ ������������� ������������ ������ ������
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{amode}
pkg_add scr $_name "Buster <buster@buster-net.ru> (c)" "1.0.0" "13-Oct-2009" \
	"������ ������������� ������������ ������ ������"

if {[pkg_info scr $_name on]} {
	
	variable amode
	if {[info exists amode]} {unset amode}
	
	################################################################################################
	# �������� �� ���������, ������� ����������, ������ �� ������ �������� ��/���/���� ���
	# ����������� ������������ � ������� ���� (0 - ���, 1 - ��). �������� ����� ���� ��������������
	# ������������ ��������� ������ ccs-autoop/ccs-autohalfop/ccs-autovoice
	set options(autoop)				0
	set options(autohalfop)			0
	set options(autovoice)			0
	
	################################################################################################
	# �������� �� ���������, ������� ����������, ������ �� ������ �������� ��/���/���� ��� ������
	# ����������� ������������ � ������� ���� (0 - ���, 1 - ��). �������� ����� ���� ��������������
	# ������������ ��������� ������ ccs-autodeop/ccs-autodehalfop/ccs-autodevoice
	set options(autodeop)			0
	set options(autodehalfop)		0
	set options(autodevoice)		0
	
	################################################################################################
	# ������ ������ �� ������� ������� ��������/�������� ��/���/���� ��� ������� � ������
	# �����������
	set options(flags_autoop)		{o|o}
	set options(flags_autohalfop)	{l|l}
	set options(flags_autovoice)	{v|v}
	
	################################################################################################
	# ������ ������ ��������� ������ ����� �� ���� �����
	set options(flags_amode_exempt)	{}
	
	################################################################################################
	# �������� �� ���������, ������� ����������, ������ �� ������ ������ ����� �� ���� �����
	# �������� �� ���� ������� (0 - ���, 1 - ��). �������� ����� ���� �������������� ������������
	# ���������� ����� ccs-amode
	set options(amode)				0
	
	################################################################################################
	# ����� ��������, � �������������, ����� �������� ������� ��������� ������ ����� �� ���� �����
	# ��� ������ ���� �� �����
	set options(amode_delay)		5000
	
	################################################################################################
	# ���� � ��� �����, ���� ����� ���������� ������ �������, ��� ���� �������� $options(dir_data)
	# ����� ��������������� �������� data, ������������ ������ � �������� ��������.
	set options(file_amode)			"$options(dir_data)/ccs.amode.dat"
	
	
	cmd_configure amodeadd -control -group "amode" -flags {m|m} -block 5 \
		-alias {%pref_amodeadd %pref_aadd} \
		-regexp {{^\+?([ovh])(?:\s+(-[mr]))?\s+(.*?)$} {-> mode mflag mask}}
	
	cmd_configure amodedel -control -group "amode" -flags {m|m} -block 5 \
		-alias {%pref_amodedel %pref_adel} \
		-regexp {{^\+?([ovh])(?:\s+(-[mr]))?\s+(.*?)$} {-> mode mflag mask}}
	
	cmd_configure amodelist -control -group "amode" -flags {m|m} -block 5 \
		-alias {%pref_amodelist %pref_amodes %pref_alist} \
		-regexp {{^(?:\+?([ovh]))?$} {-> mode}}
	
	setudef str ccs-amode
	setudef str ccs-autoop
	setudef str ccs-autohalfop
	setudef str ccs-autovoice
	setudef str ccs-autodeop
	setudef str ccs-autodehalfop
	setudef str ccs-autodevoice
	
	set_text -type args -- ru amodeadd {<+o|+h|+v> [-m|-r] <mask>}
	set_text -type help -- ru amodeadd {���������� ���� ���/����/����� �� �����}
	set_text -type help2 -- ru amodeadd {
		{���������� ���� ���/����/����� �� �����.}
		{��� �������� \002-m\002 ����� ������������ ����������� �����, � ������� �������� �� ������ ������� ����������� \002*\002 � \002?\002, �� � ��������� ������������ � \002[..]\002.}
		{��� �������� \002-r\002 ����� ������������ ����� �� ����������� ���������.}
		{���� �� ��������� \002-m\002 � \002-r\002 �� ����� ������������ ������� ����� � ��������� ����������� \002*\002 � \002?\002.}
	}
	
	set_text -type args -- ru amodedel {<+o|+h|+v> [-m|-r] <mask>}
	set_text -type help -- ru amodedel {�������� ���� ���/����/����� �� �����}
	set_text -type help2 -- ru amodedel {
		{�������� ���� ���/����/����� �� �����.}
		{��� �������� \002-m\002 ����� ������������ ����������� �����, � ������� �������� �� ������ ������� ����������� \002*\002 � \002?\002, �� � ��������� ������������ � \002[..]\002.}
		{��� �������� \002-r\002 ����� ������������ ����� �� ����������� ���������.}
		{���� �� ��������� \002-m\002 � \002-r\002 �� ����� ������������ ������� ����� � ��������� ����������� \002*\002 � \002?\002.}
	}
	
	set_text -type args -- ru amodelist {[+o|+h|+v]}
	set_text -type help -- ru amodelist {�������� ������ ���� ���/����/�����}
	set_text -type help2 -- ru amodelist {
		{�������� ������ ���� ���/����/�����.}
		{��� �������� ���� ������ ����� ��������� ��������� �����. ���� ��� �� ��������� ����� ��������� ���� ������.}
	}
	
	set_text ru $_name #101	"�������"
	set_text ru $_name #102	"�����������"
	set_text ru $_name #103	"����������"
	set_text ru $_name #104	"�������"
	set_text ru $_name #105	"�����������"
	set_text ru $_name #106	"����������"
	set_text ru $_name #107	"��� ������ \002%s\002 ��� \002+%s\002 � %s ������ \002%s\002 ��� ��������."
	set_text ru $_name #108	"��� ������ \002%s\002 ��� \002+%s\002 � %s ������ \002%s\002 ��������."
	set_text ru $_name #109	"��� ������ \002%s\002 ��� \002+%s\002 � %s ������ \002%s\002 �� ������."
	set_text ru $_name #110	"��� ������ \002%s\002 ��� \002+%s\002 � %s ������ \002%s\002 ������."
	set_text ru $_name #111	"��� �������� ������� �������� �������� � ������� ����� ������. ����� ����������/�����������/��������� ����� ������� ��������� ������."
	set_text ru $_name #112 "--- ����� ���� \002%s\002 ---"
	set_text ru $_name #113 "--- ����� ���� ����� ---"
	set_text ru $_name #114 "*** ���� ***"
	set_text ru $_name #115 "%s. � ��� \002+%s\002 � %s ����� \002%s\002"
	
	
	proc cmd_amodeadd {} {
		variable amode
		upvar out out
		importvars [list snick shand schan command mode mflag mask]
		
		if {![info exists amode]} {put_msg -return 0 -- [sprintf amode #111]}
		
		if {$mflag == "-m"} {
			set type_mask 1
			set msg_type [sprintf amode #102]
		} elseif {$mflag == "-r"} {
			if {[catch {regexp -- $mask ""} errMsg]} {
				put_msg [sprintf ccs #107 $mask]
				return 0
			}
			set type_mask 2
			set msg_type [sprintf amode #103]
		} else {
			set type_mask 0
			set msg_type [sprintf amode #101]
		}
		
		if {($type_mask == 0 || $type_mask == 1) && [string first ! $mask] < 0 && [string first @ $mask] < 0} {
			set mask "$mask!*@*"
		}
		
		foreach _ $amode {
			lassign $_ lchan lmode ltype_mask lmask
			
			if {[string equal -nocase $schan $lchan] && [string equal -nocase $mask $lmask] && \
				$type_mask == $ltype_mask && $mode == $lmode} {
				put_msg -return 0 -- [sprintf amode #107 $schan $mode $msg_type $mask]
			}
			
		}
		
		lappend amode [list $schan $mode $type_mask $mask]
		
		if {[catch {
			SaveFile [configure -file_amode] $amode
		} errMsg]} {
			put_msg -return 0 -- [sprintf ccs #192 $errMsg]
		}
		
		amode_checkchan $schan
		
		put_msg -- [sprintf amode #108 $schan $mode $msg_type $mask]
		put_log "type: $type_mask, mask $mask"
		return 1
		
	}
	
	proc cmd_amodedel {} {
		variable amode
		upvar out out
		importvars [list snick shand schan command mode mflag mask]
		
		if {![info exists amode]} {put_msg -return 0 -- [sprintf amode #111]}
		
		if {$mflag == "-m"} {
			set type_mask 1
			set msg_type [sprintf amode #102]
		} elseif {$mflag == "-r"} {
			if {[catch {regexp -- $mask ""} errMsg]} {
				put_msg [sprintf ccs #107 $mask]
				return 0
			}
			set type_mask 2
			set msg_type [sprintf amode #103]
		} else {
			set type_mask 0
			set msg_type [sprintf amode #101]
		}
		
		if {($type_mask == 0 || $type_mask == 1) && [string first ! $mask] < 0 && [string first @ $mask] < 0} {
			set mask "$mask!*@*"
		}
		
		set ind 0
		set find 0
		foreach _ $amode {
			lassign $_ lchan lmode ltype_mask lmask
			
			if {[string equal -nocase $schan $lchan] && [string equal -nocase $mask $lmask] && \
				$type_mask == $ltype_mask && $mode == $lmode} {
				set find 1
				break
			}
			
			incr ind
		}
		
		if {!$find} {put_msg -return 0 -- [sprintf amode #109 $schan $mode $msg_type $mask]}
		set amode [lreplace $amode $ind $ind]
		
		if {[catch {
			SaveFile [configure -file_amode] $amode
		} errMsg]} {
			put_msg -return 0 -- [sprintf ccs #192 $errMsg]
		}
		
		put_msg -- [sprintf amode #110 $schan $mode $msg_type $mask]
		put_log "type: $type_mask, mask $mask"
		return 1
		
	}
	
	proc cmd_amodelist {} {
		variable amode
		upvar out out
		importvars [list snick shand schan command mode]
		
		if {![info exists amode]} {put_msg -return 0 -- [sprintf amode #111]}
		
		set r {}
		lappend r [sprintf amode #112 $schan]
		set find 0
		set ind 1
		foreach _ $amode {
			lassign $_ lchan lmode ltype_mask lmask
			
			if {[string equal -nocase $schan $lchan] && ($mode == "" || $mode == $lmode)} {
				set find 1
				
				switch -exact -- $ltype_mask {
					0 {set msg_type [sprintf amode #104]}
					1 {set msg_type [sprintf amode #105]}
					2 {set msg_type [sprintf amode #106]}
				}
				lappend r [sprintf amode #115 $ind $lmode $msg_type $lmask]
				
				incr ind
			}
			
		}
		if {!$find} {lappend r [sprintf amode #114]}
		lappend r [sprintf amode #113]
		put_msg -speed 3 -list -notice2msg -- $r
		
		put_log ""
		return 1
		
	}
	
	proc amode_auth {nick uhost hand chan} {
		
		if {[get_options_int autoop $chan] && [check_matchattr $hand $chan [configure -flags_autoop]]} {
			pushmode $chan +o $nick
		} elseif {[get_options_int autohalfop $chan] && [check_matchattr $hand $chan [configure -flags_autohalfop]]} {
			pushmode $chan +l $nick
		} elseif {[get_options_int autovoice $chan] && [check_matchattr $hand $chan [configure -flags_autovoice]]} {
			pushmode $chan +v $nick
		}
		
	}
	
	proc amode_deauth {nick uhost hand chan} {
		
		if {[get_options_int autodeop $chan] && [check_matchattr $hand $chan [configure -flags_autoop]]} {
			pushmode $chan -o $nick
		}
		if {[get_options_int autodehalfop $chan] && [check_matchattr $hand $chan [configure -flags_autohalfop]]} {
			pushmode $chan -l $nick
		}
		if {[get_options_int autodevoice $chan] && [check_matchattr $hand $chan [configure -flags_autovoice]]} {
			pushmode $chan -v $nick
		}
		
	}
	
	proc amode_autolist {nick uhost hand chan} {
		
		if {![get_options_int amode $chan]} return
		if {[check_matchattr $hand $chan [configure -flags_amode_exempt]]} return
		variable amode
		if {![info exists amode]} return
		
		foreach _ $amode {
			lassign $_ lchan lmode ltype_mask lmask
			
			if {![string equal -nocase $chan $lchan]} continue
			
			switch -exact -- $ltype_mask {
				0 {
					set lmask [string map {[ \\[ ] \\] \\ \\\\} $lmask]
					if {[string match -nocase $lmask "$nick!$uhost"]} {
						pushmode $chan "+$lmode" $nick
					}
				}
				1 {
					if {[string match -nocase $lmask "$nick!$uhost"]} {
						pushmode $chan "+$lmode" $nick
					}
				}
				2 {
					if {[regexp -nocase -- $lmask "$nick!$uhost"]} {
						pushmode $chan "+$lmode" $nick
					}
				}
			}
			
		}
		
	}
	
	proc amode_checkchan {chan} {
		foreach user [chanlist $chan] {
			if {[isbotnick $user]} continue
			amode_autolist $user [getchanhost $user $chan] [nick2hand $user $chan] $chan
		}
	}
	
	proc amode_join {nick uhost hand chan} {
		
		if {[check_auth $nick $hand $uhost]} {
			amode_auth $nick $uhost $hand $chan
		}
		
		if {[isbotnick $nick]} {
			after [configure -amode_delay] [list [namespace origin amode_checkchan] $chan]
		} else {
			amode_autolist $nick $uhost $hand $chan
		}
		
	}
	
	proc amode_nick {nick uhost hand chan newnick} {
		amode_autolist $newnick $uhost $hand $chan
	}
	
	proc amode_mode {nick uhost hand chan modechange victim} {
		if {[isbotnick $victim] && ($modechange == "+o" || $modechange == "+h")} {
			amode_checkchan $chan
		}
	}
	
	
	proc auth_$_name {nick host hand to_botnet from_botnet} {
		foreach chan [channels] {
			amode_auth $nick $host $hand $chan
		}
	}
	
	proc deauth_$_name {nick host hand to_botnet from_botnet} {
		foreach chan [channels] {
			amode_deauth $nick $host $hand $chan
		}
	}
	
	proc main_$_name {} {
		variable amode
		
		bind join - *	[namespace origin amode_join]
		bind nick - *	[namespace origin amode_nick]
		bind mode - *	[namespace origin amode_mode]
		
		if {[file exists [configure -file_amode]]} {
			catch {
				set amode [LoadFile [configure -file_amode]]
			}
		} else {
			set amode {}
		}
		
	}
	
}