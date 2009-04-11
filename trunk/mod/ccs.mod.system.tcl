##################################################################################################################
## Модуль с системными командами управления
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"system"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"Модуль с системными командами управления ботом."

if {$ccs(mod,name,$modname)} {
	
	cconfigure servers -add -group "system" -flags {m} -block 5 -usechan 0 \
		-alias {%pref_servers} \
		-regexp {{^$} {}}
	
	cconfigure addserver -add -group "system" -flags {m} -block 1 -usechan 0 \
		-alias {%pref_addserver} \
		-regexp {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)$} {-> sserver sport spass}}
	
	cconfigure delserver -add -group "system" -flags {m} -block 1 -usechan 0 \
		-alias {%pref_delserver} \
		-regexp {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)$} {-> sserver sport spass}}
	
	cconfigure save -add -group "system" -flags {m} -block 3 -usechan 0 \
		-alias {%pref_save} \
		-regexp {{^$} {}}
	
	cconfigure reload -add -group "system" -flags {m} -block 3 -usechan 0 \
		-alias {%pref_reload} \
		-regexp {{^$} {}}
	
	cconfigure backup -add -group "system" -flags {m} -block 3 -usechan 0 \
		-alias {%pref_backup} \
		-regexp {{^$} {}}
	
	cconfigure die -add -group "system" -flags {n} -usechan 0 \
		-alias {%pref_die} \
		-regexp {{^(.*?)$} {-> stext}}
	
	cconfigure rehash -add -group "system" -flags {m} -block 5 -usechan 0 \
		-alias {%pref_rehash} \
		-regexp {{^$} {}}
	
	cconfigure restart -add -group "system" -flags {m} -usechan 0 \
		-alias {%pref_restart} \
		-regexp {{^$} {}}
	
	cconfigure jump -add -group "system" -flags {m} -block 5 -usechan 0 \
		-alias {%pref_jump} \
		-regexp {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)?$} {-> sserver sport spass}}
	
	#############################################################################################################
	# Процедуры системных команд
	
	proc cmd_rehash {} {
		importvars [list onick ochan obot snick shand schan command]
		
		put_msg [sprintf system #101]
		save
		put_msg [sprintf system #102]
		rehash
		put_log ""
		return 1
		
	}
	
	proc cmd_restart {} {
		importvars [list onick ochan obot snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #103]
		put_log ""
		restart
		return 1
		
	}
	
	proc cmd_jump {} {
		importvars [list onick ochan obot snick shand schan command sserver sport spass]
		
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
		importvars [list onick ochan obot snick shand schan command]
		global servers serveraddress
		
		put_msg [sprintf system #104] -speed 3
		foreach line $servers {
			set l_server [lindex [split $line] 0]
			set l_hub [lindex [split $line] 1]
			if {$l_server == $serveraddress} {set l_server "\002$l_server\002"}
			put_msg "» $l_server [expr {[string is space $l_hub] ? "" : "($l_hub)"}]" -speed 3
		}
		put_msg [sprintf system #105] -speed 3
		put_log ""
		return 1
		
	}
	
	proc cmd_addserver {} {
		importvars [list onick ochan obot snick shand schan command sserver sport spass]
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
				put_msg [sprintf system #106 $s_server] -speed 3
				return 0
			}
		}
		
		lappend servers $s_server
		put_msg [sprintf system #107 $s_server] -speed 3
		put_log "$s_server"
		return 1
		
	}
	
	proc cmd_delserver {} {
		importvars [list onick ochan obot snick shand schan command sserver sport spass]
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
				put_msg [sprintf system #108 $l_server] -speed 3
				put_log "$s_server"
			}
			incr ind
		}
		if {!$del} {put_msg [sprintf system #109 $s_server] -speed 3; return 0}
		return 1
		
	}
	
	proc cmd_save {} {
		importvars [list onick ochan obot snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #110]
		save
		put_log ""
		return 1
		
	}
	
	proc cmd_reload {} {
		importvars [list onick ochan obot snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #111]
		reload
		put_log ""
		return 1
		
	}
	
	proc cmd_backup {} {
		importvars [list onick ochan obot snick shand schan command]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_msg [sprintf system #112]
		backup
		put_log ""
		return 1
		
	}
	
	proc cmd_die {} {
		importvars [list onick ochan obot snick shand schan command stext]
		
		if {[check_notavailable {-getting_users}]} {return 0}
		
		put_log "($stext)"
		die $stext
		return 1
		
	}
	
}