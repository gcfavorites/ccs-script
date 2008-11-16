##################################################################################################################
## Модуль с системными командами управления
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"system"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"servers"
	lappend ccs(commands)	"addserver"
	lappend ccs(commands)	"delserver"
	lappend ccs(commands)	"save"
	lappend ccs(commands)	"reload"
	lappend ccs(commands)	"backup"
	lappend ccs(commands)	"die"
	lappend ccs(commands)	"rehash"
	lappend ccs(commands)	"restart"
	lappend ccs(commands)	"jump"
	
	set ccs(group,servers) "system"
	set ccs(use_chan,servers) 0
	set ccs(flags,servers) {m}
	set ccs(alias,servers) {%pref_servers}
	set ccs(block,servers) 5
	set ccs(regexp,servers) {{^$} {}}
	
	set ccs(group,addserver) "system"
	set ccs(use_chan,addserver) 0
	set ccs(flags,addserver) {m}
	set ccs(alias,addserver) {%pref_addserver}
	set ccs(block,addserver) 1
	set ccs(regexp,addserver) {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)$} {-> sserver sport spass}}
	
	set ccs(group,delserver) "system"
	set ccs(use_chan,delserver) 0
	set ccs(flags,delserver) {m}
	set ccs(alias,delserver) {%pref_delserver}
	set ccs(block,delserver) 1
	set ccs(regexp,delserver) {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)$} {-> sserver sport spass}}
	
	set ccs(group,save) "system"
	set ccs(use_chan,save) 0
	set ccs(flags,save) {m}
	set ccs(alias,save) {%pref_save}
	set ccs(block,save) 3
	set ccs(regexp,save) {{^$} {}}
	
	set ccs(group,reload) "system"
	set ccs(use_chan,reload) 0
	set ccs(flags,reload) {m}
	set ccs(alias,reload) {%pref_reload}
	set ccs(block,reload) 3
	set ccs(regexp,reload) {{^$} {}}
	
	set ccs(group,backup) "system"
	set ccs(use_chan,backup) 0
	set ccs(flags,backup) {m}
	set ccs(alias,backup) {%pref_backup}
	set ccs(block,backup) 3
	set ccs(regexp,backup) {{^$} {}}
	
	set ccs(group,die) "system"
	set ccs(use_chan,die) 0
	set ccs(flags,die) {n}
	set ccs(alias,die) {%pref_die}
	set ccs(regexp,die) {{^(.*?)$} {-> stext}}
	
	set ccs(group,rehash) "system"
	set ccs(use_chan,rehash) 0
	set ccs(flags,rehash) {m}
	set ccs(alias,rehash) {%pref_rehash}
	set ccs(block,rehash) 5
	set ccs(regexp,rehash) {{^$} {}}
	
	set ccs(group,restart) "system"
	set ccs(use_chan,restart) 0
	set ccs(flags,restart) {m}
	set ccs(alias,restart) {%pref_restart}
	set ccs(regexp,restart) {{^$} {}}
	
	set ccs(group,jump) "system"
	set ccs(use_chan,jump) 0
	set ccs(flags,jump) {m}
	set ccs(alias,jump) {%pref_jump}
	set ccs(block,jump) 5
	set ccs(regexp,jump) {{^(?:([^\ :]+)(?:[\:\ ](\d+)(?:[\:\ ]([^\ ]+))?)?)?$} {-> sserver sport spass}}
	
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