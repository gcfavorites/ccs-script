####################################################################################################
## Модуль вывода трафика
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{traf}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль выдающий информацию о расходуемом трафике бота."

if {[pkg_info mod $_name on]} {
	
	cmd_configure traf -control -group "info" -flags {%v} -block 3 -use_auth 0 -use_chan 0 -use_botnet 0 \
		-alias {%pref_traf} \
		-regexp {{^([^\ ]+)?$} {-> stype}}
	
	proc cmd_traf {} {
		upvar out out
		importvars [list snick shand schan command stype]
		
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