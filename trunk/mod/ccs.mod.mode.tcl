##################################################################################################################
## ������ � �������� ��������� ����������
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"mode"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"������ ���������� ������ ������."

if {$ccs(mod,name,$modname)} {
	
	cconfigure op -add -group "mode" -flags {o|o} -block 1 \
		-alias {%pref_op} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure deop -add -group "mode" -flags {o|o} -block 1 \
		-alias {%pref_deop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure hop -add -group "mode" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_hop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure dehop -add -group "mode" -flags {l|l} -use 0 -block 1 \
		-alias {%pref_dehop} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure voice -add -group "mode" -flags {v|v o|o} -block 1 -useauth 0 \
		-alias {%pref_voice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure devoice -add -group "mode" -flags {v|v o|o} -block 1 -useauth 0 \
		-alias {%pref_devoice} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure allvoice -add -group "mode" -flags {m|m} -block 5 \
		-alias {%pref_allvoice} \
		-regexp {{^$} {}}
	
	cconfigure alldevoice -add -group "mode" -flags {m|m} -block 1 \
		-alias {%pref_alldevoice} \
		-regexp {{^$} {}}
	
	cconfigure mode -add -group "mode" -flags {o|o} \
		-alias {%pref_mode} \
		-regexp {{^(.+?)$} {-> smode}}
	
	
	#############################################################################################################
	# ��������� ������ ���������� ����� � ������ (OP, HOP).
	
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
	# ��������� ������ ���������� ������� (VOICE).
	
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