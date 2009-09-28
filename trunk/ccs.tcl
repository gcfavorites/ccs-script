####################################################################################################
## Продолжение известного скрипта управления CCS (Channel Control Script)
## Version: 1.8.4.
## Script's author: Buster (buster@buster-net.ru)
##                                        (http://buster-net.ru/index.php?section=irc&theme=scripts)
##                               (http://reserver.buster-net.ru/index.php?section=irc&theme=scripts)
## Forum:           http://forum.systemplanet.ru/viewtopic.php?f=3&t=3
## sf.net:          http://sourceforge.net/projects/ccs-eggdrop/
## SVN:             svn checkout http://ccs-script.googlecode.com/svn/trunk/ ccs-script-read-only
## Тестеры:         Net_Storm, Kein, anaesthesia
####################################################################################################
# Установка скрипта:
#  1) Распаковать архив в директорию scripts;
#  2) Прописать скрипт в конфигурационном файле, не забывая указать правильный путь, пример:
#     source scripts/ccs/ccs.tcl
#  3) Настроить дополнительные параметры по желания. Все изменения должны производиться _только_
#     в файлах ccs.rсX.tcl. Если соответствующая настройка присутствует в файле, то необходимо
#     разкомментировать параметр и изменить по желанию. Если какой ни будь из параметров
#     присутствует только в скрипте, то следует скопировать строку и добавить её в соответсвующий
#     ccs.rсX.tcl с измененным значением;
#  4) Перезапустить бота командой .rehash через патилайн.
####################################################################################################
# Помощь по командам осуществляеться через команду !helps, флаги помощи:
#  all               -- вывод полного списка с максимальной информацией.
#  limit             -- вывод списка команд доступных пользователю с максимальной информацией.
#  -a[ccess]         -- вывод уровня доступа.
#  -c[ommands]       -- дополнительные команды (алиасы).
#  -g[roup] [группа] -- выводит команды _только_ указанной группы.
#  -l[imit]          -- выводит _только_ доступные команды.
####################################################################################################
# Список последних изменений:
#	v1.8.4
# - Добавление функционала для интеграции скриптов.
# - Исправлена работоспособность параметра -override_level.
# - Исправлено пересечение переменных определенных в namespace и глобально.
# - Добавлен параметр max_msg_chan определяющий ограничение строк отправленных на канал из списка.
# - Обновлена функция пересылки текста через ботнет с учетом изменений глобальных функций.
# - Добавлен новый параметр use_blocktime_limit, с помощью которого можно отключить задержку.
# - Добавлен новый параметр time_format представляющий формат времени.
# - Добавлен вывод даты при выводе списка банов.
#	v1.8.2
# - Для библиотеки IP добавлена поддержка Tcl8.4. Оптимизирована работа скрипта в целом для Tcl8.5+
# - В библиотеке IP обновлен список адрессов RIR
# - Для скрипта whoisip загрузка библиотек IP и DNS перенесена на момент загрузки биндов. По этой
#   причине следует перенести настройки модуля DNS, если таковые имеются, в файл ccs.rc2.tcl
# - Добавлена возможность обновления через интернет для не патченных ботов и ботов, работающих в
#   любой кодировке
# - Для модуля regban, для совместимости с разными IRC сетями изменен запрос WHO
# - Переписано и оптимизировано большинство процедур
# - Конфигурирование параметров ограничено функциями configure и cmd_configure
# - Переписано ботнет управление (для работы требуется обновить скрипт на всех ботах)
# - Для ботнет управления добавлена поддержка работы с разной кодировкой
# - Для ботнет управления добавлена защита от переполнения буфера
# - Введен в работу алгоритм пресекающий выкидывание бота за флуд в той ситуации, когда нотисом
#   отправляется слишком много строк, если был подготовлен большой список для вывода нотисом, то
#   такой список отправится в приват
# - Для модуля regban исправлена ошибка, связанная с указанием маски бана
# - Для модуля regban исправлена ошибка ложного срабатывания при наличии нескольких правил.
#	v1.8.1
# - Изменены файлы инициализации загрузки. Теперь их три ccs.rc0.tcl, ccs.rc1.tcl, ccs.rc2.tcl.
#   В первом можно указать модули, скрипты, языки которые не должны загружаться, во втором можно
#   переопределить любые параметры, третий запускается после поднимания биндов.
# - Исправлена возможность использования префиксов * и % для команд патилайна.
# - Для команды !info добавлен вывод информации по пользовательским флагам
#	v1.8.0
# - Исправлен вывод помощи. В определенной ситуации в помощи не выводился аргумент, требующий
#   указание канала.
# - Добавлена процедура cmd_configure для удобного конфигурирования параметров команд. В связи с
#   этим во всех модулях переписано присвоение дефолтных настроек.
####################################################################################################
# Полный список изменений, начиная с версии 1.1.0, можно прочитать в файле ChangeLog.
####################################################################################################
#######          После следующей линии категорически не рекомендуется что-то менять          #######
####### Все изменения необходимо производить в файлах: ccs.rc0.tcl, ccs.rc1.tcl, ccs.rc2.tcl #######
####################################################################################################

####################################################################################################
# Список параметров команд:
#
# set ccs(args,lang,command)
#   Аргументы использования команды для указанного языка (строка);
#
# set ccs(help,lang,command)
#   Помощь по команде для указанного языка (строка);
#
# set ccs(help2,lang,command)
#   Расширенная помощь по команде для указанного языка (список строк);
#
# -group
#   Принадлежность команды к определенной группе (строка);
#
# -use
#   Включение/отключение команды (1 - включена, 0 - отключена), значение по умолчанию 1
#   (если параметр не указан);
#
# -use_auth
#   Команда требует авторизацию для её использования (1 - авторизация требуется, 0 - нет), значение
#   по умолчанию 1 (если параметр не указан);
#
# -use_chan
#   Команда использует имя канала, для каких либо действий, в случае управления ботом через приват
#   данная команда потребует ввести имя канала над которым производиться действие.
#   Значение по умолчанию 1 (если параметр не указан)
#      0 - канал не используеться;
#      1 - указание канала обязательно;
#      2 - указание канала либо "*" обязательно;
#      3 - указание канала не обязательно;
#
# -flags
#   Флаги доступа к команде. Если флаги указываются через вертикальную черту, это будет означать
#   доступность команды, как для глобальных пользователей, так и для локальных. Если же флаг
#   указывается одной буквой, то использовать команду смогут только пользователи с глобальным
#   правами. (дополнительные флаги: %v - при этом пользователь должен присутствовать в юзерлист);
#
# -alias
#   Список команд на которые бот будет реагировать для использования данной команды "%pref_" будет
#   заменена на префикс по умолчанию.
#
# -block
#   Необязательный параметр блокировка использования команды по времени. Задается время в секундах,
#   через которое будет доступно повторное выполнение команды.
#
# -regexp
#   Регулярное выражение, выбирающее данные и передающее обрабатываемой процедуре
#
# -override_level
#   Переопределение уровня доступа юзера для выполнения команды. Если у юзера не хватает прав
#   (пример: в случае если для команды назначен юзерский флаг), то этим значением можно поднять
#   уровень доступа пользователя. Список стандартных уровней прав назначаемых стандартными флагами:
#      0 - нету никаких прав
#      1 - локальный флаг l
#      2 - локальный флаг o
#      3 - локальный флаг m
#      4 - локальный флаг n
#      5 - глобальный флаг l
#      6 - глобальный флаг o
#      7 - глобальный флаг m
#      8 - глобальный флаг n
#      9 - перманентный овнер ("set owner" в конфиге)
#   Не рекомендуется выставлять значение этого параметра больше уровня доступа по флагам указанного
#   в параметре -flags
####################################################################################################

package require Tcl
catch {package require http}

namespace eval ::ccs {
	
	################################################################################################
	# Версия и автор скрипта
	variable author		"Buster <buster@buster-net.ru> (c)"
	variable version	"1.8.4"
	variable date		"21-Sep-2009"
	
	set time_up [clock clicks -milliseconds]
	
	################################################################################################
	# Объявление канальных флагов
	setudef str ccs-default_lang
	setudef str ccs-on_chan
	setudef str ccs-usecolors
	
	################################################################################################
	# Объявление общих переменных
	
	variable options
	variable cmd_options
	variable text
	variable commands
	variable tokens
	variable limit
	
	variable url_update
	variable file_version
	variable file_ccs
	variable dir_ccs
	variable group
	variable type_file
	
	foreach _ [array names options]     { unset options($_)     }
	foreach _ [array names cmd_options] { unset cmd_options($_) }
	foreach _ [array names text]        { unset text($_)        }
	foreach _ [array names commands]    { unset commands($_)    }
	foreach _ [array names pkg]         { unset pkg($_)         }
	
	foreach _ [lsearch -all -inline [package names] "[namespace current]::*"] {package forget $_}
	foreach _ [namespace children [namespace current]] {namespace delete $_}
	
	set commands(control) {}
	set commands(scripts) {}
	set group             {}
	
	################################################################################################
	#    _НЕ ИЗМЕНЯТЬ_
	# Список адресов для автоматического обновления.
	set url_update {
		http://buster-net.ru/files/irc/scripts/ccs
		http://reserve.buster-net.ru/files/irc/scripts/ccs
		http://bots.systemplanet.ru/scripts/ccs
	}
	# Имя файла версий для автоматического обновления.
	set file_version	"ccsversion5.txt"
	# Путь и имя загружаемого скрипта.
	set file_ccs		[info script]
	# Путь загружаемого скрипта. 
	set dir_ccs			[file dirname $file_ccs]
	# Список загружаемых типов файлов. _НЕ ИЗМЕНЯТЬ_
	set type_file		{mod lang scr lib}
	
	################################################################################################
	# Префиксы для команд управления. pub - канал, msg - приват, dcc - патилайн.
	# Использование префикса "." для патилайна не доступно.
	set options(prefix_pub)				"!"
	set options(prefix_msg)				"!"
	set options(prefix_dcc)				"!"
	
	################################################################################################
	# Префиксы для команд управления передаваемых ботам ботнета. pub - канал, msg - приват,
	# dcc - патилайн. !Внимание! команды без префиксов не будут прописаны. Если поля оставить
	# пустыми, то команды не будут прописаны. Использование префикса "." для патилайна не доступно.
	set options(prefix_botnet_pub)		"!!"
	set options(prefix_botnet_msg)		"!!"
	set options(prefix_botnet_dcc)		"!!"
	
	################################################################################################
	# Список языков по умолчанию для выводимого текста. Значение может быть переопределено
	# выставлением канального флага ccs-default_lang и настройкой пользователя. Первое значение в
	# списке имеет наибольший приоритет, последнее - наименьший.
	set options(default_lang)			{ru en}
	
	################################################################################################
	# Флаг, обеспечивающий быстрый вывод и работу с командами. Актуален при наличии флага +F на
	# боте, иначе бот будет вылетать за флуд (0 - медленно, 1 - быстро).
	set options(fast)					0
	
	################################################################################################
	# Максимальное количество строк отсылаемых нотисом, при превышении данного значения сообщение
	# будет отправлено в приват
	set options(max_msg_notice)			10
	
	################################################################################################
	# Максимальное количество строк отсылаемых в канал, при превышении данного значения сообщение
	# будет отправлено в приват
	set options(max_msg_chan)			5
	
	################################################################################################
	# Длина одного сообщения в количестве символов. Если сообщение будет превышать максимально
	# допустимое для IRCd, то оно будет разделено на несколько сообщений.
	set options(msg_len)				400
	
	################################################################################################
	# Максимальная длина идента в IRC сети. Нужна для получения правильной хостмаски бана.
	set options(identlen)				10
	
	################################################################################################
	# Разрешать вывод хелпа только по группам (1 - только по группам, 0 - общий и по группам)
	set options(help_group)				0
	
	################################################################################################
	# Уровень отладки (1 - вывод основной информации; 2, 3, ... - вывод дополнительной информации)
	set options(debug)					2
	
	################################################################################################
	# Значение по умолчанию, которое определяет, должен ли скрипт работать на всех каналах (0 - нет,
	# 1 - да). Значение может быть переопределено выставлением канального флага ccs-on_chan
	set options(on_chan)				1
	
	################################################################################################
	# Значение по умолчанию, которое определяет какая цветовая гамма, при их наличии, должна
	# использоваться для вывода. (0 - черно белая, 1 - цветная). Это же значение определяет какая
	# цветовая гамма должна использоваться для вывода текста в приват и патилайн. Значение может
	# быть переопределено выставлением канального флага ccs-usecolors
	set options(usecolors)				1
	
	################################################################################################
	# Использовать блокировку с задержкой по времени при повторном выполнении команды
	set options(use_blocktime_limit)	1
	
	################################################################################################
	# Время в миллисекундах, в течение которого удерживать авторизацию юзера, если он не зашел на
	# канал после авторизации.
	set options(time_auth_notonchan)	300000
	
	################################################################################################
	# Время в миллисекундах, в течение которого удерживать авторизацию юзера после покидании канала.
	set options(time_auth_part)			3000
	
	################################################################################################
	# Каталог, куда будут помещаться старые файлы после обновления, при этом указание $dir_ccs будет
	# соответствовать каталогу, где находиться основной скрипт.
	set options(dir_bak)				"$dir_ccs/bak"
	
	################################################################################################
	# Каталог, откуда будут читаться файлы ccs.lang.*.tcl, при этом указание $dir_ccs будет
	# соответствовать каталогу, где находиться основной скрипт.
	set options(dir_lang)				"$dir_ccs/lang"
	
	################################################################################################
	# Каталог, откуда будут читаться файлы ccs.mod.*.tcl, при этом указание $dir_ccs будет
	# соответствовать каталогу, где находиться основной скрипт.
	set options(dir_mod)				"$dir_ccs/mod"
	
	################################################################################################
	# Каталог, откуда будут читаться файлы ccs.scr.*.tcl, при этом указание $dir_ccs будет
	# соответствовать каталогу, где находиться основной скрипт.
	set options(dir_scr)				"$dir_ccs/scr"
	
	################################################################################################
	# Каталог, откуда будут читаться файлы ccs.lib.*.tcl, при этом указание $dir_ccs будет
	# соответствовать каталогу, где находиться основной скрипт.
	set options(dir_lib)				"$dir_ccs/lib"
	
	################################################################################################
	# Каталог, где будут хранится файлы данных, при этом указание $dir_ccs будет соответствовать
	# каталогу, где находиться основной скрипт.
	set options(dir_data)				"$dir_ccs/data"
	
	################################################################################################
	# Флаги пользователей. Крайне не желательно изменять их.
	# Флаг указывающий на авторизованного пользователя
	set options(flag_auth)				"Q"
	# Флаг указывающий на авторизованного пользователя через ботнет
	set options(flag_auth_botnet)		"B"
	# Временный флаг, указывающий на проверку авторизации пользователя через ботнет
	set options(flag_botnet_check)		"O"
	# Перманентная (постоянная) авторизация, не требующая ручной авторизации
	set options(flag_auth_perm)			"P"
	# Флаг защиты пользователя от изменений, только глобальный овнер сможет изменять параметры
	# пользователя (хосты, флаги)
	set options(flag_locked)			"L"
	# Флаг защиты пользователя от неправомерных действий (kick, ban итд). (Не дает полной защиты,
	# в случае если действие производиться не по хендлу)
	set options(flag_protect)			"H|H"
	# Флаг для ботов участвующие в общение (передача команд управления) через ботнете
	set options(flag_cmd_bot)			"U"
	
	################################################################################################
	# Минимальный флаг доступа к секретным каналам.
	set options(permission_secret_chan)	"m|-"
	
	################################################################################################
	# Формат времени. Может использоватся для вывода времени в различных скриптах и модулях.
	# Используемые символы подстановки и их описание можно посмотреть на сайте
	# http://www.tcl.tk/man/tcl8.5/TclCmd/clock.htm#M26
	set options(time_format)			{%d-%m-%Y %H:%M:%S}
	
	################################################################################################
	# Процедуры совместимости со старыми версиями Tcl.
	
	proc compare_version {version1 version2} {
		
		set dec1 [split $version1 .]; set dec2 [split $version2 .]
		foreach a1 $dec1 a2 $dec2 {
			if {[string is space [set a1 [string trimleft $a1 0]]]} {set a1 0}
			if {[string is space [set a2 [string trimleft $a2 0]]]} {set a2 0}
			
			if {$a2 > $a1} {return 1} elseif {$a2 < $a1} {return 0}
		}
		return 0
		
	}
	
	if {[info procs lassign] == ""} {
		proc lassign {values args} {
			set vlen [llength $values]
			set alen [llength $args]
			for {set i $vlen} {$i < $alen} {incr i} {
				lappend values {}
			}
			uplevel 1 [list foreach $args $values break]
			return [lrange $values $alen end]
		}
	}
	
	if {[compare_version [info pa] 8.5]} {
		proc in {list element} {expr [lsearch -exact $list $element] >= 0}
		proc ni {list element} {expr [lsearch -exact $list $element] < 0}
	} else {
		proc in {list element} {expr {$element in $list}}
		proc ni {list element} {expr {$element ni $list}}
	}
	
	proc ladd {varName el} {
		upvar $varName var
		if {![info exists var]} {set var {}}
		if {[ni $var $el]} {
			lappend var $el
		}
	}
	
	proc IfError {script varName errScript} {
		if {[catch {eval {uplevel "$script"}} _errMsg1]} {
			upvar $varName _errMsg2
			set _errMsg2 $_errMsg1
			eval {uplevel "$errScript"}
		}
	}
	
	################################################################################################
	# Процедуры конфигурирования.
	
	proc debug {text {level 1}} {
		variable options
		if {$options(debug) >= $level} {putlog "[namespace current]:: $text"}
	}
	
	proc Pop {varname {nth 0}} {
		upvar $varname args
		set r [lindex $args $nth]
		set args [lreplace $args $nth $nth]
		return $r
	}
	
	proc configure {args} {
		variable options
		
		if {[llength $args] < 1} {
			set r {}
			foreach opt [lsort [array names options]] {
				lappend r -$opt $options($opt)
			}
			return $r
		}
		
		if {[llength $args] == 1} {set cget 1} else {set cget 0}
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-- { Pop args; break }
				-* {
					if {$cget} {
						if {![info exists options([string range [lindex $args 0] 1 end])]} {
							set opts [join [lsort [array names options]] ", -"]
							return -code error "bad option [lindex $args 0]: must be one of -$opts"
						}
						return $options([string range [lindex $args 0] 1 end])
					} else {
						set options([string range [lindex $args 0] 1 end]) [Pop args 1]
					}
				}
				default {
					set opts [join [lsort [array names options]] ", -"]
					return -code error "bad option [lindex $args 0]: must be one of -$opts"
				}
			}
			Pop args
		}
		
		return
	}
	
	proc cmd_configure {command args} {
		variable cmd_options
		variable commands
		
		if {[string first " " $command] >= 0} {
			return -code error "command name cannot contain spaces (command: '$command', value: '$value')"
		}
		
		set opts {group use_auth use_chan use_botnet flags alias block regexp use add use_mode override_level}
		
		if {[llength $args] == 0} {
			set r [list]
			foreach opt [lsort $opts] {
				if {[info exists cmd_options($opt,$command)]} {lappend r -$opt $cmd_options($opt,$command)}
			}
			return $r
		}
		
		if {[llength $args] == 1} {set cget 1} else {set cget 0}
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-control {ladd commands(control) $command}
				-script {ladd commands(scripts) $command}
				-group {
					set opt "group"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return ""
						}
					} else {
						set value [Pop args 1]
						if {[string first " " $value] >= 0} \
							{return -code error "group name cannot contain spaces \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-use {
					set opt "use"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return 1
						}
					} else {
						set value [Pop args 1]
						if {![string is digit $value] || $value < 0 || $value > 1} \
							{return -code error "bad value, must be a digit \[0..1\] \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-use_mode {
					set opt "use_mode"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return 0
						}
					} else {
						set value [Pop args 1]
						if {![string is digit $value] || $value < 0 || $value > 1} \
							{return -code error "bad value, must be a digit \[0..1\] \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-use_auth {
					set opt "use_auth"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return 1
						}
					} else {
						set value [Pop args 1]
						if {![string is digit $value] || $value < 0 || $value > 1} \
							{return -code error "bad value, must be a digit \[0..1\] \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-use_chan {
					set opt "use_chan"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return 1
						}
					} else {
						set value [Pop args 1]
						if {![string is digit $value] || $value < 0 || $value > 3} \
							{return -code error "bad value, must be a digit \[0..3\] \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-use_botnet {
					set opt "use_botnet"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return 1
						}
					} else {
						set value [Pop args 1]
						if {![string is digit $value] || $value < 0 || $value > 1} \
							{return -code error "bad value, must be a digit \[0..1\] \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-override_level {
					set opt "override_level"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return -1
						}
					} else {
						set value [Pop args 1]
						if {![string is digit $value] || $value < 0 || $value > 9} \
							{return -code error "bad value, must be a digit \[0..9\] \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-flag* {
					set opt "flags"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return "-|-"
						}
					} else {
						set cmd_options($opt,$command) [Pop args 1]
					}
				}
				-alias* {
					set opt "alias"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return {}
						}
					} else {
						set cmd_options($opt,$command) [Pop args 1]
					}
				}
				-block {
					set opt "block"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return 0
						}
					} else {
						set value [Pop args 1]
						if {![string is integer $value] || $value < 0} \
							{return -code error "bad value, must be a digit \[0..int\] \
								(command: '$command', option '$opt', value: '$value')"}
						set cmd_options($opt,$command) $value
					}
				}
				-regexp {
					set opt "regexp"
					if {$cget} {
						if {[info exists cmd_options($opt,$command)]} {
							return $cmd_options($opt,$command)
						} else {
							return {}
						}
					} else {
						set value [Pop args 1]
						if {![string is space $value]} {
							if {[llength $value] != 2} \
								{return -code error "bad value, must be a list {{reg} {var}} \
									(command: '$command', option '$opt', value: '$value')"}
							if {[catch {regexp -- [lindex $value 0] ""} errMsg]} \
								{return -code error "bad value, first list item must be a regular \
									expression (command: '$command', option '$opt', value: '$value')"}
						}
						set cmd_options($opt,$command) $value
					}
				}
				-- {Pop args; break}
				default {
					set opts [join [lsort $opts] ", -"]
					return -code error "bad option [lindex $args 0]: must be one of -$opts"
				}
			}
			Pop args
		}
		
		return
		
	}
	
	proc set_text {args} {
		variable text
		
		set opts(-black) 0;      # признак черно белого текста
		set opts(-color) 0;      # признак цветного текста
		set opts(-type)  "text"; # тип текста: text, args, help, help2
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-black { set opts(-black) 1 }
				-color { set opts(-color) 1 }
				-type  { set opts(-type)  [Pop args 1] }
				-- { Pop args; break }
				default {
					set opt [join [lsort [array names opts -*]] ", "]
					return -code error "bad option [lindex $args 0]: must be $opt"
				}
			}
			Pop args
		}
		
		if {$opts(-black) && $opts(-color)} {
			return -code error "can't use \"-black -color\" at the same time together"
		} elseif {$opts(-black)} {
			set color "black"
		} elseif {$opts(-color)} {
			set color "color"
		} else {
			set color "black"
		}
		
		switch -- $opts(-type) {
			args - help - help2 {
				if {[llength $args] != 3} {
					return -code error "wrong # args: should be \"set_text ?switches? lang command string\""
				}
				set text($opts(-type),$color,[lindex $args 0],[lindex $args 1]) [lindex $args 2]
			}
			default {
				if {[llength $args] != 4} {
					return -code error "wrong # args: should be \"set_text ?switches? lang name tag string\""
				}
				set text($opts(-type),$color,[lindex $args 0],[lindex $args 1],[lindex $args 2]) [lindex $args 3]
			}
		}
		
		return
		
	}
	
	proc get_text {args} {
		variable text
		variable options
		
		set opts(-black) 0;      # признак черно белого текста
		set opts(-color) 0;      # признак цветного текста
		set opts(-type)  "text"; # тип текста: text, args, help, help2
		set opts(-hand)  "*";    # хендл юзера для которого выводится текст
		set opts(-chan)  "";     # канал для которого выводится текст
		set opts(-lang)  "";     # используемый язык
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-black { set opts(-black) 1 }
				-color { set opts(-color) 1 }
				-type  { set opts(-type)  [Pop args 1] }
				-hand  { set opts(-hand)  [Pop args 1] }
				-chan  { set opts(-chan)  [Pop args 1] }
				-lang  { set opts(-lang)  [Pop args 1] }
				-- { Pop args; break }
				default {
					set opt [join [lsort [array names opts -*]] ", "]
					return -code error "bad option [lindex $args 0]: must be $opt"
				}
			}
			Pop args
		}
		
		if {$opts(-black) && $opts(-color)} {
			return -code error "can't use \"-black -color\" at the same time together"
		} elseif {$opts(-black)} {
			set colors {black}
		} elseif {$opts(-color)} {
			set colors {color}
		} else {
			if {[get_options_int usecolors $opts(-chan)]} {
				set colors {color black}
			} else {
				set colors {black color}
			}
		}
		
		if {$opts(-lang) == ""} {
			set langs [list]
			if {![check_isnull $opts(-hand)]} {
				foreach _ [getuser $opts(-hand) XTRA ccs-default_lang] {
					if {[string is space $_]} continue
					ladd langs $_
				}
			}
			if {![check_isnull $opts(-chan)] && [validchan $opts(-chan)]} {
				foreach _ [channel get $opts(-chan) ccs-default_lang] {
					if {[string is space $_]} continue
					ladd langs $_
				}
			}
			if {[info exists options(default_lang)]} {
				foreach _ $options(default_lang) {
					if {[string is space $_]} continue
					ladd langs $_
				}
			}
		} else {
			set langs $opts(-lang)
		}
		
		switch -- $opts(-type) {
			args - help - help2 {
				if {[llength $args] != 1} {
					return -code error "wrong # args: should be \"get_text ?switches? command\""
				}
				foreach color $colors {
					foreach lang $langs {
						if {[info exists text($opts(-type),$color,$lang,[lindex $args 0])]} {
							return $text($opts(-type),$color,$lang,[lindex $args 0])
						}
					}
				}
			}
			default {
				if {[llength $args] != 2} {
					return -code error "wrong # args: should be \"get_text ?switches? name tag\""
				}
				foreach color $colors {
					foreach lang $langs {
						if {[info exists text($opts(-type),$color,$lang,[lindex $args 0],[lindex $args 1])]} {
							return $text($opts(-type),$color,$lang,[lindex $args 0],[lindex $args 1])
						}
					}
				}
			}
		}
		
		return "null"
		
	}
	
	proc get_aliases {args} {
		variable options
		
		set opts(-type)            ""; # тип возвращаемых алиасов команды
		set opts(-backslash)       0;  # экранирование ключевых знаков
		set opts(-required_prefix) 0;  # обязательность присутствия префикса у алиаса
		
		if {[llength $args] > 1} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-type            { set opts(-type)            [Pop args 1] }
					-backslash       { set opts(-backslash)       [Pop args 1] }
					-required_prefix { set opts(-required_prefix) [Pop args 1] }
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
			return -code error "wrong # args: should be \"get_aliases ?switches? command\""
		}
		
		set command [lindex $args 0]
		
		switch -exact -- $opts(-type) {
			all           { set lp [list $options(prefix_pub) $options(prefix_msg) \
							$options(prefix_dcc) $options(prefix_botnet_pub) \
							$options(prefix_botnet_msg) $options(prefix_botnet_dcc) ""] }
			pub           { set lp [list $options(prefix_pub)] }
			chan - notice { set lp [list $options(prefix_pub)] }
			msg           { set lp [list $options(prefix_msg)] }
			dcc           { set lp [list $options(prefix_dcc)] }
			botnet_pub    { set lp [list $options(prefix_botnet_pub)] }
			botnet_msg    { set lp [list $options(prefix_botnet_msg)] }
			botnet_dcc    { set lp [list $options(prefix_botnet_dcc)] }
			default       { set lp [list ""] }
		}
		
		set r [list]
		foreach pref $lp {
			foreach alias [cmd_configure $command -alias] {
				if {$opts(-required_prefix) && [string first %pref_ $alias] < 0} continue
				set alias [string map [list %pref_ $pref] $alias]
				if {$opts(-backslash)} {set alias [string map [list * \\* % \\% ~ \\~] $alias]}
				lappend r $alias
			}
		}
		return $r
		
	}
	
	# Функция получения помощи по команде
	proc get_help {args} {
		variable options
		variable group
		
		set opts(-type)    "msg"; # направление вывода сообщения
		set opts(-hand)    "*";   # хендл юзера для которого выводится текст
		set opts(-chan)    "";    # канал для которого выводится текст
		set opts(-detail)  0;     # выводить детализированную помощь
		set opts(-access)  1;     # выводить флаги доступа
		set opts(-aliases) 1;     # выводить алиасы
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-type    { set opts(-type)    [Pop args 1] }
				-hand    { set opts(-hand)    [Pop args 1] }
				-chan    { set opts(-chan)    [Pop args 1] }
				-detail  { set opts(-detail)  [Pop args 1] }
				-access  { set opts(-access)  [Pop args 1] }
				-aliases { set opts(-aliases) [Pop args 1] }
				-- { Pop args; break }
				default {
					set opt [join [lsort [array names opts -*]] ", "]
					return -code error "bad option [lindex $args 0]: must be $opt"
				}
			}
			Pop args
		}
		if {[llength $args] != 1} {
			return -code error "wrong # args: should be \"get_help ?switches? command\""
		}
		
		set command [lindex $args 0]
		
		set r {}
		set t {}
		
		set aliases [get_aliases -type $opts(-type) -- $command]
		
		lappend t "\002[lindex $aliases 0]"
		
		switch -exact -- $opts(-type) {
			dcc {
				switch -exact -- [cmd_configure $command -use_chan] {
					1 {lappend t "<chan>"}
					2 {lappend t "<chan|*>"}
					3 {lappend t "\[chan\]"}
				}
				set prefix $options(prefix_dcc)
			}
			msg {
				switch -exact -- [cmd_configure $command -use_chan] {
					1 {lappend t "<chan>"}
					2 {lappend t "<chan|*>"}
					3 {lappend t "\[chan\]"}
				}
				set prefix $options(prefix_msg)
			}
			notice - chan {
				set prefix $options(prefix_pub)
			}
		}
		
		set args [get_text -hand $opts(-hand) -chan $opts(-chan) -type args -- $command]
		lappend t "[expr {[string is space $args] ? "" : "$args"}]\002"
		
		if {$opts(-detail)} {
			set help2 [get_text -hand $opts(-hand) -chan $opts(-chan) -type help2 -- $command]
		} else {
			set help2 "null"
		}
		
		if {$help2 == "null"} {
			set help [get_text -hand $opts(-hand) -chan $opts(-chan) -type help -- $command]
			lappend t "- [string map [list %pref_ $prefix %botnick $::botnick %groups [join $group ", "]] $help]."
		}
		
		if {$opts(-aliases)} {if {[llength $aliases] > 1} {lappend t [sprintf ccs #185 [join [lrange $aliases 1 end] ", "]]}}
		if {$opts(-access)} {lappend t [sprintf ccs #186 [join [cmd_configure $command -flags] ", "]]}
		
		lappend r [join $t]
		if {$help2 != "null"} {
			foreach _ $help2 {
				lappend r [string map [list %pref_ $prefix %botnick $::botnick %groups [join $group ", "]] $_]
			}
		}
		return $r
		
	}
	
	proc StrNick {args} {
		variable options
		
		set opts(-nick)        "";     # ник
		set opts(-hand)        "*";    # хендл
		set opts(-prefix)      "\002"; # перфикс вставляемый до и после ника/хендла
		set opts(-leftprefix)  "";     # перфикс вставляемый до ника/хендла
		set opts(-rightprefix) "";     # перфикс вставляемый после ника/хендла
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-nick        { set opts(-nick)        [Pop args 1] }
				-hand        { set opts(-hand)        [Pop args 1] }
				-prefix      { set opts(-prefix)      [Pop args 1] }
				-leftprefix  { set opts(-leftprefix)  [Pop args 1] }
				-rightprefix { set opts(-rightprefix) [Pop args 1] }
				-- { Pop args; break }
				default {
					set opt [join [lsort [array names opts -*]] ", "]
					return -code error "bad option [lindex $args 0]: must be $opt"
				}
			}
			Pop args
		}
		
		if {$opts(-nick) == "" && ($opts(-hand) != "" && $opts(-hand) != "*")} {
			set opts(-nick) [hand2nick $opts(-hand)]
		} elseif {$opts(-nick) != "" && ($opts(-hand) == "" || $opts(-hand) == "*")} {
			set opts(-hand) [nick2hand $opts(-nick)]
		}
		
		if {$opts(-leftprefix) != ""} {
			set leftprefix $opts(-leftprefix)
		} else {
			set leftprefix $opts(-prefix)
		}
		if {$opts(-rightprefix) != ""} {
			set rightprefix $opts(-rightprefix)
		} else {
			set rightprefix $opts(-prefix)
		}
		
		if {$opts(-nick) != "" && ($opts(-hand) != "" && $opts(-hand) != "*")} {
			if {$opts(-nick) == $opts(-hand)} {
				return "$leftprefix$opts(-nick)$rightprefix"
			} else {
				return "$leftprefix$opts(-nick)$rightprefix ($leftprefix$opts(-hand)$rightprefix)"
			}
		} elseif {$opts(-nick) != "" && ($opts(-hand) == "" || $opts(-hand) == "*")} {
			return "$leftprefix$opts(-nick)$rightprefix"
		} elseif {$opts(-nick) == "" && ($opts(-hand) != "" && $opts(-hand) != "*")} {
			return "$leftprefix$opts(-hand)$rightprefix"
		} else {
			return ""
		}
		
	}
	
	proc get_randcode {args} {
		
		set opts(-length)  3; # длина генерируемого кода
		set opts(-ualpha)  0; # использование алфавита верхнего регистра в коде
		set opts(-lalpha)  0; # использование алфавита нижнего регистра в коде
		set opts(-alpha)   0; # использование алфавита верхнего и нижнего регистра в коде
		set opts(-numeric) 0; # использование цифр в коде
		
		set j 0
		
		if {[llength $args] > 1} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-alpha   {
						set j 1
						if {[string match -* [lindex $args 1]] || [llength $args] == 1} {
							set opts(-alpha) 1
						} else {
							set opts(-alpha) [Pop args 1]
						}
					}
					-lalpha  {
						set j 1
						if {[string match -* [lindex $args 1]] || [llength $args] == 1} {
							set opts(-lalpha) 1
						} else {
							set opts(-lalpha) [Pop args 1]
						}
					}
					-ualpha  {
						set j 1
						if {[string match -* [lindex $args 1]] || [llength $args] == 1} {
							set opts(-ualpha) 1
						} else {
							set opts(-ualpha) [Pop args 1]
						}
					}
					-numeric {
						set j 1
						if {[string match -* [lindex $args 1]] || [llength $args] == 1} {
							set opts(-numeric) 1
						} else {
							set opts(-numeric) [Pop args 1]
						}
					}
					-length  { set opts(-length) [Pop args 1] }
					-- { Pop args; break }
					default {
						set opt [join [lsort [array names opts -*]] ", "]
						return -code error "bad option [lindex $args 0]: must be $opt"
					}
				}
				Pop args
			}
		}
		
		if {[llength $args] != 0} {
			return -code error "wrong # args: should be \"get_randcode ?switches?\""
		}
		
		if {!$opts(-alpha) && !$opts(-ualpha) && !$opts(-lalpha) && !$opts(-numeric)} {
			if {!$j} {
				set opts(-alpha)   1
				set opts(-numeric) 1
			} else {
				return -code error "wrong # args: at least one option (-alpha, -lalpha, -ualpha, -numeric) must be enabled"
			}
		}
		
		if {$opts(-alpha)} {
			set opts(-ualpha) 1
			set opts(-lalpha) 1
		}
		
		set randcount 0
		if {$opts(-ualpha)}  {incr randcount 26}
		if {$opts(-lalpha)}  {incr randcount 26}
		if {$opts(-numeric)} {incr randcount 10}
		
		# | -- numeric (10) -- | -- ualpha (26) -- | -- lalpha (26) -- |
		set code ""
		for {set x 0} {$x < $opts(-length)} {incr x} {
			
			set ind [expr int(rand()*$randcount)]
			
			set disnumeric 0
			set disualpha  0
			set dislalpha  0
			
			if {$opts(-numeric)} {
				incr disualpha 10
				incr dislalpha 10
			}
			if {$opts(-ualpha)} {
				incr dislalpha 26
			}
			
			if {$opts(-numeric) && [expr $ind-$disnumeric] >= 0 && [expr $ind-$disnumeric] < 10} {
				append code [expr $ind-$disnumeric]
			} elseif {$opts(-ualpha) && [expr $ind-$disualpha] >= 0 && [expr $ind-$disualpha] < 26} {
				append code [format %c [expr $ind-$disualpha+65]]
			} elseif {$opts(-lalpha) && [expr $ind-$dislalpha] >= 0 && [expr $ind-$dislalpha] < 26} {
				append code [format %c [expr $ind-$dislalpha+97]]
			}
			
		}
		
		return $code
		
	}
	
	proc get_token {name} {
		variable tokens
		
		set id 1
		while {[info exists tokens($name$id)]} {incr id}
		set tokens($name$id) 1
		return "$name$id"
		
	}
	
	proc cleanup_token {token} {
		variable tokens
		
		if {[info exists tokens($token)]} {
			unset tokens($token)
			return 1
		}
		return 0
		
	}
	
	proc LoadFile {args} {
		
		set opts(-list)      0;    # признак указывающий на формирование списка
		set opts(-charsplit) "\n"; # символ по которому данные делятся на список
		set opts(-access)    "r";  # доступ открытия файла
		set opts(-binary)    0;    # чтение бинарных файлов
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-list      { set opts(-list)      1 }
				-charsplit { set opts(-charsplit) [Pop args 1] }
				-binary    { set opts(-binary)    [Pop args 1] }
				-- { Pop args ; break }
				default {
					set opt [join [lsort [array names opts -*]] ", "]
					return -code error "bad option [lindex $args 0]: must be $opt"
				}
			}
			Pop args
		}
		if {[llength $args] != 1} {
			return -code error "wrong # args: should be \"LoadFile ?switches? file\""
		}
		lassign $args file
		
		if {[catch {
			set fid [open $file $opts(-access)]
			if {$opts(-binary)} {fconfigure $fid -translation binary}
			set data [read $fid]
			close $fid
		} errMsg]} {
			debug "can't load file (data): \002$file\002"
			debug "($errMsg)"
			return -code error -errorinfo $::errorInfo $errMsg
		}
		
		if {$opts(-list)} {set data [split $data $opts(-charsplit)]}
		return $data
		
	}
	
	proc SaveFile {args} {
		
		set opts(-list)   0;   # признак указывающий на запись строк из списка
		set opts(-backup) 0;   # признак указывающий на формирование бекапа файла перед его записью
		set opts(-access) "w"; # доступ записи файла
		set opts(-binary) 0;   # запись бинарных файлов
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-list   { set opts(-list)   1 }
				-backup { set opts(-backup) [Pop args 1] }
				-access { set opts(-access) [Pop args 1] }
				-binary { set opts(-binary) [Pop args 1] }
				-- { Pop args; break }
				default {
					set opt [join [lsort [array names opts -*]] ", "]
					return -code error "bad option [lindex $args 0]: must be $opt"
				}
			}
			Pop args
		}
		if {[llength $args] != 2} {
			return -code error "wrong # args: should be \"SaveFile ?switches? file data\""
		}
		lassign $args file data
		
		catch {file mkdir [file dirname $file]}
		if {[catch {
			if {$opts(-backup) && [file exists $file]} {
				variable options
				catch {file mkdir $options(dir_bak)}
				file rename $file "$options(dir_bak)/[get_filename $file]~bak[clock format [unixtime] -format %y%m%d%H%M%S]"
			}
			set fileio [open $file $opts(-access)]
			if {$opts(-binary)} {fconfigure $fileio -translation binary}
			if {$opts(-list)} {
				foreach _ $data {puts $fileio $_}
			} else {
				puts $fileio $data
			}
			flush $fileio
			close $fileio
		} errMsg]} {
			debug "can't write file (data): \002$file\002"
			debug "($errMsg)"
			return -code error -errorinfo $::errorInfo $errMsg
		}
		return -code ok
		
	}
	
	################################################################################################
	# Процедуры блокировки по времени
	proc limit {id command {time 1} {include 0}} {
		variable limit
		if {[info exists limit($id,$command)]} {return 1}
		if {![info exists limit($id,$command)] && $include} {
			set limit($id,$command) [list [after [expr $time*1000] [list [namespace origin limit_unset] $id $command]] [clock seconds] $time]
		}
		return 0
	}
	
	proc limit_exp_time {id command} {
		variable limit
		if {![info exists limit($id,$command)]} {return 0}
		return [expr [lindex $limit($id,$command) 1] + [lindex $limit($id,$command) 2] - [clock seconds]]
	}
	
	proc limit_unset {id command} {
		variable limit
		if {[info exists limit($id,$command)]} {unset limit($id,$command)}
	}
	
	################################################################################################
	# Процедуры авторизации пользователей (AUTH).
	
	# Процедура авторизации по нику/хендлу
	proc addauth {hand nick host} {
		variable options
		
		set authnick [getuser $hand XTRA AuthNick]
		if {[in $authnick "$nick!$host"]} {return 0}
		lappend authnick $nick!$host
		setuser $hand XTRA AuthNick $authnick
		chattr $hand +$options(flag_auth)
		return 1
		
	}
	
	# Процедура снятия авторизации по нику/хендлу
	proc delauth {hand nick host} {
		variable options
		
		set authnick [getuser $hand XTRA AuthNick]
		if {[set ind [lsearch -exact $authnick $nick!$host]] < 0} {return 0}
		set authnick [lreplace $authnick $ind $ind]
		setuser $hand XTRA AuthNick $authnick
		if {[llength $authnick] == 0} {chattr $hand -$options(flag_auth)}
		return 1
		
	}
	
	proc msg_identauth {nick uhost hand text} {
		variable options
		
		set snick $nick
		set shand $hand
		set shost $uhost
		set schan ""
		set text  [string trim $text]
		set command "IDENTAUTH"
		
		set out(nick)  $nick
		set out(idx)   ""
		set out(chan)  ""
		set out(bot)   ""
		set out(hand)  $hand
		set out(thand) ""
		
		if {![check_isnull $shand]} {
			put_msg -type notice -return 0 -- [sprintf ccs #112 [StrNick -nick $snick -hand $shand]]
		}
		if {![regexp -- {^(?:([^\ ]*)\s+)?([^\ ]+)$} $text -> dhand pass]} {
			put_msg -type notice -return 0 -- [sprintf ccs #114 $::botnick]
		}
		
		if {[check_isnull $dhand]} {set dhand $snick}
		if {![validuser $dhand]} {
			put_msg -type notice -return 0 -- [sprintf ccs #123 $dhand]
		}
		if {![passwdok $dhand $pass]} {
			put_log "(\0034unsuccessfull\003)"
			put_msg -type notice -return 0 -- [sprintf ccs #132 [StrNick -nick $snick -hand $shand]]
		}
		
		if {${::strict-host} == 0} {
			set hm "$snick![regsub {^~} $shost {}]"
		} else {
			set hm "$snick!$shost"
		}
		setuser $dhand HOSTS $hm
		set shand $dhand
		set out(hand) $dhand
		
		if {![addauth $shand $snick $shost]} {
			put_msg -type notice -return 0 -- [sprintf ccs #130]
		}
		if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsaddauth $snick $shost $::network}
		
		if {![onchan $snick]} {
			after $options(time_auth_notonchan) [list [namespace origin autoauthoff] $snick $uhost $shand 0]
		}
		put_log "ON"
		put_msg -type notice -return 0 -- [sprintf ccs #131 [StrNick -nick $snick -hand $shand] \
			$options(prefix_pub) $options(prefix_msg) $options(prefix_dcc) \
			$options(prefix_botnet_pub) $options(prefix_botnet_msg) $options(prefix_botnet_dcc)]
		
	}
	
	# авторизация и удаление авторизации через команду, поралельно идет рассылка по ботнету
	proc msg_auth {nick uhost hand text} {
		variable options
		variable procs_auth
		
		set snick $nick
		set shand $hand
		set shost $uhost
		set schan ""
		set text [string trim $text]
		set command "AUTH"
		
		set out(nick)  $nick
		set out(idx)   ""
		set out(chan)  ""
		set out(bot)   ""
		set out(hand)  $hand
		set out(thand) ""
		
		if {[info exists procs_auth]} {
			foreach _ $procs_auth {if {[proc_exists $_]} {catch {$_ $nick $uhost $hand $text}}}
		}
		
		if {[check_isnull $shand]} {
			put_msg -type notice -return 0 -- [sprintf ccs #127]
		}
		if {![regexp -- {^([^\ ]*)$} $text -> pass]} {
			put_msg -type notice -return 0 -- [sprintf ccs #121 $::botnick]
		}
		
		if {$pass == ""} {
			
			if {![delauth $shand $snick $shost]} {
				put_msg -type notice -return 0 -- [sprintf ccs #128]
			}
			if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsdelauth $snick $shost $::network 1}
			put_log "OFF"
			put_msg -type notice -- [sprintf ccs #129 [StrNick -nick $snick -hand $shand]]
			
		} else {
			
			if {[passwdok $shand -]} {
				put_msg -type notice -return 0 -- [sprintf ccs #212 [StrNick -nick $snick -hand $shand] $::botnick]
			}
			if {![passwdok $shand $pass]} {
				put_log "(\0034unsuccessfull\003)"
				put_msg -type notice -return 0 -- [sprintf ccs #132 [StrNick -nick $snick -hand $shand]]
			}
			if {![addauth $shand $snick $shost]} {
				put_msg -type notice -return 0 -- [sprintf ccs #130]
			}
			if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsaddauth $snick $shost $::network}
			
			if {![onchan $snick]} {
				after $options(time_auth_notonchan) [list [namespace origin autoauthoff] $snick $uhost $shand 0]
			}
			put_log "ON"
			put_msg -type notice -- [sprintf ccs #131 [StrNick -nick $snick -hand $shand] \
				$options(prefix_pub) $options(prefix_msg) $options(prefix_dcc) \
				$options(prefix_botnet_pub) $options(prefix_botnet_msg) $options(prefix_botnet_dcc)]
			
		}
		return 0
		
	}
	
	proc nick_auth {nick uhost hand chan newnick} {
		
		set snick $nick
		set shand $hand
		set shost $uhost
		set schan ""
		set command "AUTH"
		
		set out(nick)  $newnick
		set out(idx)   ""
		set out(chan)  ""
		set out(bot)   ""
		set out(hand)  $hand
		set out(thand) ""
		
		if {[nick2hand $newnick] != $shand} {
			if {![delauth $shand $snick $shost]} {return 0}
			if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsdelauth $snick $shost $::network 0}
			put_log "OFF"
			put_msg -type notice -- [sprintf ccs #211]
		} else {
			set authnick [getuser $shand XTRA AuthNick]
			set ind [lsearch -exact $authnick $snick!$shost]
			if {$ind < 0} {return 0}
			lset authnick $ind $newnick!$shost
			setuser $shand XTRA AuthNick $authnick
		}
		
	}
	
	# бинд срабатывающий при выходе юзера с канала
	proc part_auth {nick uhost hand chan text} {
		variable options
		after $options(time_auth_part) [list [namespace origin autoauthoff] $nick $uhost $hand 0]
	}
	
	proc kick_auth {nick uhost hand chan target reason} {
		variable options
		after $options(time_auth_part) [list [namespace origin autoauthoff] $target [getchanhost $target] [nick2hand $target] 0]
	}
	
	# бинд срабатывающий при выходе юзера из ирц
	proc sign_auth {nick uhost hand chan text} {
		variable options
		after $options(time_auth_part) [list [namespace origin autoauthoff] $nick $uhost $hand 1]
	}
	
	proc splt_auth {nick uhost hand chan} {
		variable options
		after $options(time_auth_part) [list [namespace origin autoauthoff] $nick $uhost $hand 1]
	}
	
	# снятие авторизации при выходе юзера, так же рассылка в ботнет о снятии авторизации
	proc autoauthoff {snick shost shand quiet} {
		
		set schan ""
		set command "AUTOAUTH"
		
		set out(nick)  $snick
		set out(idx)   ""
		set out(chan)  ""
		set out(bot)   ""
		set out(hand)  $shand
		set out(thand) ""
		
		if {[onchan $snick]} {return 0}
		if {![delauth $shand $snick $shost]} {return 0}
		if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsdelauth $snick $shost $::network 0}
		put_log "OFF"
		if {!$quiet} {put_msg -type notice -- [sprintf ccs #126]}
		
	}
	
	# Функция проверки авторизации
	proc check_auth {snick shand shost {sidx ""} {sbot ""}} {
		variable options
		
		if {[valididx $sidx]} {
			return 1
		}
		if {[string is space $sbot] && [matchattr $shand $options(flag_auth_perm)]} {
			return 1
		}
		if {[matchattr $shand $options(flag_auth)] && \
			[in [getuser $shand XTRA AuthNick] "$snick!$shost"]} {
			return 1
		}
		if {![string is space $sbot] && [matchattr $shand $options(flag_auth_botnet)] && \
			[in [getuser $shand XTRA AuthBot] $sbot]} {
			return 1
		}
		upvar out out
		put_msg -type notice -- [sprintf ccs #120]
		put_msg -type notice -- [sprintf ccs #121 $::botnick]
		return 0
		
	}
	
	################################################################################################
	# Процедуры вывода сообщений
	
	proc put_log {args} {
		importvars [list snick shand schan command]
		
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
		
		if {$upreturn} {return -code return $opts(-return)}
		
	}
	
	proc put_help {args} {
		upvar out out command command
		
		set opts(-return) ""; # выход из процедуры после вывода сообщения
		if {[info exists out(chan)]} { set opts(-chan)    $out(chan) } else { set opts(-chan)    "" }
		if {[info exists out(hand)]} { set opts(-hand)    $out(hand) } else { set opts(-hand)    "" }
		if {[info exists command]}   { set opts(-command) $command   } else { set opts(-command) "" }
		
		set upreturn 0
		
		if {[llength $args] > 1} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-return  { set opts(-return)  [Pop args 1]; set upreturn 1 }
					-chan    { set opts(-chan)    [Pop args 1] }
					-hand    { set opts(-hand)    [Pop args 1] }
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
		
		if {[llength $args] != 0} {
			return -code error "wrong # args: should be \"put_help ?switches?\""
		}
		
		set type [get_autotype]
		put_msg -type $type -speed 3 -list -notice2msg -- [get_help -type $type -detail 1 -hand $opts(-hand) -chan $opts(-chan) -- $opts(-command)]
		
		if {$upreturn} {return -code return $opts(-return)}
		
	}
	
	proc get_autotype {args} {
		upvar out out
		
		if {[info exists out(nick)]} { set opts(-nick) $out(nick) } else { set opts(-nick) "" }
		if {[info exists out(chan)]} { set opts(-chan) $out(chan) } else { set opts(-chan) "" }
		if {[info exists out(idx)]}  { set opts(-idx)  $out(idx)  } else { set opts(-idx)  "" }
		
		if {[llength $args] > 1} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-nick { set opts(-nick) [Pop args 1] }
					-chan { set opts(-chan) [Pop args 1] }
					-idx  { set opts(-idx)  [Pop args 1] }
					-- { Pop args; break }
					default {
						set opt [join [lsort [array names opts -*]] ", "]
						return -code error "bad option [lindex $args 0]: must be $opt"
					}
				}
				Pop args
			}
		}
		
		if {[llength $args] != 0} {
			return -code error "wrong # args: should be \"get_autotype ?switches?\""
		}
		
		if {$opts(-idx) != ""} {
			return "dcc"
		} elseif {$opts(-chan) == "" && $opts(-nick) != ""} {
			return "msg"
		} elseif {$opts(-chan) != "" && $opts(-nick) != ""} {
			return "notice"
		} elseif {$opts(-chan) != "" && $opts(-nick) == ""} {
			return "chan"
		}
		return "none"
		
	}
	
	proc put_msg {args} {
		upvar out out
		variable options
		
		set opts(-list)       0;  # текст передается списком
		set opts(-notice2msg) 0;  # если количество строк нотисом превышает допустимое то сообщение будет отправленно в приват
		set opts(-chan2msg)   0;  # если количество строк в канал превышает допустимое то сообщение будет отправленно в приват
		set opts(-type)       ""; # направление вывода сообщения
		set opts(-speed)      2;  # скорость очереди, в которой будет выведен текст
		set opts(-return)     ""; # выход из процедуры после вывода сообщения
		if {[info exists out(nick)]}  { set opts(-nick)  $out(nick)  } else { set opts(-nick)  "" }
		if {[info exists out(chan)]}  { set opts(-chan)  $out(chan)  } else { set opts(-chan)  "" }
		if {[info exists out(idx)]}   { set opts(-idx)   $out(idx)   } else { set opts(-idx)   "" }
		if {[info exists out(bot)]}   { set opts(-bot)   $out(bot)   } else { set opts(-bot)   "" }
		if {[info exists out(hand)]}  { set opts(-hand)  $out(hand)  } else { set opts(-hand)  "" }
		if {[info exists out(thand)]} { set opts(-thand) $out(thand) } else { set opts(-thand) "" }
		
		set upreturn 0
		
		if {[llength $args] > 1} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-list       {
						if {[string match -* [lindex $args 1]]} {
							set opts(-list) 1
						} else {
							set opts(-list) [Pop args 1]
						}
					}
					-notice2msg {
						if {[string match -* [lindex $args 1]]} {
							set opts(-notice2msg) 1
						} else {
							set opts(-notice2msg) [Pop args 1]
						}
					}
					-chan2msg   {
						if {[string match -* [lindex $args 1]]} {
							set opts(-chan2msg) 1
						} else {
							set opts(-chan2msg) [Pop args 1]
						}
					}
					-type       { set opts(-type)   [Pop args 1] }
					-speed      { set opts(-speed)  [Pop args 1] }
					-nick       { set opts(-nick)   [Pop args 1] }
					-chan       { set opts(-chan)   [Pop args 1] }
					-idx        { set opts(-idx)    [Pop args 1] }
					-bot        { set opts(-bot)    [Pop args 1] }
					-hand       { set opts(-hand)   [Pop args 1] }
					-thand      { set opts(-thand)  [Pop args 1] }
					-return     { set opts(-return) [Pop args 1]; set upreturn 1 }
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
			return -code error "wrong # args: should be \"put_msg ?switches? text\""
		}
		
		set text [lindex $args 0]
		
		if {![string is space $opts(-bot)]} {
			#if {[proc_exists "send_ccstext"]} {send_ccstext $opts(-bot) $opts(-hand) $text}
			if {[proc_exists "put_msg_bot"]} {
				put_msg_bot -list     $opts(-list)     -notice2msg $opts(-notice2msg) \
				            -chan2msg $opts(-chan2msg) -type       $opts(-type) \
				            -nick     $opts(-nick)     -chan       $opts(-chan) \
				            -idx      $opts(-idx)      -bot        $opts(-bot) \
				            -hand     $opts(-hand)     -thand      $opts(-thand) \
				            -- $text
			}
			if {$upreturn} {return -code return $opts(-return)} else {return}
		}
		
		if {$opts(-type) == ""} {
			set opts(-type) [get_autotype -nick $opts(-nick) -chan $opts(-chan) -idx $opts(-idx)]
		}
		
		switch -exact -- $opts(-type) {
			dcc {
				if {![string is space $opts(-idx)]} {
					if {$opts(-list)} {
						foreach _ $text {put_msgdest -type dcc -- $opts(-idx) $_}
					} else {
						put_msgdest -type dcc -- $opts(-idx) $text
					}
				}
			}
			msg {
				if {![string is space $opts(-nick)]} {
					if {$opts(-list)} {
						foreach _ $text {put_msgdest -speed $opts(-speed) -type privmsg -- $opts(-nick) $_}
					} else {
						put_msgdest -speed $opts(-speed) -type privmsg -- $opts(-nick) $text
					}
				}
			}
			notice {
				if {![string is space $opts(-nick)]} {
					if {$opts(-list)} {
						if {$opts(-notice2msg) && [llength $text] > $options(max_msg_notice)} {
							foreach _ $text {put_msgdest -speed $opts(-speed) -type privmsg -- $opts(-nick) $_}
						} else {
							foreach _ $text {put_msgdest -speed $opts(-speed) -type notice -- $opts(-nick) $_}
						}
					} else {
						put_msgdest -speed $opts(-speed) -type notice -- $opts(-nick) $text
					}
				}
			}
			chan {
				if {![string is space $opts(-chan)]} {
					if {$opts(-list)} {
						if {$opts(-chan2msg) && [llength $text] > $options(max_msg_chan) && ![string is space $opts(-nick)]} {
							foreach _ $text {put_msgdest -speed $opts(-speed) -type privmsg -- $opts(-nick) $_}
						} else {
							foreach _ $text {put_msgdest -speed $opts(-speed) -type privmsg -- $opts(-chan) $_}
						}
					} else {
						put_msgdest -speed $opts(-speed) -type privmsg -- $opts(-chan) $text
					}
				}
			}
		}
		
		if {$upreturn} {return -code return $opts(-return)}
		
	}
	
	proc put_msgdest {args} {
		variable options
		
		set opts(-type)  "privmsg"; # направление вывода сообщения
		set opts(-speed) 2;         # скорость очереди, в которой будет выведен текст
		
		if {[llength $args] > 2} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-type  { set opts(-type)  [Pop args 1] }
					-speed { set opts(-speed) [Pop args 1] }
					-- { Pop args; break }
					default {
						set opt [join [lsort [array names opts -*]] ", "]
						return -code error "bad option [lindex $args 0]: must be $opt"
					}
				}
				Pop args
			}
		}
		
		if {[llength $args] != 2} {
			return -code error "wrong # args: should be \"put_msgdest ?switches? dest text\""
		}
		
		set dest [lindex $args 0]
		set text [lindex $args 1]
		
		set text [string map [list {\002} "\002" {\037} "\037" {\026} "\026" {\003} "\003" {\017} "\017"] $text]
		
		set list_out [list]
		
		if {[string length $text] <= $options(msg_len)} {
			lappend list_out $text
		} else {
			
			set str_out ""
			set str_color ""
			set new 1
			
			set reg_color  {(\003\d{1,2}(?:,\d{1,2})?|\003|\037|\026|\017|\002|\d{1,2}(?:,\d{1,2})?|||||)}
			set reg_dcolor {|\037\037||\002\002||\026\026}
			set reg_ccolor {[\017](.*?)$}
			
			foreach _0 [split $text] {
				
				if {$new} {set _1 $_0; set new 0} else {set _1 " $_0"}
				
				if {[string length "$_0"] > $options(msg_len)} {
					# слово больше длины строки, чтобы не терять место прибавляем к прошлой строке и начинаем дробить
					set str_tmp "$str_out$_1"
					while {[string length $str_tmp] > $options(msg_len)} {
						set str_out [string range "$str_color$str_tmp" 0 [expr $options(msg_len)-1]]
						set str_tmp [string range "$str_color$str_tmp" $options(msg_len) end]
						lappend list_out "$str_color$str_out"
						foreach {block color} [regexp -all -inline -- $reg_color $str_out] {
							append str_color $color
						}
						while {[regexp -all -- $reg_ccolor $str_color -> str_color]} {}
						regsub -all -- $reg_dcolor $str_color {} str_color
					}
					set str_out $str_tmp
				} elseif {[string length "$str_color$str_out$_1"] > $options(msg_len)} {
					# новое слово не влезает в строку, выводим то что есть
					lappend list_out "$str_color$str_out"
					foreach {block color} [regexp -all -inline -- $reg_color $str_out] {
						append str_color $color
					}
					while {[regexp -all -- $reg_ccolor $str_color -> str_color]} {}
					regsub -all -- $reg_dcolor $str_color {} str_color
					set str_out $_0
				} else {
					append str_out $_1
				}
				
			}
			
			if {![string is space $str_out]} {lappend list_out "$str_color$str_out"}
			
		}
		
		if {$opts(-type) == "privmsg"} {
			set put_out "PRIVMSG [join $dest ","] :"
		} elseif {$opts(-type) == "notice"} {
			set put_out "NOTICE [join $dest ","] :"
		} elseif {$opts(-type) == "dcc" && [valididx $dest]} {
			set put_out ""
		} else {
			return
		}
		
		foreach _ $list_out {
			set msg $put_out$_
			if {$opts(-type) == "dcc"} {
				putdcc $dest $msg
			} elseif {$options(fast) || $opts(-speed) == 0} {
				append msg "\n"
				putdccraw 0 [string length $msg] $msg
			} elseif {$opts(-speed) == 1} {
				putquick $msg
			} elseif {$opts(-speed) == 2} {
				putserv $msg
			} elseif {$opts(-speed) == 3} {
				puthelp $msg
			}
		}
		
	}
	
	proc sprintf {name text args} {
		
		if {[string index $text 0] == "#"} {
			importvars [list shand schan]
			if {![info exists schan]} {set schan "*"}
			set textlang [get_text -hand $shand -chan $schan -- $name $text]
			if {$textlang == "null"} {
				return "Module \002$name\002, text \002$text\002 not found. Args: [join $args ", "]"
			} else {
				set text $textlang
			}
		}
		set ind 0
		set first [string first "%s" $text]
		while {$first >= 0} {
			set text [string replace $text $first [expr $first+1] [lindex $args $ind]]
			set first [string first "%s" $text [expr $first+[string length [lindex $args $ind]]]]
			incr ind
		}
		return $text
		
	}
	
	################################################################################################
	# Дополнительные процедуры и функции.
	
	proc proc_exists {name} {
		if {[info procs $name] == ""} {return 0} else {return 1}
	}
	
	proc get_dirname {name} {
		return [string range $name 0 [expr [string last "/" $name]-1]]
	}
	
	proc get_filename {name} {
		return [string range $name [expr [string last "/" $name]+1] end]
	}
	
	# Функция получения хостмаски из хоста
	proc get_mask {uhost ind} {
		variable options
		
		set a [string first ! $uhost]
		set b [string first @ $uhost]
		set nick  [string range $uhost 0 [expr $a-1]]
		set ident [string range $uhost [expr $a+1] [expr $b-1]]
		set host  [string range $uhost [expr $b+1] end]
		
		set theretilde [regsub {^~} $ident {} nident]
		
		if {[string length $nident] > [expr $options(identlen)-[expr {$theretilde ? 2 : 1}]]} {
			set nident *[string range $nident 0 [expr $options(identlen)-3]]*
		} else {
			set nident *$nident
		}
		
		set maddr [maskhost $uhost]
		set mhost [string range $maddr [expr [string first @ $maddr]+1] end]
		switch -exact -- $ind {
			0       { return $nick!$ident@$host   }
			1       { return *!$ident@$host       }
			2       { return *!$nident@$host      }
			3       { return *!*@$host            }
			4       { return *!$nident@$mhost     }
			5       { return *!*@$mhost           }
			6       { return $address             }
			7       { return $nick!$nident@$host  }
			8       { return $nick!*@$host        }
			9       { return $nick!$nident@$mhost }
			10      { return $nick!*@$mhost       }
			default { return $uhost               }
		}
		
	}
	
	# Функция проверки и получения хендла из указаного ника/хендла
	proc get_hand {args} {
		upvar out out
		
		set opts(-quiet) 0; # тихий режим
		
		if {[llength $args] > 1} {
			while {[string match -* [lindex $args 0]]} {
				switch -glob -- [lindex $args 0] {
					-quiet { set opts(-type) [Pop args 1] }
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
			return -code error "wrong # args: should be \"get_hand ?switches? nick/hand\""
		}
		
		set nick [lindex $args 0]
		
		if {[onchan $nick]} {
			if {[check_isnull [set dhand [nick2hand $nick]]]} {
				if {![validuser $nick]} {
					if {!$opts(-quiet)} {put_msg [sprintf ccs #123 $nick]}
					return ""
				}
				if {!$opts(-quiet)} {put_msg [sprintf ccs #122 $nick $nick]}
				return $nick
			} else {
				if {![string equal -nocase $nick $dhand] && [validuser $nick]} {
					if {!$opts(-quiet)} {put_msg [sprintf ccs #124 $nick $dhand $nick $dhand]}
					return ""
				}
				return $dhand
			}
		} else {
			if {![validuser $nick]} {
				if {!$opts(-quiet)} {put_msg [sprintf ccs #125 $nick]}
				return ""
			}
			return $nick
		}
		
	}
	
	# Функция получения уровня доступа
	proc get_accesshand {hand chan {useowner 0}} {
		
		if {[check_isnull $hand]} {return 0}
		
		set powner 0
		if {$useowner} {
			foreach _ [split $::owner ", "] {
				if {![string is space $_] && [string equal -nocase $_ $hand]} {
					set powner 1
					break
				}
			}
		}
		
		if {$powner} {
			return 9
		} elseif {[matchattr $hand n]} {
			return 8
		} elseif {[matchattr $hand m]} {
			return 7
		} elseif {[matchattr $hand o]} {
			return 6
		} elseif {[matchattr $hand l]} {
			return 5
		} elseif {![check_isnull $chan] && [matchattr $hand -|n $chan]} {
			return 4
		} elseif {![check_isnull $chan] && [matchattr $hand -|m $chan]} {
			return 3
		} elseif {![check_isnull $chan] && [matchattr $hand -|o $chan]} {
			return 2
		} elseif {![check_isnull $chan] && [matchattr $hand -|l $chan]} {
			return 1
		} else {
			return 0
		}
		
	}
	
	# Функция получения установленного параметра
	proc get_options {param {chan ""}} {get_options_int $param $chan}
	proc get_options_int {param {chan ""}} {
		variable options
		
		if {[check_isnull $chan] || ![validchan $chan]} {
			if {[info exists options($param)] && [string is digit $options($param)] && $options($param) >= 0} {
				return $options($param)
			}
		} else {
			set cset [channel get $chan ccs-$param]
			if {![string is space $cset] && [string is digit $cset] && $cset >= 0} {return $cset}
			if {[info exists options($param)] && [string is digit $options($param)] && $options($param) >= 0} {
				return $options($param)
			}
		}
		return 0
		
	}
	
	# Функция получения установленного параметра
	proc get_options_str {param {chan ""}} {
		variable options
		
		if {[check_isnull $chan] || ![validchan $chan]} {
			if {[info exists options($param)] && $options($param) != ""} {return $options($param)}
		} else {
			set cset [channel get $chan ccs-$param]
			if {![string is space $cset] && $cset != ""} {return $cset}
			if {[info exists options($param)] && $options($param) != ""} {return $options($param)}
		}
		return ""
		
	}
	
	#proc importvars {lo {la {}} {ln {}}} {
	#	
	#	set lvars [list]
	#	foreach {var value} $ln {uplevel [list set $var $value]; lappend lvars $var}
	#	foreach {flag value} $la {
	#		if {[string index $flag 0] == "-"} {
	#			set var [string range $flag 1 end]
	#			uplevel [list set $var $value]
	#			lappend lvars $var
	#		}
	#	}
	#	foreach var $lo {
	#		if {[lsearch $lvars $var] < 0} {
	#			set value [uplevel 2 "if {\[info exists $var\]} {set $var} else {set $var \"\"}"]
	#			uplevel [list set $var $value]
	#		}
	#	}
	#	
	#}
	
	proc importvars {lo} {
		
		foreach var $lo {
			set value [uplevel 2 "if {\[info exists $var\]} {set $var} else {set $var \"\"}"]
			uplevel [list set $var $value]
		}
		
	}
	
	# Функция проверки пустого значения для хендла/канала
	proc check_isnull {str} {
		if {$str == "" || $str == "*"} {return 1} else {return 0}
	}
	
	# Функция проверки прав
	proc check_matchattr {dhand dchan dflags} {
		
		foreach flag $dflags {
			if {[string equal $flag "-"] || [string equal $flag "-|-"]} {
				return 1
			} elseif {[string first | $flag] >= 0 && ![check_isnull $dchan]} {
				if {[matchattr $dhand $flag $dchan]} {return 1}
			} elseif {[string equal $flag "%v"]} {
				if {[validuser $dhand]} {return 1}
			} elseif {[string equal $flag "%a"]} {
				return 1
			} else {
				if {[matchattr $dhand $flag]} {return 1}
			}
		}
		return 0
		
	}
	
	proc xdate {expire} {
		
		set s_time ""
		foreach {number text} $expire {
			if {![string is space $s_time]} {append s_time " "}
			if {$text == "seconds" || $text == "second"} {
				append s_time "$number [lindex {. секунда секунды секунд} [numgrp $number]]"
			} elseif {$text == "minutes" || $text == "minute"} {
				append s_time "$number [lindex {. минута минуты минут} [numgrp $number]]"
			} elseif {$text == "hours" || $text == "hour"} {
				append s_time "$number [lindex {. час часа часов} [numgrp $number]]"
			} elseif {$text == "days" || $text == "day"} {
				append s_time "$number [lindex {. день дня дней} [numgrp $number]]"
			} elseif {$text == "weeks" || $text == "week"} {
				append s_time "$number [lindex {. неделя недели недель} [numgrp $number]]"
			} elseif {$text == "months" || $text == "month"} {
				append s_time "$number [lindex {. месяц месяца месяцев} [numgrp $number]]"
			} elseif {$text == "years" || $text == "year"} {
				append s_time "$number [lindex {. год года лет} [numgrp $number]]"
			} else {
				append s_time "$number $text"
			}
		}
		return $s_time
		
	}
	
	proc numgrp {number} {
		switch -glob -- $number {*11 {return 3} *12 {return 3} *13 {return 3} *14 {return 3} \
			*1 {return 1} *2 {return 2} *3 {return 2} *4 {return 2} default {return 3}}
	}
	
	################################################################################################
	# Функции проверки доступа
	
	proc check_notavailable {lo args} {
		importvars [list snick shand schan command]
		
		foreach {flag value} $args {
			if {[string index $flag 0] == "-"} {
				set [string range $flag 1 end] $value
			} elseif {[string index $flag 0] == "+"} {
				upvar $value [string range $flag 1 end]
			}
		}
		
		foreach _ $lo {if {[proc_exists "notavailable$_"]} {if {[notavailable$_]} {return 1}}}
		return 0
		
	}
	
	proc notavailable-isop {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {[isop $dnick $dchan]} {
			if {$snick == $dnick} {put_msg [sprintf ccs #133 $schan]} else {put_msg [sprintf ccs #134 $dnick $dchan]}
			return 1
		}
		return 0
	}
	
	proc notavailable-getting_users {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		if {[getting-users]} {put_msg [sprintf ccs #117]; return 1}
		return 0
	}
	
	proc notavailable-isbotnick {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick
		if {[isbotnick $dnick]} {return 1}
		return 0
	}
	
	proc notavailable-notonchan {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {![onchan $dnick $dchan]} {put_msg [sprintf ccs #119 $dnick $dchan]; return 1}
		return 0
	}
	
	proc notavailable-protect {} {
		upvar 2 out out
		variable options
		importvars [list snick shand schan command]
		upvar dhand dhand dchan dchan
		if {[check_isnull $dhand] && (([check_isnull $dchan] && [matchattr $dhand $options(flag_protect)]) \
			|| (![check_isnull $dchan] && [matchattr $dhand $options(flag_protect) $dchan])) && ![matchattr $shand n]} {
			put_msg [sprintf ccs #179 $dhand]
			return 1
		}
		return 0
	}
	
	proc notavailable-locked {} {
		upvar 2 out out
		variable options
		importvars [list snick shand schan command]
		upvar dhand dhand
		if {[check_isnull $dhand] && [matchattr $dhand $options(flag_locked)] && ![matchattr $shand n]} {
			put_msg [sprintf ccs #116 $shand]
			return 1
		}
		return 0
	}
	
	# Запрет если уровень доступа меньше
	proc notavailable-nopermition0 {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dchan dchan dhand dhand dnick dnick
		set saccess [get_accesshand $shand $dchan 1]
		if {[set override_level [cmd_configure $command -override_level]] > 0 && $override_level > $saccess} {set saccess $override_level}
		set daccess [get_accesshand $dhand $dchan]
		if {($saccess <= $daccess)} {
			put_msg [sprintf ccs #102 $command [StrNick -nick $dnick -hand $dhand]]
			return 1
		}
		return 0
	}
	
	# Запрет если уровень доступа меньше и действия производится не над собой
	proc notavailable-nopermition1 {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dhand dhand dchan dchan dnick dnick
		if {$shand == $dhand} {return 0}
		set saccess [get_accesshand $shand $dchan 1]
		if {[set override_level [cmd_configure $command -override_level]] > 0 && $override_level > $saccess} {set saccess $override_level}
		set daccess [get_accesshand $dhand $dchan]
		if {($saccess <= $daccess)} {
			put_msg [sprintf ccs #102 $command [StrNick -nick $dnick -hand $dhand]]
			return 1
		}
		return 0
	}
	
	proc notavailable-notisop {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {![isop $dnick $dchan]} {
			if {$snick == $dnick} {
				put_msg [sprintf ccs #136]
			} else {
				put_msg [sprintf ccs #137 $dnick $dchan]
			}
			return 1
		}
		return 0
	}
	
	proc notavailable-ishalfop {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {[ishalfop $dnick $dchan]} {
			if {$snick == $dnick} {
				put_msg [sprintf ccs #138 $dchan]
			} else {
				put_msg [sprintf ccs #139 $dnick $dchan]
			}
			return 1
		}
		return 0
	}
	
	proc notavailable-notishalfop {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {![ishalfop $dnick $dchan]} {
			if {$snick == $dnick} {
				put_msg [sprintf ccs #140]
			} else {
				put_msg [sprintf ccs #141 $dnick $dchan]
			}
			return 1
		}
		return 0
	}
	
	proc notavailable-isvoice {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {[isvoice $dnick $dchan]} {
			if {$snick == $dnick} {
				put_msg [sprintf ccs #142 $dchan]
			} else {
				put_msg [sprintf ccs #143 $dnick $dchan]
			}
			return 1
		}
		return 0
	}
	
	proc notavailable-notisvoice {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dnick dnick dchan dchan
		if {![isvoice $dnick $dchan]} {
			if {$snick == $dnick} {
				put_msg [sprintf ccs #144 $dchan]
			} else {
				put_msg [sprintf ccs #145 $dnick $dchan]
			}
			return 1
		}
		return 0
	}
	
	proc notavailable-validhandle {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dhand dhand dnick dnick
		if {![check_isnull $dhand]} {
			put_msg [sprintf ccs #169 [StrNick -nick $dnick -hand $dhand]]
			return 1
		}
		return 0
	}
	
	proc notavailable-notvalidhandle {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dhand dhand
		if {[check_isnull $dhand]} {return 1}
		return 0
	}
	
	proc notavailable-validchan {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dchan dchan
		if {[validchan $dchan]} {
			put_msg [sprintf ccs #170 $dchan]
			return 1
		}
		return 0
	}
	
	proc notavailable-notisbot {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dhand dhand dnick dnick
		if {![matchattr $dhand b]} {
			put_msg [sprintf ccs #188 [StrNick -nick $dnick -hand $dhand]]
			return 1
		}
		return 0
	}
	
	proc notavailable-bitch {} {
		upvar 2 out out
		importvars [list snick shand schan command]
		upvar dchan dchan dnick dnick
		if {[channel get $dchan bitch] && ![matchattr [nick2hand $dnick] o|o $dchan]} {
			put_msg [sprintf ccs #135 $dnick $dchan]
			return 1
		}
		return 0
	}
	
	################################################################################################
	# Процедуры обработки биндов приватных и канальных сообщений
	
	#proc valid_out {onick ochan obot} {
	#	if {[llength $obot] != 0 && [llength $obot] != 3} {
	#		return -code error "bad obot \"$obot\": must be null list or list {bot shand thand}"
	#	}
	#	if {[string is space $onick] || ([llength $obot] == 0 && \
	#		[string is integer $onick] && ($onick <= 0 || ![valididx $onick]))} {
	#		return -code error "bad onick \"$onick\": must be nick or idx"
	#	}
	#	return -code ok 1
	#}
	
	#proc use_botnet {obot} {
	#	return [expr [llength $obot] == 3]
	#}
	
	proc on_chan {schan command} {
		if {![get_options_int on_chan $schan]} {return 0}
		if {[cmd_configure $command -use_mode] && [get_mode $schan $command] == "none"} {return 0}
		return 1
	}
	
	proc limit_command {snick command} {
		variable options
		if {!$options(use_blocktime_limit)} {return 0}
		if {[set block [cmd_configure $command -block]] > 0 && [limit $snick $command $block 1]} {
			upvar out out
			put_msg [sprintf ccs #103 $block]
			return 1
		}
		return 0
	}
	
	proc get_mode {schan command} {
		if {[check_isnull $schan]} {return "msg"}
		switch -glob -- [channel get $schan ccs-mode-$command] {
			chan*       { return "chan"   }
			not*        { return "notice" }
			user* - msg { return "msg"    }
			default     { return "none"   }
		}
	}
	
	proc launch_cmd {snick shand shost schan text command} {
		upvar out out
		#debug "snick: $snick, shand: $shand, shost: $shost, schan: $schan, onick: $onick, ochan: $ochan, obot: $obot, text: $text, command: $command" 3
		
		#valid_out $onick $ochan $obot
		
		if {![cmd_configure $command -use]} {return -code ok 0}
		if {![on_chan $schan $command]} {return -code ok 0}
		if {[info exists out(bot)] && ![string is space $out(bot)] && ![cmd_configure $command -use_botnet]} {
			put_msg -return 0 -- [sprintf ccs #207]
		}
		if {[limit_command $snick $command]} {return -code ok 0}
		
		set text [string trim $text]
		set use_chan [cmd_configure $command -use_chan]
		
		if {[check_isnull $schan]} {
			
			switch -exact -- $use_chan {
				0 {}
				1 {
					if {![regexp -- {^([^\ ]+)(?:\ +(.*?))?$} $text -> chan1 text1]} {
						put_help -return 0
					}
					if {![validchan $chan1]} {put_msg -return 0 -- [sprintf ccs #208 $chan1]}
					set schan $chan1
					set text $text1
				}
				2 {
					if {![regexp -- {^([^\ ]+)(?:\ +(.*?))?$} $text -> chan1 text1]} {
						put_help -return 0
					}
					if {$chan1 != "*" && ![validchan $chan1]} {
						put_msg -return 0 -- [sprintf ccs #208 $chan1]
					}
					set schan $chan1
					set text $text1
				}
				3 {
					if {[regexp -- {^([^\ ]+)(?:\ +(.*?))?$} $text -> chan1 text1] && [validchan $chan1]} {
						set schan $chan1
						set text $text1
					}
				}
				default {return 0}
			}
			
		} else {
			if {![check_isnull $schan] && ![validchan $schan] && $use_chan != 0} {
				put_msg -return 0 -- [sprintf ccs #208 $schan]
			}
		}
		
		if {[llength [set rege [cmd_configure $command -regexp]]] == 2} {
			set regline [regexp -nocase -inline -- [lindex $rege 0] $text]
			if {[llength $regline] == 0} {put_help -return 0}
			if {[llength [set subvars [lindex $rege 1]]] > 0} {foreach $subvars $regline break}
		}
		
		if {![check_matchattr $shand $schan [cmd_configure $command -flags]]} {
			if {[check_isnull $shand] && [validuser $snick] && [check_matchattr $snick $schan [cmd_configure $command -flags]]} {
				put_msg [sprintf ccs #115 $::botnick]
			} else {
				put_msg [sprintf ccs #118]
			}
			return 0
		}
		if {[info exists out(idx)]} {set idx $out(idx)} else {set idx ""}
		if {[info exists out(bot)]} {set bot $out(bot)} else {set bot ""}
		if {[cmd_configure $command -use_auth] && ![check_auth $snick $shand $shost $idx $bot]} {return 0}
		
		set str_proc "cmd_$command"
		if {[proc_exists $str_proc]} {
			foreach _ [info args cmd_$command] {
				append str_proc " \$$_"
			}
			IfError {
				eval $str_proc
			} errMsg {
				put_log $errMsg
				put_log $::errorInfo
			}
		} else {
			put_log "proc \"$str_proc\" is not exist"
		}
		
	}
	
	cmd_configure update -control -group "system" -use_chan 0 -flags {n} -block 5 \
		-alias {%pref_updateccs %pref_ccsupdate} \
		-regexp {{^(list|download|update|template)(?:\ +(.*?))?$} {-> stype stext}}
	
	cmd_configure help -control -group "info" -use_auth 0 -use_chan 3 -use_botnet 0 -block 3 -flags {%v} \
		-alias {%pref_helps} \
		-regexp {{^(.+?)$} {-> stext}}
	
	proc cmd_update {} {
		upvar out out
		importvars [list snick shand schan command stype stext]
		variable url_update
		variable file_ccs
		variable dir_ccs
		variable options
		variable type_file
		variable ccs
		
		switch -exact -- [string tolower $stype] {
			list     { set type 1 }
			download { set type 2 }
			update   { set type 3 }
			template { set type 4 }
			default  { put_help -return 0 }
		}
		
		switch -exact -- $type {
			1 {
				
				set reg {-type(?:\s+|=)([[:alpha:],\*]+)(?:$|\s+)}
				if {[regexp -nocase -- $reg $stext -> dtype]} {regsub -- $reg $stext {} stext} else {set dtype "*"}
				
				set reg {-name(?:\s+|=)([[:alpha:],\*]+)(?:$|\s+)}
				if {[regexp -nocase -- $reg $stext -> dname]} {regsub -- $reg $stext {} stext} else {set dname "*"}
				
				set reg {-lang(?:\s+|=)([[:alpha:],\*]+)(?:$|\s+)}
				if {[regexp -nocase -- $reg $stext -> dlang]} {regsub -- $reg $stext {} stext} else {set dlang "*"}
				
				if {![string is space $stext]} {put_help -return 0}
				
				set find 0
				foreach _ [get_lversion] {
					lassign $_ ftype fname fversion fauthor fdate ffiles furl fdiscription
					if {[ni $type_file $ftype]} continue
					
					if {$dtype != "*" && [ni [split $dtype ,] $ftype]} continue
					if {$dname != "*" && [ni [split $dname ,] [lindex $fname 0]]} continue
					if {$ftype == "lang"} {
						if {$dlang != "*" && [ni [split $dlang ,] [lindex $fname 1]]} continue
					}
					
					if {![compare_version [set cversion [pkg_info $ftype $fname version]] $fversion]} continue
					
					set find 1
					put_msg [sprintf ccs #195 $ftype [join $fname ,] $fdate $cversion $fversion]
				}
				if {!$find} {put_msg -return 1 -- [sprintf ccs #189]}
				
			}
			2 - 3 {
				
				set reg {-type(?:\s+|=)([[:alpha:],\*]+)(?:$|\s+)}
				if {[regexp -nocase -- $reg $stext -> dtype]} {regsub -- $reg $stext {} stext} else {set dtype "*"}
				
				set reg {-name(?:\s+|=)([[:alpha:],\*]+)(?:$|\s+)}
				if {[regexp -nocase -- $reg $stext -> dname]} {regsub -- $reg $stext {} stext} else {set dname "*"}
				
				set reg {-lang(?:\s+|=)([[:alpha:],\*]+)(?:$|\s+)}
				if {[regexp -nocase -- $reg $stext -> dlang]} {regsub -- $reg $stext {} stext} else {set dlang "*"}
				
				if {$type == 2 && (($dtype == "*" && $dname == "*" && $dlang == "*") || ![string is space $stext])} {put_help -return 0}
				
				set find 0
				set error 0
				set update 0
				foreach _ [get_lversion] {
					lassign $_ ftype fname fversion fauthor fdate ffiles furl fdiscription
					if {[ni $type_file $ftype]} continue
					
					if {$type == 2} {
						
						if {$dtype == "*"} {
							if {$ftype != "mod" && $ftype != "lang"} continue
						} else {
							if {[ni [split $dtype ,] $ftype]} continue
						}
						if {$dname != "*" && [ni [split $dname ,] [lindex $fname 0]]} continue
						if {$ftype == "lang"} {
							if {$dlang != "*" && [ni [split $dlang ,] [lindex $fname 1]]} continue
						}
						
					}
					
					set cversion [pkg_info $ftype $fname version]
					if {$type == 3 && $cversion == ""} continue
					if {![compare_version $cversion $fversion]} continue
					
					set find 1
					put_msg [sprintf ccs #195 $ftype [join $fname ,] $fdate $cversion $fversion]
					foreach {sfile dfile} $ffiles {
						set file [string map [list %pscr $options(dir_scr) %plib $options(dir_lib) %plang $options(dir_lang) %pmod $options(dir_mod) %is $file_ccs] $dfile]
						if {[update_file $furl/$sfile $file]} {
							incr update
							put_log "$furl/$sfile to $file v$fversion (successfull)."
						} else {
							incr error
							put_log "$furl/$sfile to $file v$fversion (\0034unsuccessfull\003)."
						}
					}
				}
				if {$find} {
					put_msg [sprintf ccs #196 $update $error]
					if {$error > 0} {
						put_msg [sprintf ccs #197]
					} else {
						put_msg [sprintf ccs #167]
						binds_down
						source $file_ccs
					}
					return 1
				} else {
					put_msg -return 1 -- [sprintf ccs #189]
				}
				
			}
			4 {
				
				for {set i 0} {$i < 3} {incr i} {
					foreach _ $url_update {
						
						set data [get_httpdata "$_/ccs.rc${i}-template.tcl"]
						if {[string is space $data]} continue
						
						if {[file exists "$dir_ccs/ccs.rc${i}.tcl"]} {
							set file "ccs.rc${i}-template.tcl"
						} else {
							set file "ccs.rc${i}.tcl"
						}
						if {[catch {
							SaveFile -binary 1 -- "$dir_ccs/$file" $data
						} errMsg]} {
							put_msg [sprintf ccs #192 $errMsg]
						} else {
							put_msg [sprintf ccs #191 "$dir_ccs/$file"]
						}
						break
						
					}
				}
				
			}
		}
		
	}
	
	proc cmd_help {} {
		upvar out out
		importvars [list snick shand schan command stext]
		variable options
		variable commands
		variable group
		
		set cmds {}
		foreach cmd [concat $commands(control) $commands(scripts)] {
			foreach alias [get_aliases -type all -- $cmd] {
				if {[string match -nocase $stext $alias]} {lappend cmds $cmd; break}
			}
		}
		
		if {[llength $cmds] > 0} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 0; set par_scr 0
		} elseif {[string equal -nocase $stext "all"]} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 0; set par_scr 0
		} elseif {[string equal -nocase $stext "limit"]} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 1; set par_scr 0
		} elseif {[string equal -nocase $stext "scr"] || [string equal -nocase $stext "script"] || [string equal -nocase $stext "scripts"]} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 0; set par_scr 1
		} else {
			set par_access   [regexp -nocase -all -- {-a(?:ccess)?} $stext]
			set par_commands [regexp -nocase -all -- {-c(?:ommands)?} $stext]
			set par_group    [regexp -nocase -all -- {-g(?:roup)?\ +([\w]+)} $stext -> g]
			set par_limit    [regexp -nocase -all -- {-l(?:imit)?} $stext]
			set par_scr      [regexp -nocase -all -- {-s(?:cript(?:s)?)?} $stext]
			if {$par_group && [ni $group [string tolower $g]]} {
				put_msg -speed 3 -return 0 -- [sprintf ccs #177 $g [join $group ", "]]
			}
			if {!$par_group && $options(help_group)} {
				put_msg -speed 3 -return 0 -- [sprintf ccs #178 [join $group ", "]]
			}
		}
		
		if {$par_limit && [check_isnull $schan]} {
			put_msg -speed 3 -return 0 -- [sprintf ccs #200]
		}
		
		if {$par_access || $par_commands || $par_group || $par_limit || $par_scr} {
			
			if {[llength $cmds] == 0} {
				if {$par_scr} {set l $commands(scripts)} else {set l $commands(control)}
				foreach cmd $l {
					if {![cmd_configure $cmd -use]} continue
					if {$par_group && ![string equal -nocase $g [cmd_configure $cmd -group]]} continue
					if {$par_limit && ![check_matchattr $shand $schan [cmd_configure $cmd -flags]]} continue
					lappend cmds $cmd
				}
			}
			
			set type [get_autotype]
			set r {}
			
			if {[llength $cmds] > 1} {
				set detail 0
				lappend r [sprintf ccs #101 $::ccs::version $::ccs::date $::ccs::author \
					$options(prefix_pub) $options(prefix_msg) $options(prefix_dcc) \
					$options(prefix_botnet_pub) $options(prefix_botnet_msg) $options(prefix_botnet_dcc)]
			} else {
				set detail 1
			}
			
			foreach cmd $cmds {
				foreach _ [get_help -type $type -access $par_access -aliases $par_commands \
					-detail $detail -hand $shand -chan $schan -- $cmd] {
					lappend r $_
				}
			}
			
			put_msg -speed 3 -type $type -list -notice2msg -- $r
			
		}
		if {[llength $cmds] == 0} {put_help}
		put_log ""
		return 1
		
	}
	
	proc update_file {url filename} {
		upvar out out
		importvars [list snick shand schan]
		
		set data [get_httpdata $url]
		if {[string is space $data]} {return 0}
		
		if {[catch {
			SaveFile -backup 1 -binary 1 -- $filename $data
		} errMsg]} {put_msg -return 0 -- [sprintf ccs #192 $errMsg]}
		return 1
		
	}
	
	proc get_lversion {} {
		upvar out out
		importvars [list snick shand schan]
		variable url_update
		variable file_version
		variable type_file
		
		foreach url $url_update {
			put_msg [sprintf ccs #193 "$url/$file_version"]
			if {[string is space [set data [get_httpdata "$url/$file_version"]]]} continue
			foreach _ [split $data \n] {
				if {[string is space $_]} continue
				lassign $_ ftype fname fversion fauthor fdate ffiles fdiscription
				
				if {[ni $type_file $ftype]} continue
				
				set n [join $fname ,]
				if {![info exists fileinfo($ftype,version,$n)] || [compare_version $fileinfo($ftype,version,$n) $fversion]} {
					set fileinfo($ftype,version,$n)	$fversion
					set fileinfo($ftype,data,$n)	[list $ftype $fname $fversion $fauthor \
						$fdate $ffiles $url $fdiscription]
				}
				
			}
		}
		
		set r {}
		foreach _ [array names fileinfo -glob "*,data,*"] {lappend r $fileinfo($_)}
		return $r
		
	}
	
	proc get_httpdata {url} {
		upvar out out
		importvars [list shand]
		
		if {[catch {
			#put_msg [sprintf ccs #193 $url]
			set token [::http::geturl $url -timeout 60000 -blocksize 32768 -binary true]
			
			set errid	[::http::status $token]
			set ncode	[::http::ncode $token]
			set errtxt	[::http::error $token]
			set data	[::http::data $token]
			#set code	[::http::code $token]
			::http::cleanup $token
			
			if {$errid == "ok" && $ncode == 200} {
			} else {
				put_msg [sprintf ccs #194 $url "$errid $ncode $errtxt"]
				set data ""
			}
		} errMsg]} {
			put_msg [sprintf ccs #194 $url $errMsg]
			set data ""
		}
		return $data
		
	}
	
	proc pkg_add {type name author version date {description ""}} {
		variable pkg
		set n [join $name ,]
		if {![info exists pkg($type,on,$n)]} {
			set pkg($type,on,$n) 1
		}
		set pkg($type,name,$n)        $name
		set pkg($type,author,$n)      $author
		set pkg($type,version,$n)     $version
		set pkg($type,date,$n)        $date
		set pkg($type,description,$n) $description
		set pkg($type,info_script,$n) [info script]
	}
	
	proc pkg_info {type name p} {
		variable pkg
		set n [join $name ,]
		if {[info exists pkg($type,$p,$n)]} {
			return $pkg($type,$p,$n)
		} else {
			return ""
		}
	}
	
	proc pkg_list {type {only_on 0}} {
		variable pkg
		set r {}
		foreach _ [array names pkg -glob "$type,name,*"] {
			set name [lrange [split $_ ,] 2 end]
			if {$only_on && ![pkg_info $type $name on]} continue
			lappend r $name
		}
		return $r
	}
	
	################################################################################################
	# Процедуры поднятия и убивания биндов
	
	proc fixbind {} {
		variable procs_auth
		
		set procs_auth [list]
		
		foreach _ [binds auth] {
			
			if {[lindex $_ 0] != "msg"} continue
			set p [lindex $_ 4]
			if {$p != [namespace origin msg_auth]} {
				if {[string range $p 0 1] != "::"} {set p "::$p"}
				lappend procs_auth $p
			}
			
		}
		bind msg -|- auth [namespace origin msg_auth]
		
	}
	
	proc main {} {
		variable options
		variable group
		variable commands
		
		set group {}
		
		foreach command [concat $commands(control) $commands(scripts)] {
			if {![cmd_configure $command -use]} continue
			if {![string is space [set g [cmd_configure $command -group]]]} {
				ladd group $g
			}
			
			# Прописываем бинды управления для PUB команд
			foreach _ [get_aliases -type pub -- $command] {
				bind pub -|- $_ [namespace current]::pub_cmd_$command
				eval "
					proc [namespace current]::pub_cmd_$command {nick uhost hand chan text} {
						
						set out(nick)  \$nick
						set out(idx)   \"\"
						set out(chan)  \$chan
						set out(bot)   \"\"
						set out(hand)  \$hand
						set out(thand) \"\"
						
						launch_cmd \$nick \$hand \$uhost \$chan \$text \"$command\"
						return 0
						
					}
				"
			}
			
			# Прописываем бинды управления для MSG команд
			foreach _ [get_aliases -type msg -- $command] {
				bind msg -|- $_ [namespace current]::msg_cmd_$command
				eval "
					proc [namespace current]::msg_cmd_$command {nick uhost hand text} {
						
						set out(nick)  \$nick
						set out(idx)   \"\"
						set out(chan)  \"\"
						set out(bot)   \"\"
						set out(hand)  \$hand
						set out(thand) \"\"
						
						launch_cmd \$nick \$hand \$uhost \"*\" \$text \"$command\"
						return 0
						
					}
				"
			}
			
			if {$options(prefix_dcc) != "."} {
				# Прописываем бинды управления для DCC команд
				foreach _ [get_aliases -type dcc -backslash 1 -- $command] {
					bind filt -|- "$_" [namespace current]::filt_cmd_$command
					bind filt -|- "$_ *" [namespace current]::filt_cmd_$command
					eval "
						proc [namespace current]::filt_cmd_$command {idx text} {
							
							set hand  \[idx2hand \$idx\]
							set nick  \[hand2nick \$hand\]
							set uhost \[getchanhost \$nick\]
							set text  \[join \[lrange \[split \$text\] 1 end\]\]
							set ::lastbind \[join \[lindex \[split \$text\] 0\]\]
							
							set out(nick)  \"\"
							set out(idx)   \$idx
							set out(chan)  \"\"
							set out(bot)   \"\"
							set out(hand)  \$hand
							set out(thand) \"\"
							
							launch_cmd \$nick \$hand \$uhost \"*\" \$text \"$command\"
							return \"\"
							
						}
					"
				}
			}
			
		}
		
		bind msg  -|-                 auth        [namespace origin msg_auth]
		bind msg  -|-                 identauth   [namespace origin msg_identauth]
		bind part $options(flag_auth) *           [namespace origin part_auth]
		bind sign $options(flag_auth) *           [namespace origin sign_auth]
		bind kick -|-                 *           [namespace origin kick_auth]
		bind nick $options(flag_auth) *           [namespace origin nick_auth]
		bind splt $options(flag_auth) *           [namespace origin splt_auth]
		bind evnt -|-                 prerehash   [namespace origin prerehash]
		bind evnt -|-                 init-server [namespace origin init_server]
		
		after 3000 [list [namespace origin fixbind]]
		
		foreach _ [concat [pkg_list mod 1] [pkg_list scr 1]] {
			if {[proc_exists "main_$_"]} {main_$_}
		}
		debug "[llength [binds "[namespace current]::*"]] binds is up"
		
	}
	
	proc prerehash {type} {
		binds_down
	}
	
	proc init_server {type} {
		variable options
		
		foreach hand [userlist] {
			if {![matchattr $hand $options(flag_auth)] && ![matchattr $hand $options(flag_auth_botnet)]} continue
			chattr $hand "-$options(flag_auth)$options(flag_auth_botnet)"
			setuser $hand XTRA AuthBot [list]
			setuser $hand XTRA AuthNick [list]
			put_log -level 3 -- "(auto) Init log out"
		}
		
	}
	
	proc binds_down {} {
		
		set b [binds "[namespace current]::*"]
		foreach _ $b {unbind [lindex $_ 0] [lindex $_ 1] [lindex $_ 2] [lindex $_ 4]}
		debug "[llength $b] binds is down"
		
	}
	
	proc get_filelist {dirname mask} {
		if {[catch {
			set filelist [glob -directory $dirname $mask]
		} errMsg]} {
			set filelist [list]
			debug "Error obtain a list of files from the directory: \"$dirname\", mask: \"$mask\"" 4
			debug "($errMsg)" 4
		}
		return $filelist
	}
	
	proc sourcefile {type path mask list {debuglevel 1}} {
		global errorInfo
		
		set fcount 0
		if {$list} {set lfile [get_filelist $path $mask]} else {set lfile [list "$path/$mask"]}
		foreach _ $lfile {
			if {[catch {
				if {[file exists $_] && [file isfile $_]} {
					uplevel "source $_"
					incr fcount
					debug "loaded file ($type): \002$_\002" $debuglevel
				} else {
					debug "loaded file ($type): \002$_\002 (no such file)" $debuglevel
				}
			} errMsg]} {
				debug "error load file ($type): \002$_\002"
				debug "($errorInfo)"
			}
		}
		if {$list} {debug "loaded file ($type). $fcount files"}
		
	}
	
	################################################################################################
	# Начальная подгатовка переменных и загрузка модулей
	if {[file exists $dir_ccs/ccs.addonce.tcl] && \
		[file isfile $dir_ccs/ccs.addonce.tcl] && \
		![file exists $dir_ccs/ccs.rc1.tcl]} {
		catch {file rename $dir_ccs/ccs.addonce.tcl $dir_ccs/ccs.rc1.tcl}
	}
	if {[file exists $dir_ccs/ccs.r5.tcl] && \
		[file isfile $dir_ccs/ccs.r5.tcl] && \
		![file exists $dir_ccs/ccs.rc1.tcl]} {
		catch {file rename $dir_ccs/ccs.r5.tcl $dir_ccs/ccs.rc1.tcl}
	}
	
	pkg_add mod ccs $author $version $date
	
	sourcefile rc0  $dir_ccs           ccs.rc0.tcl    0
	sourcefile lib  $options(dir_lib)  ccs.lib.*.tcl  1 3
	sourcefile mod  $options(dir_mod)  ccs.mod.*.tcl  1 3
	sourcefile scr  $options(dir_scr)  ccs.scr.*.tcl  1 3
	sourcefile lang $options(dir_lang) ccs.lang.*.tcl 1 3
	sourcefile rc1  $dir_ccs           ccs.rc1.tcl    0
	main
	sourcefile rc2  $dir_ccs           ccs.rc2.tcl    0
	
	set time_down [clock clicks -milliseconds]
	
	debug "v$version \[$date\] by $author loaded in [expr ($time_down-$time_up)/1000.0] s"
	
}
