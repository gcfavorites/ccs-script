##################################################################################################################
## Модуль управления игнорами
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"ignore"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"Модуль управления списком игноров."

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Значение по умолчанию, которое определяет маску по умолчанию для выставления игнора. Значение может быть
	# переопределено выставлением канального флага ccs-ignoremask.
	# Доступные значения:
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
	set ccs(ignoremask)			4
	
	cconfigure addignore -add -group "other" -flags {o} -block 3 -usechan 0 \
		-alias {%pref_addignore %pref_+ignore} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ +(.*?))?$} {-> dnick stime reason}}
	
	cconfigure delignore -add -group "other" -flags {o} -block 1 -usechan 0 \
		-alias {%pref_delignore %pref_-ignore} \
		-regexp {{^([^\ ]+)$} {-> ignore}}
	
	cconfigure ignorelist -add -group "other" -flags {m} -block 3 -usechan 0 \
		-alias {%pref_ignorelist %pref_ignores} \
		-regexp {{^$} {}}
	
	setudef str ccs-ignoremask
	
	#############################################################################################################
	# Процедуры команд управления игнорами (IGNORES).
	
	proc cmd_addignore {} {
		importvars [list onick ochan obot snick shand schan command dnick stime reason]
		variable ccs
		
		if {$stime == ""} {set stime 1440}
		if {$reason == ""} {set reason [sprintf ignore #101]}
		
		if {[onchan $dnick]} {
			set dhand [nick2hand $dnick]
			set dhost [get_mask "$dnick![getchanhost $dnick]" [get_options "ignoremask"]]
		} else {
			set dhand [finduser $dnick]
			set dhost $dnick
		}
		if {[check_notavailable {-isbotnick -protect -nopermition0} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		if {$stime == 0} {
			put_msg [sprintf ignore #103 $dhost]
			put_log "$dhost \002(permanently)\002."
		} else {
			set btime [expr $stime * 60]
			if {$ccs(bandate)} {set reason [sprintf ignore #107 $reason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf ignore #102 $dhost [xdate [duration $btime]]]
			put_log "$dhost at [duration $btime]."
		}
		newignore $dhost $shand $reason $stime
		return 1
		
	}
	
	proc cmd_delignore {} {
		importvars [list onick ochan obot snick shand schan command ignore]
		
		if {![killignore $ignore]} {put_msg [sprintf ignore #105 $ignore]; return 0}
		put_msg [sprintf ignore #104 $ignore]
		put_log "$ignore."
		return 1
		
	}
	
	proc cmd_ignorelist {} {
		importvars [list onick ochan obot snick shand schan command]
		
		put_msg [sprintf ignore #106] -speed 3
		set date [ignorelist]
		
		if {[llength $date] == 0} {
			put_msg [sprintf ignore #110] -speed 3
		} else {
			foreach _ $date {
				foreach {what comment expire added by} $_ break
				if {$expire == 0} {set expire [sprintf ignore #107]} else {
					set expire [sprintf ignore #108 [xdate [duration [expr $expire - [unixtime]]]]]
				}
				put_msg [sprintf ignore #109 $what $comment $expire [xdate [duration [expr [unixtime] - $added]]] $by] -speed 3
			}
		}
		put_msg [sprintf ignore #111] -speed 3
		put_log ""
		return 1
		
	}
	
	
}