####################################################################################################
## Модуль с базовыми командами управления
####################################################################################################
# Список последних изменений:
#	v1.3.1
# - Для команды !info добавлен вывод информации по пользовательским флагам
#	v1.2.7
# - Для команды !info добавлен вывод библиотек
#	v1.2.6
# - Для команды !info добавлен вывод списка порядковых номеров хостмасок
#	v1.2.5
# - Убраны скобки { } при выводе хостов в команде !whois

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{base}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль предоставляющий базовые команды не попадающие под другие группы."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# Отображать в сообщение кика пользователя подавшего команду. (0 - нет, 1 - да).
	# Значение может быть переопределено выставлением канального флага ccs-vkickuser
	set options(vkickuser)			0
	
	################################################################################################
	# Отображать при смене топика пользователя подавшего команду. (0 - нет, 1 - да).
	# Значение может быть переопределено выставлением канального флага ccs-vtopicuser
	set options(vtopicuser)			1
	
	cmd_configure kick -control -group "mode" -flags {o|o} -block 1 \
		-alias {%pref_kick} \
		-regexp {{^([^\ ]+)(?:\ +(.*?))?$} {-> dnick reason}}
	
	cmd_configure inv -control -group "other" -flags {m|m} -block 5 \
		-alias {%pref_inv} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cmd_configure topic -control -group "chan" -flags {o|o T|T} -block 3 \
		-alias {%pref_topic} \
		-regexp {{^(.+?)$} {-> stext}}
	
	cmd_configure addtopic -control -group "chan" -flags {o|o T|T} -block 5 \
		-alias {%pref_addtopic %pref_добавить} \
		-regexp {{^(.+?)$} {-> stext}}
	
	cmd_configure ops -control -group "info" -flags {-|-} -block 5 -use_auth 0 -use_botnet 0 \
		-alias {%pref_ops} \
		-regexp {{^$} {}}
	
	cmd_configure admins -control -group "info" -flags {-|-} -block 5 -use_auth 0 -use_chan 0 -use_botnet 0 \
		-alias {%pref_admins} \
		-regexp {{^$} {}}
	
	cmd_configure whom -control -group "info" -flags {p} -block 5 -use_auth 0 -use_chan 0 -use_botnet 0 \
		-alias {%pref_whom} \
		-regexp {{^$} {}}
	
	cmd_configure whois -control -group "user" -flags {%v} -block 2 -use_auth 0 -use_chan 3 \
		-alias {%pref_whois} \
		-regexp {{^([^\ ]+)?$} {-> dnick}}
	
	cmd_configure info -control -group "info" -flags {%v} -block 5 -use_auth 0 -use_chan 0 \
		-alias {%pref_info} \
		-regexp {{^(?:(mod|scr|lang|lib|mask|flag)(?:\s+([a-zA-Z]))?)?$} {-> dname dflag}}
	
	setudef str ccs-vkickuser
	setudef str ccs-vtopicuser
	
	################################################################################################
	# Процедуры команд кика (KICK).
	
	proc cmd_kick {} {
		upvar out out
		importvars [list snick shand schan command dnick reason]
		
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
	
	################################################################################################
	# Процедуры команд управления инвайтами (INVITE).
	
	proc cmd_inv {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		
		if {[check_notavailable {-onchan} -dnick $dnick -dchan $schan]} {return 0}
		
		putserv "INVITE $dnick $schan"
		put_log "$dnick"
		return 1
		
	}
	
	################################################################################################
	# Процедуры команд управления топиком (TOPIC).
	
	proc cmd_topic {} {
		upvar out out
		importvars [list snick shand schan command stext]
		
		if {[get_options "vtopicuser" $schan]} {append stext " \($shand\)"}
		putserv "TOPIC $schan :[sprintf base #102 $stext]"
		put_log "($stext)"
		return 1
		
	}
	
	proc cmd_addtopic {} {
		upvar out out
		importvars [list snick shand schan command stext]
		
		if {[get_options "vtopicuser" $schan]} {append stext " \($shand\)"}
		putserv "TOPIC $schan :[sprintf base #103 [topic $schan] $stext]"
		put_log "($stext)"
		return 1
		
	}
	
	################################################################################################
	# Процедуры команд просмотра Администрации бота.
	
	proc own_list {data} {
		
		set outstring [list]
		foreach n $data {lappend outstring [StrNick -hand $n]}
		return [join $outstring ", "]
		
	}
	
	proc cmd_ops {} {
		upvar out out
		importvars [list snick shand schan command]
		
		put_msg -speed 3 -- [sprintf base #107 $schan]
		foreach {t f} {#108 f #109 l #110 o #111 m #112 n} {
			put_msg -speed 3 -- [sprintf base $t [own_list [userlist -|$f $schan]]]
		}
		put_log ""
		return 1
		
	}
	
	proc cmd_admins {} {
		upvar out out
		importvars [list snick shand schan command]
		global botnick admin
		
		put_msg -speed 3 -- [sprintf base #113 $botnick]
		foreach {t f} {#114 f #115 l #116 o #117 m #118 n} {
			put_msg -speed 3 -- [sprintf base $t [own_list [userlist $f]]]
		}
		put_msg -speed 3 -- [sprintf base #119 $admin]
		put_log ""
		return 1
		
	}
	
	################################################################################################
	# Процедуры команд пользователей патилайна (DCC Chat).
	
	proc cmd_whom {} {
		upvar out out
		importvars [list snick shand schan command]
		
		set p_t [whom *]
		if {[llength $p_t] == 0} {put_msg [sprintf base #120]; return 0}
		
		put_msg -speed 3 -- [sprintf base #121]
		foreach _ $p_t {
			lassign $_ fnick fbot fhostname fflag fidle faway fchan
			if {$fidle == "" || $fidle == 0} {
				put_msg -speed 3 -- [sprintf base #122 $fnick $fbot $fhostname]
			} else {
				put_msg -speed 3 -- [sprintf base #123 $fnick $fbot $fhostname [xdate [duration [expr ($fidle * 60)]]]]
			}
		}
		put_msg -speed 3 -- [sprintf base #124]
		put_log ""
		return 1
		
	}
	
	################################################################################################
	# Процедуры команд управления пользователями (USER).
	
	proc cmd_whois {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		
		if {[string is space $dnick]} {set dnick $snick}
		
		if {[onchan $dnick]} {
			if {[check_isnull [set dhand [nick2hand $dnick]]]} {
				if {[validuser $dnick]} {
					# Юзер сидит на канале и есть в юзерлисте но соответствия нету
					put_msgwhois [hand2nick $dnick] $dnick $schan
				} else {
					# Юзер не найден в юзерлисте
					put_msg [sprintf ccs #123 $dnick]
					return 0
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
				put_msg [sprintf ccs #125 $dnick]
				return 0
			}
		}
		return 1
		
	}
	
	proc put_msgwhois {dnick dhand schan} {
		variable options
		upvar out out
		
		put_msg "[expr {![check_isnull $dnick] ? "nick \002$dnick\002, " : ""}]handle \002$dhand\002. [sprintf base #125 [chattr $dhand $schan] [join [getuser $dhand HOSTS]] [expr {[string is space [set info [getchaninfo $dhand $schan]]] ? "" : " INFO: $info."}]]"
		
		set lauth [list]
		if {[matchattr $dhand $options(flag_auth_perm)]} {
			lappend lauth [sprintf base #129]
		} elseif {[matchattr $dhand $options(flag_auth)] || [matchattr $dhand $options(flag_auth_botnet)]} {
			if {[matchattr $dhand $options(flag_auth)]} {
				lappend lauth [sprintf base #127 [join [getuser $dhand XTRA AuthNick] ", "]]
			}
			if {[matchattr $dhand $options(flag_auth_botnet)]} {
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
		upvar out out
		importvars [list snick shand schan command dname dflag]
		variable author
		variable version
		variable date
		variable options
		
		switch -exact -- $dname {
			mod {
				set r {}
				foreach _ [pkg_list mod] {
					lappend r [sprintf base #146 $_ [pkg_info mod $_ version] [pkg_info mod $_ date] \
						[pkg_info mod $_ author] [pkg_info mod $_ on] [pkg_info mod $_ description]]
				}
				if {[llength $r] > 0} {
					put_msg -speed 3 -list -notice2msg -- $r
				} else {
					put_msg [sprintf base #147]
				}
			}
			scr {
				set r {}
				foreach _ [pkg_list scr] {
					lappend r [sprintf base #146 $_ [pkg_info scr $_ version] [pkg_info scr $_ date] \
						[pkg_info scr $_ author] [pkg_info scr $_ on] [pkg_info scr $_ description]]
				}
				if {[llength $r] > 0} {
					put_msg -speed 3 -list -notice2msg -- $r
				} else {
					put_msg [sprintf base #148]
				}
			}
			lang {
				set r {}
				foreach _ [pkg_list lang] {
					lappend r [sprintf base #146 $_ [pkg_info lang $_ version] [pkg_info lang $_ date] \
						[pkg_info lang $_ author] [pkg_info lang $_ on] [pkg_info lang $_ description]]
				}
				if {[llength $r] > 0} {
					put_msg -speed 3 -list -notice2msg -- $r
				} else {
					put_msg [sprintf base #149]
				}
			}
			lib {
				set r {}
				foreach _ [pkg_list lib] {
					lappend r [sprintf base #146 $_ [pkg_info lib $_ version] [pkg_info lib $_ date] \
						[pkg_info lib $_ author] [pkg_info lib $_ on] [pkg_info lib $_ description]]
				}
				if {[llength $r] > 0} {
					put_msg -speed 3 -list -notice2msg -- $r
				} else {
					put_msg [sprintf base #150]
				}
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
						if {$dflag == $options(flag_auth)} {put_msg [sprintf base #175 $options(flag_auth)]
						} elseif {$dflag == $options(flag_auth_botnet)} {put_msg [sprintf base #176 $options(flag_auth_botnet)]
						} elseif {$dflag == $options(flag_botnet_check)} {put_msg [sprintf base #177 $options(flag_botnet_check)]
						} elseif {$dflag == $options(flag_auth_perm)} {put_msg [sprintf base #178 $options(flag_auth_perm)]
						} elseif {$dflag == $options(flag_locked)} {put_msg [sprintf base #179 $options(flag_locked)]
						} elseif {$dflag == [string range $options(flag_protect) 0 0]} {put_msg [sprintf base #180 $options(flag_protect)]
						} elseif {$dflag == $options(flag_cmd_bot)} {put_msg [sprintf base #181 $options(flag_cmd_bot)]
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
				put_msg -speed 3 -- "[sprintf base #133] [join $lout "; "]"
				
				set lout [list]
				lappend lout [sprintf base #141 $::handlen]
				if {[info exists ::seen-nick-len]} {lappend lout [sprintf base #142 ${::seen-nick-len}]}
				lappend lout [sprintf base #143 [encoding system]]
				lappend lout [sprintf base #144 [xdate [duration [expr [unixtime]-$::uptime]]]]
				lappend lout [sprintf base #145 [xdate [duration [expr [unixtime]-${::server-online}]]]]
				put_msg -speed 3 -- [join $lout "; "]
			}
		}
		
		return 1
		
	}
	
	proc notavailable-onchan {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {[onchan $dnick $dchan]} {
			put_msg [sprintf base #131 $dnick $dchan]
			return 1
		}
		return 0
	}
	
}