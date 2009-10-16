####################################################################################################
## ћодуль управлени€ регул€рными банами
####################################################################################################
# —писок последних изменений:
#	v1.4.0
# - ƒл€ совместимости с разными IRC сет€ми изменен запрос WHO
# - »справлена ошибка, св€занна€ с указанием маски бана
# - »справлена ошибка ложного срабатывани€ при наличии нескольких правил.
#	v1.2.6
# - «аменена функци€ lsearch_equal
# - »зменена директори€ по умолчанию дл€ сохранени€ банов модул€ regban. ≈сли такие баны
#   существовали то следует переместить файл данных в директорию data и сделать .rehash
#	v1.2.5
# - ƒобавлены две новые команды !regbantest и !regbanaction

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{regban}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"ћодуль управлени€ банами по регул€рным выражени€м."

if {[pkg_info mod $_name on]} {
	
	variable regban
	foreach _ [array names regban] { unset regban($_) }
	
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
	set options(banmask)			4
	
	################################################################################################
	# ѕуть и им€ файла, куда будут помещатьс€ данные скрипта, при этом указание $options(dir_data)
	# будет соответствовать каталогу data, наход€щемус€ вместе с основным скриптом.
	set options(regbanfile)			"$options(dir_data)/ccs.regban.dat"
	
	################################################################################################
	# ¬рем€ в милисекундах в течении которого хранить обработанные WHO запросы. —лишком большое
	# врем€ снизит нагрузку но может выдавать неправильные результаты. —лишком маленькое значение
	# может пропускать ответы от сервера.
	set options(regbanwhohash)		10000
	
	cmd_configure regbanlist -control -group "regban" -flags {o} -block 3 \
		-alias {%pref_regbanlist} \
		-regexp {{^$} {}}
	
	cmd_configure regban -control -group "regban" -flags {o} -block 3 \
		-alias {%pref_regban %pref_addregban %pref_regbanadd} \
		-regexp {{^(.*?)$} {-> text}}
	
	cmd_configure regunban -control -group "regban" -flags {o} -block 3 -use_chan 3 \
		-alias {%pref_regunban %pref_delregban %pref_unregban %pref_regbandel} \
		-regexp {{^(\d+)$} {-> rid}}
	
	cmd_configure regbantest -control -group "regban" -flags {o} -block 5 \
		-alias {%pref_regbantest %pref_testregban} \
		-regexp {{^$} {}}
	
	cmd_configure regbanaction -control -group "regban" -flags {o} -block 5 \
		-alias {%pref_regbanaction %pref_actionregban} \
		-regexp {{^$} {}}
	
	setudef str ccs-banmask
	
	proc get_msgregban {var} {
		
		upvar $var r
		
		set ro [list]
		if {![string is space $r(chan)]}	{lappend ro "chan: \002$r(chan)\002"}
		if {![string is space $r(host)]}	{lappend ro "host: \002$r(host)\002"}
		if {![string is space $r(server)]}	{lappend ro "server: \002$r(server)\002"}
		if {![string is space $r(status)]}	{lappend ro "status: \002$r(status)\002"}
		if {![string is space $r(hops)]}	{lappend ro "hops: \002$r(hops)\002"}
		if {![string is space $r(name)]}	{lappend ro "name: \002$r(name)\002"}
		if {$r(ban)} {
			lappend ro "ban[expr {$r(mask) != -1 ? ": mask \002$r(mask)\002" : ""}]"
		}
		if {$r(kick)} {
			lappend ro "kick[expr {$r(mask) != -1 ? ": reson \"$r(kickreson)\"" : ""}]"
		}
		if {[llength $r(notify)] > 0} {
			lappend ro "notify: \002[join $r(notify) ,]\002[expr {[string is space $r(notifytext)] ? "" : " text \"$r(notifytext)\""}]"
		}
		
		return [join $ro "; "]
		
	}
	
	proc cmd_regbanlist {} {
		upvar out out
		variable regban
		importvars [list snick shand schan command]
		
		put_msg [sprintf regban #104 $schan]
		set find 0
		foreach rid [array names regban -glob "*"] {
			array set r $regban($rid)
			
			if {![string equal -nocase $schan $r(chan)]} {
				unset r
				continue
			}
			set find 1
			put_msg -speed 3 -- [sprintf regban #107 $rid [expr {$r(enable) ? [sprintf ccs #209] : [sprintf ccs #210]}] [get_msgregban r]]
			unset r
		}
		if {!$find} {put_msg [sprintf regban #105]}
		put_msg [sprintf regban #106 $shand]
		
	}
	
	proc cmd_regban {} {
		upvar out out
		variable options
		variable regban
		importvars [list snick shand schan command text]
		
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
		
		if {![string is space $text] || ($rhost == "" && $rserver == "" && $rname == "" && $rstatus == "" && $rhops == "")} {
			put_help
			return 0
		}
		if {![string is space $rhost] && [catch {regexp -- $rhost ""} errMsg]} {
			put_msg [sprintf ccs #104 $rhost]
			return 0
		}
		if {![string is space $rserver] && [catch {regexp -- $rserver ""} errMsg]} {
			put_msg [sprintf ccs #104 $rserver]
			return 0
		}
		if {![string is space $rstatus] && [catch {regexp -- $rstatus ""} errMsg]} {
			put_msg [sprintf ccs #104 $rstatus]
			return 0
		}
		if {![string is space $rname] && [catch {regexp -- $rname ""} errMsg]} {
			put_msg [sprintf ccs #104 $rname]
			return 0
		}
		
		set rid 1
		while {[info exists regban($rid)]} {incr rid}
		
		set r(id)			$rid
		set r(enable)		1
		set r(chan)			$schan
		set r(host)			$rhost
		set r(server)		$rserver
		set r(status)		$rstatus
		set r(hops)			$rhops
		set r(name)			$rname
		set r(ban)			$rban
		set r(mask)			$rmask
		set r(kick)			$rkick
		set r(kickreson)	$rkickreson
		set r(notify)		[list]
		set r(notifytext)	$rnotifytext
		foreach _ [split $rnotify ", "] {
			if {![string is space $_] && [lsearch -exact $r(notify) $_] < 0} {lappend r(notify) $_}
		}
		
		set regban($rid) [array get r]
		put_msg [sprintf regban #101 $rid [get_msgregban r]]
		
		SaveFile -access a -- $options(regbanfile) $regban($rid)
		
	}
	
	proc cmd_regunban {} {
		upvar out out
		variable options
		variable regban
		importvars [list snick shand schan command rid]
		
		if {![info exists regban($rid)]} {
			put_msg [sprintf regban #103 $rid]
			return 0
		}
		
		if {[catch {
			
			set data [LoadFile -list -- $options(regbanfile)]
			
			set new_data [list]
			foreach _ $data {
				array set r $_
				if {![info exists r(id)]} {
					unset r
					continue
				}
				if {$r(id) == $rid} {
					put_msg [sprintf regban #102 $rid [get_msgregban r]]
					unset r
					continue
				}
				lappend new_data $_
				unset r
			}
			
			SaveFile -list -- $options(regbanfile) $new_data
			
			unset regban($rid)
			
			debug "write file (data): \002$options(regbanfile)\002"
		} errMsg]} {
			debug "error write file (data): \002$options(regbanfile)\002"
			debug "($errMsg)"
		}
		
	}
	
	proc cmd_regbantest {} {
		upvar out out
		variable regban
		importvars [list snick shand schan command]
		
		set whochan 0
		foreach nick [chanlist $schan] {
			set uhost [getchanhost $nick]
			
			set who 0
			set notwho 0
			
			foreach rid [array names regban -glob "*"] {
				array set r $regban($rid)
				
				if {!$r(enable) || ![string equal -nocase $schan $r(chan)]} {
					unset r
					continue
				}
				
				set inc 1
				set uninc 0
				if {$inc && ![string is space $r(host)] && \
							![regexp -- $r(host) "$nick!$uhost"]} {set inc 0}
				if {$inc && (![string is space $r(server)] || \
							 ![string is space $r(status)] || \
							 ![string is space $r(hops)] || \
							 ![string is space $r(name)])} {set uninc 1}
				
				if {$inc && !$uninc} {
					regban_action $rid $nick $uhost 1 [array get out]
					set notwho 1
				} elseif {$inc && $uninc} {
					set who 1
				}
				unset r
			}
			
			# inc uninc
			# 1    0      - проверка прошла
			# 0    0      - проверка не прошла
			# 1    1      - требует дополнительной проверки
			if {$who && !$notwho && [regban_whoadd $nick $uhost $schan 0 1 [array get out]]} {
				set whochan 1
			}
		}
		
		if {$whochan} {putquick "WHO $schan"}
		
	}
	
	proc cmd_regbanaction {} {
		upvar out out
		variable regban
		importvars [list snick shand schan command]
		
		set whochan 0
		foreach nick [chanlist $schan] {
			set uhost [getchanhost $nick]
			
			set who 0
			set notwho 0
			
			foreach rid [array names regban -glob "*"] {
				array set r $regban($rid)
				
				if {!$r(enable) || ![string equal -nocase $schan $r(chan)]} {
					unset r
					continue
				}
				
				set inc 1
				set uninc 0
				if {$inc && ![string is space $r(host)] && \
							![regexp -- $r(host) "$nick!$uhost"]} {set inc 0}
				if {$inc && (![string is space $r(server)] || \
							 ![string is space $r(status)] || \
							 ![string is space $r(hops)] || \
							 ![string is space $r(name)])} {set uninc 1}
				
				if {$inc && !$uninc} {
					regban_action $rid $nick $uhost
					set notwho 1
				} elseif {$inc && $uninc} {
					set who 1
				}
				unset r
				
			}
			
			# inc uninc
			# 1    0      - проверка прошла
			# 0    0      - проверка не прошла
			# 1    1      - требует дополнительной проверки
			if {$who && !$notwho && [regban_whoadd $nick $uhost $schan 0]} {
				set whochan 1
			}
		}
		
		if {$whochan} {putquick "WHO $schan"}
		
	}
	
	proc regban_raw_352 {from key msg} {
		variable regbanturn
		
		if {![regexp -- {[^\ ]+ [^\ ]+ ([^\ ]+) ([^\ ]+) ([^\ ]+) ([^\ ]+) ([^\ ]+) :(\d+) (.*?)$} $msg -> rident rhost rserver rnick rstatus rhops rname]} {
			debug "error regexp raw_352"
			return
		}
		
		set nick $rnick
		set uhost "$rident@$rhost"
		
		if {[info exists regbanturn($nick,$uhost,on)]} {
			set regbanturn($nick,$uhost,on)		1
			set regbanturn($nick,$uhost,server)	$rserver
			set regbanturn($nick,$uhost,status)	$rstatus
			set regbanturn($nick,$uhost,hops)	$rhops
			set regbanturn($nick,$uhost,name)	$rname
			
			regban_whotest $nick $uhost
		}
		
	}
	
	proc regban_join {nick uhost hand chan} {
		variable regban
		
		set who 0
		set notwho 0
		
		foreach rid [array names regban -glob "*"] {
			array set r $regban($rid)
			
			if {!$r(enable) || ![string equal -nocase $chan $r(chan)]} {
				unset r
				continue
			}
			
			set inc 1
			set uninc 0
			if {$inc && ![string is space $r(host)] && \
						![regexp -- $r(host) "$nick!$uhost"]} {set inc 0}
			if {$inc && (![string is space $r(server)] || \
						 ![string is space $r(status)] || \
						 ![string is space $r(hops)] || \
						 ![string is space $r(name)])} {set uninc 1}
			
			if {$inc && !$uninc} {
				regban_action $rid $nick $uhost
				set notwho 1
			} elseif {$inc && $uninc} {
				set who 1
			}
			unset r
			
		}
		
		# inc uninc
		# 1    0      - проверка прошла
		# 0    0      - проверка не прошла
		# 1    1      - требует дополнительной проверки
		if {$who && !$notwho} {regban_whoadd $nick $uhost $chan}
		
	}
	
	proc regban_whoadd {nick uhost chan {query_who 1} {only_notify 0} {array_out {}}} {
		variable regbanturn
		variable options
		
		if {[info exists regbanturn($nick,$uhost,on)]} {
			
			if {$regbanturn($nick,$uhost,on)} {
				set regbanturn($nick,$uhost,chans) [list $chan]
				regban_whotest $nick $uhost
			} elseif {[lsearch -exact $regbanturn($nick,$uhost,chans) $chan] < 0} {
				lappend regbanturn($nick,$uhost,chans) $chan
			}
			
			return 0
			
		} else {
			
			set regbanturn($nick,$uhost,on)				0
			set regbanturn($nick,$uhost,chans)			[list $chan]
			set regbanturn($nick,$uhost,server)			""
			set regbanturn($nick,$uhost,status)			""
			set regbanturn($nick,$uhost,hops)			""
			set regbanturn($nick,$uhost,name)			""
			set regbanturn($nick,$uhost,only_notify)	$only_notify
			set regbanturn($nick,$uhost,array_out)		$array_out
			
			if {$query_who} {putquick "WHO $nick"}
			
			after $options(regbanwhohash) [list [namespace origin regban_whodel] $nick $uhost]
			
			return 1
			
		}
		
	}
	
	proc regban_whodel {nick uhost} {
		variable regbanturn
		foreach _ [array names regbanturn -glob "$nick,$uhost,*"] {unset regbanturn($_)}
	}
	
	proc regban_whotest {nick uhost} {
		variable regbanturn
		variable regban
		
		if {![info exists regbanturn($nick,$uhost,on)]} {return}
		
		set rserver	$regbanturn($nick,$uhost,server)
		set rstatus	$regbanturn($nick,$uhost,status)
		set rhops	$regbanturn($nick,$uhost,hops)
		set rname	$regbanturn($nick,$uhost,name)
		
		foreach rid [array names regban -glob "*"] {
			array set r $regban($rid)
			
			if {!$r(enable)} {
				unset r
				continue
			}
			
			set find 0
			foreach _2 $regbanturn($nick,$uhost,chans) {
				if {[string equal -nocase $_2 $r(chan)]} {
					set find 1
					break
				}
			}
			if {!$find} {
				unset r
				continue
			}
			
			set inc 1
			
			if {$inc && ![string is space $r(host)] && ![regexp -- $r(host) "$nick!$uhost"]} \
				{set inc 0}
			if {$inc && ![string is space $r(server)] && ![regexp -nocase -- $r(server) $rserver]} \
				{set inc 0}
			if {$inc && ![string is space $r(status)] && ![regexp -nocase -- $r(status) $rstatus]} \
				{set inc 0}
			if {$inc && ![string is space $r(hops)] && $r(hops) != $rhops} \
				{set inc 0}
			if {$inc && ![string is space $r(name)] && ![regexp -nocase -- $r(name) $rname]} \
				{set inc 0}
			
			if {$inc} {
				regban_action $rid $nick $uhost $regbanturn($nick,$uhost,only_notify) $regbanturn($nick,$uhost,array_out)
			}
			unset r
			
		}
		
		if {$regbanturn($nick,$uhost,only_notify)} {
			set regbanturn($nick,$uhost,only_notify)	0
			set regbanturn($nick,$uhost,array_out)		{}
		}
		
	}
	
	proc regban_action {id nick uhost {only_notify 0} {array_out {}}} {
		variable regban
		
		array set r $regban($id)
		
		if {!$r(enable)} {return}
		
		if {$only_notify} {
			array set out $array_out
			put_msg "RegBan \002ID: $id\002; chan: \002[join $r(chan) ","]\002; nick: \002$nick\002; host: \002$uhost\002[expr {[string is space $r(notifytext)] ? "" : "; notice: \"\002$r(notifytext)\002\""}]"
		} else {
			
			if {$r(ban)} {
				foreach _ $r(chan) {
					if {$r(mask) > 0} {set mask $r(mask)} else {set mask [get_options "banmask" $_]}
					set dhost [get_mask "$nick!$uhost" $mask]
					pushmode $_ +b $dhost
				}
			}
			
			if {$r(kick)} {
				foreach _ $r(chan) {
					flushmode $_
					putkick $_ $nick $r(kickreson)
				}
			}
			
			if {[llength $r(notify)] > 0} {
				foreach _ $r(notify) {
					if {[validuser $_] && ![check_isnull [set onick [hand2nick $_]]]} {
						put_msgdest -type notice -- $onick "RegBan \002ID: $id\002; chan: \002[join $r(chan) ","]\002; nick: \002$nick\002; host: \002$uhost\002[expr {[string is space $r(notifytext)] ? "" : "; notice: \"\002$r(notifytext)\002\""}]"
					}
				}
			}
			
		}
		
	}
	
	proc main_$_name {} {
		variable options
		variable regban
		
		if {[file exists $options(regbanfile)]} {
			catch {
				foreach _ [LoadFile -list $options(regbanfile)] {
					if {[string is space $_]} continue
					array set r $_
					if {[info exists r(id)]} {set regban($r(id)) $_}
					unset r
				}
			}
		}
		
		bind join - *	[namespace origin regban_join]
		bind raw - 352	[namespace origin regban_raw_352]
		
	}
	
}

