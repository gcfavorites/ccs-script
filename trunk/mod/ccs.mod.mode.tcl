####################################################################################################
## Модуль с базовыми командами управления
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{mode}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.1" "05-Nov-2009" \
	"Модуль управления модами канала."

if {[pkg_info mod $_name on]} {
	
	cmd_configure op -control -group "mode" -flags {o|o} -block 1 \
		-alias {%pref_op} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure deop -control -group "mode" -flags {o|o} -block 1 \
		-alias {%pref_deop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure hop -control -group "mode" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_hop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure dehop -control -group "mode" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_dehop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure voice -control -group "mode" -flags {v|v o|o} -block 1 -use_auth 0 \
		-alias {%pref_voice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure devoice -control -group "mode" -flags {v|v o|o} -block 1 -use_auth 0 \
		-alias {%pref_devoice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure allvoice -control -group "mode" -flags {m|m} -block 5 \
		-alias {%pref_allvoice} \
		-regexp {{^$} {}}
	
	cmd_configure alldevoice -control -group "mode" -flags {m|m} -block 1 \
		-alias {%pref_alldevoice} \
		-regexp {{^$} {}}
	
	cmd_configure mode -control -group "mode" -flags {o|o} \
		-alias {%pref_mode} \
		-regexp {{^(.+?)$} {-> smode}}
	
	################################################################################################
	# Процедуры команд управления Опами и Хопами (OP, HOP).
	
	proc cmd_op {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		
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
		upvar out out
		importvars [list snick shand schan command dnick]
		
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
		upvar out out
		importvars [list snick shand schan command dnick]
		
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
		upvar out out
		importvars [list snick shand schan command dnick]
		
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
	
	################################################################################################
	# Процедуры команд управления войсами (VOICE).
	
	proc cmd_voice {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		
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
		upvar out out
		importvars [list snick shand schan command dnick]
		
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
		upvar out out
		importvars [list snick shand schan command]
		
		if {[check_notavailable {-botisnotmode} -dchan $schan]} {return 0}
		
		foreach _ [chanlist $schan] {if {![isvoice $_ $schan]} {pushmode $schan +v $_}}
		flushmode $schan
		
		put_log ""
		return 1
		
	}
	
	proc cmd_alldevoice {} {
		upvar out out
		importvars [list snick shand schan command]
		global modes-per-line
		
		if {[check_notavailable {-botisnotmode} -dchan $schan]} {return 0}
		
		foreach _ [chanlist $schan] {if {[isvoice $_ $schan]} {pushmode $schan -v $_}}
		flushmode $schan
		
		put_log ""
		return 1
		
	}
	
	proc cmd_mode {} {
		upvar out out
		importvars [list snick shand schan command smode]
		
		if {[check_notavailable {-botisnotmode} -dchan $schan]} {return 0}
		putserv "MODE $schan $smode"
		put_log "$smode"
		return 1
		
	}
	
	proc notavailable-botisnotmode {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dchan dchan
		if {![botisop $dchan] && ![botishalfop $dchan]} {
			put_msg [sprintf mode #101]
			return 1
		}
		return 0
	}
	
	proc set_net_type_$_name {net_type} {
		
		switch -exact -- $net_type {
			1 {
				cmd_configure hop -use 0
				cmd_configure dehop -use 0
			}
			2 {
				cmd_configure hop -use 1
				cmd_configure dehop -use 1
			}
			3 {
				cmd_configure hop -use 0
				cmd_configure dehop -use 0
			}
			4 {
				cmd_configure hop -use 0
				cmd_configure dehop -use 0
			}
			5 {
				cmd_configure hop -use 0
				cmd_configure dehop -use 0
			}
			6 {
				cmd_configure hop -use 0
				cmd_configure dehop -use 0
			}
			7 {
				cmd_configure hop -use 1
				cmd_configure dehop -use 1
			}
		}
		
	}
	
}