##################################################################################################################
## Модуль управления инвайтами
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"invite"
addmod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.2.2" \
				"26-Okt-2008"

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Значение по умолчанию, которое определяет маску по умолчанию для выставления инвайта. Значение может быть
	# переопределено выставлением канального флага ccs-invitemask.
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
	set ccs(invitemask)		4
	
	lappend ccs(commands)	"invite"
	lappend ccs(commands)	"uninvite"
	lappend ccs(commands)	"ginvite"
	lappend ccs(commands)	"guninvite"
	lappend ccs(commands)	"invitelist"
	lappend ccs(commands)	"resetinvites"
	
	set ccs(group,invite) "invite"
	set ccs(flags,invite) {o|o}
	set ccs(alias,invite) {%pref_invite}
	set ccs(block,invite) 1
	set ccs(regexp,invite) {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	set ccs(group,uninvite) "invite"
	set ccs(flags,uninvite) {o|o}
	set ccs(alias,uninvite) {%pref_uninvite}
	set ccs(block,uninvite) 1
	set ccs(regexp,uninvite) {{^([^\ ]+)$} {-> sinvite}}
	
	set ccs(group,ginvite) "invite"
	set ccs(use_chan,ginvite) 0
	set ccs(flags,ginvite) {o}
	set ccs(alias,ginvite) {%pref_ginvite}
	set ccs(block,ginvite) 1
	set ccs(regexp,ginvite) {{^([^\ ]+)(?:\ +(\d+))?(?:\ *(.*?))+?(?:\ +(stick))?$} {-> dnick stime sreason stick}}
	
	set ccs(group,guninvite) "invite"
	set ccs(use_chan,guninvite) 0
	set ccs(flags,guninvite) {o}
	set ccs(alias,guninvite) {%pref_guninvite}
	set ccs(block,guninvite) 1
	set ccs(regexp,guninvite) {{^([^\ ]+)$} {-> sinvite}}
	
	set ccs(group,invitelist) "invite"
	set ccs(use_chan,invitelist) 3
	set ccs(flags,invitelist) {o|o}
	set ccs(alias,invitelist) {%pref_invitelist %pref_invites}
	set ccs(block,invitelist) 3
	set ccs(regexp,invitelist) {{^((?!global)[^\ ]+)?(?:\s*(global))?$} {-> smask sglobal}}
	
	set ccs(group,resetinvites) "invite"
	set ccs(flags,resetinvites) {o|o}
	set ccs(alias,resetinvites) {%pref_resetinvites}
	set ccs(block,resetinvites) 5
	set ccs(regexp,resetinvites) {{^$} {}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	setudef str ccs-invitemask
	
	#############################################################################################################
	# Процедуры команд управления исключениями (+e)
	
	proc cmd_invite {} {
		importvars [list onick ochan obot snick shand schan command dnick stime sreason stick]
		variable ccs
		
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
			if {$ccs(bandate)} {set sreason [sprintf invite #103 $sreason [ctime [expr [unixtime] + $btime]]]}
			put_msg [sprintf invite #104 $sstick $dhost [xdate [duration $btime]]]
			put_log "$dstick $dhost at [duration $btime]."
		}
		newchaninvite $schan $dhost $shand $sreason $stime $stick
		return 1
		
	}
	
	proc cmd_uninvite {} {
		importvars [list onick ochan obot snick shand schan command sinvite]
		variable ccs
		
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
		importvars [list onick ochan obot snick shand schan command dnick stime sreason stick]
		variable ccs
		
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
		importvars [list onick ochan obot snick shand schan command sinvite]
		variable ccs
		
		set sinvite [string trim $sinvite]
		set stick [isinvitesticky $sinvite]
		
		if {![killinvite $sinvite]} {put_msg [sprintf invite #111 $sinvite]; return 0}
		put_msg [sprintf invite #110 [expr {$stick ? " [sprintf invite #120]" : ""}] $sinvite]
		put_log "[expr {$stick ? "STICK" : ""}] $sinvite"
		return 1
		
	}
	
	proc cmd_invitelist {} {
		importvars [list onick ochan obot snick shand schan command smask sglobal]
		variable ccs
		
		set global [expr ![string is space $sglobal]]
		if {$smask != ""} {set text_m " [sprintf invite #121 $smask]"} else {set text_m ""}
		if {$global} {
			put_msg [sprintf invite #112 $text_m] -speed 3
			set date [invitelist]
			set сinvites [list]
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			put_msg [sprintf invite #113 $schan $text_m] -speed 3
			set date [invitelist $schan]
			set сinvites [chaninvites $schan]
		}
		
		set find 0
		foreach _ $date {
			
			foreach {invite comment expire added timeactive bywho} $_ break
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
					foreach {invite1 bywho1 age1} $_1 break
					if {[string match -nocase $invite1 $invite]} {
						set text_cb " [sprintf invite #122 $bywho1 [xdate [duration $age1]]]"
						set сinvites [lreplace $сinvites $ind $ind]
						break
					}
					incr ind
				}
			}
			put_msg [sprintf invite #117 $invite [expr {$stick ? " ([sprintf invite #120])" : ""}] $comment $expire $passed $bywho $text_cb] -speed 3
			set find 1
			
		}
		if {!$find} {put_msg [sprintf invite #114] -speed 3}
		
		set tout 0
		foreach _ $сinvites {
			foreach {invite bywho age} $_ break
			if {$smask != "" && ![string match -nocase $smask $invite]} {continue}
			if {!$tout} {put_msg [sprintf invite #123] -speed 3; set tout 1}
			put_msg [sprintf invite #124 $invite $bywho [xdate [duration $age]]] -speed 3
		}
		
		put_msg [sprintf invite #118] -speed 3
		put_log ""
		return 1
		
	}
	
	proc cmd_resetinvites {} {
		importvars [list onick ochan obot snick shand schan command]
		variable ccs
		
		resetinvites $schan
		put_msg [sprintf invite #119]
		put_log ""
		return 1
		
	}
	
}
