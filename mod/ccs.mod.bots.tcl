####################################################################################################
## Модуль управления ботами и ботнетом
####################################################################################################
# Список последних изменений:
#	v1.2.3
# - Перенесены все процедуры авторизации и управления через ботнет

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{bots}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.1" "11-Jul-2009" \
	"Модуль управления ботнетом."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# Значение, которое определяет маску, по которой будут добавляться новые боты.
	set options(addbotmask)				4
	
	################################################################################################
	# Разрешать вывод ботнета в виде дерева (1 - разрешить, 0 - запретить). Не рекомендуется
	# включать для ботов без отключенного на сервере контроля за флудом и для больших ботнетов.
	set options(botnettree)				1
	
	################################################################################################
	# Время в миллисекундах, повторения проверки ботнет авторизации.
	set options(time_botauth_check)		900000
	
	################################################################################################
	# Время в миллисекундах, в течение которого ждать ответа от бота при проверки авторизации.
	set options(time_botauth_receive)	10000
	
	################################################################################################
	# Кодировка, в которой будет отправляться/приниматься сообщение через ботнет, требуется для
	# совместимости, если в ботнете боты работают в разной кодировке. UTF не поддерживается.
	set options(botnet_encoding)		""
	
	################################################################################################
	# Длина кода отсылаемого сообщения. Необходимо для того чтобы параллельно отсылаемые сообщения
	# не перемешивались. В случае если ботнет управление используется очень часто (в течение
	# пересылки одного сообщения вызывается следующее), следует увеличить это значение.
	set options(botnet_lencode)			3
	
	################################################################################################
	# Длина одного пакета сообщения отсылаемого через ботнет.
	set options(botnet_lensend)			300
	
	################################################################################################
	# Максимальное количество отсылаемых/принятых пакетов для одного сообщения. Предотвращает
	# переполнение буфера.
	set options(botnet_maxsend)			100
	
	################################################################################################
	# Время в миллисекундах в течении которого ожидать приемку сообщения из ботнета.
	set options(botnet_timesend)		5000
	
	
	cmd_configure bots -control -group "botnet" -flags {%v} -block 5 -use_chan 0 -use_botnet 0 \
		-alias {%pref_bots} \
		-regexp {{^(tree)?$} {-> stree}}
	
	cmd_configure botattr -control -group "botnet" -flags {mt} -block 2 -use_chan 0 \
		-alias {%pref_botattr} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick sflag}}
	
	cmd_configure chaddr -control -group "botnet" -flags {mt} -block 2 -use_chan 0 \
		-alias {%pref_chaddr} \
		-regexp {{^([^\ ]+)(?:\ +([^\ :]+)(?:\:(\d+)(?:/(\d+))?)?)$} {-> dnick saddress sbport suport}}
	
	cmd_configure addbot -control -group "botnet" -flags {mt} -block 3 -use_chan 0 \
		-alias {%pref_addbot} \
		-regexp {{^([^\ ]+)(?:\ +([^\ :]+)(?:\:(\d+)(?:/(\d+))?)?)(?:\ +([^\ ]+))?$} {-> dnick daddress dbport duport dhost}}
	
	cmd_configure delbot -control -group "botnet" -flags {mt} -block 3 -use_chan 0 \
		-alias {%pref_delbot} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cmd_configure chbotpass -control -group "botnet" -flags {mt} -block 3 -use_chan 0 \
		-alias {%pref_chbotpass} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick dpass}}
	
	cmd_configure listauth -control -group "botnet" -flags {mt} -block 3 -use_chan 0 \
		-alias {%pref_listauth} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cmd_configure addauth -control -group "botnet" -flags {mt} -block 3 -use_chan 0 \
		-alias {%pref_addauth} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))(?:\ +([^\ ]+))$} {-> dnick dbotnick dhandle}}
	
	cmd_configure delauth -control -group "botnet" -flags {mt} -block 3 -use_chan 0 \
		-alias {%pref_delauth} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick dbotnick}}
	
	################################################################################################
	################################################################################################
	################################################################################################
	
	proc get_botpass {hand} {
		return [getuser $hand XTRA PassCmdBot]
	}
	
	proc set_botpass {hand pass} {
		setuser $hand XTRA PassCmdBot $pass
	}
	
	proc get_thand {hand bothand} {
		
		set thand ""
		foreach _ [getuser $hand XTRA ListAuth] {
			lassign $_ pbot phand
			if {[string equal -nocase $pbot $bothand]} {
				set thand $phand
				break
			}
		}
		
		return $thand
		
	}
	
	# Функция получения списка ботов для выполнения команд
	proc get_lcmdbots {} {
		variable options
		set r {}
		foreach _ [userlist b] {if {[matchattr $_ $options(flag_cmd_bot)]} {lappend r $_}}
		return $r
	}
	
	proc launch_cmdbot {snick shand shost schan text command} {
		upvar out out
		
		if {![on_chan $schan $command]} {return -code ok 0}
		
		set text [string trim $text]
		if {![regexp -- {^([^\ ]+)(?:\ +(.*?))?$} $text -> dbotnick text]} {put_msg [sprintf ccs #201 $::lastbind]; return 0}
		
		if {[string equal -nocase $dbotnick "all"] || [string equal -nocase $dbotnick "*"]} {
			launch_cmd $snick $shand $shost $schan $text $command
			set lcmdbots [get_lcmdbots]
		} else {
			set dbothand [get_hand $dbotnick]
			if {[check_notavailable {-notisbot -notiscmdbot -notvalidhandle} -dnick $dbotnick -dhand $dbothand]} {return 0}
			set lcmdbots [list $dbothand]
		}
		
		foreach bot $lcmdbots {
			send_cmdbot $bot $snick $shand $shost $schan $text $command
		}
		
	}
	
	proc send_cmdbot {bot snick shand shost schan text command} {
		upvar out out
		variable options
		
		set dbotpass [get_botpass $bot]
		set thand [get_thand $shand $bot]
		if {[check_notavailable {-notvalidpasscmdbot -notislinked -notisauth} \
			-snick $snick -shand $shand -dbothand $bot -dbotpass $dbotpass -thand $thand]} {return 0}
		
		set code ""
		for {set x 0} {$x < $options(botnet_lencode)} {incr x} {append code [expr int(rand()*10)]}
		
		if {[info exists out(nick)] && ![string is space $out(nick)]} {set tout(nick) $out(nick)}
		if {[info exists out(chan)] && ![string is space $out(chan)]} {set tout(chan) $out(chan)}
		if {[info exists out(idx)] && ![string is space $out(idx)]}   {set tout(idx) $out(idx)}
		
		set array_tout [array get tout]
		
		set msg [list ok260285 $code $array_tout $shand $snick $thand $shost $schan $command $text]
		if {$options(botnet_encoding) != ""} {
			if {$options(botnet_encoding) == "unicode"} {
				set l {}
				foreach _ [split $msg ""] {lappend l [scan $_ %c]}
				set msg $l
			} else {
				set msg [encoding convertto $options(botnet_encoding) $msg]
			}
		}
		set msg [encrypt $dbotpass $msg]
		
		set ind 0
		while {$msg != ""} {
			
			incr ind
			
			set head [list [encrypt $dbotpass [list ok260285 $code $ind]] ""]
			set len1 [string length $head]
			set msg1 [string range $msg 0 [expr $options(botnet_lensend)-$len1]]
			set msg  [string range $msg [expr $options(botnet_lensend)-$len1+1] end]
			
			lset head 1 $msg1
			
			if {$msg == ""} {putbot $bot "ccscmdbotend $head"} else {putbot $bot "ccscmdbot $head"}
			
		}
		
	}
	
	proc bot_clean {bot command code} {
		variable turn
		foreach _ [array names turn -glob "$code,$bot,*"] {unset turn($_)}
		put_log -return 0 -- "\0034receive a timeout message\003 ($bot)"
	}
	
	proc bot_ccscmdbot {bot command text} {
		variable turn
		variable options
		
		if {[set dbotpass [get_botpass $bot]] == ""} {
			put_log -return 0 -- "(\0034pass cmdbot not set\003) ($bot)"
		}
		
		set head [lindex $text 0]
		set head [decrypt $dbotpass $head]
		
		lassign $head ok code ind
		
		if {$ok != "ok260285"} {put_log -return 0 -- "\0034text do not decrypted\003 ($bot)"}
		
		if {![info exists turn($code,$bot,ind)]} {
			set turn($code,$bot,ind) 0
			set turn($code,$bot,msg) ""
			if {$command != "ccscmdbotend"} {
				set turn($code,$bot,afterid) [after $options(botnet_timesend) [list [namespace origin bot_clean] $bot $command $code]]
			} else {
				set turn($code,$bot,afterid) ""
			}
		}
		incr turn($code,$bot,ind)
		if {$turn($code,$bot,ind) != $ind} {
			if {$turn($code,$bot,afterid) != ""} {after cancel $turn($code,$bot,afterid)}
			foreach _ [array names turn -glob "$code,$bot,*"] {unset turn($_)}
			put_log -return 0 -- "\0034violated the sequence data (expected: $turn($code,$bot,ind), came: $ind)\003 ($bot)"
		}
		if {$turn($code,$bot,ind) > $options(botnet_maxsend)} {
			if {$turn($code,$bot,afterid) != ""} {after cancel $turn($code,$bot,afterid)}
			foreach _ [array names turn -glob "$code,$bot,*"] {unset turn($_)}
			put_log -return 0 -- "\0034exceeded the maximum number of packets (max: $options(botnet_maxsend))\003 ($bot)"
		}
		append turn($code,$bot,msg) [lindex $text 1]
		
		if {$command == "ccscmdbotend"} {
			
			set msg $turn($code,$bot,msg)
			set msg [decrypt $dbotpass $msg]
			if {$options(botnet_encoding) != ""} {
				if {$options(botnet_encoding) == "unicode"} {
					set s ""
					foreach _ $msg {append s [format %c $_]}
					set msg $s
				} else {
					set msg [encoding convertfrom $options(botnet_encoding) $msg]
				}
			}
			
			lassign $msg ok1 code1 array_out thand snick shand shost schan command text
			
			if {$ok1 != "ok260285"} {put_log -return 0 -- "\0034text do not decrypted\003 ($bot)"}
			if {$code1 != $code} {put_log -return 0 -- "\0034text do not decrypted\003 ($bot)"}
			if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
			
			array set out $array_out
			set out(bot)	$bot
			set out(hand)	$shand
			set out(thand)	$thand
			launch_cmd $snick $shand $shost $schan $text $command
			
			if {$turn($code,$bot,afterid) != ""} {after cancel $turn($code,$bot,afterid)}
			foreach _ [array names turn -glob "$code,$bot,*"] {unset turn($_)}
			
		}
		
		return 0
		
	}
	
	proc send_ccstext {bot shand text} {
		upvar out out
		variable options
		
		set dbotpass [get_botpass $bot]
		set thand [get_thand $shand $bot]
		if {[check_notavailable {-notvalidpasscmdbot -notislinked -notisauth} \
			-shand $shand -thand $thand -dbothand $bot -dbotpass $dbotpass]} {return 0}
		
		set code ""
		for {set x 0} {$x < $options(botnet_lencode)} {incr x} {append code [expr int(rand()*10)]}
		
		if {[info exists out(nick)] && ![string is space $out(nick)]} {set tout(nick) $out(nick)}
		if {[info exists out(chan)] && ![string is space $out(chan)]} {set tout(chan) $out(chan)}
		if {[info exists out(idx)] && ![string is space $out(idx)]} {set tout(idx) $out(idx)}
		
		set array_tout [array get tout]
		
		set msg [list ok210385 $code $array_tout $shand $thand $text]
		if {$options(botnet_encoding) != ""} {
			if {$options(botnet_encoding) == "unicode"} {
				set l {}
				foreach _ [split $msg ""] {lappend l [scan $_ %c]}
				set msg $l
			} else {
				set msg [encoding convertto $options(botnet_encoding) $msg]
			}
		}
		set msg [encrypt $dbotpass $msg]
		
		set ind 0
		while {$msg != ""} {
			
			incr ind
			
			set head [list [encrypt $dbotpass [list ok210385 $code $ind]] ""]
			set len1 [string length $head]
			set msg1 [string range $msg 0 [expr $options(botnet_lensend)-$len1]]
			set msg  [string range $msg [expr $options(botnet_lensend)-$len1+1] end]
			
			lset head 1 $msg1
			if {$msg == ""} {putbot $bot "ccstextend $head"} else {putbot $bot "ccstext $head"}
			
		}
		
	}
	
	proc bot_ccstext {bot command text} {
		variable turn
		variable options
		
		if {[set dbotpass [get_botpass $bot]] == ""} {
			put_log -return 0 -- "(\0034pass cmdbot not set\003) ($bot)"
		}
		
		set head [lindex $text 0]
		set head [decrypt $dbotpass $head]
		
		lassign $head ok code ind
		
		if {$ok != "ok210385"} {put_log -return 0 -- "\0034text do not decrypted\003 ($bot)"}
		
		if {![info exists turn($code,$bot,ind)]} {
			set turn($code,$bot,ind) 0
			set turn($code,$bot,msg) ""
			if {$command != "ccstextend"} {
				set turn($code,$bot,afterid) [after $options(botnet_timesend) [list [namespace origin bot_clean] $bot $command $code]]
			} else {
				set turn($code,$bot,afterid) ""
			}
		}
		incr turn($code,$bot,ind)
		if {$turn($code,$bot,ind) != $ind} {
			if {$turn($code,$bot,afterid) != ""} {after cancel $turn($code,$bot,afterid)}
			foreach _ [array names turn -glob "$code,$bot,*"] {unset turn($_)}
			put_log -return 0 -- "\0034violated the sequence data (expected: $turn($code,$bot,ind), came: $ind)\003 ($bot)"
		}
		if {$turn($code,$bot,ind) > $options(botnet_maxsend)} {
			if {$turn($code,$bot,afterid) != ""} {after cancel $turn($code,$bot,afterid)}
			foreach _ [array names turn -glob "$code,$bot,*"] {unset turn($_)}
			put_log -return 0 -- "\0034exceeded the maximum number of packets (max: $options(botnet_maxsend))\003 ($bot)"
		}
		append turn($code,$bot,msg) [lindex $text 1]
		
		if {$command == "ccstextend"} {
			
			set msg $turn($code,$bot,msg)
			set msg [decrypt $dbotpass $msg]
			if {$options(botnet_encoding) != ""} {
				if {$options(botnet_encoding) == "unicode"} {
					set s ""
					foreach _ $msg {append s [format %c $_]}
					set msg $s
				} else {
					set msg [encoding convertfrom $options(botnet_encoding) $msg]
				}
			}
			
			lassign $msg ok1 code1 array_out thand shand text
			
			if {$ok1 != "ok210385"} {put_log -return 0 -- "\0034text do not decrypted\003 ($bot)"}
			if {$code1 != $code} {put_log -return 0 -- "\0034text do not decrypted\003 ($bot)"}
			if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
			
			array set out $array_out
			set out(bot)	""
			set out(hand)	$shand
			set out(thand)	""
			
			put_msg -speed 3 -- "$bot :: $text"
			
			if {$turn($code,$bot,afterid) != ""} {after cancel $turn($code,$bot,afterid)}
			foreach _ [array names turn -glob "$code,$bot,*"] {unset turn($_)}
			
		}
		
		return 0
		
	}
	
	# Процедура ботнет авторизации по хендлу
	proc addbotauth {hand sbothand} {
		variable options
		
		set authnick [getuser $hand XTRA AuthBot]
		if {[lsearch -exact $authnick $sbothand] >= 0} {return 0}
		lappend authnick $sbothand
		setuser $hand XTRA AuthBot $authnick
		chattr $hand +$options(flag_auth_botnet)
		return 1
		
	}
	
	# Процедура снятия ботнет авторизации по хендлу
	proc delbotauth {hand sbothand} {
		variable options
		
		set authnick [getuser $hand XTRA AuthBot]
		if {[set ind [lsearch -exact $authnick $sbothand]] < 0} {return 0}
		set authnick [lreplace $authnick $ind $ind]
		setuser $hand XTRA AuthBot $authnick
		if {[llength $authnick] == 0} {chattr $hand -$options(flag_auth_botnet)}
		return 1
		
	}
	
	# отсылка запроса через ботнет по авторизационному списку
	proc putbot_authall {hand command args} {
		foreach _ [getuser $hand XTRA ListAuth] {
			lassign $_ tbot thand
			if {![islinked $tbot]} continue
			putbot $tbot "$command [concat [list $hand $thand] $args]"
		}
	}
	
	# Таймер выполняющий проверку регистрации юзера
	proc timer_authcheck {hand sbot} {
		variable options
		variable afterid
		
		if {![matchattr $hand $options(flag_auth_botnet)]} {return 0}
		set authnick [getuser $hand XTRA AuthBot]
		set ind [lsearch -exact $authnick $sbot]
		if {$ind < 0} {return 0}
		
		if {[info exists afterid(authoff,$hand,$sbot)]} {after cancel $afterid(authoff,$hand,$sbot)}
		set afterid(authoff,$hand,$sbot) [after $options(time_botauth_receive) [list [namespace origin timer_authoff] $hand $sbot]]
		putbot_auth $sbot $hand ccsauthcheck
		
	}
	
	# Таймер снимающий авторизацию при отсутствии подтверждения
	proc timer_authoff {hand sbot} {
		variable afterid
		
		set command "BOTNETAUTH"
		
		delbotauth $hand $sbot
		unset afterid(authoff,$hand,$sbot)
		
		put_log "OFF ($sbot)"
		
	}
	
	# принятие запроса через ботнет на авторизацию или удаление авторизации, поралельно запуск цикла проверки авторизации
	proc bot_ccsaddauth {bot command text} {
		variable options
		
		lassign $text thand shand snick shost snetwork
		set command "BOTNETADDAUTH"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		if {$::network == $snetwork && [onchan $snick]} {addauth $shand $snick $shost}
		addbotauth $shand $bot
		after $options(time_botauth_check) [list [namespace origin timer_authcheck] $shand $bot]
		
		put_log "ON (Bot: $bot)"
		
	}
	
	proc bot_ccsdelauth {bot command text} {
		
		lassign $text thand shand snick shost snetwork hard
		set command "BOTNETDELAUTH"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		if {$::network == $snetwork && $hard} {delauth $shand $snick $shost}
		delbotauth $shand $bot
		
		put_log "OFF (Bot: $bot)"
		
	}
	
	# возвращение запроса о действующей авторизации
	proc bot_ccsauthreceive {bot command text} {
		variable options
		variable afterid
		
		lassign $text thand shand receive
		set command "BOTNETAUTHRECEIVE"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		
		if {[info exists afterid(authoff,$shand,$bot)]} {
			after cancel $afterid(authoff,$shand,$bot)
			if {$receive} {
				set afterid(authoff,$shand,$bot) [after $options(time_botauth_check) [list [namespace origin timer_authcheck] $shand $bot]]
				put_log -level 4 -- "OK ($bot)"
			} else {
				unset afterid(authoff,$shand,$bot)
				delbotauth $shand $bot
				put_log "OFF ($bot)"
			}
		} else {
			delbotauth $shand $bot
			put_log "OFF ($bot)"
		}
		
		return 0
		
	}
	
	# принятие запроса о действующей авторизации
	proc bot_ccsauthcheck {bot command text} {
		variable options
		
		lassign $text thand shand
		set command "BOTNETAUTHCHECK"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		
		if {[matchattr $shand $options(flag_auth)]} {
			putbot_auth $bot $shand ccsauthreceive 1
			put_log -level 4 -- "ON ($bot)"
		} else {
			putbot_auth $bot $shand ccsauthreceive 0
			put_log -level 3 -- "OFF ($bot)"
		}
		return 0
		
	}
	
	# отсылка запроса через ботнет по авторизационному списку выбранному боту
	proc putbot_auth {sbot shand command args} {
		foreach _ [getuser $shand XTRA ListAuth] {
			lassign $_ tbot thand
			if {$tbot != $sbot} continue
			if {![islinked $tbot]} continue
			putbot $tbot "$command [concat [list $shand $thand] $args]"
		}
	}
	
	################################################################################################
	# Процедуры команд ботнета (BotNet).
	
	proc cmd_bots {} {
		upvar out out
		importvars [list snick shand schan command stree]
		variable options
		
		set tree [expr ![string is space $stree]]
		set bots [bots]
		
		if {$tree && $options(botnettree)} {
			put_msg [sprintf bots #101 [expr [llength $bots]+1]]
			
			set date [botlist]
			set lbots [list [list ${::botnet-nick} n/a 1 2]]
			
			foreach _0 $date {
				lassign $_0 bot0 hub0 version0 share0
				set ind1 0
				foreach _1 $lbots {
					lassign $_1 bot1 hub1 l1 r1
					if {$hub0 == $bot1} {
						set ind2 0
						foreach _2 $lbots {
							lassign $_2 bot2 hub2 left2 right2
							if {$left2 >= $r1} {incr left2 2; lset lbots $ind2 2 $left2}
							if {$right2 >= $r1} {incr right2 2; lset lbots $ind2 3 $right2}
							incr ind2
						}
						lappend lbots [list $bot0 $hub0 $r1 [expr $r1+1]]
						break
					}
					incr ind1
				}
			}
			
			set pref {}
			set lastleft 0
			set lastright 0
			set lasthub ""
			set lhublevel {}
			set ind0 0
			set lbots [lsort -integer -index 2 $lbots]
			set lastclose 0
			set r {}
			foreach _0 $lbots {
				lassign $_0 bot0 hub0 l0 r0
				
				if {$lastclose} {lset pref end "    "; set lastclose 0}
				if {$lasthub != $hub0} {
					if {[expr $lastleft+1] == $l0} {
						set find1 0
						for {set ind1 $ind0} {$ind1 < [llength $lbots]} {incr ind1} {
							lassign [lindex $lbots $ind1] bot1 hub1 l1 r1
							if {$r1 < $lastright} {set find1 1; break}
						}
						if {$find1} {lappend pref "   |"} else {lappend pref "    "}
					} else {
						foreach _1 $lhublevel {
							lassign $_1 bot1 level1
							if {$hub0 == $bot1} {set pref [lreplace $pref [expr $level1+1] end]; break}
						}
					}
				}
				set find2 0
				foreach _1 $lbots {
					lassign $_1 bot1 hub1 l1 r1
					if {$bot1 == $hub0} {
						if {[expr $r0+1] == $r1} {lset pref end "   `"; set lastclose 1}
						break
					}
				}
				
				lappend lhublevel [list $bot0 [llength $pref]]
				set lastleft $l0
				set lastright $r0
				set lasthub $hub0
				lappend r "[join $pref ""] - $bot0"
				
				incr ind0
			}
			
			put_msg -speed 3 -list -notice2msg -- $r
			
		} else {
			put_msg [sprintf bots #102 [expr [llength $bots]+1]]
			if {[llength $bots] > 0} {put_msg [sprintf bots #103 [join $bots]]}
		}
		put_log ""
		return 1
		
	}
	
	proc cmd_addbot {} {
		upvar out out
		importvars [list snick shand schan command dnick daddress dbport duport dhost]
		variable options
		
		set dhand [get_hand -quiet 1 -- $dnick]
		if {[check_notavailable {-getting_users -validhandle} -dnick $shand -dhand $dhand]} {return 0}
		
		set address $daddress
		if {$dbport != ""} {append address ":$dbport"}
		if {$duport != ""} {append address "/$duport"}
		
		if {[string is space $dhost] && [onchan $dnick]} {set dhost [get_mask "$dnick![getchanhost $dnick]" $options(addbotmask)]}
		
		if {![addbot $dnick $address]} {put_msg [sprintf bots #107 $dhost]; return 0}
		
		if {![string is space $dhost]} {setuser $dnick HOSTS $dhost}
		put_msg [sprintf bots #106 $dnick $address $dhost]
		put_log "$dnick $address ($dhost)"
		return 1
		
	}
	
	proc cmd_delbot {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		deluser $dhand
		put_msg [sprintf bots #104 [StrNick -nick $dnick -hand $dhand]]
		put_log "$dhand"
		return 1
		
	}
	
	proc cmd_botattr {} {
		upvar out out
		importvars [list snick shand schan command dnick sflag]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		set newflags [botattr $dhand $sflag]
		put_msg [sprintf bots #109 [StrNick -nick $dnick -hand $dhand] $newflags]
		put_log "$dhand: $newflags"
		return 1
		
	}
	
	proc cmd_chaddr {} {
		upvar out out
		importvars [list snick shand schan command dnick saddress sbport suport]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		if {[string is space $sbport]} {
			setuser $dhand BOTADDR $saddress
		} elseif {[string is space $suport]} {
			setuser $dhand BOTADDR $saddress $sbport $sbport
		} else {
			setuser $dhand BOTADDR $saddress $sbport $suport
		}
		put_msg [sprintf bots #108 [StrNick -nick $dnick -hand $dhand] $saddress $sbport $suport]
		put_log "$dhand (address: $saddress, bot port: $sbport, user port: $suport)"
		return 1
		
	}
	
	proc cmd_chbotpass {} {
		upvar out out
		importvars [list snick shand schan command dnick dpass]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle -notisbot} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		if {[string is space $dpass]} {
			set_botpass $dhand ""
			put_msg [sprintf bots #111 [StrNick -nick $dnick -hand $dhand]]
			put_log "CLEAR $dhand"
		} else {
			set_botpass $dhand $dpass
			put_msg [sprintf bots #110 [StrNick -nick $dnick -hand $dhand]]
			put_log "SET $dhand"
		}
		return 1
		
	}
	
	proc cmd_listauth {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-notvalidhandle} -dnick $dnick -dhand $dhand]} {return 0}
		
		set lout [list]
		foreach _ [getuser $dhand XTRA ListAuth] {
			lassign $_ bothand nickhand
			lappend lout "\[bot: [StrNick -hand $bothand], handle: \002$nickhand\002\]"
		}
		
		if {[llength $lout] == 0} {
			put_msg [sprintf bots #113 [StrNick -nick $dnick -hand $dhand]]
		} else {
			put_msg [sprintf bots #112 [StrNick -nick $dnick -hand $dhand] [join $lout "; "]]
		}
		
		return 1
		
	}
	
	proc cmd_addauth {} {
		upvar out out
		importvars [list snick shand schan command dnick dbotnick dhandle]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		set dbothand [get_hand $dbotnick]
		if {[check_notavailable {-notvalidhandle -notisbot} -shand $shand -dnick $dbotnick -dhand $dbothand]} {return 0}
		
		set newListAuth [list]
		set find 0
		foreach _0 [getuser $dhand XTRA ListAuth] {
			lassign $_0 bothand handle
			if {$bothand == $dbothand && $handle == $dhandle} {
				put_msg [sprintf bots #114 [StrNick -nick $dnick -hand $dhand] [StrNick -hand $bothand] $handle]
				return 0
			} elseif {$bothand == $dbothand && $handle != $dhandle} {
				set tbothand $bothand
				set thandle $handle
				set find 1
			} else {
				lappend newListAuth $_0
			}
		}
		foreach _0 [userlist] {
			if {$_0 == $dhand} continue
			foreach _1 [getuser $_0 XTRA ListAuth] {
				lassign $_1 bothand handle
				if {$bothand == $dbothand && $handle == $dhandle} {
					put_msg [sprintf bots #117 [StrNick -hand $bothand] $handle [StrNick -hand $_0]]
					return 0
				}
			}
		}
		if {$find} {
			put_msg [sprintf bots #115 [StrNick -nick $dnick -hand $dhand] [StrNick -hand $tbothand] $thandle [StrNick -nick $dbotnick -hand $dbothand] $dhandle]
		} else {
			put_msg [sprintf bots #116 [StrNick -nick $dnick -hand $dhand] [StrNick -nick $dbotnick -hand $dbothand] $dhandle]
		}
		lappend newListAuth [list $dbothand $dhandle]
		setuser $dhand XTRA ListAuth $newListAuth
		return 1
		
	}
	
	proc cmd_delauth {} {
		upvar out out
		importvars [list snick shand schan command dnick dbotnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		set dbothand [get_hand -quiet 1 -- $dbotnick ]
		if {[check_isnull $dbothand]} {set dbothand $dbotnick}
		
		set newListAuth [list]
		set find 0
		foreach _0 [getuser $dhand XTRA ListAuth] {
			lassign $_0 bothand handle
			if {$bothand == $dbothand} {
				set tbothand $bothand
				set thandle $handle
				set find 1
			} else {
				lappend newListAuth $_0
			}
		}
		if {$find} {
			put_msg [sprintf bots #118 [StrNick -nick $dnick -hand $dhand] [StrNick -hand $tbothand] $thandle]
		} else {
			put_msg [sprintf bots #119 [StrNick -nick $dnick -hand $dhand] [StrNick -nick $dbotnick -hand $dbothand]]
		}
		setuser $dhand XTRA ListAuth $newListAuth
		return 1
		
	}
	
	proc notavailable-notiscmdbot {} {
		upvar 2 out out
		variable options
		importvars [list snick shand schan command]
		upvar dhand dhand dnick dnick
		if {![matchattr $dhand b] || ![matchattr $dhand $options(flag_cmd_bot)]} {
			put_msg [sprintf ccs #202 [StrNick -nick $dnick -hand $dhand]]
			return 1
		}
		return 0
	}
	
	proc notavailable-notbotnetuser {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dbothand dbothand thand thand
		if {![validuser $shand]} {put_log -return 1 -- "(\0034handle not found\003) ($dbothand)"}
		if {![string equal -nocase $thand [get_thand $shand $dbothand]]} {
			put_log -return 1 -- "(\0034not access\003) ($dbothand)"
		}
		return 0
	}
	
	proc notavailable-notvalidpasscmdbot {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dbotpass dbotpass dbothand dbothand
		if {$dbotpass == ""} {
			put_msg [sprintf ccs #203 [StrNick -hand $dbothand]]
			put_log -return 1 -- "(\0034pass cmdbot not set\003) ($dbothand)"
		}
		return 0
	}
	
	proc notavailable-notislinked {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dbothand dbothand
		if {![islinked $dbothand]} {
			put_msg [sprintf ccs #204 [StrNick -hand $dbothand]]
			return 1
		}
		return 0
	}
	
	proc notavailable-notisauth {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dbothand dbothand thand thand
		if {$thand == ""} {
			put_msg [sprintf ccs #205 [StrNick -nick $snick -hand $shand] [StrNick -hand $dbothand]]
			return 1
		}
		return 0
	}
	
	proc main_$_name {} {
		variable options
		variable commands
		
		foreach command [concat $commands(control) $commands(scripts)] {
			if {![cmd_configure $command -use]} continue
			
			if {![string is space $options(prefix_botnet_pub)] && $options(prefix_botnet_pub) != $options(prefix_pub)} {
				# Прописываем бинды управления через ботнет для PUB команд
				foreach _ [get_aliases -type botnet_pub -required_prefix 1 -- $command] {
					bind pub -|- $_ [namespace current]::pub_cmdbot_$command
					eval "
						proc [namespace current]::pub_cmdbot_$command {nick uhost hand chan text} {
							
							set out(nick)  \$nick
							set out(idx)   \"\"
							set out(chan)  \$chan
							set out(bot)   \"\"
							set out(hand)  \$hand
							set out(thand) \"\"
							
							launch_cmdbot \$nick \$hand \$uhost \$chan \$text \"$command\"
							return 0
							
						}
					"
				}
			}
			
			if {![string is space $options(prefix_botnet_msg)] && $options(prefix_botnet_msg) != $options(prefix_msg)} {
				# Прописываем бинды управления через ботнет для MSG команд
				foreach _ [get_aliases -type botnet_msg -required_prefix 1 -- $command] {
					bind msg -|- $_ [namespace current]::msg_cmdbot_$command
					eval "
						proc [namespace current]::msg_cmdbot_$command {nick uhost hand text} {
							
							set out(nick)  \$nick
							set out(idx)   \"\"
							set out(chan)  \"\"
							set out(bot)   \"\"
							set out(hand)  \$hand
							set out(thand) \"\"
							
							launch_cmdbot \$nick \$hand \$uhost \"*\" \$text \"$command\"
							return 0
							
						}
					"
				}
			}
			
			if {![string is space $options(prefix_botnet_dcc)] && $options(prefix_botnet_dcc) != $options(prefix_dcc) && $options(prefix_botnet_dcc) != "."} {
				# Прописываем бинды управления через ботнет для DCC команд
				foreach _ [get_aliases -type botnet_dcc -backslash 1 -required_prefix 1 -- $command] {
					bind filt -|- "$_" [namespace current]::filt_cmdbot_$command
					bind filt -|- "$_ *" [namespace current]::filt_cmdbot_$command
					eval "
						proc [namespace current]::filt_cmdbot_$command {idx text} {
							
							set hand  \[idx2hand \$idx\]
							set nick  \[hand2nick \$hand\]
							set uhost \[getchanhost \$nick\]
							set text  \[join \[lrange \[split \$text\] 1 end\]\]
							set ::lastbind \[join \[lindex \[split \$text\] 0\]\]
							
							set out(nick)  \"\"
							set out(idx)   \$idx
							set out(chan)  \"\"
							set out(bot)   \"\"
							set out(hand)  \$hand
							set out(thand) \"\"
							
							launch_cmdbot \$nick \$hand \$uhost \"*\" \$text \"$command\"
							return \"\"
							
						}
					"
				}
			}
			
		}
		
		bind bot -|- ccscmdbot		[namespace origin bot_ccscmdbot]
		bind bot -|- ccscmdbotend	[namespace origin bot_ccscmdbot]
		
		bind bot -|- ccstext		[namespace origin bot_ccstext]
		bind bot -|- ccstextend		[namespace origin bot_ccstext]
		
		bind bot -|- ccsaddauth		[namespace origin bot_ccsaddauth]
		bind bot -|- ccsdelauth		[namespace origin bot_ccsdelauth]
		bind bot -|- ccsauthreceive	[namespace origin bot_ccsauthreceive]
		bind bot -|- ccsauthcheck	[namespace origin bot_ccsauthcheck]
		
	}
	
}