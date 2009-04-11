##################################################################################################################
## ћодуль управлени€ ботами и ботнетом
##################################################################################################################
# —писок последних изменений:
#	v1.2.3
# - ѕеренесены все процедуры авторизации и управлени€ через ботнет

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"bots"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"ћодуль управлени€ ботнетом."

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# –азрешать вывод ботнета в виде дерева (1 - разрешить, 0 - запретить). Ќе рекомендуетс€ включать дл€ ботов
	# без отключенного на сервере контрол€ за флудом и дл€ больших ботнетов.
	set ccs(botnettree)			1
	
	#############################################################################################################
	# ¬рем€ в миллисекундах, повторени€ проверки ботнет авторизации.
	set ccs(time_botauth_check)		900000
	
	#############################################################################################################
	# ¬рем€ в миллисекундах, в течение которого ждать ответа от бота при проверки авторизации.
	set ccs(time_botauth_receive)	10000
	
	cconfigure bots -add -group "botnet" -flags {%v} -block 5 -usechan 0 -usebotnet 0 \
		-alias {%pref_bots} \
		-regexp {{^(tree)?$} {-> stree}}
	
	cconfigure botattr -add -group "botnet" -flags {mt} -block 2 -usechan 0 \
		-alias {%pref_botattr} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick sflag}}
	
	cconfigure chaddr -add -group "botnet" -flags {mt} -block 2 -usechan 0 \
		-alias {%pref_chaddr} \
		-regexp {{^([^\ ]+)(?:\ +([^\ :]+)(?:\:(\d+)(?:/(\d+))?)?)$} {-> dnick saddress sbport suport}}
	
	cconfigure addbot -add -group "botnet" -flags {mt} -block 3 -usechan 0 \
		-alias {%pref_addbot} \
		-regexp {{^([^\ ]+)(?:\ +([^\ :]+)(?:\:(\d+)(?:/(\d+))?)?)(?:\ +([^\ ]+))?$} {-> dnick daddress dbport duport dhost}}
	
	cconfigure delbot -add -group "botnet" -flags {mt} -block 3 -usechan 0 \
		-alias {%pref_delbot} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cconfigure chbotpass -add -group "botnet" -flags {mt} -block 3 -usechan 0 \
		-alias {%pref_chbotpass} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick dpass}}
	
	cconfigure listauth -add -group "botnet" -flags {mt} -block 3 -usechan 0 \
		-alias {%pref_listauth} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cconfigure addauth -add -group "botnet" -flags {mt} -block 3 -usechan 0 \
		-alias {%pref_addauth} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))(?:\ +([^\ ]+))$} {-> dnick dbotnick dhandle}}
	
	cconfigure delauth -add -group "botnet" -flags {mt} -block 3 -usechan 0 \
		-alias {%pref_delauth} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick dbotnick}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	proc launch_cmdbot {snick shand shost schan onick ochan text command} {
		variable ccs
		global lastbind
		
		if {![on_chan $schan $command]} {return -code ok 0}
		
		set text [string trim $text]
		if {![regexp -- {^([^\ ]+)(?:\ +(.*?))?$} $text -> dbotnick text]} {put_msg [sprintf ccs #201 $lastbind]; return 0}
		
		if {[string equal -nocase $dbotnick "all"] || [string equal -nocase $dbotnick "*"]} {
			launch_cmd $snick $shand $shost $schan $onick $ochan [list] $text $command
			set lcmdbots [get_lcmdbots]
		} else {
			set dbothand [get_hand $dbotnick]
			if {[check_notavailable {-notisbot -notiscmdbot -notvalidhandle} -dnick $dbotnick -dhand $dbothand]} {return 0}
			set lcmdbots [list $dbothand]
		}
		
		foreach dbothand $lcmdbots {
			if {[check_notavailable {-notvalidpasscmdbot -notislinked -notisauth} \
				-snick $snick -shand $shand -dbotnick $dbothand -dbothand $dbothand +dbotpass dbotpass +thand thand]} continue
			send_cmdbot $dbothand $dbotpass $thand $snick $shand $shost $schan $onick $ochan $text $command
		}
		
	}
	
	# ‘ункци€ получени€ списка ботов дл€ выполнени€ команд
	proc get_lcmdbots {} {
		variable ccs
		set lcmdbots [list]
		foreach _ [userlist b] {if {[matchattr $_ $ccs(flag_cmd_bot)]} {lappend lcmdbots $_}}
		return $lcmdbots
	}
	
	proc send_cmdbot {dbothand dbotpass thand snick shand shost schan onick ochan text command} {
		
		set lencode 3
		set lensend 300
		
		set code ""
		for {set x 0} {$x < $lencode} {incr x} {append code [expr int(rand()*10)]}
		
		set lenhead1 [string length [list ok2602 $snick $shand $shost $schan $onick $ochan $command $thand $code 1]]
		set lentext [string length $text]
		set lenencrtext [match_lenencr [expr $lenhead1+$lentext+1]]
		
		if {$lenencrtext > $lensend} {
			
			set lenrem1 [expr [match_lendencr $lensend]-$lenhead1-1]
			
			putbot $dbothand "ccscmdbot [encrypt $dbotpass [list ok2602 $shand $code 0 $snick $thand \
				$shost $schan $onick $ochan $command [string range $text 0 [expr $lenrem1-1]]]]"
			set lenhead2 [string length [list ok2602 $code 1]]
			set lenrem2 [expr [match_lendencr $lensend]-$lenhead2-1]
			
			set x $lenrem1
			while {$x < $lentext} {
				if {[expr $x+$lenrem2+1] >= $lentext} {set end 1} else {set end 0}
				putbot $dbothand "ccscmdbotadd [encrypt $dbotpass [list ok2602 $code $end \
					[string range $text $x [expr $x+$lenrem2]]]]"
				set x [expr $x+$lenrem2+1]
			}
		} else {
			putbot $dbothand "ccscmdbot [encrypt $dbotpass [list ok2602 $shand $code 1 $snick $thand \
				$shost $schan $onick $ochan $command $text]]"
		}
		
	}
	
	proc bot_ccscmdbot {bot command text} {
		variable turn
		
		if {[check_notavailable {-notvalidpasscmdbot} -dbotnick $bot -dbothand $bot -quiet 1 +dbotpass dbotpass]} {return 0}
		set ldecrypt [decrypt $dbotpass $text]
		
		if {$command == "ccscmdbot"} {
			
			foreach {ok thand code end snick shand shost schan onick ochan command text} $ldecrypt break
			
			if {$ok != "ok2602"} {put_log "(\0034not decrypt\003) ($bot)"; return 0}
			if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
			
			if {!$end} {
				set turn($code,bot) $bot
				set turn($code,thand) $thand
				set turn($code,snick) $snick
				set turn($code,shand) $shand
				set turn($code,shost) $shost
				set turn($code,schan) $schan
				set turn($code,onick) $onick
				set turn($code,ochan) $ochan
				set turn($code,command) $command
				set turn($code,text) $text
			} else {
				launch_cmd $snick $shand $shost $schan $onick $ochan [list $bot $shand $thand] $text $command
			}
			
		} elseif {$command == "ccscmdbotadd"} {
			
			foreach {ok code end text} $ldecrypt break
			if {$ok != "ok2602"} {put_log "(\0034not decrypt\003) ($bot)"; return 0}
			
			if {![info exists turn($code,bot)] || $turn($code,bot) != $bot} {put_log "(\0034turn not start\003) ($bot)"; return 0}
			append turn($code,text) $text
			
			if {$end} {
				set bot $turn($code,bot)
				set thand $turn($code,thand)
				set snick $turn($code,snick)
				set shand $turn($code,shand)
				set shost $turn($code,shost)
				set schan $turn($code,schan)
				set onick $turn($code,onick)
				set ochan $turn($code,ochan)
				set command $turn($code,command)
				set text $turn($code,text)
				launch_cmd $snick $shand $shost $schan $onick $ochan [list $bot $shand $thand] $text $command
				unset turn($code,bot) turn($code,thand) turn($code,snick) turn($code,shand) \
					turn($code,shost) turn($code,schan) turn($code,onick) turn($code,ochan) \
					turn($code,command) turn($code,text)
			}
			
		}
		
		return 0
		
	}
	
	proc bot_ccstext {bot command text} {
		variable turn
		
		if {[check_notavailable {-notvalidpasscmdbot} -dbotnick $bot -dbothand $bot -quiet 1 +dbotpass dbotpass]} {return 0}
		set ldecrypt [decrypt $dbotpass $text]
		
		if {$command == "ccstext"} {
			
			foreach {ok thand code end shand onick ochan quiet text} $ldecrypt break
			if {$ok != "ok2103"} {put_log "(\0034not decrypt\003) ($bot)"; return 0}
			if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
			
			if {!$end} {
				set turn($code,bot) $bot
				set turn($code,onick) $onick
				set turn($code,ochan) $ochan
				set turn($code,quiet) $quiet
				set turn($code,text) $text
			} else {
				put_msg "$bot :: $text" -speed 3
			}
			
		} elseif {$command == "ccstextadd"} {
			
			foreach {ok code end text} $ldecrypt break
			if {$ok != "ok2103"} {put_log "(\0034not decrypt\003) ($bot)"; return 0}
			
			if {![info exists turn($code,bot)] || $turn($code,bot) != $bot} {put_log "(\0034turn not start\003) ($bot)"; return 0}
			append turn($code,text) $text
			
			if {$end} {
				set onick $turn($code,onick)
				set ochan $turn($code,ochan)
				set quiet $turn($code,quiet)
				set text $turn($code,text)
				put_msg "$bot :: $text" -speed 3
				unset turn($code,bot) turn($code,onick) turn($code,ochan) turn($code,quiet) turn($code,text)
			}
			
		}
		return 0
		
	}
	
	# ѕроцедура ботнет авторизации по хендлу
	proc addbotauth {shand sbothand} {
		variable ccs
		
		set authnick [getuser $shand XTRA AuthBot]
		if {[lsearch -exact $authnick $sbothand] >= 0} {return 0}
		lappend authnick $sbothand
		setuser $shand XTRA AuthBot $authnick
		chattr $shand +$ccs(flag_auth_botnet)
		return 1
		
	}
	
	# ѕроцедура сн€ти€ ботнет авторизации по хендлу
	proc delbotauth {shand sbothand} {
		variable ccs
		
		set authnick [getuser $shand XTRA AuthBot]
		if {[set ind [lsearch -exact $authnick $sbothand]] < 0} {return 0}
		set authnick [lreplace $authnick $ind $ind]
		setuser $shand XTRA AuthBot $authnick
		if {[llength $authnick] == 0} {chattr $shand -$ccs(flag_auth_botnet)}
		return 1
		
	}
	
	# отсылка запроса через ботнет по авторизационному списку
	proc putbot_authall {shand command args} {
		set lauth [getuser $shand XTRA ListAuth]
		foreach _ $lauth {
			foreach {tbot thand} $_ break
			if {![islinked $tbot]} continue
			putbot $tbot "$command [concat [list $shand $thand] $args]"
		}
	}
	
	# “аймер выполн€ющий проверку регистрации юзера
	proc timer_authcheck {shand sbot} {
		variable ccs
		variable afterid
		
		if {![matchattr $shand $ccs(flag_auth_botnet)]} {return 0}
		set authnick [getuser $shand XTRA AuthBot]
		set ind [lsearch -exact $authnick $sbot]
		if {$ind < 0} {return 0}
		
		if {[info exists afterid(authoff,$shand,$sbot)]} {after cancel $afterid(authoff,$shand,$sbot)}
		set afterid(authoff,$shand,$sbot) [after $ccs(time_botauth_receive) [list [namespace origin timer_authoff] $shand $sbot]]
		putbot_auth $sbot $shand ccsauthcheck
		
	}
	
	# “аймер снимающий авторизацию при отсутствии подтверждени€
	proc timer_authoff {shand sbot} {
		variable ccs
		variable afterid
		
		set command "BOTNETAUTH"
		
		delbotauth $shand $sbot
		unset afterid(authoff,$shand,$sbot)
		
		put_log "OFF ($sbot)"
		
	}
	
	# прин€тие запроса через ботнет на авторизацию или удаление авторизации, поралельно запуск цикла проверки авторизации
	proc bot_ccsaddauth {bot command text} {
		variable ccs
		global network
		
		foreach {thand shand snick shost snetwork} $text break
		set command "BOTNETADDAUTH"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		if {$network == $snetwork && [onchan $snick]} {addauth $shand $snick $shost}
		addbotauth $shand $bot
		after $ccs(time_botauth_check) [list [namespace origin timer_authcheck] $shand $bot]
		
		put_log "ON (Bot: $bot)"
		
	}
	
	proc bot_ccsdelauth {bot command text} {
		variable ccs
		global network
		
		foreach {thand shand snick shost snetwork hard} $text break
		set command "BOTNETDELAUTH"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		if {$network == $snetwork && $hard} {delauth $shand $snick $shost}
		delbotauth $shand $bot
		
		put_log "OFF (Bot: $bot)"
		
	}
	
	# возвращение запроса о действующей авторизации
	proc bot_ccsauthreceive {bot command text} {
		variable ccs
		variable afterid
		
		foreach {thand shand receive} $text break
		set command "BOTNETAUTHRECEIVE"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		
		if {[info exists afterid(authoff,$shand,$bot)]} {
			after cancel $afterid(authoff,$shand,$bot)
			if {$receive} {
				set afterid(authoff,$shand,$bot) [after $ccs(time_botauth_check) [list [namespace origin timer_authcheck] $shand $bot]]
				put_log "OK ($bot)" -level 4
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
	
	# прин€тие запроса о действующей авторизации
	proc bot_ccsauthcheck {bot command text} {
		variable ccs
		
		foreach {thand shand} $text break
		set command "BOTNETAUTHCHECK"
		
		if {[check_notavailable {-notbotnetuser} -shand $shand -thand $thand -dbothand $bot]} {return 0}
		
		if {[matchattr $shand $ccs(flag_auth)]} {
			putbot_auth $bot $shand ccsauthreceive 1; put_log "ON ($bot)" -level 4
		} else {
			putbot_auth $bot $shand ccsauthreceive 0; put_log "OFF ($bot)" -level 3
		}
		return 0
		
	}
	
	# отсылка запроса через ботнет по авторизационному списку выбранному боту
	proc putbot_auth {sbot shand command args} {
		set lauth [getuser $shand XTRA ListAuth]
		foreach _ $lauth {
			foreach {tbot thand} $_ break
			if {$tbot != $sbot} continue
			if {![islinked $tbot]} continue
			putbot $tbot "$command [concat [list $shand $thand] $args]"
		}
	}
	
	proc send_ccstext {dbothand dbotpass thand shand onick ochan quiet text} {
		
		set lencode 3
		set lensend 300
		
		set code ""
		for {set x 0} {$x < $lencode} {incr x} {append code [expr int(rand()*10)]}
		
		set lenhead1 [string length [list ok2103 $shand $thand $onick $ochan $quiet $code 1]]
		set lentext [string length $text]
		set lenencrtext [match_lenencr [expr $lenhead1+$lentext+1]]
		
		if {$lenencrtext > $lensend} {
			
			set lenrem1 [expr [match_lendencr $lensend]-$lenhead1-1]
			
			putbot $dbothand "ccstext [encrypt $dbotpass [list ok2103 $shand $code 0 $thand $onick \
				$ochan $quiet [string range $text 0 [expr $lenrem1-1]]]]"
			set lenhead2 [string length [list ok2103 $code 1]]
			set lenrem2 [expr [match_lendencr $lensend]-$lenhead2-1]
			
			set x $lenrem1
			while {$x < $lentext} {
				if {[expr $x+$lenrem2+1] >= $lentext} {set end 1} else {set end 0}
				putbot $dbothand "ccstextadd [encrypt $dbotpass [list ok2103 $code $end \
					[string range $text $x [expr $x+$lenrem2]]]]"
				set x [expr $x+$lenrem2+1]
			}
		} else {
			putbot $dbothand "ccstext [encrypt $dbotpass [list ok2103 $shand $code 1 $thand $onick \
				$ochan $quiet $text]]"
		}
		
	}
	
	proc match_lenencr {x} {
		return [expr (($x-1)/8+1)*12]
	}
	
	proc match_lendencr {x} {
		return [expr ($x/12-1)*8+1]
	}
	
	#############################################################################################################
	# ѕроцедуры команд ботнета (BotNet).
	
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
		
		if {[string is space $dhost] && [onchan $dnick]} {set dhost [get_mask "$dnick![getchanhost $dnick]" $ccs(addusermask)]}
		
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
	
	proc notavailable-notiscmdbot {} {
		variable ccs
		importvars [list snick shand schan onick ochan obot command]
		upvar dhand dhand dnick dnick
		if {![matchattr $dhand b] || ![matchattr $dhand $ccs(flag_cmd_bot)]} {
			put_msg [sprintf ccs #202 [get_nick $dnick $dhand]]; return 1
		}
		return 0
	}
	
	proc notavailable-notbotnetuser {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dbothand dbothand thand thand
		if {![validuser $shand]} {put_log "(\0034handle not found\003) ($dbothand)"; return 1}
		set find 0
		foreach _ [getuser $shand XTRA ListAuth] {
			foreach {pbot phand} $_ break
			if {[string equal -nocase $dbothand $pbot] && [string equal -nocase $thand $phand]} {
				set find 1; break
			}
		}
		if {!$find} {put_log "(\0034not access\003) ($dbothand)"; return 1}
		return 0
	}
	
	proc notavailable-notvalidpasscmdbot {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dbotpass dbotpass dbothand dbothand dbotnick dbotnick quiet quiet
		if {![info exists quiet]} {set quiet 0}
		if {[set dbotpass [getuser $dbothand XTRA PassCmdBot]] == ""} {
			if {!$quiet} {put_msg [sprintf ccs #203 [get_nick $dbotnick $dbothand]]}
			put_log "(\0034pass cmdbot not set\003) ($dbothand)"
			return 1
		}
		return 0
	}
	
	proc notavailable-notislinked {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dbothand dbothand dbotnick dbotnick
		if {![islinked $dbothand]} {
			put_msg [sprintf ccs #204 [get_nick $dbotnick $dbothand]]; return 1
		}
		return 0
	}
	
	proc notavailable-notisauth {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dbothand dbothand dbotnick dbotnick thand thand
		set find 0
		foreach _ [getuser $shand XTRA ListAuth] {
			foreach {pbot phand} $_ break
			if {[string equal -nocase $pbot $dbothand]} {set find 1; set thand $phand; break}
		}
		if {!$find} {
			set thand ""
			put_msg [sprintf ccs #205 [get_nick $snick $shand] [get_nick $dbotnick $dbothand]]
			return 1
		}
		return 0
	}
	
	proc binds_up_bots {} {
		variable ccs
		upvar curr curr
		
		foreach command [concat $ccs(commands) $ccs(scr_commands)] {
			if {![use_command $command]} continue
			
			foreach _ $ccs(alias,$command) {
				
				if {![string is space $ccs(pref_pubcmd)] && $ccs(pref_pubcmd) != $ccs(pref_pub) && [string first %pref_ $_] >= 0} {
					# ѕрописываем бинды управлени€ через ботнет дл€ PUB команд
					incr curr
					bind pub -|- [string map [list %pref_ $ccs(pref_pubcmd)] $_] [namespace current]::pub_cmdbot_$command
					eval "
						proc [namespace current]::pub_cmdbot_$command {nick uhost hand chan text} {
							launch_cmdbot \$nick \$hand \$uhost \$chan \$nick \$chan \$text \"$command\"
							return 0
						}
					"
				}
				
				if {![string is space $ccs(pref_msgcmd)] && $ccs(pref_msgcmd) != $ccs(pref_msg)} {
					# ѕрописываем бинды управлени€ через ботнет дл€ MSG команд
					incr curr
					bind msg -|- [string map [list %pref_ $ccs(pref_msgcmd)] $_] [namespace current]::msg_cmdbot_$command
					eval "
						proc [namespace current]::msg_cmdbot_$command {nick uhost hand text} {
							launch_cmdbot \$nick \$hand \$uhost \"*\" \$nick \$nick \$text \"$command\"
							return 0
						}
					"
				}
				
				if {$ccs(pref_dcccmd) != "." && $ccs(pref_dcccmd) != $ccs(pref_dcc)} {
					# ѕрописываем бинды управлени€ через ботнет дл€ DCC команд
					incr curr 2
					bind filt -|- "[string map [list %pref_ $ccs(pref_dcccmd)] $_]" [namespace current]::filt_cmdbot_$command
					bind filt -|- "[string map [list %pref_ $ccs(pref_dcccmd)] $_] *" [namespace current]::filt_cmdbot_$command
					eval "
						proc [namespace current]::filt_cmdbot_$command {idx text} {
							set hand \[idx2hand \$idx\]
							set nick \[hand2nick \$hand\]
							set uhost \[getchanhost \$nick\]
							set text \[join \[lrange \[split \$text\] 1 end\]\]
							launch_cmdbot \$nick \$hand \$uhost \"*\" \$idx \$idx \$text \"$command\"
							return \"\"
						}
					"
				}
				
			}
			
		}
		
		incr curr 8
		bind bot -|- ccscmdbot		[namespace origin bot_ccscmdbot]
		bind bot -|- ccscmdbotadd	[namespace origin bot_ccscmdbot]
		
		bind bot -|- ccstext		[namespace origin bot_ccstext]
		bind bot -|- ccstextadd		[namespace origin bot_ccstext]
		
		bind bot -|- ccsaddauth		[namespace origin bot_ccsaddauth]
		bind bot -|- ccsdelauth		[namespace origin bot_ccsdelauth]
		bind bot -|- ccsauthreceive	[namespace origin bot_ccsauthreceive]
		bind bot -|- ccsauthcheck	[namespace origin bot_ccsauthcheck]
		
	}
	
}