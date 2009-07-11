####################################################################################################
## Модуль с системными командами управления
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{system}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль с системными командами управления ботом."

if {[pkg_info mod $_name on]} {
	
	cmd_configure servers -control -group "system" -flags {m} -block 5 -use_chan 0 \
		-alias {%pref_servers} \
		-regexp {{^$} {}}
	
	cmd_configure addserver -control -group "system" -flags {m} -block 1 -use_chan 0 \
		-alias {%pref_addserver} \
		-regexp {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)$} {-> sserver sport spass}}
	
	cmd_configure delserver -control -group "system" -flags {m} -block 1 -use_chan 0 \
		-alias {%pref_delserver} \
		-regexp {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)$} {-> sserver sport spass}}
	
	cmd_configure save -control -group "system" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_save} \
		-regexp {{^$} {}}
	
	cmd_configure reload -control -group "system" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_reload} \
		-regexp {{^$} {}}
	
	cmd_configure backup -control -group "system" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_backup} \
		-regexp {{^$} {}}
	
	cmd_configure die -control -group "system" -flags {n} -use_chan 0 \
		-alias {%pref_die} \
		-regexp {{^(.*?)$} {-> stext}}
	
	cmd_configure rehash -control -group "system" -flags {m} -block 5 -use_chan 0 \
		-alias {%pref_rehash} \
		-regexp {{^$} {}}
	
	cmd_configure restart -control -group "system" -flags {m} -use_chan 0 \
		-alias {%pref_restart} \
		-regexp {{^$} {}}
	
	cmd_configure jump -control -group "system" -flags {m} -block 5 -use_chan 0 \
		-alias {%pref_jump} \
		-regexp {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)?$} {-> sserver sport spass}}
	
	################################################################################################
	# Процедуры системных команд
	
	proc cmd_rehash {} {
		upvar out out
		importvars [list snick shand schan command]
		
		put_msg [sprintf system #101]
		save
		put_msg [sprintf system #102]
		rehash
		put_log ""
		return 1
		
	}
	
	proc cmd_restart {} {
		upvar out out
		importvars [list snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #103]
		put_log ""
		restart
		return 1
		
	}
	
	proc cmd_jump {} {
		upvar out out
		importvars [list snick shand schan command sserver sport spass]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		if {[string is space $sserver]} {
			jump
		} elseif {[string is space $sport]} {
			jump $sserver
		} elseif {[string is space $spass]} {
			jump $sserver $sport
		} else {
			jump $sserver $sport $spass
		}
		put_log "$sserver $sport $spass"
		return 1
		
	}
	
	proc cmd_servers {} {
		upvar out out
		importvars [list snick shand schan command]
		global servers serveraddress
		
		put_msg -speed 3 -- [sprintf system #104]
		foreach line $servers {
			set l_server [lindex [split $line] 0]
			set l_hub [lindex [split $line] 1]
			if {$l_server == $serveraddress} {set l_server "\002$l_server\002"}
			put_msg -speed 3 -- "» $l_server [expr {[string is space $l_hub] ? "" : "($l_hub)"}]"
		}
		put_msg -speed 3 -- [sprintf system #105]
		put_log ""
		return 1
		
	}
	
	proc cmd_addserver {} {
		upvar out out
		importvars [list snick shand schan command sserver sport spass]
		global servers
		
		if {[string is space $sport]} {
			set s_server "$sserver"
		} elseif {[string is space $spass]} {
			set s_server "$sserver:$sport"
		} else {
			set s_server "$sserver:$sport:$spass"
		}
		
		foreach line $servers {
			set l_server [lindex [split $line] 0]
			if {$l_server == $s_server || [string match $s_server:* $l_server]} {
				put_msg -speed 3 -- [sprintf system #106 $s_server]
				return 0
			}
		}
		
		lappend servers $s_server
		put_msg -speed 3 -- [sprintf system #107 $s_server]
		put_log "$s_server"
		return 1
		
	}
	
	proc cmd_delserver {} {
		upvar out out
		importvars [list snick shand schan command sserver sport spass]
		global servers
		
		if {[string is space $sport]} {
			set s_server "$sserver"
		} elseif {[string is space $spass]} {
			set s_server "$sserver:$sport"
		} else {
			set s_server "$sserver:$sport:$spass"
		}
		
		set ind 0
		set del 0
		foreach line $servers {
			set l_server [lindex [split $line] 0]
			if {$l_server == $s_server || [string match $s_server:* $l_server]} {
				set servers [lreplace $servers $ind $ind]
				set del 1
				put_msg -speed 3 -- [sprintf system #108 $l_server]
				put_log "$s_server"
			}
			incr ind
		}
		if {!$del} {put_msg -speed 3 -- [sprintf system #109 $s_server]; return 0}
		return 1
		
	}
	
	proc cmd_save {} {
		upvar out out
		importvars [list snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #110]
		save
		put_log ""
		return 1
		
	}
	
	proc cmd_reload {} {
		upvar out out
		importvars [list snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #111]
		reload
		put_log ""
		return 1
		
	}
	
	proc cmd_backup {} {
		upvar out out
		importvars [list snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #112]
		backup
		put_log ""
		return 1
		
	}
	
	proc cmd_die {} {
		upvar out out
		importvars [list snick shand schan command stext]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_log "($stext)"
		die $stext
		return 1
		
	}
	
}