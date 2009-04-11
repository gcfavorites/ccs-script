##################################################################################################################
## Модуль управления исключениями
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"exempt"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"Модуль управления списком исключений."

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Значение по умолчанию, которое определяет маску по умолчанию для выставления исключения. Значение может
	# быть переопределено выставлением канального флага ccs-exemptmask.
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
	set ccs(exemptmask)		4
	
	cconfigure exempt -add -group "exempt" -flags {o|o} -block 1 \
		-alias {%pref_exempt} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	cconfigure unexempt -add -group "exempt" -flags {o|o} -block 1 -useauth 0 -usechan 0 -usebotnet 0 \
		-alias {%pref_unexempt} \
		-regexp {{^([^\ ]+)$} {-> sexempt}}
	
	cconfigure gexempt -add -group "exempt" -flags {o} -block 1 -usechan 0 \
		-alias {%pref_gexempt} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	cconfigure gunexempt -add -group "exempt" -flags {o} -block 1 -usechan 0 \
		-alias {%pref_gunexempt} \
		-regexp {{^([^\ ]+)$} {-> sexempt}}
	
	cconfigure exemptlist -add -group "exempt" -flags {o|o} -block 5 -usechan 3 \
		-alias {%pref_exemptlist %pref_exempts} \
		-regexp {{^((?!global)[^\ ]+)?(?:\s*(global))?$} {-> smask sglobal}}
	
	cconfigure resetexempts -add -group "exempt" -flags {o|o} -block 5 \
		-alias {%pref_resetexempts} \
		-regexp {{^$} {}}
	
	set ccs(group,resetexempts) "exempt"
	set ccs(flags,resetexempts) {o|o}
	set ccs(alias,resetexempts) {%pref_resetexempts}
	set ccs(block,resetexempts) 5
	set ccs(regexp,resetexempts) {{^$} {}}
	
	setudef str ccs-exemptmask
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	#############################################################################################################
	# Процедуры команд управления исключениями (+e)
	
	proc cmd_exempt {} {
		importvars [list onick ochan obot snick shand schan command dnick stime sreason stick]
		variable ccs
		
		set stick [expr ![string is space $stick]]
		if {$stime == ""} {set stime [channel get $schan exempt-time]}
		if {$sreason == ""} {set sreason [sprintf exempt #101]}
		if {$stick} {
			set stick "sticky"
			set sstick " [sprintf exempt #120]"
			set dstick "STICK"
		} else {
			set stick "none"
			set sstick ""
			set dstick ""
		}
		
		if {[onchan $dnick $schan]} {
			set dhost [get_mask "$dnick![getchanhost $dnick $schan]" [get_options "exemptmask" $schan]]
		} else {
			set dhost $dnick
		}
		
		if {$stime == 0} {
			put_msg [sprintf exempt #102 $sstick $dhost]
			put_log "$dstick $dhost \002(permanently)\002."
		} else {
			set btime [expr $stime * 60]
			if {$ccs(bandate)} {set sreason [sprintf exempt #103 $sreason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf exempt #104 $sstick $dhost [xdate [duration $btime]]]
			put_log "$dstick $dhost at [duration $btime]."
		}
		newchanexempt $schan $dhost $shand $sreason $stime $stick
		return 1
		
	}
	
	proc cmd_unexempt {} {
		importvars [list onick ochan obot snick shand schan command sexempt]
		variable ccs
		
		set stick [isexemptsticky $sexempt $schan]
		if {[killchanexempt $schan $sexempt]} {
			put_msg [sprintf exempt #105 [expr {$stick ? " [sprintf exempt #120]" : ""}] $sexempt]
			put_log "[expr {$stick ? "STICK" : ""}] $sexempt"
			return 1
		} else {
			if {![ischanexempt $sexempt $schan]} {
				put_msg [sprintf exempt #106 $sexempt $schan]
				return 0
			}
			putquick "MODE $schan -e $sexempt"
			put_msg [sprintf exempt #105 "" $sexempt]
			put_log "$sexempt"
			return 1
		}
		
	}
	
	proc cmd_gexempt {} {
		importvars [list onick ochan obot snick shand schan command dnick stime sreason stick]
		variable ccs
		
		set stick [expr ![string is space $stick]]
		if {$stime == ""} {set stime 1440}
		if {$sreason == ""} {set sreason [sprintf exempt #107]}
		if {$stick} {
			set stick "sticky"
			set sstick " [sprintf exempt #120]"
			set dstick "STICK"
		} else {
			set stick "none"
			set sstick ""
			set dstick ""
		}
		
		if {$stime == 0} {
			put_msg [sprintf exempt #108 $sstick $dnick]
			put_log "$dstick $dnick \002(pernament)\002."
		} else {
			set btime [expr $stime * 60]
			put_msg [sprintf exempt #109 $sstick $dnick [xdate [duration $btime]]]
			put_log "$dstick $dnick at [duration $btime]."
		}
		newexempt $dnick $shand $sreason $stime $stick
		return 1
		
	}
	
	proc cmd_gunexempt {} {
		importvars [list onick ochan obot snick shand schan command sexempt]
		variable ccs
		
		set sexempt [string trim $sexempt]
		set stick [isexemptsticky $sexempt]
		
		if {![killexempt $sexempt]} {put_msg [sprintf exempt #111 $sexempt]; return 0}
		put_msg [sprintf exempt #110 [expr {$stick ? " [sprintf exempt #120]" : ""}] $sexempt]
		put_log "[expr {$stick ? "STICK" : ""}] $sexempt"
		return 1
		
	}
	
	proc cmd_exemptlist {} {
		importvars [list onick ochan obot snick shand schan command smask sglobal]
		variable ccs
		
		set global [expr ![string is space $sglobal]]
		if {$smask != ""} {set text_m " [sprintf exempt #121 $smask]"} else {set text_m ""}
		if {$global} {
			put_msg [sprintf exempt #112 $text_m] -speed 3
			set date [exemptlist]
			set сexempts [list]
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			put_msg [sprintf exempt #113 $schan $text_m] -speed 3
			set date [exemptlist $schan]
			set сexempts [chanexempts $schan]
		}
		
		set find 0
		foreach _ $date {
			
			foreach {exempt comment expire added timeactive bywho} $_ break
			if {$smask != "" && ![string match -nocase $smask $exempt]} {continue}
			if {$expire == 0} {
				set expire [sprintf exempt #115]
			} else {
				set expire [sprintf exempt #116 [xdate [duration [expr $expire - [unixtime]]]]]
			}
			set passed [xdate [duration [expr [unixtime] - $added]]]
			set text_cb ""
			if {$global} {
				set stick [isexemptsticky $exempt]
			} else {
				set stick [isexemptsticky $exempt $schan]
				set ind 0
				foreach _1 $сexempts {
					foreach {exempt1 bywho1 age1} $_1 break
					if {[string match -nocase $exempt1 $exempt]} {
						set text_cb " [sprintf exempt #122 $bywho1 [xdate [duration $age1]]]"
						set сexempts [lreplace $сexempts $ind $ind]
						break
					}
					incr ind
				}
			}
			put_msg [sprintf exempt #117 $exempt [expr {$stick ? " ([sprintf exempt #120])" : ""}] $comment $expire $passed $bywho $text_cb] -speed 3
			set find 1
			
		}
		if {!$find} {put_msg [sprintf exempt #114] -speed 3}
		
		set tout 0
		foreach _ $сexempts {
			foreach {exempt bywho age} $_ break
			if {$smask != "" && ![string match -nocase $smask $exempt]} {continue}
			if {!$tout} {put_msg [sprintf exempt #123] -speed 3; set tout 1}
			put_msg [sprintf exempt #124 $exempt $bywho [xdate [duration $age]]] -speed 3
		}
		
		put_msg [sprintf exempt #118] -speed 3
		put_log ""
		return 1
		
	}
	
	proc cmd_resetexempts {} {
		importvars [list onick ochan obot snick shand schan command]
		variable ccs
		
		resetexempts $schan
		put_msg [sprintf exempt #119]
		put_log ""
		return 1
		
	}
	
}
