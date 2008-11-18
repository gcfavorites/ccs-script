##################################################################################################################
## Модуль вывода трафика
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"traf"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"traf"
	
	set ccs(group,traf) "info"
	set ccs(use_auth,traf) 0
	set ccs(use_chan,traf) 0
	set ccs(use_botnet,traf) 0
	set ccs(flags,traf) {%v}
	set ccs(alias,traf) {%pref_traf}
	set ccs(block,traf) 3
	set ccs(regexp,traf) {{^([^\ ]+)?$} {-> stype}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	proc cmd_traf {} {
		importvars [list onick ochan obot snick shand schan command stype]
		variable ccs
		
		set flag 0
		foreach {ttypes today_in total_in today_out total_out} [join [traffic]] {
			
			if {[string equal -nocase $ttypes $stype] || [string is space $stype]} {
				put_msg "$ttypes: Today in/out: [convertvalue $today_in]/[convertvalue $today_out] Total in/out: [convertvalue $total_in]/[convertvalue $total_out]"
				set flag 1
			}
		}
		
		if {!$flag} {put_msg [sprintf traf #101 $stype]; return 0}
		return 1
		
	}
	
	proc convertvalue {value} {
		if {$value > 1099511627776} {
			return "[format "%.2f" [expr $value / 1099511627776.00]] Tb"
		} elseif {$value > 1073741824} {
			return "[format "%.2f" [expr $value / 1073741824.00]] Gb"
		} elseif {$value > 1048576} {
			return "[format "%.2f" [expr $value / 1048576.00]] Mb"
		} elseif {$value > 1024} {
			return "[format "%.2f" [expr $value / 1024.00]] Kb"
		} else {
			return "[format "%.2f" $value] b"
		}
	}
	
}