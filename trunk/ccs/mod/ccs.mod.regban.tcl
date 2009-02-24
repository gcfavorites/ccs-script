##################################################################################################################
## Модуль управления регулярными банами
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"regban"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.4" \
				"25-Feb-2009"

if {$ccs(mod,name,$modname)} {
	
	unsetccs "regban,*"
	
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
	set ccs(banmask)			4
	
	#############################################################################################################
	# Каталог, куда будут помещаться старые файлы после обновления, при этом указание $ccs(scrdir) будет
	# соответствовать каталогу, где находиться основной скрипт.
	set ccs(regbanfile)			"$ccs(ccsdir)/ccs.regban.dat"
	
	#############################################################################################################
	# Время в милисекундах в течении которого хранить обработанные WHO запросы. Слишком большое время снизит
	# нагрузку но может выдавать неправильные результаты. Слишком маленькое значение может пропускать ответы от 
	# сервера.
	set ccs(regbanwhohash)		10000
	
	lappend ccs(commands)	"regbanlist"
	lappend ccs(commands)	"regban"
	lappend ccs(commands)	"regunban"
	
	set ccs(group,regbanlist) "regban"
	set ccs(flags,regbanlist) {o}
	set ccs(alias,regbanlist) {%pref_regbanlist}
	set ccs(block,regbanlist) 3
	set ccs(regexp,regbanlist) {{^$} {}}
	
	set ccs(group,regban) "regban"
	set ccs(flags,regban) {o}
	set ccs(alias,regban) {%pref_regban %pref_addregban}
	set ccs(block,regban) 3
	set ccs(regexp,regban) {{^(.*?)$} {-> text}}
	
	set ccs(group,regunban) "regban"
	set ccs(use_chan,regunban) 3
	set ccs(flags,regunban) {o}
	set ccs(alias,regunban) {%pref_regunban %pref_delregban}
	set ccs(block,regunban) 3
	set ccs(regexp,regunban) {{^(\d+)$} {-> rid}}
	
	setudef str ccs-banmask
	
	proc get_msgregban {var} {
		
		upvar $var regban
		
		set lout [list]
		if {![string is space $regban(chan)]}	{lappend lout "chan: \002$regban(chan)\002"}
		if {![string is space $regban(host)]}	{lappend lout "host: \002$regban(host)\002"}
		if {![string is space $regban(server)]}	{lappend lout "server: \002$regban(server)\002"}
		if {![string is space $regban(status)]}	{lappend lout "status: \002$regban(status)\002"}
		if {![string is space $regban(hops)]}	{lappend lout "hops: \002$regban(hops)\002"}
		if {![string is space $regban(name)]}	{lappend lout "name: \002$regban(name)\002"}
		if {$regban(ban)}	{lappend lout "ban[expr {$regban(mask) != -1 ? ": mask \002$regban(mask)\002" : ""}]"}
		if {$regban(kick)}	{lappend lout "kick[expr {$regban(mask) != -1 ? ": reson \"$regban(kickreson)\"" : ""}]"}
		if {[llength $regban(notify)] > 0}	{lappend lout "notify: \002[join $regban(notify) ,]\002[expr {[string is space $regban(notifytext)] ? "" : " text \"$regban(notifytext)\""}]"}
		
		return [join $lout "; "]
		
	}
	
	proc cmd_regbanlist {} {
		variable ccs
		importvars [list onick ochan obot snick shand schan command]
		
		put_msg [sprintf regban #104 $schan]
		set find 0
		foreach _ [array names ccs -glob "regban,*"] {
			set rid [lindex [split $_ ,] 1]
			array set regban $ccs($_)
			
			if {![string equal -nocase $schan $regban(chan)]} {unset regban; continue}
			set find 1
			put_msg [sprintf regban #107 $rid [expr {$regban(enable) ? [sprintf ccs #209] : [sprintf ccs #210]}] [get_msgregban regban]]
			unset regban
		}
		if {!$find} {put_msg [sprintf regban #105]}
		put_msg [sprintf regban #106 $shand]
		
	}
	
	proc cmd_regban {} {
		variable ccs
		importvars [list onick ochan obot snick shand schan command text]
		
		
		if {[regexp -nocase -- [set reg {-host\s\{([^\ ]+)\}}] $text -> rhost]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rhost ""
		}
		if {[regexp -nocase -- [set reg {-server\s\{([^\ ]+)\}}] $text -> rserver]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rserver ""
		}
		if {[regexp -nocase -- [set reg {-status\s\{([^\ ]+)\}}] $text -> rstatus]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rstatus ""
		}
		if {[regexp -nocase -- [set reg {-hops\s(\d+)}] $text -> rhops]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rhops ""
		}
		if {[regexp -nocase -- [set reg {-name\s\{(.*?)\}}] $text -> rname]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rname ""
		}
		if {[set rban [regexp -nocase -- [set reg {-ban\s(\d+)}] $text -> rmask]]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rmask 0
			set reg {-ban}
			if {[set rban [regexp -nocase -- $reg $text]]} {regsub -nocase -- $reg $text {} text}
		}
		if {[set rkick [regexp -nocase -- [set reg {-kick\s\{(.*?)\}}] $text -> rkickreson]]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rkickreson ""
			set reg {-kick}
			if {[set rkick [regexp -nocase -- $reg $text]]} {regsub -nocase -- $reg $text {} text}
		}
		if {[regexp -nocase -- [set reg {-notify\s\{(.*?)\}\s\{(.*?)\}}] $text -> rnotify rnotifytext]} {
			regsub -nocase -- $reg $text {} text
		} else {
			set rnotifytext ""
			set reg {-notify\s\{(.*?)\}}
			if {[regexp -nocase -- $reg $text -> rnotify]} {regsub -nocase -- $reg $text {} text} else {set rnotify ""}
		}
		
		if {![string is space $text] || ($rhost == "" && $rserver == "" && $rname == "" && $rstatus == "" && $rhops == "")} {put_help; return 0}
		if {![string is space $rhost]} {if {[catch {regexp -- $rhost ""} errMsg]} {put_msg [sprintf regban #108 $rhost]; return 0}}
		if {![string is space $rserver]} {if {[catch {regexp -- $rserver ""} errMsg]} {put_msg [sprintf regban #108 $rserver]; return 0}}
		if {![string is space $rstatus]} {if {[catch {regexp -- $rstatus ""} errMsg]} {put_msg [sprintf regban #108 $rstatus]; return 0}}
		if {![string is space $rname]} {if {[catch {regexp -- $rname ""} errMsg]} {put_msg [sprintf regban #108 $rname]; return 0}}
		
		set rid 1
		while {[info exists ccs(regban,$rid)]} {incr rid}
		
		set regban(id)			$rid
		set regban(enable)		1
		set regban(chan)		$schan
		set regban(host)		$rhost
		set regban(server)		$rserver
		set regban(status)		$rstatus
		set regban(hops)		$rhops
		set regban(name)		$rname
		set regban(ban)			$rban
		set regban(mask)		$rmask
		set regban(kick)		$rkick
		set regban(kickreson)	$rkickreson
		set regban(notify)		[list]
		set regban(notifytext)	$rnotifytext
		foreach _ [split $rnotify ", "] {
			if {![string is space $_] && [lsearch_equal $regban(notify) $_] < 0} {lappend regban(notify) $_}
		}
		
		set ccs(regban,$rid) [array get regban]
		put_msg [sprintf regban #101 $rid [get_msgregban regban]]
		
		catch {file mkdir [file dirname $ccs(regbanfile)]}
		if {[catch {
			
			set fid [open $ccs(regbanfile) a]
			puts $fid $ccs(regban,$rid)
			close $fid
			
			debug "write file (data): \002$ccs(regbanfile)\002"
		} errMsg]} {
			debug "error write file (data): \002$ccs(regbanfile)\002"
			debug "($errMsg)"
		}
		
	}
	
	proc cmd_regunban {} {
		variable ccs
		importvars [list onick ochan obot snick shand schan command rid]
		
		if {![info exists ccs(regban,$rid)]} {put_msg [sprintf regban #103 $rid]; return 0}
		
		if {[catch {
			
			set fid [open $ccs(regbanfile) r]
			set data [read $fid]
			close $fid
			
			set fid [open $ccs(regbanfile) w]
			foreach _ [split $data \n] {
				array set regban $_
				if {![info exists regban(id)]} {unset regban; continue}
				if {$regban(id) == $rid} {put_msg [sprintf regban #102 $rid [get_msgregban regban]]; unset regban; continue}
				puts $fid $_
				unset regban
			}
			close $fid
			
			unset ccs(regban,$rid)
			
			debug "write file (data): \002$ccs(regbanfile)\002"
		} errMsg]} {
			debug "error write file (data): \002$ccs(regbanfile)\002"
			debug "($errMsg)"
		}
		
	}
	
	proc regban_raw_352 {from key msg} {
		variable regbanturn
		
		if {![regexp -- {[^\ ]+ [^\ ]+ ([^\ ]+) ([^\ ]+) ([^\ ]+) ([^\ ]+) ([^\ ]+) :(\d+) (.*?)$} $msg -> rident rhost rserver rnick rstatus rhops rname]} {
			debug "error regexp raw_352"; return
		}
		
		set nick $rnick
		set uhost "$rident@$rhost"
		
		if {[info exists regbanturn(on,$nick,$uhost)]} {
			set regbanturn(on,$nick,$uhost)		1
			set regbanturn(server,$nick,$uhost)	$rserver
			set regbanturn(status,$nick,$uhost)	$rstatus
			set regbanturn(hops,$nick,$uhost)	$rhops
			set regbanturn(name,$nick,$uhost)	$rname
			
			regban_whotest $nick $uhost
		}
		
	}
	
	proc regban_join {nick uhost hand chan} {
		variable ccs
		
		set who 0
		set notwho 0
		
		foreach _ [array names ccs -glob "regban,*"] {
			set rid [lindex [split $_ ,] 1]
			array set regban $ccs($_)
			
			if {!$regban(enable) || ![string equal -nocase $chan $regban(chan)]} {unset regban; continue}
			
			set inc 1
			set uninc 0
			if {$inc && ![string is space $regban(host)] && \
						![regexp -- $regban(host) "$nick!$uhost"]} {set inc 0}
			if {$inc && (![string is space $regban(server)] || \
						 ![string is space $regban(status)] || \
						 ![string is space $regban(hops)] || \
						 ![string is space $regban(name)])} {set uninc 1}
			
			if {$inc && !$uninc} {
				regban_action $rid $nick $uhost
				set notwho 1
			} elseif {$inc && $uninc} {
				set who 1
			}
			unset regban
			
		}
		
		# inc uninc
		# 1    0      - проверка прошла
		# 0    0      - проверка не прошла
		# 1    1      - требует дополнительной проверки
		if {$who && !$notwho} {regban_whoadd $nick $uhost $chan}
		
	}
	
	proc regban_whoadd {nick uhost chan} {
		variable regbanturn
		variable ccs
		
		if {[info exists regbanturn(on,$nick,$uhost)]} {
			
			if {$regbanturn(on,$nick,$uhost)} {
				set regbanturn(chans,$nick,$uhost) [list $chan]
				regban_whotest $nick $uhost
			} elseif {[lsearch_equal $regbanturn(chans,$nick,$uhost) $chan] < 0} {
				lappend regbanturn(chans,$nick,$uhost) $chan
			}
			
		} else {
			
			set regbanturn(on,$nick,$uhost)		0
			set regbanturn(chans,$nick,$uhost)	[list $chan]
			set regbanturn(server,$nick,$uhost)	""
			set regbanturn(status,$nick,$uhost)	""
			set regbanturn(hops,$nick,$uhost)	""
			set regbanturn(name,$nick,$uhost)	""
			
			putquick "WHO +n $nick"
			
			after $ccs(regbanwhohash) [list [namespace origin regban_whodel] $nick $uhost]
			
		}
		
	}
	
	proc regban_whodel {nick uhost} {
		variable regbanturn
		
		unset regbanturn(on,$nick,$uhost)		regbanturn(chans,$nick,$uhost) \
			  regbanturn(server,$nick,$uhost)	regbanturn(status,$nick,$uhost) \
			  regbanturn(hops,$nick,$uhost)		regbanturn(name,$nick,$uhost)
		
	}
	
	proc regban_whotest {nick uhost} {
		variable regbanturn
		variable ccs
		
		if {![info exists regbanturn(on,$nick,$uhost)]} {return}
		
		set rserver	$regbanturn(server,$nick,$uhost)
		set rstatus	$regbanturn(status,$nick,$uhost)
		set rhops	$regbanturn(hops,$nick,$uhost)
		set rname	$regbanturn(name,$nick,$uhost)
		
		foreach _ [array names ccs -glob "regban,*"] {
			set rid [lindex [split $_ ,] 1]
			array set regban $ccs($_)
			
			if {!$regban(enable)} {unset regban; continue}
			
			set find 0
			foreach _2 $regbanturn(chans,$nick,$uhost) {
				if {[string equal -nocase $_2 $regban(chan)]} {set find 1; break}
			}
			if {!$find} {unset regban; continue}
			
			set inc 1
			
			if {$inc && ![string is space $regban(server)] && ![regexp -nocase -- $regban(server) $rserver]} {set inc 0}
			if {$inc && ![string is space $regban(status)] && ![regexp -nocase -- $regban(status) $rstatus]} {set inc 0}
			if {$inc && ![string is space $regban(hops)] && $regban(hops) != $rhops} {set inc 0}
			if {$inc && ![string is space $regban(name)] && ![regexp -nocase -- $regban(name) $rname]} {set inc 0}
			
			if {$inc} {regban_action $rid $nick $uhost}
			unset regban
			
		}
		
	}
	
	proc regban_action {id nick uhost} {
		variable ccs
		
		array set regban $ccs(regban,$id)
		
		if {!$regban(enable)} {return}
		
		if {$regban(ban)} {
			foreach _ $regban(chan) {
				if {$regban(mask) > 0} {set mask [get_options "banmask" $_]} else {set mask $regban(mask)}
				set dhost [get_mask "$nick!$uhost" $mask]
				pushmode $_ +b $dhost
			}
		}
		
		if {$regban(kick)} {
			foreach _ $regban(chan) {flushmode $_; putkick $_ $nick $regban(kickreson)}
		}
		
		if {[llength $regban(notify)] > 0} {
			foreach _ $regban(notify) {
				if {[validuser $_] && ![check_isnull [set onick [hand2nick $_]]]} {
					put_msgdest $onick "RegBan \002ID: $id\002; chan: \002[join $regban(chan) ","]\002; nick: \002$nick\002; host: \002$uhost\002[expr {[string is space $regban(notifytext)] ? "" : "; notice: \"\002$regban(notifytext)\002\""}]" -type notice
				}
			}
		}
		
	}
	
	proc binds_up_regban {} {
		variable ccs
		upvar curr curr
		
		if {[file exists $ccs(regbanfile)]} {
			
			catch {
				set data [loadfile $ccs(regbanfile)]
				foreach _ [split $data \n] {
					if {[string is space $_]} continue
					array set regban $_
					if {[info exists regban(id)]} {set ccs(regban,$regban(id)) $_}
					unset regban
				}
			}
			
		}
		
		incr curr 2
		bind join - *	[namespace origin regban_join]
		bind raw - 352	[namespace origin regban_raw_352]
		
	}
	
}

