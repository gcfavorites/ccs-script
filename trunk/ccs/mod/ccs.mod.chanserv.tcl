##################################################################################################################
## Модуль управления через ChanServ
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"chanserv"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.2" \
				"26-Okt-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"csop"
	lappend ccs(commands)	"csdeop"
	lappend ccs(commands)	"cshop"
	lappend ccs(commands)	"csdehop"
	lappend ccs(commands)	"csvoice"
	lappend ccs(commands)	"csdevoice"
	
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
	
	set ccs(group,csop) "chanserv"
	set ccs(flags,csop) {o|o}
	set ccs(alias,csop) {%pref_csop}
	set ccs(block,csop) 1
	set ccs(regexp,csop) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,csdeop) "chanserv"
	set ccs(flags,csdeop) {o|o}
	set ccs(alias,csdeop) {%pref_csdeop}
	set ccs(block,csdeop) 1
	set ccs(regexp,csdeop) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,cshop) "chanserv"
	set ccs(use,cshop) 0
	set ccs(flags,cshop) {l|l}
	set ccs(alias,cshop) {%pref_cshop}
	set ccs(block,cshop) 1
	set ccs(regexp,cshop) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,csdehop) "chanserv"
	set ccs(use,csdehop) 0
	set ccs(flags,csdehop) {l|l}
	set ccs(alias,csdehop) {%pref_csdehop}
	set ccs(block,csdehop) 1
	set ccs(regexp,csdehop) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,csvoice) "chanserv"
	set ccs(use_auth,csvoice) 0
	set ccs(flags,csvoice) {v|v o|o}
	set ccs(alias,csvoice) {%pref_csvoice}
	set ccs(block,csvoice) 1
	set ccs(regexp,csvoice) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,csdevoice) "chanserv"
	set ccs(use_auth,csdevoice) 0
	set ccs(flags,csdevoice) {v|v o|o}
	set ccs(alias,csdevoice) {%pref_csdevoice}
	set ccs(block,csdevoice) 1
	set ccs(regexp,csdevoice) {{^([^\ ]+)?$} {-> dnick}}
	
	
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