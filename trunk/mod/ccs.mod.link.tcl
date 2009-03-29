##################################################################################################################
## Модуль линковки ботов через ботнет
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"link"
addmod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"link"
	lappend ccs(commands)	"unlink"
	
	set ccs(group,link) "botnet"
	set ccs(use_chan,link) 0
	set ccs(flags,link) {nt}
	set ccs(alias,link) {%pref_link}
	set ccs(block,link) 5
	set ccs(regexp,link) {{^(?:([^\ ]+)\ +)?([^\ ]+)+?$} {-> sviabot sbot}}
	
	set ccs(group,unlink) "botnet"
	set ccs(use_chan,unlink) 0
	set ccs(flags,unlink) {nt}
	set ccs(alias,unlink) {%pref_unlink %pref_dellink}
	set ccs(block,unlink) 5
	set ccs(regexp,unlink) {{^([^\ ]+)$} {-> sbot}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	proc cmd_unlink {} {
		importvars [list onick ochan obot snick shand schan command sbot]
		
		set dhandbot [get_hand $sbot]
		if {[check_notavailable {-notvalidhandle} -dnick $sbot -dhand $dhandbot]} {return 0}
		
		if {![unlink $dhandbot]} {
			put_msg [sprintf link #102 [get_nick $sbot $dhandbot]]
			return 0
		}
		put_msg [sprintf link #101 [get_nick $sbot $dhandbot]]
		put_log "UNLINK [get_nick $sbot $dhandbot ""]"
		return 1
		
	}
	
	proc cmd_link {} {
		importvars [list onick ochan obot snick shand schan command]
		global botnick
		
		set dhandbot [get_hand $sbot]
		if {[check_notavailable {-notvalidhandle -notisbot} -dnick $sbot -dhand $dhandbot]} {return 0}
		
		if {[string is space $sviabot]} {
			if {![link $dhandbot]} {
				put_msg [sprintf link #104 [get_nick $sbot $dhandbot] [get_nick $botnick $botnick]]
				return 0
			}
			put_msg [sprintf link #103 [get_nick $sbot $dhandbot] [get_nick $botnick $botnick]]
			put_log "[get_nick $sbot $dhandbot ""]"
			return 1
		} else {
			set dhandviabot [get_hand $sviabot]
			if {[check_notavailable {-notvalidhandle -notisbot} -dnick $sviabot -dhand $dhandviabot]} {return 0}
			
			if {![link $dhandviabot $dhandbot]} {
				put_msg [sprintf link #104 [get_nick $sbot $dhandbot] [get_nick $botnick $botnick]]
				return 0
			}
			put_msg [sprintf link #105 [get_nick $sbot $dhandbot] [get_nick $botnick $botnick] [get_nick $sviabot $dhandviabot]]
			put_log "[get_nick $sbot $dhandbot ""], VIA-BOT [get_nick $sviabot $dhandviabot ""]"
			return 1
		}
		
	}
	
}
