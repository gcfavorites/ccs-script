##################################################################################################################
## Модуль управления ботами и ботнетом
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"bots"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.1" \
				"10-Jul-2008"

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Разрешать вывод ботнета в виде дерева (1 - разрешить, 0 - запретить). Не рекомендуется включать для ботов
	# без отключенного на сервере контроля за флудом и для больших ботнетов.
	set ccs(botnettree)			1
	
	lappend ccs(commands)	"bots"
	lappend ccs(commands)	"botattr"
	lappend ccs(commands)	"addbot"
	lappend ccs(commands)	"delbot"
	lappend ccs(commands)	"chaddr"
	lappend ccs(commands)	"chbotpass"
	lappend ccs(commands)	"listauth"
	lappend ccs(commands)	"addauth"
	lappend ccs(commands)	"delauth"
	
	set ccs(group,bots) "botnet"
	set ccs(use_chan,bots) 0
	set ccs(use_botnet,bots) 0
	set ccs(flags,bots) {%v}
	set ccs(alias,bots) {%pref_bots}
	set ccs(block,bots) 5
	set ccs(regexp,bots) {{^(tree)?$} {-> stree}}
	
	set ccs(group,botattr) "botnet"
	set ccs(use_chan,botattr) 0
	set ccs(flags,botattr) {mt}
	set ccs(alias,botattr) {%pref_botattr}
	set ccs(block,botattr) 2
	set ccs(regexp,botattr) {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick sflag}}
	
	set ccs(group,chaddr) "botnet"
	set ccs(use_chan,chaddr) 0
	set ccs(flags,chaddr) {mt}
	set ccs(alias,chaddr) {%pref_chaddr}
	set ccs(block,chaddr) 2
	set ccs(regexp,chaddr) {{^([^\ ]+)(?:\ +([^\ :]+)(?:\:(\d+)(?:/(\d+))?)?)$} {-> dnick saddress sbport suport}}
	
	set ccs(group,addbot) "botnet"
	set ccs(use_chan,addbot) 0
	set ccs(flags,addbot) {mt}
	set ccs(alias,addbot) {%pref_addbot}
	set ccs(block,addbot) 3
	set ccs(regexp,addbot) {{^([^\ ]+)(?:\ +([^\ :]+)(?:\:(\d+)(?:/(\d+))?)?)(?:\ +([^\ ]+))?$} {-> dnick daddress dbport duport dhost}}
	
	set ccs(group,delbot) "botnet"
	set ccs(use_chan,delbot) 0
	set ccs(flags,delbot) {mt}
	set ccs(alias,delbot) {%pref_delbot}
	set ccs(block,delbot) 3
	set ccs(regexp,delbot) {{^([^\ ]+)$} {-> dnick}}
	
	set ccs(group,chbotpass) "botnet"
	set ccs(use_chan,chbotpass) 0
	set ccs(flags,chbotpass) {mt}
	set ccs(alias,chbotpass) {%pref_chbotpass}
	set ccs(block,chbotpass) 3
	set ccs(regexp,chbotpass) {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick dpass}}
	
	set ccs(group,listauth) "botnet"
	set ccs(use_chan,listauth) 0
	set ccs(flags,listauth) {mt}
	set ccs(alias,listauth) {%pref_listauth}
	set ccs(block,listauth) 3
	set ccs(regexp,listauth) {{^([^\ ]+)$} {-> dnick}}
	
	set ccs(group,addauth) "botnet"
	set ccs(use_chan,addauth) 0
	set ccs(flags,addauth) {mt}
	set ccs(alias,addauth) {%pref_addauth}
	set ccs(block,addauth) 3
	set ccs(regexp,addauth) {{^([^\ ]+)(?:\ +([^\ ]+))(?:\ +([^\ ]+))$} {-> dnick dbotnick dhandle}}
	
	set ccs(group,delauth) "botnet"
	set ccs(use_chan,delauth) 0
	set ccs(flags,delauth) {mt}
	set ccs(alias,delauth) {%pref_delauth}
	set ccs(block,delauth) 3
	set ccs(regexp,delauth) {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick dbotnick}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	#############################################################################################################
	# Процедуры команд ботнета (BotNet).
	
	proc cmd_bots {} {
		importvars [list onick ochan obot snick shand schan command stree]
		variable ccs
		global botnet-nick
		
		set tree [expr ![string is space $stree]]
		set bots [bots]
		
		if {$tree && $ccs(botnettree)} {
			put_msg [sprintf bots #101 [expr [llength $bots]+1]]
			
			set date [botlist]
			set lbots [list [list ${botnet-nick} n/a 1 2]]
			
			foreach _0 $date {
				foreach {bot0 hub0 version0 share0} $_0 break
				set ind1 0
				foreach _1 $lbots {
					foreach {bot1 hub1 left1 right1} $_1 break
					if {$hub0 == $bot1} {
						set ind2 0
						foreach _2 $lbots {
							foreach {bot2 hub2 left2 right2} $_2 break
							if {$left2 >= $right1} {incr left2 2; lset lbots $ind2 2 $left2}
							if {$right2 >= $right1} {incr right2 2; lset lbots $ind2 3 $right2}
							incr ind2
						}
						lappend lbots [list $bot0 $hub0 $right1 [expr $right1+1]]
						break
					}
					incr ind1
				}
			}
			putlog $lbots
			set pref [list]
			set lastleft 0
			set lastright 0
			set lasthub ""
			set lhublevel [list]
			set ind0 0
			set lbots [lsort -integer -index 2 $lbots]
			set lastclose 0
			foreach _0 $lbots {
				foreach {bot0 hub0 left0 right0} $_0 break
				
				if {$lastclose} {lset pref end "    "; set lastclose 0}
				if {$lasthub != $hub0} {
					if {[expr $lastleft+1] == $left0} {
						set find1 0
						for {set ind1 $ind0} {$ind1 < [llength $lbots]} {incr ind1} {
							foreach {bot1 hub1 left1 right1} [lindex $lbots $ind1] break
							if {$right1 < $lastright} {set find1 1; break}
						}
						if {$find1} {lappend pref "   |"} else {lappend pref "    "}
					} else {
						foreach _1 $lhublevel {
							foreach {bot1 level1} $_1 break
							if {$hub0 == $bot1} {set pref [lreplace $pref [expr $level1+1] end]; break}
						}
					}
				}
				set find2 0
				foreach _1 $lbots {
					foreach {bot1 hub1 left1 right1} $_1 break
					if {$bot1 == $hub0} {
						if {[expr $right0+1] == $right1} {lset pref end "   `"; set lastclose 1}
						break
					}
				}
				
				lappend lhublevel [list $bot0 [llength $pref]]
				set lastleft $left0
				set lastright $right0
				set lasthub $hub0
				put_msg "[join $pref ""] - $bot0" -speed 3
				incr ind0
			}
			
		} else {
			put_msg [sprintf bots #102 [expr [llength $bots]+1]]
			if {[llength $bots] > 0} {put_msg [sprintf bots #103 [join $bots]]}
		}
		put_log ""
		return 1
		
	}
	
	proc cmd_addbot {} {
		importvars [list onick ochan obot snick shand schan command dnick daddress dbport duport dhost]
		variable ccs
		
		set dhand [get_hand $dnick -quiet 1]
		if {[check_notavailable {-getting_users -validhandle} -dnick $shand -dhand $dhand]} {return 0}
		
		set address $daddress
		if {$dbport != ""} {append address ":$dbport"}
		if {$duport != ""} {append address "/$duport"}
		
		if {[string is space $dhost]} {
			if {[onchan $dnick]} {
				set dhost [get_mask "$dnick![getchanhost $dhand]" $ccs(addusermask)]
			}
		}
		
		if {![addbot $dnick $address]} {put_msg [sprintf bots #107 $dhost]; return 0}
		
		if {![string is space $dhost]} {setuser $dnick HOSTS $dhost}
		put_msg [sprintf bots #106 $dnick $address $dhost]
		put_log "$dnick $address ($dhost)"
		return 1
		
	}
	
	proc cmd_delbot {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		deluser $dhand
		put_msg [sprintf bots #104 [get_nick $dnick $dhand]]
		put_log "$dhand"
		return 1
		
	}
	
	proc cmd_botattr {} {
		importvars [list onick ochan obot snick shand schan command dnick sflag]
		variable ccs
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand  -dnick $dnick -dhand $dhand]} {return 0}
		
		set newflags [botattr $dhand $sflag]
		put_msg [sprintf bots #109 [get_nick $dnick $dhand] $newflags]
		put_log "$dhand: $newflags"
		return 1
		
	}
	
	proc cmd_chaddr {} {
		importvars [list onick ochan obot snick shand schan command dnick saddress sbport suport]
		variable ccs
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		if {[string is space $sbport]} {
			setuser $dhand BOTADDR $saddress
		} elseif {[string is space $suport]} {
			setuser $dhand BOTADDR $saddress $sbport $sbport
		} else {
			setuser $dhand BOTADDR $saddress $sbport $suport
		}
		put_msg [sprintf bots #108 [get_nick $dnick $dhand] $saddress $sbport $suport]
		put_log "$dhand (address: $saddress, bot port: $sbport, user port: $suport)"
		return 1
		
	}
	
	proc cmd_chbotpass {} {
		importvars [list onick ochan obot snick shand schan command dnick dpass]
		variable ccs
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		if {[string is space $dpass]} {
			setuser $dhand XTRA PassCmdBot ""
			put_msg [sprintf bots #111 [get_nick $dnick $dhand]]
			put_log "CLEAR $dhand"
		} else {
			setuser $dhand XTRA PassCmdBot $dpass
			put_msg [sprintf bots #110 [get_nick $dnick $dhand]]
			put_log "SET $dhand"
		}
		return 1
		
	}
	
	proc cmd_listauth {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		variable ccs
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-notvalidhandle} -dnick $dnick -dhand $dhand]} {return 0}
		
		set lout [list]
		foreach _0 [getuser $dhand XTRA ListAuth] {
			foreach {bothand nickhand} $_0 break
			set botnick [hand2nick $bothand]
			lappend lout "\[bot: [get_nick $botnick $bothand], handle: \002$nickhand\002\]"
		}
		
		if {[llength $lout] == 0} {
			put_msg [sprintf bots #113 [get_nick $dnick $dhand]]
		} else {
			put_msg [sprintf bots #112 [get_nick $dnick $dhand] [join $lout "; "]]
		}
		
		return 1
		
	}
	
	proc cmd_addauth {} {
		importvars [list onick ochan obot snick shand schan command dnick dbotnick dhandle]
		variable ccs
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		set dbothand [get_hand $dbotnick]
		if {[check_notavailable {-notvalidhandle -notisbot} -shand $shand -dnick $dbotnick -dhand $dbothand]} {return 0}
		
		set newListAuth [list]
		set find0 0
		foreach _0 [getuser $dhand XTRA ListAuth] {
			foreach {bothand handle} $_0 break
			if {$bothand == $dbothand && $handle == $dhandle} {
				put_msg [sprintf bots #114 [get_nick $dnick $dhand] [get_nick [hand2nick $bothand] $bothand] $handle]
				return 0
			} elseif {$bothand == $dbothand && $handle != $dhandle} {
				set tbothand $bothand
				set thandle $handle
				set find0 1
			} else {
				lappend newListAuth $_0
			}
		}
		foreach _0 [userlist] {
			if {$_0 == $dhand} continue
			foreach _1 [getuser $_0 XTRA ListAuth] {
				foreach {bothand handle} $_1 break
				if {$bothand == $dbothand && $handle == $dhandle} {
					put_msg [sprintf bots #117 [get_nick [hand2nick $bothand] $bothand] $handle [get_nick [hand2nick $_0] $_0]]
					return 0
				}
			}
		}
		if {$find0} {
			put_msg [sprintf bots #115 [get_nick $dnick $dhand] [get_nick [hand2nick $tbothand] $tbothand] $thandle [get_nick $dbotnick $dbothand] $dhandle]
		} else {
			put_msg [sprintf bots #116 [get_nick $dnick $dhand] [get_nick $dbotnick $dbothand] $dhandle]
		}
		lappend newListAuth [list $dbothand $dhandle]
		setuser $dhand XTRA ListAuth $newListAuth
		return 1
		
	}
	
	proc cmd_delauth {} {
		importvars [list onick ochan obot snick shand schan command dnick dbotnick]
		variable ccs
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		set dbothand [get_hand $dbotnick -quiet 1]
		if {[check_isnull $dbothand]} {set dbothand $dbotnick}
		
		set newListAuth [list]
		set find0 0
		foreach _0 [getuser $dhand XTRA ListAuth] {
			foreach {bothand handle} $_0 break
			if {$bothand == $dbothand} {
				set tbothand $bothand
				set thandle $handle
				set find0 1
			} else {
				lappend newListAuth $_0
			}
		}
		if {$find0} {
			put_msg [sprintf bots #118 [get_nick $dnick $dhand] [get_nick [hand2nick $tbothand] $tbothand] $thandle]
		} else {
			put_msg [sprintf bots #119 [get_nick $dnick $dhand] [get_nick $dbotnick $dbothand]]
		}
		setuser $dhand XTRA ListAuth $newListAuth
		return 1
		
	}
	
	
}