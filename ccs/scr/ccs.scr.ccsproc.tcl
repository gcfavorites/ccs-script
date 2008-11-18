if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set scrname		"ccsproc"
addscr $scrname "Buster <buster@ircworld.ru> (c)" \
				"1.0.0" \
				"03-Nov-2008"

if {$ccs(scr,name,$scrname)} {
	
	# Функция поиска неиспользуемых индексов в текстовых переменных
	proc check_freetext {modname {lang default}} {
		variable ccs
		
		set lmsg [list]
		set bropen 0
		set indopen 0
		for {set x 1} {$x < 1000} {incr x} {
			if {$x < 10} {set sx "#00$x"
			} elseif {$x < 100} {set sx "#0$x"
			} else {set sx "#$x"}
			if {![info exists ccs(text,$modname,$lang,$sx)] && !$bropen} {
				set bropen 1
				set indopen $x
			} elseif {[info exists ccs(text,$modname,$lang,$sx)] && $bropen} {
				if {$indopen == [expr $x-2]} {
					lappend lmsg "$indopen, [expr $x-1]"
				} elseif {$indopen == [expr $x-1]} {
					lappend lmsg "$indopen"
				} else {
					lappend lmsg "$indopen-[expr $x-1]"
				}
				set bropen 0
			}
		}
		if {$bropen} {
			lappend lmsg "$indopen[expr {$indopen == [expr $x-2] ? ", " : "-"}][expr $x-1]"
			set bropen 0
		}
		debug "free text: [join $lmsg ", "]"
		
	}
	
	proc ccsgenerate {handle idx str} {
		variable ccs
		
		set filename "ccsversion3.txt"
		
		set fileio [open $ccs(ccsdir)/$filename w]
		
		debug [list mod ccs * $::ccs::version $::ccs::author	$::ccs::date	[list ccs.tcl %is]]
		puts $fileio [list mod ccs * $::ccs::version $::ccs::author	$::ccs::date	[list ccs.tcl %is]]
		
		foreach _ [array names ::ccs::ccs -glob "mod,name,*"] {
			set modname [lindex [split $_ ,] 2]
			if {$modname == "ccs"} continue
			set fscr [string map [list $ccs(ccsdir)/ ""] $::ccs::ccs(mod,info_script,$modname)]
			set tscr [string map [list $ccs(ccsdir)/ "" mod/ %pm/] $::ccs::ccs(mod,info_script,$modname)]
			debug [list mod $modname * $::ccs::ccs(mod,version,$modname) $::ccs::ccs(mod,author,$modname)	$::ccs::ccs(mod,date,$modname)	[list $fscr $tscr]]
			puts $fileio [list mod $modname * $::ccs::ccs(mod,version,$modname) $::ccs::ccs(mod,author,$modname)	$::ccs::ccs(mod,date,$modname)	[list $fscr $tscr]]
		}
		
		foreach _ [array names ::ccs::ccs -glob "lang,name,*,*"] {
			set modname [lindex [split $_ ,] 2]
			set lang [lindex [split $_ ,] 3]
			set fscr [string map [list $ccs(ccsdir)/ ""] $::ccs::ccs(lang,info_script,$modname,$lang)]
			set tscr [string map [list $ccs(ccsdir)/ "" lang/ %pl/] $::ccs::ccs(lang,info_script,$modname,$lang)]
			debug [list lang $modname $lang $::ccs::ccs(lang,version,$modname,$lang) $::ccs::ccs(lang,author,$modname,$lang)	$::ccs::ccs(lang,date,$modname,$lang)	[list $fscr $tscr]]
			puts $fileio [list lang $modname $lang $::ccs::ccs(lang,version,$modname,$lang) $::ccs::ccs(lang,author,$modname,$lang)	$::ccs::ccs(lang,date,$modname,$lang)	[list $fscr $tscr]]
		}
		
		foreach _ [array names ::ccs::ccs -glob "scr,name,*"] {
			set modname [lindex [split $_ ,] 2]
			if {$modname == "ccsproc"} continue
			set fscr [string map [list $ccs(ccsdir)/ ""] $::ccs::ccs(scr,info_script,$modname)]
			set tscr [string map [list $ccs(ccsdir)/ "" scr/ %ps/] $::ccs::ccs(scr,info_script,$modname)]
			debug [list mod $modname * $::ccs::ccs(scr,version,$modname) $::ccs::ccs(scr,author,$modname)	$::ccs::ccs(scr,date,$modname)	[list $fscr $tscr]]
			puts $fileio [list scr $modname * $::ccs::ccs(scr,version,$modname) $::ccs::ccs(scr,author,$modname)	$::ccs::ccs(scr,date,$modname)	[list $fscr $tscr]]
		}
		
		flush $fileio
		close $fileio
	}
	
	proc binds_up_ccsproc {} {
		
		bind dcc n ccsgenerate		[namespace origin ccsgenerate]
		
	}
	
}