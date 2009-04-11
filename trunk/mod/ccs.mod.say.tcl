##################################################################################################################
## Модуль управления разговором от имени бота
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"say"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"Модуль отправки сообщений от имени бота."

if {$ccs(mod,name,$modname)} {
	
	cconfigure broadcast -add 1 -group "other" -flags {o} -block 10 -usechan 0 \
		-alias {%pref_broadcast} \
		-regexp {{^(?:([@\+]|@\+)\s+)?(.+?)$} {-> smod stext}}
	
	cconfigure say -add 1 -group "other" -flags {m} -block 3 \
		-alias {%pref_say} \
		-regexp {{^(?:([@\+]|@\+)\s+)?(act)?(?:\ *(.+?))$} {-> smod sact stext}}
	
	cconfigure msg -add 1 -group "other" -flags {m} -block 3 -usechan 0 \
		-alias {%pref_msg} \
		-regexp {{^([^\ ]+)(?:\ +(act))?(?:\ +(.*?))$} {-> dnick sact stext}}
	
	cconfigure act -add 1 -group "other" -flags {m} -block 3 \
		-alias {%pref_act} \
		-regexp {{^(?:([@\+]|@\+)\s+)?(.+?)$} {-> smod stext}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	#############################################################################################################
	# Процедуры команд отправки сообщений (MESSAGE).
	
	proc cmd_broadcast {} {
		importvars [list onick ochan obot snick shand schan command smod stext]
		variable ccs
		
		set lchan [list]
		foreach _ [channels] {
			if {![get_options "on_chan" $_]} continue
			lappend lchan $smod$_
		}
		put_msgdest $lchan [sprintf say #101 [get_nick $snick $shand] $stext]
		put_log "$stext"
		
	}
	
	proc cmd_say {} {
		importvars [list onick ochan obot snick shand schan command smod sact stext]
		
		if {$sact == ""} {
			put_msgdest $smod$schan $stext
		} else {
			put_msgdest $smod$schan "\001ACTION $stext\001"
		}
		
		put_log "$ochan $sact TEXT: $stext"
		
	}
	
	proc cmd_act {} {
		importvars [list onick ochan obot snick shand schan command smod stext]
		
		put_msgdest $smod$schan "\001ACTION $stext\001"
		put_log "$ochan act TEXT: $stext"
		
	}
	
	proc cmd_msg {} {
		importvars [list onick ochan obot snick shand schan command dnick sact stext]
		
		if {$sact == ""} {
			put_msgdest $dnick $stext
		} else {
			put_msgdest $dnick "\001ACTION $stext\001"
		}
		
		put_log "$dnick $sact TEXT: $stext"
		
	}
	
}