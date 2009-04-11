##################################################################################################################
## Модуль настройки языков
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"lang"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.3.0" \
				"11-Apr-2009" \
				"Модуль локализации (установка языка по умолчанию для каналов и пользователей)."

if {$ccs(mod,name,$modname)} {
	
	cconfigure langlist -add -group "lang" -flags {%v} -block 3 -usechan 0 \
		-alias {%pref_langlist} \
		-regexp {{^([^\ ]+)?$} {-> mod}}
	
	cconfigure chansetlang -add -group "lang" -flags {m|m} -block 3 \
		-alias {%pref_chansetlang} \
		-regexp {{^([^\ ]+)?$} {-> lang}}
	
	cconfigure chlang -add -group "lang" -flags {m} -block 3 -usechan 0 \
		-alias {%pref_chlang} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick lang}}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	#############################################################################################################
	# Процедуры команд отправки сообщений (MESSAGE).
	
	proc cmd_langlist {} {
		importvars [list onick ochan obot snick shand schan command mod]
		variable ccs
		
		set lmod [list]
		foreach _ [array names ccs -glob "mod,name,*"] {
			if {!$ccs($_)} continue
			set modname [lindex [split $_ ,] 2]
			lappend lmod $modname
		}
		
		if {$mod == ""} {
			put_msg [sprintf lang #101 [join $lmod ", "]]
			put_log ""
			return 1
		} else {
			
			if {[lsearch $lmod $mod] < 0} {
				put_msg [sprintf lang #101 [join $lmod ", "]]
				return 0
			}
			
			set author $ccs(mod,author,$mod)
			set version $ccs(mod,version,$mod)
			set date $ccs(mod,date,$mod)
			put_msg [sprintf lang #102 $mod $version $date $author]
			foreach line [array names ccs -glob "lang,name,$mod,*"] {
				set land [lindex [split $line ,] 3]
				set author $ccs(lang,author,$mod,$land)
				set version $ccs(lang,version,$mod,$land)
				set date $ccs(lang,date,$mod,$land)
				put_msg [sprintf lang #103 $land $version $date $author]
			}
			return 1
			
		}
		put_log ""
		
	}
	
	proc cmd_chansetlang {} {
		importvars [list onick ochan obot snick shand schan command lang]
		variable ccs
		
		if {$lang == ""} {
			set lang [channel get $schan ccs-default_lang]
			if {$lang == ""} {
				put_msg [sprintf lang #109 $schan]
			} else {
				put_msg [sprintf lang #110 $schan $lang]
			}
		} else {
			set llang [list]
			foreach _ [array names ccs -glob "lang,name,*,*"] {
				if {!$ccs($_)} continue
				set slang [lindex [split $_ ,] 3]
				lappend llang $slang
			}
			set llang [lsort -unique $llang]
			
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
		importvars [list onick ochan obot snick shand schan command dnick lang]
		variable ccs
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition1 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		if {$lang == ""} {
			set lang [getuser $dhand XTRA ccs-default_lang]
			if {$lang == ""} {
				put_msg [sprintf lang #111 [get_nick $dnick $dhand]]
			} else {
				put_msg [sprintf lang #112 [get_nick $dnick $dhand] $lang]
			}
		} else {
			set llang [list]
			foreach _ [array names ccs -glob "lang,name,*,*"] {
				if {!$ccs($_)} continue
				set slang [lindex [split $_ ,] 3]
				lappend llang $slang
			}
			set llang [lsort -unique $llang]
			
			if {[string equal -nocase $lang "default"]} {
				setuser $dhand XTRA ccs-default_lang ""
				put_msg [sprintf lang #107 [get_nick $dnick $dhand]]
				return 1
			} else {
				if {[lsearch $llang $lang] < 0} {
					put_msg [sprintf lang #104 $lang [join $llang ", "]]
					return 0
				}
				setuser $dhand XTRA ccs-default_lang $lang
				put_msg [sprintf lang #108 [get_nick $dnick $dhand] $lang]
				return 1
			}
		}
		
	}
	
}