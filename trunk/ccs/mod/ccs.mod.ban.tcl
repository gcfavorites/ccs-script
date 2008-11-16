##################################################################################################################
## Модуль управления банами
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"ban"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.5" \
				"27-Okt-2008"

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Отображать в причине бана дату/время снятия бана. (0 - нет, 1 - да)
	set ccs(bandate)		1
	
	#############################################################################################################
	# Проверять при снятии бана уровень доступа того, кто поставил бан.
	#   0 - снять бан может любой при наличии прав
	#   1 - снять бан может любой человек с равными правами поставившему бан или большими
	#   2 - снять бан может человек поставивший бан или с большими правами
	# Значение может быть переопределено выставлением канального флага ccs-unban_level
	set ccs(unban_level)	0
	
	#############################################################################################################
	# Значение по умолчанию, которое определяет маску по умолчанию для выставления банов. Значение может быть
	# переопределено выставлением канального флага ccs-banmask.
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
	set ccs(banmask)		4
	
	lappend ccs(commands)	"ban"
	lappend ccs(commands)	"unban"
	lappend ccs(commands)	"gban"
	lappend ccs(commands)	"gunban"
	lappend ccs(commands)	"banlist"
	lappend ccs(commands)	"resetbans"
	
	set ccs(group,ban) "ban"
	set ccs(flags,ban) {o|o}
	set ccs(alias,ban) {%pref_ban}
	set ccs(block,ban) 1
	set ccs(regexp,ban) {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime reason stick}}
	
	set ccs(group,unban) "ban"
	set ccs(flags,unban) {o|o}
	set ccs(alias,unban) {%pref_unban}
	set ccs(block,unban) 1
	set ccs(regexp,unban) {{^([^\ ]+)$} {-> sban}}
	
	set ccs(group,gban) "ban"
	set ccs(use_chan,gban) 0
	set ccs(flags,gban) {o}
	set ccs(alias,gban) {%pref_gban}
	set ccs(block,gban) 1
	set ccs(regexp,gban) {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime reason stick}}
	
	set ccs(group,gunban) "ban"
	set ccs(use_chan,gunban) 0
	set ccs(flags,gunban) {o}
	set ccs(alias,gunban) {%pref_gunban}
	set ccs(block,gunban) 1
	set ccs(regexp,gunban) {{^([^\ ]+)$} {-> sban}}
	
	set ccs(group,banlist) "ban"
	set ccs(use_chan,banlist) 3
	set ccs(flags,banlist) {o|o}
	set ccs(alias,banlist) {%pref_banlist %pref_bans}
	set ccs(block,banlist) 3
	set ccs(regexp,banlist) {{^((?!global)[^\ ]+)?(?:\s*(global))?$} {-> smask sglobal}}
	
	set ccs(group,resetbans) "ban"
	set ccs(flags,resetbans) {o|o}
	set ccs(alias,resetbans) {%pref_resetbans}
	set ccs(block,resetbans) 5
	set ccs(regexp,resetbans) {{^$} {}}
	
	setudef str ccs-banmask
	setudef str ccs-unban_level
	
	#############################################################################################################
	# Процедуры команд управления банами (+b)
	
	proc cmd_ban {} {
		importvars [list onick ochan obot snick shand schan command dnick stime reason stick]
		variable ccs
		
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
			set dhost $dnick
		}
		if {[check_notavailable {-isbotnick -protect -nopermition0} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		if {$stime == 0} {
			put_msg [sprintf ban #102 $sstick $dhost]
			put_log "$dstick $dhost \002(permanently)\002."
		} else {
			set btime [expr $stime * 60]
			if {$ccs(bandate)} {set reason [sprintf ban #104 $reason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf ban #103 $sstick $dhost [xdate [duration $btime]]]
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
			foreach {ban comment expire added timeactive bywho} $_ break
			if {[string equal -nocase $ban $sban]} {
				return $_
			}
		}
		return [list]
		
	}
	
	proc cmd_unban {} {
		importvars [list onick ochan obot snick shand schan command sban]
		
		if {[set unban_level [get_options "unban_level" $schan]] > 0} {
			set fban [find_ban $sban $schan]
			if {[llength $fban] > 0} {
				foreach {ban comment expire added timeactive dnick} $fban break
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
		importvars [list onick ochan obot snick shand schan command dnick stime reason stick]
		variable ccs
		
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
			set dhost $dnick
		}
		if {[check_notavailable {-isbotnick -protect -nopermition0} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		if {$stime == 0} {
			put_msg [sprintf ban #109 $sstick $dhost]
			put_log "$dstick $dhost \002(permanently)\002."
		} else {
			set btime [expr $stime * 60]
			if {$ccs(bandate)} {set reason [sprintf ban #104 $reason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf ban #110 $sstick $dhost [xdate [duration $btime]]]
			put_log "$dstick $dhost at [duration $btime]."
		}
		newban $dhost $shand $reason $stime $stick
		return 1
		
	}
	
	proc cmd_gunban {} {
		importvars [list onick ochan obot snick shand schan command sban]
		variable ccs
		
		if {[set unban_level [get_options "unban_level"]] > 0} {
			set fban [find_ban $sban]
			if {[llength $fban] > 0} {
				foreach {ban comment expire added timeactive dnick} [find_ban $sban] break
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
		importvars [list onick ochan obot snick shand schan command smask sglobal]
		variable ccs
		
		set global [expr ![string is space $sglobal]]
		if {$smask != ""} {set text_m " [sprintf ban #116 $smask]"} else {set text_m ""}
		if {$global} {
			put_msg [sprintf ban #113 $text_m] -speed 3
			set date [banlist]
			set cbans [list]
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			put_msg [sprintf ban #114 $schan $text_m] -speed 3
			set date [banlist $schan]
			set cbans [chanbans $schan]
		}
		
		set find 0
		set ind 1
		foreach _ $date {
			
			foreach {ban comment expire added timeactive bywho} $_ break
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
					foreach {ban1 bywho1 age1} $_1 break
					if {[string match -nocase $ban1 $ban]} {
						set text_cb " [sprintf ban #123 $bywho1 [xdate [duration $age1]]]"
						set cbans [lreplace $cbans $ind1 $ind1]
						break
					}
					incr ind1
				}
			}
			put_msg [sprintf ban #119 $ind $ban [expr {$stick ? " ([sprintf ban #105])" : ""}] $comment $expire $passed $bywho $text_cb] -speed 3
			set find 1
			
			incr ind
		}
		if {!$find} {put_msg [sprintf ban #115] -speed 3}
		
		set tout 0
		foreach _ $cbans {
			foreach {ban bywho age} $_ break
			if {$smask != "" && ![string match -nocase $smask $ban]} {continue}
			if {!$tout} {put_msg [sprintf ban #124] -speed 3; set tout 1}
			put_msg [sprintf ban #125 $ban $bywho [xdate [duration $age]]] -speed 3
		}
		
		put_msg [sprintf ban #120] -speed 3
		put_log ""
		return 1
		
	}
	
	proc cmd_resetbans {} {
		importvars [list onick ochan obot snick shand schan command]
		
		resetbans $schan
		put_msg [sprintf ban #121]
		put_log ""
		return 1
		
	}
	
}