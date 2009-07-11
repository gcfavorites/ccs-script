####################################################################################################
## Модуль настройки языков
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{lang}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль локализации (установка языка по умолчанию для каналов и пользователей)."

if {[pkg_info mod $_name on]} {
	
	cmd_configure langlist -control -group "lang" -flags {%v} -block 3 -use_chan 0 \
		-alias {%pref_langlist} \
		-regexp {{^([^\ ]+)?$} {-> mod}}
	
	cmd_configure chansetlang -control -group "lang" -flags {m|m} -block 3 \
		-alias {%pref_chansetlang} \
		-regexp {{^([^\ ]+)?$} {-> lang}}
	
	cmd_configure chlang -control -group "lang" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_chlang} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick lang}}
	
	################################################################################################
	# Процедуры команд отправки сообщений (MESSAGE).
	
	proc cmd_langlist {} {
		upvar out out
		importvars [list snick shand schan command mod]
		
		set lmod [pkg_list mod 1]
		
		if {$mod == ""} {
			put_msg [sprintf lang #101 [join $lmod ", "]]
			put_log ""
			return 1
		} else {
			
			if {[lsearch -exact $lmod $mod] < 0} {
				put_msg [sprintf lang #101 [join $lmod ", "]]
				return 0
			}
			
			put_msg [sprintf lang #102 $mod [pkg_info mod $mod version] [pkg_info mod $mod date] [pkg_info mod $mod author]]
			foreach _ [pkg_list lang 1] {
				lassign $_ m l
				if {$m != $mod} continue
				put_msg [sprintf lang #103 $l [pkg_info lang $_ version] [pkg_info lang $_ date] [pkg_info lang $_ author]]
			}
			return 1
			
		}
		put_log ""
		
	}
	
	proc cmd_chansetlang {} {
		upvar out out
		importvars [list snick shand schan command lang]
		
		if {$lang == ""} {
			set lang [channel get $schan ccs-default_lang]
			if {$lang == ""} {
				put_msg [sprintf lang #109 $schan]
			} else {
				put_msg [sprintf lang #110 $schan $lang]
			}
		} else {
			set llang {}
			foreach _ [pkg_list lang 1] {
				lassign $_ m l
				if {[lsearch -exact $llang $l] < 0} {lappend llang $l}
			}
			set llang [lsort $llang]
			
			if {[string equal -nocase $lang "default"]} {
				channel set $schan ccs-default_lang ""
				put_msg [sprintf lang #105 $schan]
				return 1
			} else {
				if {[lsearch $llang $lang] < 0} {
					put_msg [sprintf lang #104 $lang [join $llang ", "]]
					return 0
				}
				
				channel set $schan ccs-default_lang $lang
				put_msg [sprintf lang #106 $schan $lang]
				return 1
			}
		}
		
	}
	
	proc cmd_chlang {} {
		upvar out out
		importvars [list snick shand schan command dnick lang]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition1 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		if {$lang == ""} {
			set lang [getuser $dhand XTRA ccs-default_lang]
			if {$lang == ""} {
				put_msg [sprintf lang #111 [StrNick -nick $dnick -hand $dhand]]
			} else {
				put_msg [sprintf lang #112 [StrNick -nick $dnick -hand $dhand] $lang]
			}
		} else {
			set llang {}
			foreach _ [pkg_list lang 1] {
				lassign $_ m l
				if {[lsearch -exact $llang $l] < 0} {lappend llang $l}
			}
			set llang [lsort $llang]
			
			if {[string equal -nocase $lang "default"]} {
				setuser $dhand XTRA ccs-default_lang ""
				put_msg [sprintf lang #107 [StrNick -nick $dnick -hand $dhand]]
				return 1
			} else {
				if {[lsearch $llang $lang] < 0} {
					put_msg [sprintf lang #104 $lang [join $llang ", "]]
					return 0
				}
				setuser $dhand XTRA ccs-default_lang $lang
				put_msg [sprintf lang #108 [StrNick -nick $dnick -hand $dhand] $lang]
				return 1
			}
		}
		
	}
	
}