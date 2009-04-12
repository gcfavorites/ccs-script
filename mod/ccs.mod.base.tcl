##################################################################################################################
## Модуль с базовыми командами управления
##################################################################################################################
# Список последних изменений:
#	v1.3.1
# - Для команды !info добавлен вывод информации по пользовательским флагам
#	v1.2.7
# - Для команды !info добавлен вывод библиотек
#	v1.2.6
# - Для команды !info добавлен вывод списка порядковых номеров хостмасок
#	v1.2.5
# - Убраны скобки { } при выводе хостов в команде !whois

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"base"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.1" \
				"12-Apr-2009" \
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
	
	cconfigure kick -add 1 -group "mode" -flags {o|o} -block 1 \
		-alias {%pref_kick} \
		-regexp {{^([^\ ]+)(?:\ +(.*?))?$} {-> dnick reason}}
	
	cconfigure inv -add 1 -group "other" -flags {m|m} -block 5 \
		-alias {%pref_inv} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cconfigure topic -add 1 -group "chan" -flags {o|o T|T} -block 3 \
		-alias {%pref_topic} \
		-regexp {{^(.+?)$} {-> stext}}
	
	cconfigure addtopic -add 1 -group "chan" -flags {o|o T|T} -block 5 \
		-alias {%pref_addtopic %pref_добавить} \
		-regexp {{^(.+?)$} {-> stext}}
	
	cconfigure ops -add 1 -group "info" -flags {-|-} -block 5 -useauth 0 -usebotnet 0 \
		-alias {%pref_ops} \
		-regexp {{^$} {}}
	
	cconfigure admins -add 1 -group "info" -flags {-|-} -block 5 -useauth 0 -usechan 0 -usebotnet 0 \
		-alias {%pref_admins} \
		-regexp {{^$} {}}
	
	cconfigure whom -add 1 -group "info" -flags {p} -block 5 -useauth 0 -usechan 0 -usebotnet 0 \
		-alias {%pref_whom} \
		-regexp {{^$} {}}
	
	cconfigure whois -add 1 -group "user" -flags {%v} -block 2 -useauth 0 -usechan 3 \
		-alias {%pref_whois} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cconfigure info -add 1 -group "info" -flags {%v} -block 5 -useauth 0 -usechan 0 \
		-alias {%pref_info} \
		-regexp {{^(?:(mod|scr|lang|lib|mask|flag)\s+([a-zA-Z]))?$} {-> dname dflag}}
	
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
		importvars [list onick ochan obot snick shand schan command dname dflag]
		variable author
		variable version
		variable date
		variable ccs
		
		switch -exact -- $dname {
			mod {
				set lmod [get_fileinfo mod]
				foreach _ $lmod {
					put_msg [sprintf base #146 $_ $ccs(mod,version,$_) $ccs(mod,date,$_) $ccs(mod,author,$_) $ccs(mod,name,$_) $ccs(mod,description,$_)] -speed 3
				}
				if {[llength $lmod] == 0} {put_msg [sprintf base #147]}
			}
			scr {
				set lscr [get_fileinfo scr]
				foreach _ $lscr {
					put_msg [sprintf base #146 $_ $ccs(scr,version,$_) $ccs(scr,date,$_) $ccs(scr,author,$_) $ccs(scr,name,$_) $ccs(scr,description,$_)] -speed 3
				}
				if {[llength $lscr] == 0} {put_msg [sprintf base #148]}
			}
			lang {
				set llang [get_fileinfo lang]
				foreach _ $llang {
					set _0 [lindex $_ 0]
					set _1 [lindex $_ 1]
					put_msg [sprintf base #146 "$_0 ($_1)" $ccs(lang,version,$_0,$_1) $ccs(lang,date,$_0,$_1) $ccs(lang,author,$_0,$_1) $ccs(lang,name,$_0,$_1) $ccs(lang,description,$_0,$_1)] -speed 3
				}
				if {[llength $llang] == 0} {put_msg [sprintf base #149]}
			}
			lib {
				set llib [get_fileinfo lib]
				foreach _ $llib {
					put_msg [sprintf base #146 $_ $ccs(lib,version,$_) $ccs(lib,date,$_) $ccs(lib,author,$_) $ccs(lib,name,$_) $ccs(lib,description,$_)] -speed 3
				}
				if {[llength $llib] == 0} {put_msg [sprintf base #150]}
			}
			mask {
				put_msg "\0021:\002 *!user@host, \0022:\002 *!*user@host, \0023:\002 *!*@host, \0024:\002 *!*user@*.host, \0025:\002 *!*@*.host, \0026:\002 nick!user@host, \0027:\002 nick!*user@host, \0028:\002 nick!*@host, \0029:\002 nick!*user@*.host, \00210:\002 nick!*@*.host"
			}
			flag {
				
				switch -exact -- $dflag {
					n {put_msg [sprintf base #151]}
					m {put_msg [sprintf base #152]}
					t {put_msg [sprintf base #153]}
					a {put_msg [sprintf base #154]}
					o {put_msg [sprintf base #155]}
					y {put_msg [sprintf base #156]}
					l {put_msg [sprintf base #157]}
					g {put_msg [sprintf base #158]}
					v {put_msg [sprintf base #159]}
					f {put_msg [sprintf base #160]}
					p {put_msg [sprintf base #161]}
					q {put_msg [sprintf base #162]}
					r {put_msg [sprintf base #163]}
					d {put_msg [sprintf base #164]}
					k {put_msg [sprintf base #165]}
					x {put_msg [sprintf base #166]}
					j {put_msg [sprintf base #167]}
					c {put_msg [sprintf base #168]}
					w {put_msg [sprintf base #169]}
					z {put_msg [sprintf base #170]}
					e {put_msg [sprintf base #171]}
					u {put_msg [sprintf base #172]}
					h {put_msg [sprintf base #173]}
					b {put_msg [sprintf base #174]}
					default {
						
						if {$dflag == $ccs(flag_auth)} {put_msg [sprintf base #175 $ccs(flag_auth)]
						} elseif {$dflag == $ccs(flag_auth_botnet)} {put_msg [sprintf base #176 $ccs(flag_auth_botnet)]
						} elseif {$dflag == $ccs(flag_botnet_check)} {put_msg [sprintf base #177 $ccs(flag_botnet_check)]
						} elseif {$dflag == $ccs(flag_auth_perm)} {put_msg [sprintf base #178 $ccs(flag_auth_perm)]
						} elseif {$dflag == $ccs(flag_locked)} {put_msg [sprintf base #179 $ccs(flag_locked)]
						} elseif {$dflag == [string range $ccs(flag_protect) 0 0]} {put_msg [sprintf base #180 $ccs(flag_protect)]
						} elseif {$dflag == $ccs(flag_cmd_bot)} {put_msg [sprintf base #181 $ccs(flag_cmd_bot)]
						} else {put_msg [sprintf base #182 $dflag]}
					}
				}
				
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