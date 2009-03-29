##################################################################################################################
## Модуль с базовыми командами управления
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"mode"
addmod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.2.4" \
				"20-Oct-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"op"
	lappend ccs(commands)	"deop"
	lappend ccs(commands)	"hop"
	lappend ccs(commands)	"dehop"
	lappend ccs(commands)	"voice"
	lappend ccs(commands)	"devoice"
	lappend ccs(commands)	"allvoice"
	lappend ccs(commands)	"alldevoice"
	lappend ccs(commands)	"mode"
	
	set ccs(group,op) "mode"
	set ccs(flags,op) {o|o}
	set ccs(alias,op) {%pref_op}
	set ccs(block,op) 1
	set ccs(regexp,op) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,deop) "mode"
	set ccs(flags,deop) {o|o}
	set ccs(alias,deop) {%pref_deop}
	set ccs(block,deop) 1
	set ccs(regexp,deop) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,hop) "mode"
	set ccs(use,hop) 0
	set ccs(flags,hop) {l|l}
	set ccs(alias,hop) {%pref_hop}
	set ccs(block,hop) 1
	set ccs(regexp,hop) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,dehop) "mode"
	set ccs(use,dehop) 0
	set ccs(flags,dehop) {l|l}
	set ccs(alias,dehop) {%pref_dehop}
	set ccs(block,dehop) 1
	set ccs(regexp,dehop) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,voice) "mode"
	set ccs(use_auth,voice) 0
	set ccs(flags,voice) {v|v o|o}
	set ccs(alias,voice) {%pref_voice}
	set ccs(block,voice) 1
	set ccs(regexp,voice) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,devoice) "mode"
	set ccs(use_auth,devoice) 0
	set ccs(flags,devoice) {v|v o|o}
	set ccs(alias,devoice) {%pref_devoice}
	set ccs(block,devoice) 1
	set ccs(regexp,devoice) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,allvoice) "mode"
	set ccs(use_auth,allvoice) 0
	set ccs(flags,allvoice) {m|m}
	set ccs(alias,allvoice) {%pref_allvoice}
	set ccs(block,allvoice) 3
	set ccs(regexp,allvoice) {{^$} {}}
	
	set ccs(group,alldevoice) "mode"
	set ccs(use_auth,alldevoice) 0
	set ccs(flags,alldevoice) {m|m}
	set ccs(alias,alldevoice) {%pref_alldevoice}
	set ccs(block,alldevoice) 3
	set ccs(regexp,alldevoice) {{^$} {}}
	
	set ccs(group,mode) "mode"
	set ccs(flags,mode) {o|o}
	set ccs(alias,mode) {%pref_mode}
	set ccs(regexp,mode) {{^(.+?)$} {-> smode}}
	
	
	#############################################################################################################
	# Процедуры команд управления Опами и Хопами (OP, HOP).
	
	proc cmd_op {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-isop} -dnick $snick -dchan $schan]} {return 0}
			pushmode $schan +o $snick
			put_log "SELF"
		} else {
			foreach _ [split $dnick ,] {
				if {[string is space $_]} continue
				if {[check_notavailable {-notonchan -isop -bitch} -dnick $_ -dchan $schan]} continue
				pushmode $schan +o $_
			}
			put_log "$dnick"
		}
		flushmode $schan
		return 1
		
	}
	
	proc cmd_deop {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notisop} -dnick $snick -dchan $schan]} {return 0}
			pushmode $schan -o $snick
			put_log "SELF"
		} else {
			foreach _ [split $dnick ,] {
				if {[string is space $_]} continue
				set dhand [nick2hand $_]
				if {[check_notavailable {-isbotnick -notonchan -protect -nopermition1 -notisop} -shand $shand -dnick $_ -dhand $dhand -dchan $schan]} continue
				pushmode $schan -o $_
			}
			put_log "$dnick"
		}
		flushmode $schan
		return 1
		
	}
	
	proc cmd_hop {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-ishalfop -botisnotmode} -dnick $snick -dchan $schan]} {return 0}
			pushmode $schan +h $snick
			put_log "SELF"
		} else {
			foreach _ [split $dnick ,] {
				if {[string is space $_]} continue
				if {[check_notavailable {-notonchan -ishalfop -botisnotmode} -dnick $_ -dchan $schan]} continue
				pushmode $schan +h $_
			}
			put_log "$dnick"
		}
		flushmode $schan
		return 1
		
	}
	
	proc cmd_dehop {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notishalfop -botisnotmode} -dnick $snick -dchan $schan]} {return 0}
			pushmode $schan -h $snick
			put_log "SELF"
		} else {
			foreach _ [split $dnick ,] {
				if {[string is space $_]} continue
				set dhand [nick2hand $_]
				if {[check_notavailable {-isbotnick -notonchan -protect -nopermition1 -notishalfop -botisnotmode} -shand $shand -dnick $_ -dhand $dhand -dchan $schan]} continue
				pushmode $schan -h $_
			}
			put_log "$dnick"
		}
		flushmode $schan
		return 1
		
	}
	
	#############################################################################################################
	# Процедуры команд управления войсами (VOICE).
	
	proc cmd_voice {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-isvoice -botisnotmode} -dnick $snick -dchan $schan]} {return 0}
			pushmode $schan +v $snick
			put_log "SELF"
		} else {
			foreach _ [split $dnick ,] {
				if {[string is space $_]} continue
				if {[check_notavailable {-notonchan -isvoice -botisnotmode} -dnick $_ -dchan $schan]} continue
				pushmode $schan +v $_
			}
			put_log "$dnick"
		}
		flushmode $schan
		return 1
		
	}
	
	proc cmd_devoice {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[string is space $dnick]} {
			if {[check_notavailable {-notisvoice -botisnotmode} -dnick $snick -dchan $schan]} {return 0}
			pushmode $schan -v $snick
			put_log "SELF"
		} else {
			foreach _ [split $dnick ,] {
				if {[string is space $_]} continue
				set dhand [nick2hand $_]
				if {[check_notavailable {-isbotnick -notonchan -protect -nopermition1 -notisvoice -botisnotmode} -shand $shand -dnick $_ -dhand $dhand -dchan $schan]} continue
				pushmode $schan -v $_
			}
			put_log "$dnick"
		}
		flushmode $schan
		return 1
		
	}
	
	proc cmd_allvoice {} {
		importvars [list onick ochan obot snick shand schan command]
		
		if {[check_notavailable {-botisnotmode} -dchan $schan]} {return 0}
		
		foreach _ [chanlist $schan] {if {![isvoice $_ $schan]} {pushmode $schan +v $_}}
		flushmode $schan
		
		put_log ""
		return 1
		
	}
	
	proc cmd_alldevoice {} {
		importvars [list onick ochan obot snick shand schan command]
		global modes-per-line
		
		if {[check_notavailable {-botisnotmode} -dchan $schan]} {return 0}
		
		foreach _ [chanlist $schan] {if {[isvoice $_ $schan]} {pushmode $schan -v $_}}
		flushmode $schan
		
		put_log ""
		return 1
		
	}
	
	proc cmd_mode {} {
		importvars [list onick ochan obot snick shand schan command smode]
		
		if {[check_notavailable {-botisnotmode} -dchan $schan]} {return 0}
		putserv "MODE $schan $smode"
		put_log "$smode"
		return 1
		
	}
	
	proc notavailable-botisnotmode {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dchan dchan
		if {![botisop $dchan] && ![botishalfop $dchan]} {
			put_msg [sprintf mode #101]
			return 1
		}
		return 0
	}
	
}