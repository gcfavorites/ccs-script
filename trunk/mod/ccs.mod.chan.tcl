####################################################################################################
## ћодуль с канальными командами управлени€
####################################################################################################
# —писок последних изменений:
#	v1.4.2
# - ƒобавлена возможность назначени€ флагов и параметров списком в одной строке
#	v1.4.1
# - ƒобавлена возможность просмотра флагов/параметров канала через команду !chaninfo по всем каналам
#	v1.2.7
# - ƒл€ команды !channels добавлен вывод секретных каналов если у запрашиваемого достаточно прав.
# - «аменена функци€ lsearch_equal

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{chan}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.2" "02-Nov-2009" \
	"ћодуль управлени€ списком каналов и настроек канальных флагов."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# ѕуть и маска файлов сохранени€ настроек каналов. %s в имени будет заменен на им€ настроек.
	set options(chansetfile)		"$options(dir_data)/ccs.chanset.%s.dat"
	
	################################################################################################
	# ѕуть и маска файлов сохранени€ шаблонов настроек каналов. %s в имени будет заменен на им€
	# шаблона.
	set options(chantemplatefile)	"$options(dir_data)/ccs.chantemplate.%s.dat"
	
	################################################################################################
	# —охран€ть старые файлы настроек в bak директории (1 - да, 0 - нет)
	set options(bakchanset)			1
	
	cmd_configure channels -control -group "chan" -flags {o|o} -block 5 -use_auth 0 -use_chan 0 \
		-alias {%pref_channels} \
		-regexp {{^$} {}}
	
	cmd_configure chanadd -control -group "chan" -flags {n} -block 3 -use_chan 0 \
		-alias {%pref_chanadd %pref_addchan} \
		-regexp {{^([^\ ]+)$} {-> dchan}}
	
	cmd_configure chandel -control -group "chan" -flags {n} -block 3 -use_chan 0 \
		-alias {%pref_chandel %pref_delchan} \
		-regexp {{^([^\ ]+)$} {-> dchan}}
	
	cmd_configure rejoin -control -group "chan" -flags {m|m} -block 3 \
		-alias {%pref_rejoin} \
		-regexp {{^$} {}}
	
	cmd_configure chanset -control -group "chan" -flags {n|n} -block 1 -use_chan 2 \
		-alias {%pref_set %pref_chanset} \
		-regexp {{^(.*?)?$} {-> sargs}}
		#-regexp {{^([^\ ]+)(?:\ +(.*?))?$} {-> smode sargs}}
	
	cmd_configure chaninfo -control -group "chan" -flags {n|n} -block 5 -use_chan 2 \
		-alias {%pref_chaninfo} \
		-regexp {{^([^\ ]+)?$} {-> smode}}
	
	cmd_configure chansave -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_chansave} \
		-regexp {{^([\w\.\-]{1,100})(?:\s+([\w\.\-]{1,100}))?$} {-> sfile tname}}
	
	cmd_configure chanload -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_chanload} \
		-regexp {{^([\w\.\-]{1,100})(?:\s+([\w\.\-]{1,100}))?$} {-> sfile tname}}
	
	cmd_configure chancopy -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_chancopy} \
		-regexp {{^([^\ ]+)(?:\s+([\w\.\-]{1,100}))?$} {-> dchan tname}}
	
	cmd_configure templateadd -control -group "chan" -flags {n|n} -block 5 -use_chan 0 \
		-alias {%pref_templateadd} \
		-regexp {{^([^\ ]+)\s+(.+?)$} {-> tname param}}
	
	cmd_configure templatedel -control -group "chan" -flags {n|n} -block 5 -use_chan 0 \
		-alias {%pref_templatedel} \
		-regexp {{^([^\ ]+)\s+(.+?)$} {-> tname param}}
	
	cmd_configure templatelist -control -group "chan" -flags {n|n} -block 5 -use_chan 0 \
		-alias {%pref_templatelist} \
		-regexp {{^([\w\.\-]{1,100})$} {-> tname}}
	
	################################################################################################
	# ѕроцедуры команд управлени€ каналами (CHANNEL).
	
	#   Input  : chan
	#   Output : {index type name value ref_value}
	proc channel_info {chan} {
		
		set r {}
		set ind 0
		foreach _ [channel info $chan] {
			incr ind
			
			set type 0
			set value $_
			switch -exact $ind {
				1 {set name "chanmode"}
				2 {set name "idle-kick"}
				3 {set name "stopnethack-mode"}
				4 {set name "revenge-mode"}
				5 {set name "need-op"}
				6 {set name "need-invite"}
				7 {set name "need-key"}
				8 {set name "need-unban"}
				9 {set name "need-limit"}
				10 {set name "flood-chan"}
				11 {set name "flood-ctcp"}
				12 {set name "flood-join"}
				13 {set name "flood-kick"}
				14 {set name "flood-deop"}
				15 {set name "flood-nick"}
				16 {set name "aop-delay"}
				17 {set name "ban-time"}
				18 {set name "exempt-time"}
				19 {set name "invite-time"}
				default {
					
					if {[llength $_] == 1} {
						set type 1
						set name [string range $_ 1 end]
						if {[string index $_ 0] == "+"} {
							set value 1
						} else {
							set value 0
						}
					} elseif {[llength $_] == 2} {
						set type 2
						set name [lindex $_ 0]
						set value [lindex $_ 1]
					}
					
				}
			}
			
			lappend r [list $ind $type $name $value $_]
			
		}
		
		return $r
		
	}
	
	proc cmd_templatelist {snick shand schan command tname} {
		upvar out out
		variable options
		
		set filename [string map [list %s $tname] $options(chantemplatefile)]
		
		if {![file exists $filename]} {put_msg -return 0 -- [sprintf chan #120 $tname]}
		
		IfError {
			set udef [LoadFile $filename]
		} errMsg {
			put_msg [sprintf ccs #213 $errMsg]
			return -code return 0
		}
		
		set udef [lsort $udef]
		
		put_msg [sprintf chan #130 $tname [join $udef ", "]]
		put_log "name: \"$tname\"; file: \"$filename\""
		return 1
		
	}
	
	proc cmd_templateadd {snick shand schan command tname param} {
		upvar out out
		variable options
		
		set filename [string map [list %s $tname] $options(chantemplatefile)]
		
		set udef         [list];         # список параметров наход€щихс€ в файле
		set user_udef    [split $param]; # пользовательский список параметров
		set new_udef     [list];         # список параметров отсутствующих в шаблоне
		set old_udef     [list];         # список параметров присутствующих в шаблоне
		set error_udef   [list];         # список ошибочных параметров
		set correct_udef [list];         # список корректных параметров
		
		if {[file exists $filename]} {
			IfError {
				set udef [LoadFile $filename]
			} errMsg {
				put_msg [sprintf ccs #213 $errMsg]
				return -code return 0
			}
		}
		
		# формируем список корректных флагов
		set chans [channels]
		if {[llength $chans] == 0} {put_log -return 0 -- "no channels"}
		foreach _ [channel_info [lindex $chans 0]] {
			lassign $_ index type name value ref_value
			lappend correct_udef $name
		}
		
		set user_udef [lsort -unique $user_udef]
		foreach _ $user_udef {
			
			if {[in $udef $_]} {
				lappend old_udef $_
			} elseif {[ni $correct_udef $_]} {
				lappend error_udef $_
			} else {
				lappend new_udef $_
				lappend udef $_
			}
			
		}
		
		set udef       [lsort $udef]
		set new_udef   [lsort $new_udef]
		set old_udef   [lsort $old_udef]
		set error_udef [lsort $error_udef]
		
		if {[llength $new_udef] == 0} {
			set lout [list]
			if {[llength $error_udef] > 0} {lappend lout [sprintf chan #126 [join $error_udef ", "]]}
			if {[llength $old_udef] > 0}   {lappend lout [sprintf chan #127 [join $old_udef ", "]]}
			put_msg -return 0 -- [sprintf chan #121 $tname [join $lout "; "]]
		}
		
		IfError {
			SaveFile $filename $udef
		} errMsg {
			put_msg [sprintf ccs #192 $errMsg]
			return -code return 0
		}
		
		set lout [list]
		if {[llength $new_udef] > 0}   {lappend lout [sprintf chan #125 [join $new_udef ", "]]}
		if {[llength $error_udef] > 0} {lappend lout [sprintf chan #126 [join $error_udef ", "]]}
		if {[llength $old_udef] > 0}   {lappend lout [sprintf chan #127 [join $old_udef ", "]]}
		
		put_msg [sprintf chan #123 $tname [join $lout "; "]]
		put_msg [sprintf chan #131 [join $udef ", "]]
		put_log "name: \"$tname\"; file: \"$filename\"; new udef: \"[join $new_udef ", "]\"; old udef: \"[join $old_udef ", "]\"; error udef: \"[join $error_udef ", "]\""
		return 1
		
	}
	
	proc cmd_templatedel {snick shand schan command tname param} {
		upvar out out
		variable options
		
		set filename [string map [list %s $tname] $options(chantemplatefile)]
		
		if {![file exists $filename]} {put_msg -return 0 -- [sprintf chan #120 $tname]}
		
		IfError {
			set udef [LoadFile $filename]
		} errMsg {
			put_msg [sprintf ccs #213 $errMsg]
			return -code return 0
		}
		
		set user_udef [split $param]; # пользовательский список параметров
		set del_udef  [list];         # список параметров на удаление
		set no_udef   [list];         # список параметров отсутствующих в шаблоне
		
		set user_udef [lsort -unique $user_udef]
		foreach _ $user_udef {
			
			if {[in $udef $_]} {
				lappend del_udef $_
				set udef [lsearch -all -inline -not $udef $_]
			} else {
				lappend no_udef $_
			}
			
		}
		
		set udef     [lsort $udef]
		set del_udef [lsort $del_udef]
		set no_udef  [lsort $no_udef]
		
		if {[llength $del_udef] == 0} {
			set lout [list]
			if {[llength $no_udef] > 0} {lappend lout [sprintf chan #129 [join $no_udef ", "]]}
			put_msg [sprintf chan #122 $tname [join $lout "; "]]
			return 0
		}
		
		IfError {
			SaveFile $filename $udef
		} errMsg {
			put_msg [sprintf ccs #192 $errMsg]
			return -code return 0
		}
		
		set lout [list]
		if {[llength $del_udef] > 0} {lappend lout [sprintf chan #128 [join $del_udef ", "]]}
		if {[llength $no_udef] > 0}  {lappend lout [sprintf chan #129 [join $no_udef ", "]]}
		put_msg [sprintf chan #124 $tname [join $lout "; "]]
		put_msg [sprintf chan #131 [join $udef ", "]]
		put_log "name: \"$tname\"; file: \"$filename\"; del udef: \"[join $del_udef ", "]\"; no udef: \"[join $no_udef ", "]\""
		return 1
		
	}
	
	proc cmd_chansave {snick shand schan command sfile tname} {
		upvar out out
		variable options
		
		set filename [string map [list %s $sfile] $options(chansetfile)]
		
		if {![string is space $tname]} {
			
			set tfilename [string map [list %s $tname] $options(chantemplatefile)]
			if {![file exists $tfilename]} {put_msg [sprintf chan #120 $tname]; return 0}
			if {[catch {
				set tdata [LoadFile $tfilename]
			} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
			set usetemplate 1
			
		} else {set usetemplate 0}
		
		set data [list]
		set lok [list]
		
		foreach _ [channel_info $schan] {
			lassign $_ index type name value ref_value
			if {$usetemplate && [ni $tdata $name]} continue
			if {$type == 1} {
				lappend data [list $name 1 $ref_value]
			} else {
				lappend data [list $name 0 $value]
			}
			lappend lok $name
		}
		
		if {[catch {
			SaveFile -backup $options(bakchanset) -- $filename $data
		} errMsg]} {put_msg [sprintf ccs #192 $errMsg]; return 0}
		if {$usetemplate} {
			put_msg [sprintf chan #112 $schan $sfile $tname]
		} else {
			put_msg [sprintf chan #111 $schan $sfile]
		}
		put_msg [sprintf chan #131 [join $lok ", "]]
		put_log ""
		return 1
		
	}
	
	proc cmd_chanload {} {
		upvar out out
		variable options
		importvars [list snick shand schan command sfile tname]
		
		set filename [string map [list %s $sfile] $options(chansetfile)]
		if {![file exists $filename]} {put_msg [sprintf chan #119 $sfile]; return 0}
		if {[catch {
			set data [LoadFile $filename]
		} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
		
		if {![string is space $tname]} {
			
			set tfilename [string map [list %s $tname] $options(chantemplatefile)]
			if {![file exists $tfilename]} {put_msg [sprintf chan #120 $tname]; return 0}
			if {[catch {
				set tdata [LoadFile $tfilename]
			} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
			set usetemplate 1
			
		} else {set usetemplate 0}
		
		set lerr [list]
		set lok [list]
		foreach _ $data {
			if {$usetemplate && [ni $tdata [lindex $_ 0]]} continue
			if {[catch {
				if {[lindex $_ 1]} {
					channel set $schan [lindex $_ 2]
				} else {
					channel set $schan [lindex $_ 0] [lindex $_ 2]
				}
				lappend lok [lindex $_ 0]
			}]} {lappend lerr [lindex $_ 0]}
		}
		if {$usetemplate} {
			if {[llength $lerr] > 0} {
				put_msg [sprintf chan #116 $schan $sfile $tname [join $lerr ", "]]
			} else {
				put_msg [sprintf chan #114 $schan $sfile $tname]
			}
		} else {
			if {[llength $lerr] > 0} {
				put_msg [sprintf chan #115 $schan $sfile [join $lerr ", "]]
			} else {
				put_msg [sprintf chan #113 $schan $sfile]
			}
		}
		put_msg [sprintf chan #131 [join $lok ", "]]
		put_log ""
		return 1
		
	}
	
	proc cmd_chancopy {} {
		upvar out out
		variable options
		importvars [list snick shand schan command dchan tname]
		
		if {[check_notavailable {-notvalidchan} -dchan $dchan]} {return 0}
		if {![check_matchattr $shand $dchan [cmd_configure $command -flags]]} {put_msg -return 0 -- [sprintf ccs #118]}
		
		set usetemplate 0
		if {![string is space $tname]} {
			set tfilename [string map [list %s $tname] $options(chantemplatefile)]
			if {![file exists $tfilename]} {put_msg -return 0 -- [sprintf chan #120 $tname]}
			if {[catch {
				set tdata [LoadFile $tfilename]
			} errMsg]} {put_msg -return 0 -- [sprintf ccs #213 $errMsg]}
			set usetemplate 1
		}
		
		set lok [list]
		foreach _ [channel_info $schan] {
			lassign $_ index type name value ref_value
			if {$usetemplate && [ni $tdata $name]} continue
			lappend lok $name
			if {$type == 1} {
				channel set $dchan $ref_value
			} else {
				channel set $dchan $name $value
			}
		}
		
		if {$usetemplate} {
			put_msg [sprintf chan #118 $schan $dchan $tname]
		} else {
			put_msg [sprintf chan #117 $schan $dchan]
		}
		put_msg [sprintf chan #131 [join $lok ", "]]
		put_log "$dchan"
		return 1
		
	}
	
	proc cmd_channels {} {
		upvar out out
		variable options
		importvars [list snick shand schan command]
		
		set permission_secret_chan [check_matchattr $shand $schan $options(permission_secret_chan)]
		set chans [list]
		foreach _ [channels] {
			if {[botonchan $_]} {set people [llength [chanlist $_]]} else {set people "b"}
			set secret [channel get $_ secret]
			set channame [chandname2name $_]
			if {[channel get $_ inactive]} {set people "\002inactive\002"}
			set prefix ""
			if {[botisvoice $_]} {set prefix "+"}
			if {[botishalfop $_]} {set prefix "%"}
			if {[botisop $_]} {set prefix "@"}
			if {!$secret || $permission_secret_chan} {lappend chans "[expr {$secret ? "(s)" : ""}]${prefix}$_[expr {$channame != $_ && $channame != "" ? " ($channame)" : ""}] ($people)"}
		}
		
		put_msg [sprintf chan #101 [join $chans ", "]]
		put_log ""
		return 1
		
	}
	
	proc cmd_chanadd {} {
		upvar out out
		importvars [list snick shand schan command dchan]
		
		if {[check_notavailable {-validchan} -dchan $dchan]} {return 0}
		
		channel add $dchan
		put_msg [sprintf chan #103 $dchan]
		put_log "$dchan"
		return 1
		
	}
	
	proc cmd_chandel {} {
		upvar out out
		importvars [list snick shand schan command dchan]
		
		if {[check_notavailable {-notvalidchan -isstaticchan} -dchan $dchan]} {return 0}
		
		channel remove $dchan
		put_msg [sprintf chan #102 $dchan]
		put_log "$dchan"
		return 1
		
	}
	
	proc cmd_rejoin {} {
		upvar out out
		importvars [list snick shand schan command]
		
		channel set $schan +inactive
		channel set $schan -inactive
		put_log ""
		return 1
		
	}
	
	################################################################################################
	# ѕроцедуры команд управлени€ настройками канала (CHANSET).
	
	proc cmd_chanset {} {
		upvar out out
		importvars [list snick shand schan command sargs]
		
		if {[catch {
			set largs [split_args $sargs]
		} errMsg]} {
			put_msg [sprintf ccs #105]
			return
		}
		
		if {[check_isnull $schan]} {
			set chans [get_channels -hand $shand -flags [cmd_configure $command -flags]]
			if {[llength $chans] == 0} {put_log -return 0 -- "no channels"}
		} else {
			set chans [list $schan]
		}
		
		set list_flags {}
		set list_setting {}
		
		foreach _ [channel_info [lindex $chans 0]] {
			lassign $_ index type name value ref_value
			
			if {$type == 1} {
				lappend list_flags $name
			} else {
				lappend list_setting $name
			}
		}
		
		set err_flags {}
		set err_setting {}
		
		set val_flags {}
		set val_setting {}
		
		set error 0
		while {[llength $largs] > 0} {
			set arg1 [lindex $largs 0]
			switch -glob -- $arg1 {
				+* - -* {
					set flag [string range $arg1 1 end]
					if {[lsearch -exact $list_flags $flag] < 0} {
						lappend err_flags $flag
					} else {
						lappend val_flags $flag $arg1
					}
				}
				default {
					if {[llength $largs] == 1} {
						set error 1
						put_msg [sprintf chan #134 $arg1]
						break
					}
					set arg2 [Pop largs 1]
					if {[lsearch -exact $list_setting $arg1] < 0} {
						lappend err_setting $arg1
					} else {
						lappend val_setting $arg1 $arg2
					}
				}
			}
			Pop largs
		}
		
		if {[llength $err_flags] > 0} {
			set error 1
			put_msg [sprintf chan #135 [join $err_flags ", "]]
		}
		if {[llength $err_setting] > 0} {
			set error 1
			put_msg [sprintf chan #136 [join $err_setting ", "]]
		}
		if {$error} {return 0}
		
		foreach chan $chans {
			
			set lmsg_flags {}
			set lmsg_setting {}
			
			foreach {flag val} $val_flags {
				set old_val [channel get $chan $flag]
				channel set $chan $val
				lappend lmsg_flags [sprintf chan #137 $flag [expr {$old_val ? "+" : "-"}] [string range $val 0 0]]
			}
			foreach {setting val} $val_setting {
				set old_val [channel get $chan $setting]
				channel set $chan $setting $val
				lappend lmsg_setting [sprintf chan #137 $setting $old_val $val]
			}
			
			if {[llength $lmsg_flags] > 0} {
				put_msg [sprintf chan #138 $chan [join $lmsg_flags ", "]]
			}
			if {[llength $lmsg_setting] > 0} {
				put_msg [sprintf chan #139 $chan [join $lmsg_setting ", "]]
			}
			
		}
		
		put_log "flag: [join $lmsg_flags ", "]; setting: [join $lmsg_setting ", "]"
		return 1
		
	}
	
	proc cmd_chaninfo {} {
		upvar out out
		importvars [list snick shand schan command smode]
		
		if {[string is space $smode]} {
			
			if {[check_isnull $schan]} {put_help -return 0}
			
			set out_group1 [list]
			set out_group2 [list]
			set out_group3 [list]
			set out_group4 [list]
			set out_group5 [list]
			
			set out_group6 ""
			set out_group7 ""
			set out_group8 ""
			set out_group9 ""
			set out_group10 ""
			
			foreach _ [channel_info $schan] {
				lassign $_ index type name value ref_value
				
				switch -exact $index {
					1 - 2 - 3 - 4 - 16 - 17 - 18 - 19 {lappend out_group1 "\002$name:\002 \"$value\""}
					10 - 11 - 12 - 13 - 14 - 15 {lappend out_group5 "$name \"$value\""}
					5 {set out_group6 "\002$name:\002 \"$value\""}
					6 {set out_group7 "\002$name:\002 \"$value\""}
					7 {set out_group8 "\002$name:\002 \"$value\""}
					8 {set out_group9 "\002$name:\002 \"$value\""}
					9 {set out_group10 "\002$name:\002 \"$value\""}
					default {
						if {$index < 45} {
							lappend out_group2 $ref_value
						} else {
							switch -exact $type {
								1 {lappend out_group3 "$ref_value"}
								2 {lappend out_group4 "$name \"$value\""}
							}
						}
					}
				}
				
			}
			
			put_msg -speed 3 -- "[join $out_group1 ", "]."
			put_msg -speed 3 -- "$out_group6."
			put_msg -speed 3 -- "$out_group7."
			put_msg -speed 3 -- "$out_group8."
			put_msg -speed 3 -- "$out_group9."
			put_msg -speed 3 -- "$out_group10."
			put_msg -speed 3 -- "\002Other modes:\002 [join $out_group2 ", "]."
			put_msg -speed 3 -- "\002User defined channel flags:\002 [join $out_group3 ", "]."
			put_msg -speed 3 -- "\002User defined channel strings:\002 [join $out_group4 ", "]."
			put_msg -speed 3 -- "\002Flood settings:\002 [join $out_group5 ", "]."
			
			put_log ""
			return 1
			
		} else {
			
			if {[check_isnull $schan]} {
				
				set chans [get_channels -hand $shand -flags [cmd_configure $command -flags]]
				if {[llength $chans] == 0} {put_log -return 0 -- "no channels"}
				
				set c1 [lindex $chans 0]
				set c2 [lrange $chans 1 end]
				
				set cinfo [channel_info $c1]
				foreach _ $cinfo {
					lassign $_ index type name value ref_value
					
					if {$name == $smode} {
						switch -exact $type {
							0 - 2 {
								set lout [list "$c1: \"\002$value\002\""]
								foreach chan $c2 {
									lappend lout "$chan: \"\002[channel get $chan $name]\002\""
								}
								put_msg -- [sprintf chan #133 $name [join $lout ", "]]
							}
							1 {
								set lout [list "$c1: \002$ref_value\002"]
								foreach chan $c2 {
									if {[channel get $chan $name]} {
										lappend lout "$chan: \002+$name\002"
									} else {
										lappend lout "$chan: \002-$name\002"
									}
								}
								put_msg -- [sprintf chan #132 [join $lout ", "]]
							}
						}
						put_log "flag $smode"
						return 1
					}
					
				}
				set find 0
				foreach _ $cinfo {
					lassign $_ index type name value ref_value
					
					if {[string match -nocase $smode $name]} {
						switch -exact $type {
							0 - 2 {
								set lout [list "$c1: \"\002$value\002\""]
								foreach chan $c2 {
									lappend lout "$chan: \"\002[channel get $chan $name]\002\""
								}
								put_msg -- [sprintf chan #133 $name [join $lout ", "]]
							}
							1 {
								set lout [list "$c1: \002$ref_value\002"]
								foreach chan $c2 {
									if {[channel get $chan $name]} {
										lappend lout "$chan: \002+$name\002"
									} else {
										lappend lout "$chan: \002-$name\002"
									}
								}
								put_msg -- [sprintf chan #132 [join $lout ", "]]
							}
						}
						set find 1
					}
					
				}
				if {!$find} {put_msg -return 0 -- [sprintf chan #106 $smode]}
				put_log "match $smode"
				return 1
				
			} else {
				
				set cinfo [channel_info $schan]
				foreach _ $cinfo {
					lassign $_ index type name value ref_value
					
					if {$name == $smode} {
						switch -exact $type {
							0 - 2 {put_msg -- [sprintf chan #110 $name $value]}
							1 {put_msg -- [sprintf chan #108 $ref_value]}
						}
						put_log "flag $smode"
						return 1
					}
					
				}
				set find 0
				foreach _ $cinfo {
					lassign $_ index type name value ref_value
					
					if {[string match -nocase $smode $name]} {
						switch -exact $type {
							0 - 2 {put_msg -speed 3 -- [sprintf chan #110 $name $value]}
							1 {put_msg -speed 3 -- [sprintf chan #108 $ref_value]}
						}
						set find 1
					}
					
				}
				if {!$find} {put_msg -return 0 -- [sprintf chan #106 $smode]}
				put_log "match $smode"
				return 1
				
			}
			
		}
		
	}
	
	proc notavailable-notvalidchan {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dchan dchan
		if {![validchan $dchan]} {
			put_msg [sprintf chan #104 $dchan]
			return 1
		}
		return 0
	}
	
	proc notavailable-isstaticchan {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dchan dchan
		if {![isdynamic $dchan]} {
			put_msg [sprintf chan #105 $dchan]
			return 1
		}
		return 0
	}
	
}