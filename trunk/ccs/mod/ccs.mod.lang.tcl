##################################################################################################################
## Модуль настройки языков
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"lang"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.1" \
				"25-Jul-2008"

if {$ccs(mod,name,$modname)} {
	
	lappend ccs(commands)	"langlist"
	lappend ccs(commands)	"chansetlang"
	lappend ccs(commands)	"chlang"
	
	set ccs(group,langlist) "lang"
	set ccs(use_chan,langlist) 0
	set ccs(flags,langlist) {%v}
	set ccs(alias,langlist) {%pref_langlist}
	set ccs(block,langlist) 3
	set ccs(regexp,langlist) {{^([^\ ]+)?$} {-> mod}}
	
	set ccs(group,chansetlang) "lang"
	set ccs(flags,chansetlang) {m|m}
	set ccs(alias,chansetlang) {%pref_chansetlang}
	set ccs(block,chansetlang) 3
	set ccs(regexp,chansetlang) {{^([^\ ]+)?$} {-> lang}}
	
	set ccs(group,chlang) "lang"
	set ccs(use_chan,chlang) 0
	set ccs(flags,chlang) {m}
	set ccs(alias,chlang) {%pref_chlang}
	set ccs(block,chlang) 3
	set ccs(regexp,chlang) {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick lang}}
	
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