####################################################################################################
## Модуль логирования в файл
####################################################################################################
# Список последних изменений:
#	v1.2.5
# - Изменена директория по умолчанию для сохранения логов

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{logs}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.1" "14-Jul-2009" \
	"Модуль логирования (сохранения всех действий пользователей в файл)."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# Имя файла и путь ведения логов. По умолчанию в папку со скриптом с именем ccs.log
	set options(logsfile)			"$options(dir_data)/ccs.log"
	
	################################################################################################
	# Максимальный уровень сообщений, которые необходимо записывать в лог файл
	set options(logslevel)			3
	
	proc put_log {args} {
		upvar snick snick shand shand schan schan command command
		variable options
		
		set opts(-return) ""; # выход из процедуры после вывода сообщения
		set opts(-level)  1;  # уровень отладки
		if {[info exists snick]}   { set opts(-snick)   $snick   } else { set opts(-snick)   "" }
		if {[info exists shand]}   { set opts(-shand)   $shand   } else { set opts(-shand)   "" }
		if {[info exists schan]}   { set opts(-schan)   $schan   } else { set opts(-schan)   "" }
		if {[info exists command]} { set opts(-command) $command } else { set opts(-command) "" }
		
		set upreturn 0
		
		if {[llength $args] > 1} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-return  { set opts(-return)  [Pop args 1]; set upreturn 1 }
					-level   { set opts(-level)   [Pop args 1] }
					-snick   { set opts(-snick)   [Pop args 1] }
					-shand   { set opts(-shand)   [Pop args 1] }
					-schan   { set opts(-schan)   [Pop args 1] }
					-command { set opts(-command) [Pop args 1] }
					-- { Pop args; break }
					default {
						set opt [join [lsort [array names opts -*]] ", "]
						return -code error "bad option [lindex $args 0]: must be $opt"
					}
				}
				Pop args
			}
		}
		
		if {[llength $args] != 1} {
			return -code error "wrong # args: should be \"put_log ?switches? text\""
		}
		
		set text [lindex $args 0]
		
		set r {}
		if {![check_isnull $opts(-snick)]} {
			if {![check_isnull $opts(-shand)] && $opts(-snick) != $opts(-shand)} {
				lappend r "<<$opts(-snick)($opts(-shand))>>"
			} else {
				lappend r "<<$opts(-snick)>>"
			}
		} elseif {![check_isnull $opts(-shand)]} {
			lappend r "<<($opts(-shand))>>"
		}
		
		if {![check_isnull $opts(-schan)]} {lappend r "!$opts(-schan)!"}
		if {$opts(-command) != ""} {lappend r "[string toupper $opts(-command)]"}
		lappend r $text
		
		debug [join $r] $opts(-level)
		
		if {$options(logslevel) >= $opts(-level)} {
			if {[catch {
				SaveFile -access a -- $options(logsfile) "\[[clock format [unixtime] -format "%d-%b-%y %H:%M:%S"]\] [join $r]"
			} errMsg]} {
				return 0
			}
		}
		
		if {$upreturn} {return -code return $opts(-return)}
		
	}
	
}