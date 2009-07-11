####################################################################################################
## ћодуль управлени€ игнорами
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{ignore}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"ћодуль управлени€ списком игноров."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# ќтображать в причине дату/врем€ сн€ти€ игнора. (0 - нет, 1 - да)
	set options(ignoredate)		1
	
	################################################################################################
	# «начение по умолчанию, которое определ€ет маску по умолчанию дл€ выставлени€ игнора.
	# «начение может быть переопределено выставлением канального флага ccs-ignoremask.
	# ƒоступные значени€:
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
	set options(ignoremask)			4
	
	cmd_configure addignore -control -group "other" -flags {o} -block 3 -use_chan 0 \
		-alias {%pref_addignore %pref_+ignore} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ +(.*?))?$} {-> dnick stime reason}}
	
	cmd_configure delignore -control -group "other" -flags {o} -block 1 -use_chan 0 \
		-alias {%pref_delignore %pref_-ignore} \
		-regexp {{^([^\ ]+)$} {-> ignore}}
	
	cmd_configure ignorelist -control -group "other" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_ignorelist %pref_ignores} \
		-regexp {{^$} {}}
	
	setudef str ccs-ignoremask
	
	################################################################################################
	# ѕроцедуры команд управлени€ игнорами (IGNORES).
	
	proc cmd_addignore {} {
		upvar out out
		importvars [list snick shand schan command dnick stime reason]
		variable options
		
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
			if {$options(ignoredate)} {set reason [sprintf ignore #107 $reason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf ignore #102 $dhost [xdate [duration $btime]]]
			put_log "$dhost at [duration $btime]."
		}
		newignore $dhost $shand $reason $stime
		return 1
		
	}
	
	proc cmd_delignore {} {
		upvar out out
		importvars [list snick shand schan command ignore]
		
		if {![killignore $ignore]} {put_msg [sprintf ignore #105 $ignore]; return 0}
		put_msg [sprintf ignore #104 $ignore]
		put_log "$ignore."
		return 1
		
	}
	
	proc cmd_ignorelist {} {
		upvar out out
		importvars [list snick shand schan command]
		
		put_msg -speed 3 -- [sprintf ignore #106]
		set date [ignorelist]
		
		if {[llength $date] == 0} {
			put_msg -speed 3 -- [sprintf ignore #110]
		} else {
			foreach _ $date {
				lassign $_ what comment expire added by
				if {$expire == 0} {set expire [sprintf ignore #107]} else {
					set expire [sprintf ignore #108 [xdate [duration [expr $expire - [unixtime]]]]]
				}
				put_msg -speed 3 -- [sprintf ignore #109 $what $comment $expire [xdate [duration [expr [unixtime] - $added]]] $by]
			}
		}
		put_msg -speed 3 -- [sprintf ignore #111]
		put_log ""
		return 1
		
	}
	
	
}