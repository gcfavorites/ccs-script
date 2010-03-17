####################################################################################################
## Модуль управления инвайтами
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{invite}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.1" "05-Nov-2009" \
	"Модуль управления списком инвайтов."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# Отображать в причине дату/время снятия инвайта. (0 - нет, 1 - да)
	set options(invitedate)		1
	
	################################################################################################
	# Значение по умолчанию, которое определяет маску по умолчанию для выставления инвайта.
	# Значение может быть переопределено выставлением канального флага ccs-invitemask.
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
	set options(invitemask)		4
	
	cmd_configure invite -control -group "invite" -flags {o|o} -block 1 \
		-alias {%pref_invite} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	cmd_configure uninvite -control -group "invite" -flags {o|o} -block 1 \
		-alias {%pref_uninvite} \
		-regexp {{^([^\ ]+)$} {-> sinvite}}
	
	cmd_configure ginvite -control -group "invite" -flags {o} -block 1 -use_chan 0 \
		-alias {%pref_ginvite} \
		-regexp {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	cmd_configure guninvite -control -group "invite" -flags {o} -block 1 -use_chan 0 \
		-alias {%pref_guninvite} \
		-regexp {{^([^\ ]+)$} {-> sinvite}}
	
	cmd_configure invitelist -control -group "invite" -flags {o|o} -block 3 -use_chan 3 \
		-alias {%pref_invitelist %pref_invites} \
		-regexp {{^((?!global)[^\ ]+)?(?:\s*(global))?$} {-> smask sglobal}}
	
	cmd_configure resetinvites -control -group "invite" -flags {o|o} -block 5 \
		-alias {%pref_resetinvites} \
		-regexp {{^$} {}}
	
	setudef str ccs-invitemask
	
	################################################################################################
	# Процедуры команд управления исключениями (+e)
	
	proc cmd_invite {} {
		upvar out out
		importvars [list snick shand schan command dnick stime sreason stick]
		variable options
		
		set stick [expr ![string is space $stick]]
		if {$stime == ""} {set stime [channel get $schan invite-time]}
		if {$sreason == ""} {set sreason [sprintf invite #101]}
		if {$stick} {
			set stick "sticky"
			set sstick " [sprintf invite #120]"
			set dstick "STICK"
		} else {
			set stick "none"
			set sstick ""
			set dstick ""
		}
		
		if {[onchan $dnick $schan]} {
			set dhost [get_mask "$dnick![getchanhost $dnick $schan]" [get_options "invitemask" $schan]]
		} else {
			set dhost $dnick
		}
		
		if {$stime == 0} {
			put_msg [sprintf invite #102 $sstick $dhost]
			put_log "$dstick $dhost \002(permanently)\002."
		} else {
			set btime [expr $stime * 60]
			if {$options(invitedate)} {set sreason [sprintf invite #103 $sreason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf invite #104 $sstick $dhost [xdate [duration $btime]]]
			put_log "$dstick $dhost at [duration $btime]."
		}
		newchaninvite $schan $dhost $shand $sreason $stime $stick
		return 1
		
	}
	
	proc cmd_uninvite {} {
		upvar out out
		importvars [list snick shand schan command sinvite]
		
		set stick [isinvitesticky $sinvite $schan]
		if {[killchaninvite $schan $sinvite]} {
			put_msg [sprintf invite #105 [expr {$stick ? " [sprintf invite #120]" : ""}] $sinvite]
			put_log "[expr {$stick ? "STICK" : ""}] $sinvite"
			return 1
		} else {
			if {![ischaninvite $sinvite $schan]} {
				put_msg [sprintf invite #106 $sinvite $schan]
				return 0
			}
			putquick "MODE $schan -i $sinvite"
			put_msg [sprintf invite #105 "" $sinvite]
			put_log "$sinvite"
			return 1
		}
		
	}
	
	proc cmd_ginvite {} {
		upvar out out
		importvars [list snick shand schan command dnick stime sreason stick]
		
		set stick [expr ![string is space $stick]]
		if {$stime == ""} {set stime 1440}
		if {$sreason == ""} {set sreason [sprintf invite #107]}
		if {$stick} {
			set stick "sticky"
			set sstick " [sprintf invite #120]"
			set dstick "STICK"
		} else {
			set stick "none"
			set sstick ""
			set dstick ""
		}
		
		if {$stime == 0} {
			put_msg [sprintf invite #108 $sstick $dnick]
			put_log "$dstick $dnick \002(pernament)\002."
		} else {
			set btime [expr $stime * 60]
			put_msg [sprintf invite #109 $sstick $dnick [xdate [duration $btime]]]
			put_log "$dstick $dnick at [duration $btime]."
		}
		newinvite $dnick $shand $sreason $stime $stick
		return 1
		
	}
	
	proc cmd_guninvite {} {
		upvar out out
		importvars [list snick shand schan command sinvite]
		
		set sinvite [string trim $sinvite]
		set stick [isinvitesticky $sinvite]
		
		if {![killinvite $sinvite]} {put_msg [sprintf invite #111 $sinvite]; return 0}
		put_msg [sprintf invite #110 [expr {$stick ? " [sprintf invite #120]" : ""}] $sinvite]
		put_log "[expr {$stick ? "STICK" : ""}] $sinvite"
		return 1
		
	}
	
	proc cmd_invitelist {} {
		upvar out out
		importvars [list snick shand schan command smask sglobal]
		
		set global [expr ![string is space $sglobal]]
		if {$smask != ""} {set text_m " [sprintf invite #121 $smask]"} else {set text_m ""}
		if {$global} {
			put_msg -speed 3 -- [sprintf invite #112 $text_m]
			set date [invitelist]
			set сinvites [list]
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			put_msg -speed 3 -- [sprintf invite #113 $schan $text_m]
			set date [invitelist $schan]
			set сinvites [chaninvites $schan]
		}
		
		set find 0
		foreach _ $date {
			lassign $_ invite comment expire added timeactive bywho
			
			if {$smask != "" && ![string match -nocase $smask $invite]} {continue}
			if {$expire == 0} {
				set expire [sprintf invite #115]
			} else {
				set expire [sprintf invite #116 [xdate [duration [expr $expire - [unixtime]]]]]
			}
			set passed [xdate [duration [expr [unixtime] - $added]]]
			set text_cb ""
			if {$global} {
				set stick [isinvitesticky $invite]
			} else {
				set stick [isinvitesticky $invite $schan]
				set ind 0
				foreach _1 $сinvites {
					lassign $_1 invite1 bywho1 age1
					if {[string match -nocase $invite1 $invite]} {
						set text_cb " [sprintf invite #122 $bywho1 [xdate [duration $age1]]]"
						set сinvites [lreplace $сinvites $ind $ind]
						break
					}
					incr ind
				}
			}
			put_msg -speed 3 -- [sprintf invite #117 $invite [expr {$stick ? " ([sprintf invite #120])" : ""}] $comment $expire $passed $bywho $text_cb]
			set find 1
			
		}
		if {!$find} {put_msg -speed 3 -- [sprintf invite #114]}
		
		set tout 0
		foreach _ $сinvites {
			lassign $_ invite bywho age
			if {$smask != "" && ![string match -nocase $smask $invite]} {continue}
			if {!$tout} {put_msg -speed 3 -- [sprintf invite #123]; set tout 1}
			put_msg -speed 3 -- [sprintf invite #124 $invite $bywho [xdate [duration $age]]]
		}
		
		put_msg -speed 3 -- [sprintf invite #118]
		put_log ""
		return 1
		
	}
	
	proc cmd_resetinvites {} {
		upvar out out
		importvars [list snick shand schan command]
		
		resetinvites $schan
		put_msg [sprintf invite #119]
		put_log ""
		return 1
		
	}
	
	proc set_net_type_$_name {net_type} {
		
		switch -exact -- $net_type {
			1 {
				cmd_configure invite -use 0
				cmd_configure uninvite -use 0
				cmd_configure ginvite -use 0
				cmd_configure guninvite -use 0
				cmd_configure invitelist -use 0
				cmd_configure resetinvites -use 0
			}
			2 {
				cmd_configure invite -use 1
				cmd_configure uninvite -use 1
				cmd_configure ginvite -use 1
				cmd_configure guninvite -use 1
				cmd_configure invitelist -use 1
				cmd_configure resetinvites -use 1
			}
			3 {
				cmd_configure invite -use 1
				cmd_configure uninvite -use 1
				cmd_configure ginvite -use 1
				cmd_configure guninvite -use 1
				cmd_configure invitelist -use 1
				cmd_configure resetinvites -use 1
			}
			4 {
				cmd_configure invite -use 1
				cmd_configure uninvite -use 1
				cmd_configure ginvite -use 1
				cmd_configure guninvite -use 1
				cmd_configure invitelist -use 1
				cmd_configure resetinvites -use 1
			}
			5 {
			}
			6 {
				cmd_configure invite -use 1
				cmd_configure uninvite -use 1
				cmd_configure ginvite -use 1
				cmd_configure guninvite -use 1
				cmd_configure invitelist -use 1
				cmd_configure resetinvites -use 1
			}
			7 {
				cmd_configure invite -use 1
				cmd_configure uninvite -use 1
				cmd_configure ginvite -use 1
				cmd_configure guninvite -use 1
				cmd_configure invitelist -use 1
				cmd_configure resetinvites -use 1
			}
		}
		
	}
	
}
