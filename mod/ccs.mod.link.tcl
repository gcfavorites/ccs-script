####################################################################################################
## Модуль линковки ботов через ботнет
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{link}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль линковки ботов."

if {[pkg_info mod $_name on]} {
	
	cmd_configure link -control -group "botnet" -flags {nt} -block 5 -use_chan 0 \
		-alias {%pref_link} \
		-regexp {{^(?:([^\ ]+)\ +)?([^\ ]+)+?$} {-> sviabot sbot}}
	
	cmd_configure unlink -control -group "botnet" -flags {nt} -block 5 -use_chan 0 \
		-alias {%pref_unlink %pref_dellink} \
		-regexp {{^([^\ ]+)$} {-> sbot}}
	
	proc cmd_unlink {} {
		upvar out out
		importvars [list snick shand schan command sbot]
		
		set dhandbot [get_hand $sbot]
		if {[check_notavailable {-notvalidhandle} -dnick $sbot -dhand $dhandbot]} {return 0}
		
		if {![unlink $dhandbot]} {
			put_msg [sprintf link #102 [StrNick -nick $sbot -hand $dhandbot]]
			return 0
		}
		put_msg [sprintf link #101 [StrNick -nick $sbot -hand $dhandbot]]
		put_log "[StrNick -nick $sbot -hand $dhandbot -prefix ""]"
		return 1
		
	}
	
	proc cmd_link {} {
		upvar out out
		importvars [list snick shand schan command sbot]
		global botnick
		
		set dhandbot [get_hand $sbot]
		if {[check_notavailable {-notvalidhandle -notisbot} -dnick $sbot -dhand $dhandbot]} {return 0}
		
		if {[string is space $sviabot]} {
			if {![link $dhandbot]} {
				put_msg [sprintf link #104 [StrNick -nick $sbot -hand $dhandbot] [StrNick -nick $botnick -hand $botnick]]
				return 0
			}
			put_msg [sprintf link #103 [StrNick -nick $sbot -hand $dhandbot] [StrNick -nick $botnick -hand $botnick]]
			put_log "[StrNick -nick $sbot -hand $dhandbot -prefix ""]"
			return 1
		} else {
			set dhandviabot [get_hand $sviabot]
			if {[check_notavailable {-notvalidhandle -notisbot} -dnick $sviabot -dhand $dhandviabot]} {return 0}
			
			if {![link $dhandviabot $dhandbot]} {
				put_msg [sprintf link #104 [StrNick -nick $sbot -hand $dhandbot] [StrNick -nick $botnick -hand $botnick]]
				return 0
			}
			put_msg [sprintf link #105 [StrNick -nick $sbot -hand $dhandbot] [StrNick -nick $botnick -hand $botnick] [StrNick -nick $sviabot -hand $dhandviabot]]
			put_log "[StrNick -nick $sbot -hand $dhandbot -prefix ""], VIA-BOT [StrNick -nick $sviabot -hand $dhandviabot -prefix ""]"
			return 1
		}
		
	}
	
}
