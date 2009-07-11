####################################################################################################
## Модуль управления исключениями
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{exempt}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль управления списком исключений."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# Отображать в причине дату/время снятия исключения. (0 - нет, 1 - да)
	set options(exemptdate)		1
	
	################################################################################################
	# Значение по умолчанию, которое определяет маску по умолчанию для выставления исключения.
	# Значение может быть переопределено выставлением канального флага ccs-exemptmask.
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
	set options(exemptmask)		4
	
	cmd_configure exempt -control -group "exempt" -flags {o|o} -block 1 \
		-alias {%pref_exempt} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	cmd_configure unexempt -control -group "exempt" -flags {o|o} -block 1 -use_auth 0 -use_chan 0 -use_botnet 0 \
		-alias {%pref_unexempt} \
		-regexp {{^([^\ ]+)$} {-> sexempt}}
	
	cmd_configure gexempt -control -group "exempt" -flags {o} -block 1 -use_chan 0 \
		-alias {%pref_gexempt} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	cmd_configure gunexempt -control -group "exempt" -flags {o} -block 1 -use_chan 0 \
		-alias {%pref_gunexempt} \
		-regexp {{^([^\ ]+)$} {-> sexempt}}
	
	cmd_configure exemptlist -control -group "exempt" -flags {o|o} -block 5 -use_chan 3 \
		-alias {%pref_exemptlist %pref_exempts} \
		-regexp {{^((?!global)[^\ ]+)?(?:\s*(global))?$} {-> smask sglobal}}
	
	cmd_configure resetexempts -control -group "exempt" -flags {o|o} -block 5 \
		-alias {%pref_resetexempts} \
		-regexp {{^$} {}}
	
	setudef str ccs-exemptmask
	
	################################################################################################
	################################################################################################
	################################################################################################
	
	################################################################################################
	# Процедуры команд управления исключениями (+e)
	
	proc cmd_exempt {} {
		upvar out out
		importvars [list snick shand schan command dnick stime sreason stick]
		variable options
		
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
			if {$options(exemptdate)} {set sreason [sprintf exempt #103 $sreason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf exempt #104 $sstick $dhost [xdate [duration $btime]]]
			put_log "$dstick $dhost at [duration $btime]."
		}
		newchanexempt $schan $dhost $shand $sreason $stime $stick
		return 1
		
	}
	
	proc cmd_unexempt {} {
		upvar out out
		importvars [list snick shand schan command sexempt]
		
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
		upvar out out
		importvars [list snick shand schan command dnick stime sreason stick]
		
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
		upvar out out
		importvars [list snick shand schan command sexempt]
		
		set sexempt [string trim $sexempt]
		set stick [isexemptsticky $sexempt]
		
		if {![killexempt $sexempt]} {put_msg [sprintf exempt #111 $sexempt]; return 0}
		put_msg [sprintf exempt #110 [expr {$stick ? " [sprintf exempt #120]" : ""}] $sexempt]
		put_log "[expr {$stick ? "STICK" : ""}] $sexempt"
		return 1
		
	}
	
	proc cmd_exemptlist {} {
		upvar out out
		importvars [list snick shand schan command smask sglobal]
		
		set global [expr ![string is space $sglobal]]
		if {$smask != ""} {set text_m " [sprintf exempt #121 $smask]"} else {set text_m ""}
		if {$global} {
			put_msg  -speed 3 -- [sprintf exempt #112 $text_m]
			set date [exemptlist]
			set сexempts [list]
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			put_msg  -speed 3 -- [sprintf exempt #113 $schan $text_m]
			set date [exemptlist $schan]
			set сexempts [chanexempts $schan]
		}
		
		set find 0
		foreach _ $date {
			lassign $_ exempt comment expire added timeactive bywho
			
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
					lassign $_1 exempt1 bywho1 age1
					
					if {[string match -nocase $exempt1 $exempt]} {
						set text_cb " [sprintf exempt #122 $bywho1 [xdate [duration $age1]]]"
						set сexempts [lreplace $сexempts $ind $ind]
						break
					}
					incr ind
				}
			}
			put_msg -speed 3 -- [sprintf exempt #117 $exempt [expr {$stick ? " ([sprintf exempt #120])" : ""}] $comment $expire $passed $bywho $text_cb]
			set find 1
			
		}
		if {!$find} {put_msg -speed 3 -- [sprintf exempt #114]}
		
		set tout 0
		foreach _ $сexempts {
			lassign $_ exempt bywho age
			if {$smask != "" && ![string match -nocase $smask $exempt]} {continue}
			if {!$tout} {put_msg -speed 3 -- [sprintf exempt #123]; set tout 1}
			put_msg -speed 3 -- [sprintf exempt #124 $exempt $bywho [xdate [duration $age]]]
		}
		
		put_msg -speed 3 -- [sprintf exempt #118]
		put_log ""
		return 1
		
	}
	
	proc cmd_resetexempts {} {
		upvar out out
		importvars [list snick shand schan command]
		
		resetexempts $schan
		put_msg [sprintf exempt #119]
		put_log ""
		return 1
		
	}
	
}
