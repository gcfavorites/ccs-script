####################################################################################################
## ћодуль управлени€ банами
####################################################################################################
# —писок последних изменений:
#	v1.4.2
# - ƒобавлен вывод списка забаненых на момент выставлени€ бана
# - ƒобавлено восстановление маски бана
#	v1.4.1
# - ƒобавлен вывод даты при выводе списка банов

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{ban}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.2" "17-Mar-2010" \
	"ћодуль управлени€ списком банов."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# ќтображать в причине бана дату/врем€ сн€ти€ бана. (0 - нет, 1 - да)
	set options(bandate)		1
	
	################################################################################################
	# ѕровер€ть при сн€тии бана уровень доступа того, кто поставил бан.
	#   0 - сн€ть бан может любой при наличии прав
	#   1 - сн€ть бан может любой человек с равными правами поставившему бан или большими
	#   2 - сн€ть бан может человек поставивший бан или с большими правами
	# «начение может быть переопределено выставлением канального флага ccs-unban_level
	set options(unban_level)	0
	
	################################################################################################
	# «начение по умолчанию, которое определ€ет маску по умолчанию дл€ выставлени€ банов.
	# «начение может быть переопределено выставлением канального флага ccs-banmask.
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
	set options(banmask)		4
	
	cmd_configure ban -control -group "ban" -flags {o|o} -block 1 \
		-alias {%pref_ban} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime reason stick}}
	
	cmd_configure unban -control -group "ban" -flags {o|o} -block 1 \
		-alias {%pref_unban} \
		-regexp {{^([^\ ]+)$} {-> sban}}
	
	cmd_configure gban -control -group "ban" -flags {o} -block 1 -use_chan 0 \
		-alias {%pref_gban} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime reason stick}}
	
	cmd_configure gunban -control -group "ban" -flags {o} -block 1 -use_chan 0 \
		-alias {%pref_gunban} \
		-regexp {{^([^\ ]+)$} {-> sban}}
	
	cmd_configure banlist -control -group "ban" -flags {o|o} -block 3 -use_chan 3 \
		-alias {%pref_banlist %pref_bans} \
		-regexp {{^((?!global)[^\ ]+)?(?:\s*(global))?$} {-> smask sglobal}}
	
	cmd_configure resetbans -control -group "ban" -flags {o|o} -block 5 \
		-alias {%pref_resetbans} \
		-regexp {{^$} {}}
	
	setudef str ccs-banmask
	setudef str ccs-unban_level
	
	################################################################################################
	# ѕроцедуры команд управлени€ банами (+b)
	
	proc cmd_ban {} {
		upvar out out
		importvars [list snick shand schan command dnick stime reason stick]
		variable options
		
		set stick [expr ![string is space $stick]]
		if {$stime == ""} {set stime [channel get $schan ban-time]}
		if {$reason == ""} {set reason [sprintf ban #101]}
		if {$stick} {
			set stick "sticky"
			set sstick " [sprintf ban #105]"
			set dstick "STICK"
		} else {
			set stick "none"
			set sstick ""
			set dstick ""
		}
		
		if {[onchan $dnick $schan]} {
			set dhand [nick2hand $dnick]
			set dhost [get_mask "$dnick![getchanhost $dnick $schan]" [get_options "banmask" $schan]]
		} else {
			set dhand [finduser $dnick]
			set dhost [recovery_mask $dnick]
		}
		if {[check_notavailable {-isbotnick -protect -nopermition0} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		set luser {}
		foreach _1 [chanlist $schan] {
			if {[string match -nocase $dhost "$_1![getchanhost $_1 $schan]"]} {
				lappend luser $_1
			}
		}
		
		if {$stime == 0} {
			put_msg [sprintf ban #102 $sstick $dhost [join $luser ", "]]
			put_log "$dstick $dhost \002(permanently)\002."
		} else {
			set btime [expr $stime * 60]
			if {$options(bandate)} {set reason [sprintf ban #104 $reason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf ban #103 $sstick $dhost [xdate [duration $btime]] [join $luser ", "]]
			put_log "$dstick $dhost at [duration $btime]."
		}
		newchanban $schan $dhost $shand $reason $stime $stick
		if {[onchan $dnick $schan]} {
			putkick $schan $dnick "Banned: $reason"
		} elseif {$dhand != "*"} {
			putkick $schan $dhand "Banned: $reason"
		}
		return 1
		
	}
	
	proc find_ban {sban {schan *}} {
		
		if {[check_isnull $schan]} {set data [banlist]} else {set data [banlist $schan]}
		
		if {[string is digit $sban] && $sban > 0 && $sban <= [llength $data]} {
			return [lindex $data [expr $sban-1]]
		}
		
		foreach _ $data {
			lassign $_ ban comment expire added timeactive bywho
			if {[string equal -nocase $ban $sban]} {return $_}
		}
		return [list]
		
	}
	
	proc cmd_unban {} {
		upvar out out
		importvars [list snick shand schan command sban]
		
		if {[set unban_level [get_options "unban_level" $schan]] > 0} {
			set fban [find_ban $sban $schan]
			if {[llength $fban] > 0} {
				lassign $fban ban comment expire added timeactive dnick
				if {[validuser $dnick] && $shand != $dnick} {
					set saccess [get_accesshand $shand $schan 1]
					set daccess [get_accesshand $dnick $schan]
					switch -exact $unban_level {
						1 {if {$saccess < $daccess} {put_msg [sprintf ban #122 $sban $dnick]; return -code ok 0}}
						2 {if {$saccess <= $daccess} {put_msg [sprintf ban #122 $sban $dnick]; return -code ok 0}}
					}
				}
			}
		}
		
		if {[string is digit $sban]} {
			set fban [find_ban $sban $schan]
			if {[llength $fban] > 0} {
				set sban [lindex $fban 0]
			}
		}
		
		set stick [isbansticky $sban $schan]
		if {[killchanban $schan $sban]} {
			put_msg [sprintf ban #106 [expr {$stick ? " [sprintf ban #105]" : ""}] $sban]
			put_log "[expr {$stick ? "STICK" : ""}] $sban"
			return 1
		} else {
			if {![ischanban $sban $schan]} {put_msg [sprintf ban #107 $sban $schan]; return 0}
			putquick "MODE $schan -b $sban"
			put_msg [sprintf ban #106 "" $sban]
			put_log "MODE $sban"
			return 1
		}
		
	}
	
	proc cmd_gban {} {
		upvar out out
		importvars [list snick shand schan command dnick stime reason stick]
		variable options
		
		set stick [expr ![string is space $stick]]
		if {$stime == ""} {set stime 1440}
		if {$reason == ""} {set reason [sprintf ban #108]}
		if {$stick} {
			set stick "sticky"
			set sstick " [sprintf ban #105]"
			set dstick "STICK"
		} else {
			set stick "none"
			set sstick ""
			set dstick ""
		}
		
		if {[onchan $dnick]} {
			set dhand [nick2hand $dnick]
			set dhost [get_mask "$dnick![getchanhost $dnick]" [get_options "banmask"]]
		} else {
			set dhand [finduser $dnick]
			set dhost [recovery_mask $dnick]
		}
		if {[check_notavailable {-isbotnick -protect -nopermition0} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		set luser {}
		foreach _0 [channels] {
			foreach _1 [chanlist $_0] {
				if {[string match -nocase $dhost "$_1![getchanhost $_1 $_0]"]} {
					lappend luser $_1
				}
			}
		}
		
		if {$stime == 0} {
			put_msg [sprintf ban #109 $sstick $dhost [join $luser ", "]]
			put_log "$dstick $dhost \002(permanently)\002."
		} else {
			set btime [expr $stime * 60]
			if {$options(bandate)} {set reason [sprintf ban #104 $reason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf ban #110 $sstick $dhost [xdate [duration $btime]] [join $luser ", "]]
			put_log "$dstick $dhost at [duration $btime]."
		}
		newban $dhost $shand $reason $stime $stick
		return 1
		
	}
	
	proc cmd_gunban {} {
		upvar out out
		importvars [list snick shand schan command sban]
		
		if {[set unban_level [get_options "unban_level"]] > 0} {
			set fban [find_ban $sban]
			if {[llength $fban] > 0} {
				lassign [find_ban $sban] ban comment expire added timeactive dnick
				if {[validuser $dnick] && $shand != $dnick} {
					set saccess [get_accesshand $shand * 1]
					set daccess [get_accesshand $dnick *]
					switch -exact $unban_level {
						1 {if {$saccess < $daccess} {put_msg [sprintf ban #122 $sban $dnick]; return -code ok 0}}
						2 {if {$saccess <= $daccess} {put_msg [sprintf ban #122 $sban $dnick]; return -code ok 0}}
					}
				}
			}
		}
		
		if {[string is digit $sban]} {
			set fban [find_ban $sban]
			if {[llength $fban] > 0} {
				set sban [lindex $fban 0]
			}
		}
		
		set stick [isbansticky $sban]
		if {![killban $sban]} {
			put_msg [sprintf ban #112 $sban]
			return 0
		}
		put_msg [sprintf ban #111 [expr {$stick ? " [sprintf ban #105]" : ""}] $sban]
		put_log "[expr {$stick ? "STICK" : ""}] $sban"
		return 1
		
	}
	
	proc cmd_banlist {} {
		upvar out out
		variable options
		importvars [list snick shand schan command smask sglobal]
		
		set global [expr ![string is space $sglobal]]
		if {$smask != ""} {set text_m " [sprintf ban #116 $smask]"} else {set text_m ""}
		if {$global} {
			put_msg -speed 3 -- [sprintf ban #113 $text_m]
			set date [banlist]
			set cbans [list]
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			put_msg -speed 3 -- [sprintf ban #114 $schan $text_m]
			set date [banlist $schan]
			set cbans [chanbans $schan]
		}
		
		set find 0
		set ind 1
		foreach _ $date {
			lassign $_ ban comment expire added timeactive bywho
			
			if {$smask != "" && ![string match -nocase $smask $ban]} {continue}
			if {$expire == 0} {
				set expire [sprintf ban #117]
			} else {
				set expire [sprintf ban #118 [xdate [duration [expr $expire - [unixtime]]]]]
			}
			set passed [xdate [duration [expr [unixtime] - $added]]]
			set text_cb ""
			if {$global} {
				set stick [isbansticky $ban]
			} else {
				set stick [isbansticky $ban $schan]
				set ind1 0
				foreach _1 $cbans {
					lassign $_1 ban1 bywho1 age1
					if {[string match -nocase $ban1 $ban]} {
						set text_cb " [sprintf ban #123 $bywho1 [xdate [duration $age1]] [clock format [expr [unixtime] - $age1] -format $options(time_format)]]"
						set cbans [lreplace $cbans $ind1 $ind1]
						break
					}
					incr ind1
				}
			}
			put_msg -speed 3 -- [sprintf ban #119 $ind $ban [expr {$stick ? " ([sprintf ban #105])" : ""}] $comment $expire $passed [clock format $added -format $options(time_format)] $bywho $text_cb]
			set find 1
			
			incr ind
		}
		if {!$find} {put_msg -speed 3 -- [sprintf ban #115]}
		
		set tout 0
		foreach _ $cbans {
			lassign $_ ban bywho age
			if {$smask != "" && ![string match -nocase $smask $ban]} {continue}
			if {!$tout} {put_msg -speed 3 -- [sprintf ban #124]; set tout 1}
			put_msg -speed 3 -- [sprintf ban #125 $ban $bywho [xdate [duration $age]] [clock format [expr [unixtime] - $age] -format $options(time_format)]]
		}
		
		put_msg -speed 3 -- [sprintf ban #120]
		put_log ""
		return 1
		
	}
	
	proc cmd_resetbans {} {
		upvar out out
		importvars [list snick shand schan command]
		
		resetbans $schan
		put_msg [sprintf ban #121]
		put_log ""
		return 1
		
	}
	
}