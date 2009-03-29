##################################################################################################################
## Модуль управления разговором от имени бота
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"say"
addmod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.2.1" \
				"20-Okt-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"broadcast"
	lappend ccs(commands)	"say"
	lappend ccs(commands)	"msg"
	lappend ccs(commands)	"act"
	
	set ccs(group,broadcast) "other"
	set ccs(use_chan,broadcast) 0
	set ccs(flags,broadcast) {o}
	set ccs(alias,broadcast) {%pref_broadcast}
	set ccs(block,broadcast) 10
	set ccs(regexp,broadcast) {{^(?:([@\+]|@\+)\s+)?(.+?)$} {-> smod stext}}
	
	set ccs(group,say) "other"
	set ccs(flags,say) {m}
	set ccs(alias,say) {%pref_say}
	set ccs(block,say) 3
	set ccs(regexp,say) {{^(?:([@\+]|@\+)\s+)?(act)?(?:\ *(.+?))$} {-> smod sact stext}}
	
	set ccs(group,msg) "other"
	set ccs(use_chan,msg) 0
	set ccs(flags,msg) {m}
	set ccs(alias,msg) {%pref_msg}
	set ccs(block,msg) 3
	set ccs(regexp,msg) {{^([^\ ]+)(?:\ +(act))?(?:\ +(.*?))$} {-> dnick sact stext}}
	
	set ccs(group,act) "other"
	set ccs(flags,act) {m}
	set ccs(alias,act) {%pref_act}
	set ccs(block,act) 3
	set ccs(regexp,act) {{^(?:([@\+]|@\+)\s+)?(.+?)$} {-> smod stext}}
	
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