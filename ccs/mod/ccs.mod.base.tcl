##################################################################################################################
## Модуль с базовыми командами управления
##################################################################################################################
# Список последних изменений:
#	v1.2.5
# - Убраны скобки { } при выводе хостов в команде !whois

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"base"
addfileinfo mod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.5" \
				"05-Jan-2009" \
				"Модуль предоставляющий базовые команды не попадающие под другие группы."

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Отображать в сообщение кика пользователя подавшего команду. (0 - нет, 1 - да). Значение может быть
	# переопределено выставлением канального флага ccs-vkickuser
	set ccs(vkickuser)			0
	
	#############################################################################################################
	# Отображать при смене топика пользователя подавшего команду. (0 - нет, 1 - да). Значение может быть
	# переопределено выставлением канального флага ccs-vtopicuser
	set ccs(vtopicuser)			1
	
	lappend ccs(commands)	"kick"
	lappend ccs(commands)	"inv"
	lappend ccs(commands)	"topic"
	lappend ccs(commands)	"addtopic"
	lappend ccs(commands)	"ops"
	lappend ccs(commands)	"admins"
	lappend ccs(commands)	"whom"
	lappend ccs(commands)	"whois"
	lappend ccs(commands)	"info"
	
	set ccs(group,kick) "mode"
	set ccs(flags,kick) {o|o}
	set ccs(alias,kick) {%pref_kick}
	set ccs(block,kick) 1
	set ccs(regexp,kick) {{^([^\ ]+)(?:\ +(.*?))?$} {-> dnick reason}}
	
	set ccs(group,inv) "other"
	set ccs(flags,inv) {m|m}
	set ccs(alias,inv) {%pref_inv}
	set ccs(block,inv) 5
	set ccs(regexp,inv) {{^([^\ ]+)$} {-> dnick}}
	
	set ccs(group,topic) "chan"
	set ccs(flags,topic) {o|o T|T}
	set ccs(alias,topic) {%pref_topic}
	set ccs(block,topic) 3
	set ccs(regexp,topic) {{^(.+?)$} {-> stext}}
	
	set ccs(group,addtopic) "chan"
	set ccs(flags,addtopic) {o|o T|T}
	set ccs(alias,addtopic) {%pref_addtopic %pref_добавить}
	set ccs(block,addtopic) 5
	set ccs(regexp,addtopic) {{^(.+?)$} {-> stext}}
	
	set ccs(group,ops) "info"
	set ccs(use_auth,ops) 0
	set ccs(use_botnet,ops) 0
	set ccs(flags,ops) {-|-}
	set ccs(alias,ops) {%pref_ops}
	set ccs(block,ops) 5
	set ccs(regexp,ops) {{^$} {}}
	
	set ccs(group,admins) "info"
	set ccs(use_auth,admins) 0
	set ccs(use_chan,admins) 0
	set ccs(use_botnet,admins) 0
	set ccs(flags,admins) {-|-}
	set ccs(alias,admins) {%pref_admins}
	set ccs(block,admins) 5
	set ccs(regexp,admins) {{^$} {}}
	
	set ccs(group,whom) "info"
	set ccs(use_auth,whom) 0
	set ccs(use_chan,whom) 0
	set ccs(use_botnet,whom) 0
	set ccs(flags,whom) {p}
	set ccs(alias,whom) {%pref_whom}
	set ccs(block,whom) 5
	set ccs(regexp,whom) {{^$} {}}
	
	set ccs(group,whois) "user"
	set ccs(use_auth,whois) 0
	set ccs(use_chan,whois) 3
	set ccs(flags,whois) {%v}
	set ccs(alias,whois) {%pref_whois}
	set ccs(block,whois) 2
	set ccs(regexp,whois) {{^([^\ ]+)?$} {-> dnick}}
	
	set ccs(group,info) "info"
	set ccs(use_auth,info) 0
	set ccs(use_chan,info) 0
	set ccs(flags,info) {%v}
	set ccs(alias,info) {%pref_info}
	set ccs(block,info) 5
	set ccs(regexp,info) {{^(mod|scr|lang)?$} {-> dname}}
	
	setudef str ccs-vkickuser
	setudef str ccs-vtopicuser
	
	#############################################################################################################
	# Процедуры команд кика (KICK).
	
	proc cmd_kick {} {
		importvars [list onick ochan obot snick shand schan command dnick reason]
		
		if {$reason == ""} {set reason [sprintf base #101]}
		foreach _ [split $dnick ,] {
			set dhand [nick2hand $_]
			if {[check_notavailable {-isbotnick -notonchan -protect -nopermition0} -shand $shand -dnick $_ -dhand $dhand -dchan $schan]} {continue}
			
			if {[get_options "vkickuser" $schan]} {append reason " \($shand\)"}
			
			putkick $schan $_ $reason
			put_log "$_ ($reason)."
		}
		return 1
		
	}
	
	#############################################################################################################
	# Процедуры команд управления инвайтами (INVITE).
	
	proc cmd_inv {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[check_notavailable {-onchan} -dnick $dnick -dchan $schan]} {return 0}
		
		putserv "INVITE $dnick $schan"
		put_log "$dnick"
		return 1
		
	}
	
	#############################################################################################################
	# Процедуры команд управления топиком (TOPIC).
	
	proc cmd_topic {} {
		importvars [list onick ochan obot snick shand schan command stext]
		
		if {[get_options "vtopicuser" $schan]} {append stext " \($shand\)"}
		putserv "TOPIC $schan :[sprintf base #102 $stext]"
		put_log "($stext)"
		return 1
		
	}
	
	proc cmd_addtopic {} {
		importvars [list onick ochan obot snick shand schan command stext]
		
		if {[get_options "vtopicuser" $schan]} {append stext " \($shand\)"}
		putserv "TOPIC $schan :[sprintf base #103 [topic $schan] $stext]"
		put_log "($stext)"
		return 1
		
	}
	
	#############################################################################################################
	# Процедуры команд просмотра Администрации бота.
	
	proc own_list {data} {
		
		set outstring [list]
		foreach n $data {
			if {[check_isnull [set qonline [hand2nick $n]]]} {
				lappend outstring "$n"
			} else {
				lappend outstring [get_nick $n $qonline]
			}
		}
		return [join $outstring ", "]
		
	}
	
	proc cmd_ops {} {
		importvars [list onick ochan obot snick shand schan command]
		
		put_msg [sprintf base #107 $schan] -speed 3
		foreach {t f} {#108 f #109 l #110 o #111 m #112 n} {
			put_msg [sprintf base $t [own_list [userlist -|$f $schan]]] -speed 3
		}
		put_log ""
		return 1
		
	}
	
	proc cmd_admins {} {
		importvars [list onick ochan obot snick shand schan command]
		global botnick admin
		
		put_msg [sprintf base #113 $botnick] -speed 3
		foreach {t f} {#114 f #115 l #116 o #117 m #118 n} {
			put_msg [sprintf base $t [own_list [userlist $f]]] -speed 3
		}
		put_msg [sprintf base #119 $admin] -speed 3
		put_log ""
		return 1
		
	}
	
	#############################################################################################################
	# Процедуры команд пользователей патилайна (DCC Chat).
	
	proc cmd_whom {} {
		importvars [list onick ochan obot snick shand schan command]
		
		set p_t [whom *]
		if {[llength $p_t] == 0} {put_msg [sprintf base #120]; return 0}
		
		put_msg [sprintf base #121] -speed 3
		foreach _ $p_t {
			foreach {fnick fbot fhostname fflag fidle faway fchan} $_ break
			if {$fidle == "" || $fidle == 0} {
				put_msg [sprintf base #122 $fnick $fbot $fhostname] -speed 3
			} else {
				put_msg [sprintf base #123 $fnick $fbot $fhostname [xdate [duration [expr ($fidle * 60)]]]] -speed 3
			}
		}
		put_msg [sprintf base #124] -speed 3
		put_log ""
		return 1
		
	}
	
	#############################################################################################################
	# Процедуры команд управления пользователями (USER).
	
	proc cmd_whois {} {
		importvars [list onick ochan obot snick shand schan command dnick]
		
		if {[string is space $dnick]} {set dnick $snick}
		
		if {[onchan $dnick]} {
			if {[check_isnull [set dhand [nick2hand $dnick]]]} {
				if {[validuser $dnick]} {
					# Юзер сидит на канале и есть в юзерлисте но соответствия нету
					put_msgwhois [hand2nick $dnick] $dnick $schan
				} else {
					# Юзер не найден в юзерлисте
					put_msg [sprintf ccs #123 $dnick]; return 0
				}
			} else {
				if {![string equal -nocase $dnick $dhand] && [validuser $dnick]} {
					# Юзер сидит на канале и есть в юзерлисте но соответствие идет с другим юзером
					put_msgwhois $dnick $dhand $schan
					put_msgwhois [hand2nick $dnick] $dnick $schan
				} else {
					# Юзер сидит на канале и он есть в юзерлисте с таким же ником
					put_msgwhois $dnick $dhand $schan
				}
			}
			
		} else {
			if {[validuser $dnick]} {
				# Юзер найден в юзерлисте (так же попробовать найти на канале соответствие хендла)
				put_msgwhois [hand2nick $dnick] $dnick $schan
			} else {
				# Юзер не найден ни на канале ни в юзерлисте
				put_msg [sprintf ccs #125 $dnick]; return 0
			}
		}
		return 1
		
	}
	
	proc put_msgwhois {dnick dhand schan} {
		variable ccs
		importvars [list onick ochan obot]
		
		put_msg "[expr {![check_isnull $dnick] ? "nick \002$dnick\002, " : ""}]handle \002$dhand\002. [sprintf base #125 [chattr $dhand $schan] [join [getuser $dhand HOSTS]] [expr {[string is space [set info [getchaninfo $dhand $schan]]] ? "" : " INFO: $info."}]]"
		
		set lauth [list]
		if {[matchattr $dhand $ccs(flag_auth_perm)]} {
			lappend lauth [sprintf base #129]
		} elseif {[matchattr $dhand $ccs(flag_auth)] || [matchattr $dhand $ccs(flag_auth_botnet)]} {
			if {[matchattr $dhand $ccs(flag_auth)]} {
				lappend lauth [sprintf base #127 [join [getuser $dhand XTRA AuthNick] ", "]]
			}
			if {[matchattr $dhand $ccs(flag_auth_botnet)]} {
				lappend lauth [sprintf base #126 [join [getuser $dhand XTRA AuthBot] ", "]]
			}
		} else {lappend lauth [sprintf base #128]}
		put_msg [sprintf base #132 [join $lauth ", "]]
		
		if {[matchattr $dhand b]} {
			set o_botaddr [getuser $dhand BOTADDR]
			put_msg [sprintf base #130 $dhand [botattr $dhand] [expr {[islinked $dhand] ? "yes" : "no"}] [lindex $o_botaddr 0] [lindex $o_botaddr 1] [lindex $o_botaddr 2]]
		}
		
	}
	
	proc cmd_info {} {
		importvars [list onick ochan obot snick shand schan command dname]
		variable author
		variable version
		variable date
		variable ccs
		
		switch -- $dname {
			mod {
				set lmod [get_lmod]
				foreach _ $lmod {
					put_msg [sprintf base #146 $_ $ccs(mod,version,$_) $ccs(mod,date,$_) $ccs(mod,author,$_) $ccs(mod,name,$_) $ccs(mod,description,$_)] -speed 3
				}
				if {[llength $lmod] == 0} {put_msg [sprintf base #147]}
			}
			scr {
				set lscr [get_lscr]
				foreach _ $lscr {
					put_msg [sprintf base #146 $_ $ccs(scr,version,$_) $ccs(scr,date,$_) $ccs(scr,author,$_) $ccs(scr,name,$_) $ccs(scr,description,$_)] -speed 3
				}
				if {[llength $lscr] == 0} {put_msg [sprintf base #148]}
			}
			lang {
				set llang [get_llang]
				foreach _ $llang {
					set _0 [lindex $_ 0]
					set _1 [lindex $_ 1]
					put_msg [sprintf base #146 "$_0 ($_1)" $ccs(lang,version,$_0,$_1) $ccs(lang,date,$_0,$_1) $ccs(lang,author,$_0,$_1) $ccs(lang,name,$_0,$_1) $ccs(lang,description,$_0,$_1)] -speed 3
				}
				if {[llength $llang] == 0} {put_msg [sprintf base #149]}
			}
			default {
				set lout [list]
				lappend lout [sprintf base #134 $version $date $author]
				lappend lout [sprintf base #135 [countusers]]
				lappend lout [sprintf base #136 [ctime [unixtime]]]
				lappend lout [sprintf base #137 [unames]]
				lappend lout [sprintf base #138 $::serveraddress[expr {[string is space $::server] ? "" : "(\002\037$::server\037\002)"}]]
				lappend lout [sprintf base #139 $::version]
				lappend lout [sprintf base #140 [expr {[info exists ::sp_version] ? "v$::sp_version" : "n/a"}]]
				put_msg "[sprintf base #133] [join $lout "; "]" -speed 3
				
				set lout [list]
				lappend lout [sprintf base #141 $::handlen]
				if {[info exists ::seen-nick-len]} {lappend lout [sprintf base #142 ${::seen-nick-len}]}
				lappend lout [sprintf base #143 [encoding system]]
				lappend lout [sprintf base #144 [xdate [duration [expr [unixtime]-$::uptime]]]]
				lappend lout [sprintf base #145 [xdate [duration [expr [unixtime]-${::server-online}]]]]
				put_msg [join $lout "; "] -speed 3
			}
		}
		
		return 1
		
	}
	
	proc notavailable-onchan {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {[onchan $dnick $dchan]} {
			put_msg [sprintf base #131 $dnick $dchan]
			return 1
		}
		return 0
	}
	
}