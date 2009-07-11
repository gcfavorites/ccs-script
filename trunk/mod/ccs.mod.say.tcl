####################################################################################################
## Модуль управления разговором от имени бота
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{say}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль отправки сообщений от имени бота."

if {[pkg_info mod $_name on]} {
	
	cmd_configure broadcast -control -group "other" -flags {o} -block 10 -use_chan 0 \
		-alias {%pref_broadcast} \
		-regexp {{^(?:([@\+]|@\+)\s+)?(.+?)$} {-> smod stext}}
	
	cmd_configure say -control -group "other" -flags {m} -block 3 \
		-alias {%pref_say} \
		-regexp {{^(?:([@\+]|@\+)\s+)?(act)?(?:\ *(.+?))$} {-> smod sact stext}}
	
	cmd_configure msg -control -group "other" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_msg} \
		-regexp {{^([^\ ]+)(?:\ +(act))?(?:\ +(.*?))$} {-> dnick sact stext}}
	
	cmd_configure act -control -group "other" -flags {m} -block 3 \
		-alias {%pref_act} \
		-regexp {{^(?:([@\+]|@\+)\s+)?(.+?)$} {-> smod stext}}
	
	################################################################################################
	# Процедуры команд отправки сообщений (MESSAGE).
	
	proc cmd_broadcast {} {
		upvar out out
		importvars [list snick shand schan command smod stext]
		
		set lchan [list]
		foreach _ [channels] {
			if {![get_options "on_chan" $_]} continue
			lappend lchan $smod$_
		}
		put_msgdest $lchan [sprintf say #101 [StrNick -nick $snick -hand $shand] $stext]
		put_log "$stext"
		
	}
	
	proc cmd_say {} {
		upvar out out
		importvars [list snick shand schan command smod sact stext]
		
		if {$sact == ""} {
			put_msgdest $smod$schan $stext
		} else {
			put_msgdest $smod$schan "\001ACTION $stext\001"
		}
		
		put_log "$smod$schan $sact TEXT: $stext"
		
	}
	
	proc cmd_act {} {
		upvar out out
		importvars [list snick shand schan command smod stext]
		
		put_msgdest $smod$schan "\001ACTION $stext\001"
		put_log "$smod$schan act TEXT: $stext"
		
	}
	
	proc cmd_msg {} {
		upvar out out
		importvars [list snick shand schan command dnick sact stext]
		
		if {$sact == ""} {
			put_msgdest $dnick $stext
		} else {
			put_msgdest $dnick "\001ACTION $stext\001"
		}
		
		put_log "$dnick $sact TEXT: $stext"
		
	}
	
}