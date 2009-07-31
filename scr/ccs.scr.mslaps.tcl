####################################################################################################
## Скрипт защиты от массовых слапов на канале
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{mslaps}
pkg_add scr $_name "Buster <buster@buster-net.ru> (c)" "1.0.0" "24-Jul-2009" \
	"Скрипт защиты от массовых слапов на канале"

if {[pkg_info scr $_name on]} {
	
	################################################################################################
	# Доступное максимальное количество уникальных ников присутствующих в сообщении.
	# Значение может быть переопределено выставлением канального флага ccs-mslaps_maxcount
	set options(mslaps_maxcount)	6
	
	################################################################################################
	# Максимальное процентное соотношение уникальных ников присутствующих в сообщении к каналу.
	# Значение может быть переопределено выставлением канального флага ccs-mslaps_maxpercent
	set options(mslaps_maxpercent)	90
	
	################################################################################################
	# Время бана в минутах.
	# Значение может быть переопределено выставлением канального флага ccs-mslaps_bantime
	set options(mslaps_bantime)		15
	
	################################################################################################
	# Флаги пользователей, на которых функция контроля будет игнорироваться.
	set options(mslaps_flag_ignore)	"o|m"
	
	################################################################################################
	# Значение по умолчанию, которое определяет, должен ли скрипт работать на всех каналах (0 - нет,
	# 1 - да). Значение может быть переопределено выставлением канального флага ccs-mslaps_on_chan
	set options(mslaps_on_chan)		0
	
	################################################################################################
	# Значение по умолчанию, которое определяет маску по умолчанию для выставления банов.
	# Значение может быть переопределено выставлением канального флага ccs-banmask
	# Доступные значения:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	set options(banmask)			4
	
	set_text ru $_name #reason	"Массовые слапы запрещены правилами канала"
	
	setudef str ccs-mslaps_maxcount
	setudef str ccs-mslaps_maxpercent
	setudef str ccs-mslaps_bantime
	setudef str ccs-mslaps_reason
	setudef str ccs-mslaps_on_chan
	setudef str ccs-banmask
	
	proc mslaps_pubm {nick uhost hand chan text} {
		mslaps_test $nick $uhost $hand $chan $text
	}
	
	proc mslaps_action {nick uhost hand chan key text} {
		mslaps_test $nick $uhost $hand $chan $text
	}
	
	proc mslaps_test {nick uhost hand schan text} {
		variable options
		
		if {![get_options_int mslaps_on_chan $schan]} return
		if {[check_matchattr $hand $schan $options(mslaps_flag_ignore)]} return
		
		regsub -all -- {(\003\d{1,2}(?:,\d{1,2})?|\003|\037|\026|\017|\002|\d{1,2}(?:,\d{1,2})?|||||)} $text {} text
		
		set count 0
		set nicks {}
		foreach _ [split $text " ,*|"] {
			if {$_ == ""} continue
			if {[onchan $_ $schan] && [lsearch -exact $nicks $_ ] < 0} {
				incr count
				lappend nicks $_
			}
		}
		if {$count < 3} return
		
		set maxcount   [get_options_int mslaps_maxcount   $schan]
		set maxpercent [get_options_int mslaps_maxpercent $schan]
		
		if {$count > $maxcount || [expr double($count) / [llength [chanlist $schan]] * 100] > $maxpercent} {
			
			set bantime [get_options_int mslaps_bantime $schan]
			set banmask [get_options_int banmask        $schan]
			set reason  [get_options_str mslaps_reason  $schan]
			
			set hostmask [get_mask "$nick!$uhost" $banmask]
			if {[string is space $reason]} {
				set reason [sprintf mslaps #reason]
			}
			
			newchanban $schan $hostmask $::nick $reason $bantime
			putkick $schan $nick "Banned: $reason"
			
			put_log -command "MASSSLAPS" -- "$nick"
			
		}
		
	}
	
	proc main_$_name {} {
		
		bind pubm - *		[namespace origin mslaps_pubm]
		bind ctcp - ACTION	[namespace origin mslaps_action]
		
	}
	
}