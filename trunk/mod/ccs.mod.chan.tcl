####################################################################################################
## ������ � ���������� ��������� ����������
####################################################################################################
# ������ ��������� ���������:
#	v1.2.7
# - ��� ������� !channels �������� ����� ��������� ������� ���� � �������������� ���������� ����.
# - �������� ������� lsearch_equal

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{chan}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"������ ���������� ������� ������� � �������� ��������� ������."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# ���� � ����� ������ ���������� �������� �������. %s � ����� ����� ������� �� ��� ��������.
	set options(chansetfile)		"$options(dir_data)/ccs.chanset.%s.dat"
	
	################################################################################################
	# ���� � ����� ������ ���������� �������� �������� �������. %s � ����� ����� ������� �� ���
	# �������.
	set options(chantemplatefile)	"$options(dir_data)/ccs.chantemplate.%s.dat"
	
	################################################################################################
	# ��������� ������ ����� �������� � bak ���������� (1 - ��, 0 - ���)
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
		-regexp {{^([^\ ]+)(?:\ +(.*?))?$} {-> smode sargs}}
	
	cmd_configure chaninfo -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_chaninfo} \
		-regexp {{^([^\ ]+)?$} {-> smode}}
	
	cmd_configure chansave -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_chansave} \
		-regexp {{^([\w\.\-]{1,100})(?:\s+([\w\.\-]{1,100}))?$} {-> sfile stfile}}
	
	cmd_configure chanload -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_chanload} \
		-regexp {{^([\w\.\-]{1,100})(?:\s+([\w\.\-]{1,100}))?$} {-> sfile stfile}}
	
	cmd_configure chancopy -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_chancopy} \
		-regexp {{^([^\ ]+)(?:\s+([\w\.\-]{1,100}))?$} {-> dchan stfile}}
	
	cmd_configure chantemplateadd -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_templateadd} \
		-regexp {{^([^\ ]+)\s+(.+?)$} {-> sfile param}}
	
	cmd_configure chantemplatedel -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_templatedel} \
		-regexp {{^([^\ ]+)\s+(.+?)$} {-> sfile param}}
	
	cmd_configure chantemplatelist -control -group "chan" -flags {n|n} -block 5 \
		-alias {%pref_templatelist} \
		-regexp {{^([\w\.\-]{1,100})$} {-> sfile}}
	
	################################################################################################
	# ��������� ������ ���������� �������� (CHANNEL).
	
	proc get_chaninfo {ind par} {
		
		set res1 $par
		set res2 $par
		set flag 0
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
				if {[string index [lindex $par 0] 0] == "-" } {
					set name [lindex [string range $par 1 end] 0]
					set res1 0
					set flag 1
				} elseif {[string index [lindex $par 0] 0] == "+"} {
					set name [lindex [string range $par 1 end] 0]
					set res1 1
					set flag 1
				} else {
					set name [lindex $par 0]
					set res1 [lindex $par 1]
					set res2 [lindex $par 1]
				}
			}
		}
		
		return [list $name $flag $res1 $res2]
		
	}
	
	proc cmd_chantemplatelist {} {
		upvar out out
		variable options
		importvars [list snick shand schan command sfile param]
		
		set filename [string map [list %s $sfile] $options(chantemplatefile)]
		
		if {![file exists $filename]} {put_msg [sprintf chan #120 $sfile]; return 0}
		
		if {[catch {
			set data [LoadFile $filename]
		} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
		
		put_msg [sprintf chan #130 $sfile [join $data ", "]]
		put_log "$sfile"
		return 1
		
	}
	
	proc cmd_chantemplateadd {} {
		upvar out out
		variable options
		importvars [list snick shand schan command sfile param]
		
		set filename [string map [list %s $sfile] $options(chantemplatefile)]
		
		if {[catch {
			set data [LoadFile $filename]
		} errMsg]} {set data [list]}
		
		set lparam [split $param]
		set lnew [list]
		set lold [list]
		set lerr [list]
		set lver [list]
		
		set ind 0
		foreach _ [channel info $schan] {
			incr ind
			lassign [get_chaninfo $ind $_] name flag res1 res2
			lappend lver $name
		}
		
		foreach _ $lparam {
			
			if {[lsearch -exact $data $_] >= 0} {
				lappend lold $_
			} elseif {[lsearch -exact $lver $_] < 0} {
				lappend lerr $_
			} else {
				lappend lnew $_
				lappend data $_
			}
			
		}
		
		if {[llength $lnew] == 0} {
			set lout [list]
			if {[llength $lerr] > 0} {lappend lout [sprintf chan #126 [join $lerr ", "]]}
			if {[llength $lold] > 0} {lappend lout [sprintf chan #127 [join $lold ", "]]}
			put_msg [sprintf chan #121 $sfile [join $lout "; "]]
			return 0
		}
		
		if {[catch {
			SaveFile $filename $data
		} errMsg]} {put_msg [sprintf ccs #192 $errMsg]; return 0}
		
		set lout [list]
		if {[llength $lnew] > 0} {lappend lout [sprintf chan #125 [join $lnew ", "]]}
		if {[llength $lerr] > 0} {lappend lout [sprintf chan #126 [join $lerr ", "]]}
		if {[llength $lold] > 0} {lappend lout [sprintf chan #127 [join $lold ", "]]}
		
		put_msg [sprintf chan #123 $sfile [join $lout "; "]]
		put_msg [sprintf chan #131 [join $data ", "]]
		put_log "$sfile (new: [join $lnew ", "]; old: [join $lold ", "]; err: [join $lerr ", "])"
		return 1
		
	}
	
	proc cmd_chantemplatedel {} {
		upvar out out
		variable options
		importvars [list snick shand schan command sfile param]
		
		set filename [string map [list %s $sfile] $options(chantemplatefile)]
		
		if {![file exists $filename]} {put_msg [sprintf chan #120 $sfile]; return 0}
		
		if {[catch {
			set data [LoadFile $filename]
		} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
		
		set lparam [split $param]
		set ldel [list]
		set lno [list]
		
		foreach _ $lparam {
			
			if {[lsearch -exact $data $_] >= 0} {
				lappend ldel $_
			} else {
				lappend lno $_
			}
			
		}
		
		if {[llength $ldel] == 0} {
			set lout [list]
			if {[llength $lno] > 0} {lappend lout [sprintf chan #129 [join $lno ", "]]}
			put_msg [sprintf chan #122 $sfile [join $lout "; "]]
			return 0
		}
		
		set newdata [list]
		foreach _ $data {if {[lsearch -exact $ldel $_] < 0} {lappend newdata $_}}
		
		if {[catch {
			SaveFile $filename $newdata
		} errMsg]} {put_msg [sprintf ccs #192 $errMsg]; return 0}
		
		set lout [list]
		if {[llength $ldel] > 0} {lappend lout [sprintf chan #128 [join $ldel ", "]]}
		if {[llength $lno] > 0} {lappend lout [sprintf chan #129 [join $lno ", "]]}
		
		put_msg [sprintf chan #124 $sfile [join $lout "; "]]
		put_msg [sprintf chan #131 [join $newdata ", "]]
		put_log "$sfile (del: [join $ldel ", "]; no: [join $lno ", "])"
		return 1
		
	}
	
	proc cmd_chansave {} {
		upvar out out
		variable options
		importvars [list snick shand schan command sfile stfile]
		
		set filename [string map [list %s $sfile] $options(chansetfile)]
		
		if {![string is space $stfile]} {
			
			set tfilename [string map [list %s $stfile] $options(chantemplatefile)]
			if {![file exists $tfilename]} {put_msg [sprintf chan #120 $stfile]; return 0}
			if {[catch {
				set tdata [LoadFile $tfilename]
			} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
			set usetemplate 1
			
		} else {set usetemplate 0}
		
		set data [list]
		set lok [list]
		
		set ind 0
		foreach _ [channel info $schan] {
			incr ind
			lassign [get_chaninfo $ind $_] name flag res1 res2
			if {$usetemplate && [lsearch -exact $tdata $name] < 0} continue
			lappend data [list $name $flag $res2]
			lappend lok $name
		}
		
		if {[catch {
			SaveFile -backup $options(bakchanset) -- $filename $data
		} errMsg]} {put_msg [sprintf ccs #192 $errMsg]; return 0}
		if {$usetemplate} {
			put_msg [sprintf chan #112 $schan $sfile $stfile]
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
		importvars [list snick shand schan command sfile stfile]
		
		set filename [string map [list %s $sfile] $options(chansetfile)]
		if {![file exists $filename]} {put_msg [sprintf chan #119 $sfile]; return 0}
		if {[catch {
			set data [LoadFile $filename]
		} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
		
		if {![string is space $stfile]} {
			
			set tfilename [string map [list %s $stfile] $options(chantemplatefile)]
			if {![file exists $tfilename]} {put_msg [sprintf chan #120 $stfile]; return 0}
			if {[catch {
				set tdata [LoadFile $tfilename]
			} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
			set usetemplate 1
			
		} else {set usetemplate 0}
		
		set lerr [list]
		set lok [list]
		foreach _ $data {
			if {$usetemplate && [lsearch -exact $tdata [lindex $_ 0]] < 0} continue
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
				put_msg [sprintf chan #116 $schan $sfile $stfile [join $lerr ", "]]
			} else {
				put_msg [sprintf chan #114 $schan $sfile $stfile]
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
		importvars [list snick shand schan command dchan stfile]
		
		if {[check_notavailable {-notvalidchan} -dchan $dchan]} {return 0}
		if {![check_matchattr $shand $dchan [cmd_configure $command -flags]]} {put_msg [sprintf ccs #118]; return 0}
		
		if {![string is space $stfile]} {
			
			set tfilename [string map [list %s $stfile] $options(chantemplatefile)]
			if {![file exists $tfilename]} {put_msg [sprintf chan #120 $stfile]; return 0}
			if {[catch {
				set tdata [LoadFile $tfilename]
			} errMsg]} {put_msg [sprintf ccs #213 $errMsg]; return 0}
			set usetemplate 1
			
		} else {set usetemplate 0}
		
		set lok [list]
		set ind 0
		foreach _ [channel info $schan] {
			incr ind
			lassign [get_chaninfo $ind $_] name flag res1 res2
			if {$usetemplate && [lsearch -exact $tdata $name] < 0} continue
			lappend lok $name
			if {$flag} {channel set $dchan $res2} else {channel set $dchan $name $res2}
		}
		if {$usetemplate} {
			put_msg [sprintf chan #118 $schan $dchan $stfile]
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
	# ��������� ������ ���������� ����������� ������ (CHANSET).
	
	proc cmd_chanset {} {
		upvar out out
		importvars [list snick shand schan command smode sargs]
		
		if {[string index $smode 0] == "+" || [string index $smode 0] == "-"} {
			if {[catch {
				if {[check_isnull $schan]} {
					foreach _ [channels] {channel set $_ $smode}
				} else {
					channel set $schan $smode
				}
			}]} {
				put_msg [sprintf chan #106 $smode]
				return 0
			}
			put_msg [sprintf chan #107 $smode]
			put_log "$smode"
			return 1
		} else {
			if {[catch {
				if {[check_isnull $schan]} {
					foreach _ [channels] {channel set $_ $smode $sargs}
				} else {
					channel set $schan $smode $sargs
				}
			}]} {
				put_msg [sprintf chan #106 $smode]
				return 0
			}
			put_msg [sprintf chan #109 $smode $sargs]
			put_log "$smode $sargs"
			return 1
		}
		
	}
	
	proc cmd_chaninfo {} {
		upvar out out
		importvars [list snick shand schan command smode]
		
		if {[string is space $smode]} {
			
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
			
			set ind 0
			foreach _ [channel info $schan] {
				
				incr ind
				switch -exact $ind {
					1 {lappend out_group1 "\002chanmode:\002 $_"}
					2 {lappend out_group1 "\002Idle-Kick:\002 $_"}
					3 {lappend out_group1 "\002Stopnethack-mode:\002 $_"}
					4 {lappend out_group1 "\002revenge-mode:\002 $_"}
					5 {set out_group6 "\002need-op:\002 $_"}
					6 {set out_group7 "\002need-invite:\002 $_"}
					7 {set out_group8 "\002need-key:\002 $_"}
					8 {set out_group9 "\002need-unban:\002 $_"}
					9 {set out_group10 "\002need-limit:\002 $_"}
					10 {lappend out_group5 "flood-chan: $_"}
					11 {lappend out_group5 "flood-ctcp: $_"}
					12 {lappend out_group5 "flood-join: $_"}
					13 {lappend out_group5 "flood-kick: $_"}
					14 {lappend out_group5 "flood-deop: $_"}
					15 {lappend out_group5 "flood-nick: $_"}
					16 {lappend out_group1 "\002aop-delay:\002 $_"}
					17 {lappend out_group1 "\002ban-time:\002 $_"}
					18 {lappend out_group1 "\002exempt-time:\002 $_"}
					19 {lappend out_group1 "\002invite-time:\002 $_"}
					default {
						if {$ind < 45} {
							lappend out_group2 "$_"
						} else {
							if {[string index $_ 0] == "-" || [string index $_ 0] == "+"} {
								lappend out_group3 "$_"
							} else {
								lappend out_group4 "$_"
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
			
		} else {
			if {[catch {set getmode [channel get $schan $smode]}]} {
				
				set find 0
				set ind 0
				foreach _ [channel info $schan] {
					incr ind
					lassign [get_chaninfo $ind $_] name flag res1 res2
					if {[string match -nocase $smode $name]} {
						set find 1
						if {$flag} {
							put_msg -speed 3 -- [sprintf chan #108 $res2]
						} else {
							put_msg -speed 3 -- [sprintf chan #110 $name $res1]
						}
					}
					
				}
				if {!$find} {put_msg [sprintf chan #106 $smode]; return 0}
				
			} else {
				
				set ind 0
				set flag1 0
				foreach _ [channel info $schan] {
					incr ind
					if {$ind < 20} continue
					lassign [get_chaninfo $ind $_] name flag res1 res2
					if {$name == $smode} {set flag1 $flag; break}
				}
				if {$flag1} {
					put_msg [sprintf chan #108 [expr {$getmode ? "+" : "-"}]$smode]
				} else {
					put_msg [sprintf chan #110 $smode $getmode]
				}
			}
		}
		put_log "$smode"
		return 1
		
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