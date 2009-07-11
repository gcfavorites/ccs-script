####################################################################################################
## ������ ���������� ����� ChanServ
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{chanserv}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"������ ���������� ChanServ."

if {[pkg_info mod $_name on]} {
	
	if {[info exists chanserv]} {unset chanserv}
	variable chanserv
	
	################################################################################################
	# ������ �������� ���������� ������
	#set chanserv(op)		"PRIVMSG ChanServ :OP %chan %nick"
	#set chanserv(deop)		"PRIVMSG ChanServ :DEOP %chan %nick"
	#set chanserv(hop)		"PRIVMSG ChanServ :HALFOP %chan %nick"
	#set chanserv(dehop)		"PRIVMSG ChanServ :DEHALFOP %chan %nick"
	#set chanserv(voice)		"PRIVMSG ChanServ :VOICE %chan %nick"
	#set chanserv(devoice)	"PRIVMSG ChanServ :DEVOICE %chan %nick"
	set chanserv(op)		"ChanServ OP %chan %nick"
	set chanserv(deop)		"ChanServ DEOP %chan %nick"
	set chanserv(hop)		"ChanServ HALFOP %chan %nick"
	set chanserv(dehop)		"ChanServ DEHALFOP %chan %nick"
	set chanserv(voice)		"ChanServ VOICE %chan %nick"
	set chanserv(devoice)	"ChanServ DEVOICE %chan %nick"
	
	cmd_configure csop -control -group "chanserv" -flags {o|o} -block 1 \
		-alias {%pref_csop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure csdeop -control -group "chanserv" -flags {o|o} -block 1 \
		-alias {%pref_csdeop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure cshop -control -group "chanserv" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_cshop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure csdehop -control -group "chanserv" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_csdehop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure csvoice -control -group "chanserv" -flags {v|v o|o} -block 1 -use_auth 0 \
		-alias {%pref_csvoice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure csdevoice -control -group "chanserv" -flags {v|v o|o} -block 1 -use_auth 0 \
		-alias {%pref_csdevoice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	
	################################################################################################
	################################################################################################
	################################################################################################
	
	################################################################################################
	# ��������� ������ ���������� ����� � ������ (OP, HOP).
	
	proc cmd_csop {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		variable chanserv
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-isop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $chanserv(op)]
			put_log "SELF"
		} else {
			if {[check_notavailable {-notonchan -isop -bitch} -dnick $dnick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $chanserv(op)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	proc cmd_csdeop {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		variable chanserv
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notisop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $chanserv(deop)]
			put_log "SELF"
		} else {
			set dhand [nick2hand $dnick]
			if {[check_notavailable {-isbotnick -notonchan -protect -nopermition0 -notisop} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $chanserv(deop)]
			put_log "$dnick"
		}
		return 1
		
		
	}
	
	proc cmd_cshop {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		variable chanserv
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-ishalfop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $chanserv(hop)]
			put_log "SELF"
		} else {
			if {[check_notavailable {-notonchan -ishalfop} -dnick $dnick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $chanserv(hop)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	proc cmd_csdehop {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		variable chanserv
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notishalfop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $chanserv(dehop)]
			put_log "SELF"
		} else {
			set dhand [nick2hand $dnick]
			if {[check_notavailable {-isbotnick -notonchan -protect -nopermition0 -notishalfop} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $chanserv(dehop)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	################################################################################################
	# ��������� ������ ���������� ������� (VOICE).
	
	proc cmd_csvoice {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		variable chanserv
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-isvoice} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $chanserv(voice)]
			put_log "SELF"
		} else {
			if {[check_notavailable {-notonchan -isvoice} -dnick $dnick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $chanserv(voice)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	proc cmd_csdevoice {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		variable chanserv
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notisvoice} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $chanserv(devoice)]
			put_log "SELF"
		} else {
			set dhand [nick2hand $dnick]
			if {[check_notavailable {-isbotnick -notonchan -protect -nopermition0 -notisvoice} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $chanserv(devoice)]
			put_log "$dnick"
		}
		return 1
		
	}
	
}