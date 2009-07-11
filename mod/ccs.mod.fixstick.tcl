####################################################################################################
## Модуль исправления ошибки бота не позволяющей возвращать стиковые баны/исключения/инвайты
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{fixstick}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль исправления ошибки бота не позволяющей возвращать стиковые баны/исключения/инвайты."

if {[pkg_info mod $_name on]} {
	
	proc fixstick {chan ind} {
		
		if {[ischanjuped $chan]} return
		if {![botonchan $chan]} {
			incr ind
			if {$ind > 4} return
			after 3000 [list [namespace origin fixstick] $chan $ind]
		}
		if {[botisop $chan] || [botishalfop $chan]} {
			foreach _ [banlist $chan] {
				lassign $_ what comment expire added timeactive by
				if {[isbansticky $what $chan] && ![ischanban $what $chan]} {
					putquick "MODE $chan +b $what"
				}
			}
			foreach _ [banlist] {
				lassign $_ what comment expire added timeactive by
				if {[isbansticky $what] && ![ischanban $what $chan]} {
					putquick "MODE $chan +b $what"
				}
			}
			foreach _ [exemptlist $chan] {
				lassign $_ what comment expire added timeactive by
				if {[isexemptsticky $what $chan] && ![ischanexempt $what $chan]} {
					putquick "MODE $chan +e $what"
				}
			}
			foreach _ [exemptlist] {
				lassign $_ what comment expire added timeactive by
				if {[isexemptsticky $what] && ![ischanexempt $what $chan]} {
					putquick "MODE $chan +e $what"
				}
			}
			foreach _ [invitelist $chan] {
				lassign $_ what comment expire added timeactive by
				if {[isinvitesticky $what $chan] && ![ischaninvite $what $chan]} {
					putquick "MODE $chan +I $what"
				}
			}
			foreach _ [invitelist] {
				lassign $_ what comment expire added timeactive by
				if {[isinvitesticky $what] && ![ischaninvite $what $chan]} {
					putquick "MODE $chan +I $what"
				}
			}
			
		}
		
	}
	
	proc mode_fixstick {nick uhost hand chan mode target} {
		if {[isbotnick $target] && ($mode == "+o" || $mode == "+h")} {fixstick $chan 0}
	}
	
	proc join_fixstick {nick uhost hand chan} {
		if {[isbotnick $nick]} {after 3000 [list [namespace origin fixstick] $chan 0]}
	}
	
	proc main_$_name {} {
		
		bind mode - *	[namespace origin mode_fixstick]
		bind join - *	[namespace origin join_fixstick]
		
	}
	
}