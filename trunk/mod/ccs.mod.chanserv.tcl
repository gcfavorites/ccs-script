##################################################################################################################
## Модуль управления через ChanServ
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chanserv"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"Модуль управление ChanServ."

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Список шаблонов отсылаемых команд
	#set ccs(chanserv,op)		"PRIVMSG ChanServ :OP %chan %nick"
	#set ccs(chanserv,deop)		"PRIVMSG ChanServ :DEOP %chan %nick"
	#set ccs(chanserv,hop)		"PRIVMSG ChanServ :HALFOP %chan %nick"
	#set ccs(chanserv,dehop)		"PRIVMSG ChanServ :DEHALFOP %chan %nick"
	#set ccs(chanserv,voice)		"PRIVMSG ChanServ :VOICE %chan %nick"
	#set ccs(chanserv,devoice)	"PRIVMSG ChanServ :DEVOICE %chan %nick"
	set ccs(chanserv,op)		"ChanServ OP %chan %nick"
	set ccs(chanserv,deop)		"ChanServ DEOP %chan %nick"
	set ccs(chanserv,hop)		"ChanServ HALFOP %chan %nick"
	set ccs(chanserv,dehop)		"ChanServ DEHALFOP %chan %nick"
	set ccs(chanserv,voice)		"ChanServ VOICE %chan %nick"
	set ccs(chanserv,devoice)	"ChanServ DEVOICE %chan %nick"
	
	cconfigure csop -add -group "chanserv" -flags {o|o} -block 1 \
		-alias {%pref_csop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure csdeop -add -group "chanserv" -flags {o|o} -block 1 \
		-alias {%pref_csdeop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure cshop -add -group "chanserv" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_cshop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure csdehop -add -group "chanserv" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_csdehop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure csvoice -add -group "chanserv" -flags {v|v o|o} -block 1 -useauth 0 \
		-alias {%pref_csvoice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure csdevoice -add -group "chanserv" -flags {v|v o|o} -block 1 -useauth 0 \
		-alias {%pref_csdevoice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	#############################################################################################################
	# Процедуры команд управления Опами и Хопами (OP, HOP).
	
	proc cmd_csop {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		variable ccs
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-isop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $ccs(chanserv,op)]
			put_log "SELF"
		} else {
			if {[check_notavailable {-notonchan -isop -bitch} -dnick $dnick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $ccs(chanserv,op)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	proc cmd_csdeop {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		variable ccs
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notisop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $ccs(chanserv,deop)]
			put_log "SELF"
		} else {
			set dhand [nick2hand $dnick]
			if {[check_notavailable {-isbotnick -notonchan -protect -nopermition0 -notisop} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $ccs(chanserv,deop)]
			put_log "$dnick"
		}
		return 1
		
		
	}
	
	proc cmd_cshop {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		variable ccs
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-ishalfop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $ccs(chanserv,hop)]
			put_log "SELF"
		} else {
			if {[check_notavailable {-notonchan -ishalfop} -dnick $dnick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $ccs(chanserv,hop)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	proc cmd_csdehop {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		variable ccs
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notishalfop} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $ccs(chanserv,dehop)]
			put_log "SELF"
		} else {
			set dhand [nick2hand $dnick]
			if {[check_notavailable {-isbotnick -notonchan -protect -nopermition0 -notishalfop} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $ccs(chanserv,dehop)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	#############################################################################################################
	# Процедуры команд управления войсами (VOICE).
	
	proc cmd_csvoice {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		variable ccs
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-isvoice} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $ccs(chanserv,voice)]
			put_log "SELF"
		} else {
			if {[check_notavailable {-notonchan -isvoice} -dnick $dnick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $ccs(chanserv,voice)]
			put_log "$dnick"
		}
		return 1
		
	}
	
	proc cmd_csdevoice {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		variable ccs
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notisvoice} -dnick $snick -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $snick] $ccs(chanserv,devoice)]
			put_log "SELF"
		} else {
			set dhand [nick2hand $dnick]
			if {[check_notavailable {-isbotnick -notonchan -protect -nopermition0 -notisvoice} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
			putquick [string map [list {%chan} $schan {%nick} $dnick] $ccs(chanserv,devoice)]
			put_log "$dnick"
		}
		return 1
		
	}
	
}