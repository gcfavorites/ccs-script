##################################################################################################################
## Модуль логирования в файл
##################################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"logs"
addmod $modname "Buster <buster@ircworld.ru> (c)" \
				"1.2.2" \
				"03-Nov-2008"

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# Имя файла и путь ведения логов. По умолчанию в папку со скриптом с именем ccs.log
	set ccs(logsfile)			"$ccs(ccsdir)/ccs.log"
	
	proc put_log {text args} {
		importvars [list snick shand schan command] $args [list level 1]
		variable ccs
		
		set lout [list]
		if {![check_isnull $snick] && ![check_isnull $shand]} {
			lappend lout "<<$snick[expr {$snick != $shand ? " ($shand)" : ""}]>>"
		} elseif {![check_isnull $snick]} {
			lappend lout "<<$snick>>"
		} elseif {![check_isnull $shand]} {
			lappend lout "<<($shand)>>"
		}
		
		if {![check_isnull $schan]} {lappend lout "!$schan!"}
		if {$command != ""} {lappend lout "[string toupper $command]"}
		lappend lout $text
		
		debug [join $lout] $level
		
		if {[catch {
			savefile $ccs(logsfile) "\[[clock format [unixtime] -format "%d-%b-%y %H:%M:%S"]\] [join $lout]" -append
		} errMsg]} {
			return 0
		}
		return 1
		
	}
	
}