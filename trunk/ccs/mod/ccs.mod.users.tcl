##################################################################################################################
## ������ ���������� ��������������
##################################################################################################################
# ������ ��������� ���������:
#	v1.2.4
# - ��� ������� !delhost ������ �� ��������� ������������ �������� ������ ���������, ����� ������� ����� ���������
#   ���������� ����� ������ ��������� ���� -m

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"users"
addfileinfo mod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.5" \
				"24-Feb-2008"

if {$ccs(mod,name,$modname)} {
	
	unsetccs "flag,global,*" "flag,local,*"
	
	#############################################################################################################
	# ��������, ������� ���������� �����, �� ������� ����� ����������� ����� ������������. ������������ ��������
	# ����� � �����, ����� ��, ��� � ��� �������� ����� ����.
	set ccs(addusermask)		4
	
	#############################################################################################################
	# ��������� �������� ������ �������������� � ���������� ������� � ��� ������, ���� �� ������, �� �������
	# ����������� �����, ����� �� ��������� ��������� ����. �� ���� ���� ���������� .whois ���������� ����� ��
	# ����� ������� ��� �� ��� �� ������������ ������ X ��� ���� ��������� ����� ���������� ������ LAST �� ��
	# ���� ������ � ���� ���������� ����� (� ���� FLAGS ����� "-")
	set ccs(deluserchanrec)		1
	
	#############################################################################################################
	# ������ ���� ������� �� �������������� ������.
	
	# n - �������� ��� ����� - ������������ � ��������� �������� � ����. ��� �������� ��� ��������� �������.
	set ccs(flag,global,n)		{}
	set ccs(flag,local,n)		{n m}
	# m - ������ (master) - ������������, �������� �������� ����� ��� ������� � �������.
	set ccs(flag,global,m)		{n}
	set ccs(flag,local,m)		{n|n m}
	# t - ������-������ (botnet-master) - ������������, �������� �������� ������� �������.
	set ccs(flag,global,t)		{n m}
	# a - ������ (���) (auto-op) - ������������, ������� ����� �������� ������ ��������� ��� ����� �� �����.
	set ccs(flag,global,a)		{n m}
	set ccs(flag,local,a)		{n|n m|m}
	# o - �������� (��) (op) - ������������, ������� ������ ��������� �� ���� �������
	set ccs(flag,global,o)		{n m}
	set ccs(flag,local,o)		{n|n m|m}
	# y - ���������� (auto-halfop) - ������������, ������� ����� �������� ������ ������� ��� ����� �� �����
	set ccs(flag,global,y)		{n m o}
	set ccs(flag,local,y)		{n|n m|m o|o}
	# l - ������ (halfop) - ������������, ������� ������ ������� �� ���� �������.
	set ccs(flag,global,l)		{n m o}
	set ccs(flag,local,l)		{n|n m|m o|o}
	# g - �������� (�����) (auto-voice) - ������������, ������� ����� �������� ����� (����) ��� ����� �� �����
	set ccs(flag,global,g)		{n m o l}
	set ccs(flag,local,g)		{n|n m|m o|o l|l}
	# v - ����� (����) (voice) - ������������, ������� ����� �������� ����� (����) �� ������� +autovoice
	set ccs(flag,global,v)		{n m o l}
	set ccs(flag,local,v)		{n|n m|m o|o l|l}
	# f - ���� (friend) - ������������, ������� �� ����� ������ �� ���� � �.�.
	set ccs(flag,global,f)		{n m o l}
	set ccs(flag,local,f)		{n|n m|m o|o l|l}
	# p - �������� (party) - ������������, � �������� ���� ������ � �������� (DCC)
	set ccs(flag,global,p)		{n}
	# q - ����� (quiet) - ������������, ������� �� ����� �������� ����� (����) �� ������� +autovoice
	set ccs(flag,global,q)		{n m o l}
	set ccs(flag,local,q)		{n|n m|m o|o l|l}
	# r - �������� (dehalfop) - ������������, �������� ������ ����� ������ �������. ������ ����� ��������� �������������.
	set ccs(flag,global,r)		{n m o}
	set ccs(flag,local,r)		{n|n m|m o|o}
	# d - ���� (deop) - ������������, �������� ������ ����� ������ ��������� (���). ������ ����� ��������� �������������.
	set ccs(flag,global,d)		{n m}
	set ccs(flag,local,d)		{n|n m|m}
	# k - ������� (����) (auto-kick) - ������������ ����� ������������� ������ � ������� ��� ������ �� �����
	set ccs(flag,global,k)		{n m}
	set ccs(flag,local,k)		{n|n m|m}
	# x - �������� ������ (xfer) - ������������, �������� ��������� ����������/��������� �����.
	set ccs(flag,global,x)		{n m}
	# j - (janitor) ������������, ������� ����� ������ ������ � �������� �������. ������ filesystem
	set ccs(flag,global,j)		{n m}
	# c - (common) ������������, ������� ����� � IRC � ���������� �����, � �������� ��������� �������������. �������� � ���� ������������� ���� *!some@some.host.dom ������������ ����� ������������������ �� ����.
	set ccs(flag,global,c)		{n m}
	# w (wasop-test) ������������, ��� �������� ����������� ���� ��������� ��� �� �� ���� �� ������ ��� +stopnethack �������
	set ccs(flag,global,w)		{n m}
	set ccs(flag,local,w)		{n|n m|m}
	# z (washalfop-test) ������������, ��� �������� ����� ���������, ��� �� �� �������� �� ������ ��� +stopnethack �������
	set ccs(flag,global,z)		{n m}
	set ccs(flag,local,z)		{n|n m|m}
	# e (nethack-exempt) ������������, �������� �� ����� ��������� ��� stopnethack ���������
	set ccs(flag,global,e)		{n m}
	set ccs(flag,local,e)		{n|n m|m}
	# u - �� ������ (unshared) - ���������������� ������ �� ����� ������������ �� ������� ���� ������� ������.
	set ccs(flag,global,u)		{n m t}
	# h - ��������� (highlight) - ������������, ��� �������� ����� �������������� ���� � ������
	set ccs(flag,global,h)		{n m}
	
	set ccs(flag,global,Q)		{n}
	set ccs(flag,global,B)		{n}
	set ccs(flag,global,P)		{n}
	set ccs(flag,global,L)		{n}
	set ccs(flag,global,H)		{n}
	set ccs(flag,local,H)		{n}
	
	lappend ccs(commands)	"adduser"
	lappend ccs(commands)	"deluser"
	lappend ccs(commands)	"addhost"
	lappend ccs(commands)	"delhost"
	lappend ccs(commands)	"chattr"
	lappend ccs(commands)	"userlist"
	lappend ccs(commands)	"resetpass"
	lappend ccs(commands)	"chhandle"
	lappend ccs(commands)	"setinfo"
	lappend ccs(commands)	"delinfo"
	
	set ccs(group,adduser) "user"
	set ccs(use_chan,adduser) 0
	set ccs(flags,adduser) {m}
	set ccs(alias,adduser) {%pref_adduser}
	set ccs(block,adduser) 3
	set ccs(regexp,adduser) {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick dhost}}
	
	set ccs(group,deluser) "user"
	set ccs(use_chan,deluser) 0
	set ccs(flags,deluser) {m}
	set ccs(alias,deluser) {%pref_deluser}
	set ccs(block,deluser) 3
	set ccs(regexp,deluser) {{^([^\ ]+)$} {-> dnick}}
	
	set ccs(group,addhost) "user"
	set ccs(use_chan,addhost) 0
	set ccs(flags,addhost) {m}
	set ccs(alias,addhost) {%pref_addmask %pref_addhost %pref_+host}
	set ccs(block,addhost) 1
	set ccs(regexp,addhost) {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick dhost}}
	
	set ccs(group,delhost) "user"
	set ccs(use_chan,delhost) 0
	set ccs(flags,delhost) {m}
	set ccs(alias,delhost) {%pref_clearhosts %pref_delhost %pref_-host}
	set ccs(block,delhost) 1
	set ccs(regexp,delhost) {{^([^\ ]+)(?:\ +(-m))?(?:\ +([^\ ]+))$} {-> dnick dmaskflag dhost}}
	
	set ccs(group,chattr) "user"
	set ccs(use_chan,chattr) 3
	set ccs(flags,chattr) {n|n m|m o|o l|l}
	set ccs(alias,chattr) {%pref_chattr}
	set ccs(block,chattr) 1
	set ccs(regexp,chattr) {{^([^\ ]+)(?:\ +([a-z\+\-]+))(?:\ +(global))?$} {-> dnick sflag sglobal}}
	
	set ccs(group,userlist) "user"
	set ccs(use_chan,userlist) 3
	set ccs(flags,userlist) {o}
	set ccs(alias,userlist) {%pref_userlist}
	set ccs(block,userlist) 5
	#set ccs(regexp,userlist) {{^(.*?)?$} {-> sflag}}
	
	set ccs(group,resetpass) "user"
	set ccs(use_chan,resetpass) 0
	set ccs(flags,resetpass) {m}
	set ccs(alias,resetpass) {%pref_resetpass}
	set ccs(block,resetpass) 3
	set ccs(regexp,resetpass) {{^([^\ ]+)$} {-> dnick}}
	
	set ccs(group,chhandle) "user"
	set ccs(use_chan,chhandle) 0
	set ccs(flags,chhandle) {m}
	set ccs(alias,chhandle) {%pref_chhandle}
	set ccs(block,chhandle) 3
	set ccs(regexp,chhandle) {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick newhandle}}
	
	set ccs(group,setinfo) "user"
	set ccs(flags,setinfo) {m|m}
	set ccs(alias,setinfo) {%pref_setinfo}
	set ccs(block,setinfo) 3
	set ccs(regexp,setinfo) {{^([^\ ]+)(?:\ +(.*?))$} {-> dnick sinfo}}
	
	set ccs(group,delinfo) "user"
	set ccs(flags,delinfo) {m|m}
	set ccs(alias,delinfo) {%pref_delinfo}
	set ccs(block,delinfo) 1
	set ccs(regexp,delinfo) {{^([^\ ]+)$} {-> dnick sinfo}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	#############################################################################################################
	# ��������� ������ ���������� �������������� (USER).
	
	proc cmd_adduser {} {
		variable ccs
		importvars [list onick ochan obot snick shand schan command dnick dhost]
		
		set dhand [get_hand $dnick -quiet 1]
		if {[check_notavailable {-getting_users -validhandle} -dnick $dnick -dhand $dhand]} {return 0}
		
		if {[string is space $dhost]} {
			if {![onchan $dnick]} {put_msg [sprintf users #101 $dnick]; return 0}
			set dhost "$dnick![getchanhost $dnick]"
			set dhost [get_mask $dhost $ccs(addusermask)]
		}
		
		if {![adduser $dnick $dhost]} {put_msg [sprintf users #107 $dnick]; return 0}
		put_msg [sprintf users #102 $dnick $dhost]
		
		if {[onchan $dnick]} {
			global botnick
			
			put_msg [sprintf users #103 $botnick] -onick $dnick
			put_msg [sprintf users #104 $botnick] -onick $dnick
			put_msg [sprintf users #105 $botnick] -onick $dnick
			put_msg [sprintf users #106 $ccs(pref_pub)] -onick $dnick
		}
		put_log "$dnick ($dhost)"
		return 1
		
	}
	
	proc cmd_deluser {} {
		variable ccs
		importvars [list onick ochan obot snick shand schan command dnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		set denied 0
		foreach n [channels] {
			set saccess [get_accesshand $shand $schan 1]
			set daccess [get_accesshand $dhand $schan]
			if {[haschanrec $dhand $n] && !($ccs(deluserchanrec) && $saccess == 0 && $daccess == 0) && ($saccess <= $daccess)} {
				set denied 1
				break
			}
		}
		if {$denied} {
			put_msg [sprintf users #108 [get_nick $dnick $dhand]]
			put_log "$dhand - \0034unsuccessfull\003!"
			return 0
		} else {
			deluser $dhand
			put_msg [sprintf users #109 [get_nick $dnick $dhand]]
			put_log "$dhand"
			return 1
		}
		
	}
	
	proc cmd_addhost {} {
		importvars [list onick ochan obot snick shand schan command dnick dhost]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		setuser $dhand HOSTS $dhost
		put_msg [sprintf users #110 $dhost $dhand]
		put_log "$dhand: $dhost"
		return 1
		
	}
	
	proc cmd_delhost {} {
		importvars [list onick ochan obot snick shand schan command dnick dmaskflag dhost]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		set findhost 0
		foreach line [getuser $dhand HOSTS] {
			if {($dmaskflag == "" && [string equal -nocase $dhost $line]) || \
				($dmaskflag != "" && [string match -nocase $dhost $line])} {
				set findhost 1
				delhost $dhand $line
				put_msg [sprintf users #111 $line $dhand]
				put_log "$dhand: $line"
			}
		}
		if {!$findhost} {put_msg [sprintf users #112]; return 0}
		return 1
		
	}
	
	proc cmd_userlist {} {
		importvars [list onick ochan obot snick shand schan command text]
		
		set sflags ""
		set lptext ""
		set useflags [regexp -nocase -- {-f ([^\ ]+)} $text -> sflags]
		regsub -- {-f ([^\ ]+)} $text {} text
		set usehost [regexp -nocase -- {-h ([^\ ]+)} $text -> dhost]
		regsub -- {-h ([^\ ]+)} $text {} text
		
		if {![string is space $text]} {put_help; return}
		
		if {[check_isnull $schan]} {
			set luser [userlist $sflags]
			if {$useflags} {lappend lptext "flags: \002$sflags\002"}
		} else {
			set luser [userlist $sflags $schan]
			if {$useflags} {lappend lptext "flags for $schan: \002$sflags\002"}
		}
		if {$usehost} {lappend lptext "host: \002$dhost\002"}
		
		
		
		set louser [list]
		foreach _ $luser {
			
			if {$usehost} {
				set lhost [getuser $_ HOSTS]
				set find 0
				foreach h $lhost {
					if {[string match -nocase $dhost $h]} {set find 1}
				}
				if {!$find} {continue}
			}
			lappend louser $_
			
		}
		
		if {[llength $lptext] == 0} {lappend lptext "-"}
		
		put_msg [sprintf users #113 [join $lptext ", "] [join $louser ", "]]
		put_log "$text"
		return 1
		
	}
	
	proc cmd_chattr {} {
		variable ccs
		importvars [list onick ochan obot snick shand schan command dnick sflag sglobal]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		set global [expr ![string is space $sglobal]]
		if {$global} {
			set typeflag global
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			set typeflag local
		}
		for {set x 0} {$x < [string length $sflag]} {incr x} {
			
			set curflag [string index $sflag $x]
			if {$curflag != "+" && $curflag != "-"} {
				set allow 0
				
				if {[info exists ccs(flag,$typeflag,$curflag)]} {
					if {[check_matchattr $shand $schan $ccs(flag,$typeflag,$curflag)]} {set allow 1}
				} else {set allow 1}
				
				if {!$allow} {put_msg [sprintf users #114 $curflag $dhand]; return}
			}
			
		}
		
		if {$global} {
			set newflags [chattr $dhand $sflag]
			put_msg [sprintf users #115 [get_nick $dnick $dhand] $newflags]
			put_log "$dhand: $newflags"
			return 1
		} else {
			set newflags [chattr $dhand |$sflag $schan]
			put_msg [sprintf users #115 [get_nick $dnick $dhand] $newflags]
			put_log "$dhand: $newflags"
			return 1
		}
		
	}
	
	proc cmd_resetpass {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition1 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		setuser $dhand PASS
		global botnick
		put_msg [sprintf users #116 [get_nick $dnick $dhand]]
		set ddnick [hand2nick $dhand]
		if {![check_isnull $ddnick]} {
			put_msgdest $ddnick [sprintf users #117 [get_nick $snick $shand] $botnick] -type notice
		}
		put_log "$dhand"
		return 1
		
	}
	
	proc cmd_chhandle {} {
		importvars [list onick ochan obot snick shand schan command dnick newhandle]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition1 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		if {[validuser $newhandle]} {put_msg [sprintf users #118 $newhandle]; return 0}
		chhandle $dhand $newhandle
		if {[string match $shand $dhand]} {
			set shand $newhandle
		}
		put_msg [sprintf users #119 [get_nick $dnick $dhand] $newhandle]
		put_log "$dhand to $newhandle"
		return 1
		
	}
	
	proc cmd_setinfo {} {
		importvars [list onick ochan obot snick shand schan command dnick sinfo]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		setchaninfo $dhand $schan $sinfo
		put_msg [sprintf users #120 $dhand]
		put_log "$dhand, text: $sinfo"
		return 1
		
	}
	
	proc cmd_delinfo {} {
		importvars [list onick ochan obot snick shand schan command dnick sinfo]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		setchaninfo $dhand $schan ""
		put_msg [sprintf users #121 $dhand]
		put_log "$dhand"
		return 1
		
	}
	
}