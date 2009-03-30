##################################################################################################################
## Продолжение известного скрипта управления CCS (Channel Control Script)
## Version: 1.7.9.
## Script's author: Buster (buster@buster-net.ru) (http://buster-net.ru/index.php?section=irc&theme=scripts).
##                                              (http://eggdrop.msk.ru/index.php?section=irc&theme=scripts).
## Forum:           http://forum.systemplanet.ru/viewtopic.php?f=3&t=3
## sf.net:          http://sourceforge.net/projects/ccs-eggdrop/
## SVN:             svn checkout http://ccs-script.googlecode.com/svn/trunk/ ccs-script-read-only
## Тестеры:         Net_Storm, Kein, anaesthesia
##################################################################################################################
# Установка скрипта:
#  1) Распаковать архив в директорию scripts;
#  2) Прописать скрипт в конфигурационном файле, не забывая указать правильный путь source scripts/ccs/ccs.tcl
#  3) Настроить дополнительные параметры по желания. Все изменения должны производиться _только_ в файлах
#     ccs.rX.tcl. Если соответствующая настройка присутствует в файле, то необходимо разкомментировать
#     параметр и изменить по желанию. Если какой ни будь из параметров присутствует только в скрипте, то следует
#     скопировать строку и добавить её в соответсвующий ccs.rX.tcl с измененным значением;
#  4) Перезапустить бота командой .rehash через патилайн.
##################################################################################################################
# Помощь по командам осуществляеться через команду !helps, флаги помощи:
#  all               -- вывод полного списка с максимальной информацией.
#  limit             -- вывод списка команд доступных пользователю с максимальной информацией.
#  -a[ccess]         -- вывод уровня доступа.
#  -c[ommands]       -- дополнительные команды (алиасы).
#  -g[roup] [группа] -- выводит команды _только_ указанной группы.
#  -l[imit]          -- выводит _только_ доступные команды.
##################################################################################################################
# Список последних изменений:
#	v1.7.9
# - Перенесены все процедуры авторизации и управления через ботнет в модуль ccs.mod.bots.tcl
#	v1.7.8
# - Для команды !ccsupdate добавлена загрузка шаблонов настроек ccs.rX.tcl. (!ccsupdate template)
#	v1.7.7
# - Добавлен флаг ccs(usecolors). Если какой либо скрипт использует цветовую раскраску и для данного скрипта есть
#   черно белая цветовая гамма, то выставляя этот параметр в 1 можно задействовать её.
# - Для скрипта whoisip добавлена поддержка старого модуля eggdrop для DNS запросов.
# - Для скрипта whoisip добавлена черно белая цветовая раскраска.
#	v1.7.6
# - Добавлена переменная ccs(permission_secret_chan) указывающая флаг доступа для работы с секретными каналами.
# - Для команды !channels добавлен вывод секретных каналов, если у запрашиваемого достаточно прав.
# - Добавлена команда !match показывающая список юзеров, сидящих на канале, с указанной хостмаской.
# - Добавлен параметр ccs(datadir) хранящий путь к директории с данными.
# - Изменена директория по умолчанию для сохранения логов.
# - Изменена директория по умолчанию для сохранения банов модуля regban. Если такие баны существовали то следует
#   переместить файл данных в директорию data и сделать .rehash
# - Для скрипта whoisip интегрирована поддержка библиотеки DNS.
# - Для скрипта whoisip улучшена работа с запросами IPv6. Разрешение прямой и обратной зоны для хостов.
# - Для скрипта whoisip в качестве дополнительной информации выводятся NS, MX, CNAME записи.
# - Файл ccs.addonce.tcl заменен на ряд файлов (ccs.r0.tcl ccs.r1.tcl ccs.r2.tcl ccs.r3.tcl ccs.r4.tcl ccs.r5.tcl
#   ccs.r6.tcl) загрузка каждого из которых происходит в определенный момент времени. Более подробная информация о
#   том в какой момент загружается тот или иной файл можно найти в самом файле.
#	v1.7.5
# - 	Добавлено свойство ccs(override_level,command) с помощью которого можно переопределить уровень доступа юзера
#   для выполнения команды. Более подробная информация в описании всех параметров команд.
# - Для модуля logs добавлено ограничение уровня сообщений, записываемое в лог файл.
# - Для команды !info добавлен вывод списка порядковых номеров хостмасок
# - Для модуля regban добавлены две новые команды !regbantest и !regbanaction
#	v1.7.4
# - Убраны скобки { } при выводе хостов в команде !whois
# - Для команды !delhost теперь по умолчанию используется указание полной хостмаски, чтобы указать маску хостмаски
#   необходимо перед маской поставить ключ -m
# - Добавлена поддержка загрузки дополнительных библиотек
# - Для файлов добавлена поддержка хранения описания. Которая так же отображается при загрузке файлов из
#   репозитория
#	v1.7.3
# - Исправлено формирование дефолтной маски при добавление бота
# - Исправлено использование "*" в команде обновления !ccsupdate и изменен текст помощи.
#	v1.7.2
# - Для команд работы с сохранением канальных флагов и шаблонов расширен список используемых символов для имени
#   файла.
# - Для команды !info добавлена возможность просмотра установленных скриптов/модулей/языковых файлах.
#	v1.7.1
# - Поправлено снятие бана не прописанного на боте, в случае если установлена опция unban_level.
# - Для команд !banlist !exemptlist !invitelist добавлен вывод списка банов/исключений/инвайтов с канала.
# - Для команд !exemptlist !invitelist добавлена возможность просмотра списка исключений/инвайтов по маске.
# - Поправлено выставление глобального бана по нику.
# - Добавлена возможность снимать баны по порядковому номеру.
# - Для модулей logs regban chan изменены дирректории по умолчанию для сохранения файлов
# - Оптимизирован вывод цветовой раскладки при выводе нескольких строк.
# - Добавлена поддержка загрузки и обновления скрипов из репозитория.
# - Создан первый тестовый скрипт whoisip показывающий всю информацию об IPv4 адрессе.
##################################################################################################################
# Поный список изменений начиная с версии 1.1.0 можно прочитать в файле ChangeLog.
##################################################################################################################
###################     После следующей линии категорически не рекомендуется что-то менять     ###################
###################        Все изменения необходимо производить в файле ccs.addonce.tcl        ###################
##################################################################################################################

##################################################################################################################
# Список параметров команд:
# command - системное имя команды
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
# set ccs(group,command)
#   Принадлежность команды к определенной группе (строка);
#
# set ccs(use,command)
#   Включение/отключение команды (1 - включена, 0 - отключена), значение по умолчанию 1
#   (если параметр не указан);
#
# set ccs(use_auth,command)
#   Команда требует авторизацию для её использования (1 - авторизация требуется, 0 - нет), значение
#   по умолчанию 1 (если параметр не указан);
#
# set ccs(use_chan,command)
#   Команда использует имя канала, для каких либо действий, в случае управления ботом через приват данная команда
#   потребует ввести имя канала над которым производиться #   действие. Значение по умолчанию 1
#   (если параметр не указан)
#      0 - канал не используеться;
#      1 - указание канала обязательно;
#      2 - указание канала либо "*" обязательно;
#      3 - указание канала не обязательно;
#
# set ccs(flags,command)
#   Флаги доступа к команде. Если флаги указываются через вертикальную черту, это будет означать доступность
#   команды, как для локальных, так и для глобальных пользователей. Если же флаг указывается одной буквой, то
#   использовать команду смогут только пользователи с глобальным флагом. (дополнительно добавлен один флаг:
#   %v - при этом пользователь должен быть добавлен в юзерлист);
#
# set ccs(alias,command)
#   Список команд на которые бот будет реагировать для использования данной команды "%pref_" будет заменена на
#   префикс по умолчанию.
#
# set ccs(block,command)
#   Необязательный параметр блокировка использования команды по времени. Задается время в секундах, через которое
#   будет доступно повторное выполнение команды.
#
# set ccs(regexp,command)
#   Регулярное выражение, выбирающее данные и передающее обрабатываемой процедуре
#
# set ccs(override_level,command)
#   Переопределение уровня доступа юзера для выполнения команды. Если у юзера не хватает прав (например: в случае
#   если для команды назначен юзерский флаг), то этим значением можно поднять уровень.
#   Список стандартных уровней прав назначаемых стандартными флагами:
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
#   Не рекомендуется выставлять значение этого параметра больше уровня доступа по флагам указанного в параметре
#   set ccs(flags,command)
##################################################################################################################

package require Tcl
catch {package require http}

namespace eval ::ccs {
	
	#############################################################################################################
	# Версия и автор скрипта
	variable author		"Buster <buster@buster-net.ru> (c)"
	variable version	"1.7.9"
	variable date		"30-Mar-2009"
	
	variable ccs
	
	setudef str ccs-default_lang
	setudef str ccs-on_chan
	setudef str ccs-usecolors
	
	proc unsetccs {args} {
		variable ccs
		foreach _0 $args {foreach _1 [array names ccs -glob $_0] {unset ccs($_1)}}
	}
	unsetccs "args,*" "help,*" "group,*" "use,*" "use_auth,*" "use_chan,*" "flags,*" "alias,*" \
		"block,*" "text,*" "mod,*" "lang,*" "scr,*" "lib,*" "regexp,*"
	
	set last_nsc [expr [string length "[namespace current]::"]-1]
	foreach _ [package names] {
		if {[string range $_ 0 $last_nsc] == "[namespace current]::"} {package forget $_}
	}
	foreach _ [namespace children [namespace current]] {namespace delete $_}
	
	#############################################################################################################
	# Префиксы по умолчанию для команд управления. pub - для канала, msg - для приватаm, dcc - патилайн.
	# Использование префикса "." для патилайна не допустимо.
	set ccs(pref_pub)				"!"
	set ccs(pref_msg)				"!"
	set ccs(pref_dcc)				"!"
	
	#############################################################################################################
	# Префиксы по умолчанию для команд управления передаваемых всем ботам ботнета. pub - для канала, msg – для
	# привата, dcc - патилайн. !Внимание! команды, для которых не используется префикс, не будут прописаны. Если
	# поля оставить пустыми, то соответствующие команды не будут прописываться.
	set ccs(pref_pubcmd)			"!!"
	set ccs(pref_msgcmd)			"!!"
	set ccs(pref_dcccmd)			"!!"
	
	#############################################################################################################
	# Список хостов для автоматического обновления. _НЕ ИЗМЕНЯТЬ_
	set ccs(urls)	{
		http://buster-net.ru/files/irc/scripts/ccs
		http://reserve.buster-net.ru/files/irc/scripts/ccs
		http://bots.systemplanet.ru/scripts/ccs
	}
	set ccs(file_ccsversion)		"ccsversion4.txt"
	
	#############################################################################################################
	# Список загружаемых типов файлов. _НЕ ИЗМЕНЯТЬ_
	set ccs(ltype)					{mod lang scr lib}
	
	#############################################################################################################
	# Список языков по умолчанию для выводимого текста. Значение может быть переопределено выставлением
	# канального флага ccs-default_lang и настройки пользователя. Первое значение в списке имеет наибольший
	# приоритет, последнее - наименьший.
	set ccs(default_lang)			[list ru en]
	
	#############################################################################################################
	# Флаг, обеспечивающий быстрый вывод и работу с командами. Актуален при наличии флага +F на боте, иначе
	# бот будет вылетать за флуд (0 - медленно, 1 - быстро).
	set ccs(fast)					0
	
	#############################################################################################################
	# Разрешать вывод хелпа только по группам (1 - только по группам, 0 - общий и по группам)
	set ccs(help_group)				0
	
	#############################################################################################################
	# Уровень отладки (1 - вывод основной информации; 2, 3, ... - Вывод основной и дополнительной информации)
	set ccs(debug)					2
	
	#############################################################################################################
	# Исправлять баг бота не позволяющий возвращать стиковые баны/исключения/инвайты при входе бота на канал или
	# при получении прав на модерирование канала.
	set ccs(fixstick)				1
	
	#############################################################################################################
	# Длина одного сообщения в количестве символов. Если сообщение будет превышать разрешимое кол-во,
	# то будет выведено несколько сообщений пользователю. Для сети WeNet максимальная длина - 468 символов.
	set ccs(msg_len)				400
	
	#############################################################################################################
	# Флаги пользователей. Крайне не желательно изменять их.
	# Флаг указывающий на авторизованного пользователя
	set ccs(flag_auth)				"Q"
	# Флаг указывающий на авторизованного пользователя через ботнет
	set ccs(flag_auth_botnet)		"B"
	# Временный флаг, указывающий на то что пользователь находиться в проверке, для авторизованных через ботнет
	set ccs(flag_botnet_check)		"O"
	# Перманентная (постоянная) авторизация, не требующая ручной авторизации
	set ccs(flag_auth_perm)			"P"
	# Флаг защиты пользователя от изменений, только глобальный овнер сможет изменять параметры пользователя
	set ccs(flag_locked)			"L"
	# Флаг защиты пользователя от неправомерных действий (kick, ban итд). (Не дает полной защиты, в случае если
	# действие производиться не по хендлу)
	set ccs(flag_protect)			"H|H"
	# Флаг для ботов участвующие в общение (передача команд управления) через ботнете
	set ccs(flag_cmd_bot)			"U"
	
	#############################################################################################################
	# Значение по умолчанию, которое определяет, должен ли скрипт использоваться по умолчанию на всех каналах
	# (0 - нет, 1 - да). Значение может быть переопределено выставлением канального флага ccs-on_chan
	set ccs(on_chan)				1
	
	#############################################################################################################
	# Значение по умолчанию, которое определяет какая цветовая гамма, при их наличии, должна использоваться для
	# вывода. (0 - черно белая цветовая раскраска, 1 - цветная цветовая раскраска). Это же значение используется
	# для вывода текста в приват и патилайн.
	# Значение может быть переопределено выставлением канального флага ccs-usecolors
	set ccs(usecolors)				1
	
	#############################################################################################################
	# Максимальная длина идента в IRC сети. Нужна для получения правильной хостмаски бана.
	set ccs(identlen)				10
	
	#############################################################################################################
	# Путь и имя загружаемого скрипта. _НЕ ИЗМЕНЯТЬ_
	set ccs(info_script)			[info script]
	
	#############################################################################################################
	# Путь загружаемого скрипта. _НЕ ИЗМЕНЯТЬ_
	set ccs(ccsdir)					[file dirname $ccs(info_script)]
	
	#############################################################################################################
	# Каталог, куда будут помещаться старые файлы после обновления, при этом указание $ccs(ccsdir) будет
	# соответствовать каталогу, где находиться основной скрипт.
	set ccs(bakdir)					"$ccs(ccsdir)/bak"
	
	#############################################################################################################
	# Каталог, откуда будут читаться файлы ccs.lang.*.tcl, при этом указание $ccs(ccsdir) будет соответствовать
	# каталогу, где находиться основной скрипт.
	set ccs(langdir)				"$ccs(ccsdir)/lang"
	
	#############################################################################################################
	# Каталог, откуда будут читаться файлы ccs.mod.*.tcl, при этом указание $ccs(ccsdir) будет соответствовать
	# каталогу, где находиться основной скрипт.
	set ccs(moddir)					"$ccs(ccsdir)/mod"
	
	#############################################################################################################
	# Каталог, откуда будут читаться файлы ccs.scr.*.tcl, при этом указание $ccs(ccsdir) будет соответствовать
	# каталогу, где находиться основной скрипт.
	set ccs(scrdir)					"$ccs(ccsdir)/scr"
	
	#############################################################################################################
	# Каталог, откуда будут читаться файлы ccs.lib.*.tcl, при этом указание $ccs(ccsdir) будет соответствовать
	# каталогу, где находиться основной скрипт.
	set ccs(libdir)					"$ccs(ccsdir)/lib"
	
	#############################################################################################################
	# Каталог, где будут хранится файлы данных, при этом указание $ccs(ccsdir) будет соответствовать
	# каталогу, где находиться основной скрипт.
	set ccs(datadir)				"$ccs(ccsdir)/data"
	
	#############################################################################################################
	# Время в миллисекундах, в течение которого удерживать авторизацию юзера, если он не зашел на канал.
	set ccs(time_auth_notonchan)	300000
	
	#############################################################################################################
	# Время в миллисекундах, в течение которого удерживать авторизацию юзера при покидании канала.
	set ccs(time_auth_part)			3000
	
	#############################################################################################################
	# Минимальный флаг доступа к секретным каналам.
	set ccs(permission_secret_chan)	"m|-"
	
	#############################################################################################################
	# Удаление, восстановление, переопределение стандартных приватных команд бота.
	#          -1 - удаление стандартного бинда;
	#           1 - восстановление стандартного бинда;
	#         имя - удаление стандартного бинда и за место него создание нового с переопределенным именем;
	#  n/a(пусто) - не трогать бинд.
	set ccs(unbind,addhost)	"1"
	set ccs(unbind,die)		"-1"
	set ccs(unbind,go)		"-1"
	set ccs(unbind,hello)	""
	set ccs(unbind,help)	"-1"
	set ccs(unbind,ident)	"1"
	set ccs(unbind,info)	"-1"
	set ccs(unbind,invite)	"-1"
	set ccs(unbind,jump)	"-1"
	set ccs(unbind,key)		"-1"
	set ccs(unbind,memory)	""
	set ccs(unbind,op)		"-1"
	set ccs(unbind,halfop)	"-1"
	set ccs(unbind,pass)	"1"
	set ccs(unbind,rehash)	"-1"
	set ccs(unbind,reset)	"-1"
	set ccs(unbind,save)	"-1"
	set ccs(unbind,status)	"-1"
	set ccs(unbind,voice)	"-1"
	set ccs(unbind,who)		"-1"
	set ccs(unbind,whois)	"-1"
	
	#############################################################################################################
	# Список системных имен команд используемых скриптом, в указанном порядке будет выводиться помощью. Список не
	# должен изменяться без надобности. Отключение тех или иных команд осуществляется флагом use описанном ниже.
	set ccs(commands)		[list]
	set ccs(scr_commands)	[list]
	
	
	proc debug {text {level 1}} {
		variable ccs
		if {$ccs(debug) >= $level} {putlog "[namespace current]:: $text"}
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
				debug "($errMsg)"
			}
		}
		if {$list} {debug "loaded file ($type). $fcount files"}
		
	}
	
	sourcefile r0 $ccs(ccsdir) ccs.r0.tcl 0
	
	lappend ccs(commands)	"help"
	lappend ccs(commands)	"update"
	
	set ccs(group,update)		"system"
	set ccs(use_chan,update)	0
	set ccs(flags,update)		{n}
	set ccs(alias,update)		{%pref_updateccs %pref_ccsupdate}
	set ccs(block,update)		5
	set ccs(regexp,update)		{{^(list|download|update|template)(?:\ +(.*?))?$} {-> stype stext}}
	
	set ccs(group,help)			"info"
	set ccs(use_auth,help)		0
	set ccs(use_chan,help)		3
	set ccs(use_botnet,help)	0
	set ccs(flags,help)			{%v}
	set ccs(alias,help)			{%pref_helps}
	set ccs(block,help)			3
	set ccs(regexp,help)		{{^(.+?)$} {-> stext}}
	
	#############################################################################################################
	# Процедуры обработки биндов приватных и канальных сообщений
	
	proc valid_out {onick ochan obot} {
		if {[llength $obot] != 0 && [llength $obot] != 3} \
			{return -code error "bad obot \"$obot\": must be null list or list {bot shand thand}"}
		if {[string is space $onick] || ([llength $obot] == 0 && \
			[string is integer $onick] && ($onick <= 0 || ![valididx $onick]))} \
			{return -code error "bad onick \"$onick\": must be nick or idx"}
		return -code ok 1
	}
	
	proc use_command		{command}	{return [get_var use $command 1]}
	proc use_botnet			{obot}		{return [expr [llength $obot] == 3]}
	proc use_command_botnet	{command}	{return [get_var use_botnet $command 1]}
	proc on_chan			{schan command} {
		if {![get_options on_chan $schan]} {return 0}
		if {[get_var use_mode $command 0]} {
			if {[get_use_mode $schan $command] == "none"} {return 0}
		}
		return 1
	}
	proc limit_command		{snick command} {
		variable ccs
		if {[info exists ccs(block,$command)] && $ccs(block,$command) > 0 && [limit $snick $command $ccs(block,$command) 1]} {
			importvars [list onick ochan obot]
			put_msg [sprintf ccs #103 $ccs(block,$command)]
			return 1
		}
		return 0
	}
	
	proc get_use_mode {schan command} {
		if {[check_isnull $schan]} {return "user"}
		set res [channel get $schan ccs-mode-$command]
		switch -exact -- $res {
			channel	{return "chan"}
			chan	{return "chan"}
			notice	{return "notice"}
			not		{return "notice"}
			user	{return "user"}
			default	{return "none"}
		}
	}
	
	proc launch_cmd {snick shand shost schan onick ochan obot text command} {
		variable ccs
		global errorInfo botnick
		#debug "snick: $snick, shand: $shand, shost: $shost, schan: $schan, onick: $onick, ochan: $ochan, obot: $obot, text: $text, command: $command" 3
		
		valid_out $onick $ochan $obot
		
		if {![use_command $command]} {return -code ok 0}
		if {![on_chan $schan $command]} {return -code ok 0}
		if {[use_botnet $obot] && ![use_command_botnet $command]} {put_msg [sprintf ccs #207]; return -code ok 0}
		if {[limit_command $snick $command]} {return -code ok 0}
		
		set text [string trim $text]
		set use_chan [get_var use_chan $command 1]
		
		if {[check_isnull $schan]} {
			
			switch -exact -- $use_chan {
				0 {}
				1 {
					if {![regexp -- {^([^\ ]+)(?:\ +(.*?))?$} $text -> chan1 text1]} {put_help; return 0}
					if {![validchan $chan1]} {put_msg [sprintf ccs #208 $chan1]; return 0}
					set schan $chan1
					set text $text1
				}
				2 {
					if {![regexp -- {^([^\ ]+)(?:\ +(.*?))?$} $text -> chan1 text1]} {put_help; return 0}
					if {$chan1 != "*" && ![validchan $chan1]} {put_msg [sprintf ccs #208 $chan1]; return 0}
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
			if {![check_isnull $schan] && ![validchan $schan] && $use_chan != 0} {put_msg [sprintf ccs #208 $schan]; return 0}
		}
		
		if {[info exists ccs(regexp,$command)]} {
			set regline [regexp -nocase -inline -- [lindex $ccs(regexp,$command) 0] $text]
			if {[llength $regline] == 0} {put_help; return 0}
			if {[llength [set subvars [lindex $ccs(regexp,$command) 1]]] > 0} {foreach $subvars $regline break}
		}
		
		if {![check_matchattr $shand $schan $ccs(flags,$command)]} {
			if {[validuser $snick] && [check_matchattr $snick $schan $ccs(flags,$command)]} \
				{put_msg [sprintf ccs #115 $botnick]} else {put_msg [sprintf ccs #118]}
			return 0
		}
		if {[get_var use_auth $command 1] && ![check_auth $snick $shand $shost $onick [lindex $obot 0]]} {return 0}
		
		if {[catch {cmd_$command} errMsg]} {
			put_log $errMsg
			put_log $errorInfo
		}
		
	}
	
	#############################################################################################################
	# Процедуры команд, вызываемые общими процедурами биндов
	#############################################################################################################
	
	#############################################################################################################
	# Процедуры и функции автоматического обновления 
	
	proc cmd_update {} {
		importvars [list onick ochan obot snick shand schan command stype stext]
		variable ccs
		global sp_version
		
		if {![info exists sp_version]} {
			put_msg [sprintf ccs #198]; return 0
		} elseif {[encoding system] != "cp1251"} {
			put_msg [sprintf ccs #199]; return 0
		}
		
		switch -exact -- [string tolower $stype] {
			"list"		{set type 1}
			"download"	{set type 2}
			"update"	{set type 3}
			"template"	{set type 4}
			default		{put_help; return 0}
		}
		
		switch -exact -- $type {
			1 {
				
				if {[regexp -nocase -- {-type\s+([[:alpha:],\*]+)(?:$|\s+)} $stext -> dtype]} {
					regsub -- {-type\s+([[:alpha:],\*]+)(?:$|\s+)} $stext {} stext
				} else {
					set dtype "*"
				}
				
				if {[regexp -nocase -- {-name\s+([[:alpha:],\*]+)(?:$|\s+)} $stext -> dname]} {
					regsub -- {-name\s+([[:alpha:],\*]+)(?:$|\s+)} $stext {} stext
				} else {
					set dname "*"
				}
				
				if {[regexp -nocase -- {-lang\s+([[:alpha:],\*]+)(?:$|\s+)} $stext -> dlang]} {
					regsub -- {-lang\s+([[:alpha:],\*]+)(?:$|\s+)} $stext {} stext
				} else {
					set dlang "*"
				}
				
				if {[string length [string trim $stext]] != 0} {put_help; return 0}
				
				set find 0
				set error 0
				set update 0
				foreach _ [get_lversion] {
					foreach {ftype fname flang fversion fauthor fdate ffiles furl fdiscription} $_ break
					
					if {$dtype != "*"} {
						if {[lsearch -exact [split $dtype ,] $ftype] < 0} continue
					}
					if {$dname != "*"} {
						if {[lsearch -exact [split $dname ,] $fname] < 0} continue
					}
					if {$dlang != "*" && $flang != "*"} {
						if {[lsearch -exact [split $dlang ,] $flang] < 0} continue
					}
					
					if {[lsearch -exact $ccs(ltype) $ftype] < 0} {continue}
					set name $fname
					if {$ftype == "lang"} {append name ",$flang"}
					
					if {![compare_version [set cversion [get_version $ftype $name]] $fversion]} continue
					
					set find 1
					put_msg [sprintf ccs #195 $ftype $fname $flang $fdate $cversion $fversion]
				}
				if {!$find} {
					put_msg [sprintf ccs #189]
					return 1
				}
				
			}
			2 - 3 {
				
				if {[regexp -nocase -- {-type\s+([[:alpha:],\*]+)(?:$|\s+)} $stext -> dtype]} {
					regsub -- {-type\s+([[:alpha:],\*]+)(?:$|\s+)} $stext {} stext
				} else {
					set dtype "*"
				}
				
				if {[regexp -nocase -- {-name\s+([[:alpha:],\*]+)(?:$|\s+)} $stext -> dname]} {
					regsub -- {-name\s+([[:alpha:],\*]+)(?:$|\s+)} $stext {} stext
				} else {
					set dname "*"
				}
				
				if {[regexp -nocase -- {-lang\s+([[:alpha:],\*]+)(?:$|\s+)} $stext -> dlang]} {
					regsub -- {-lang\s+([[:alpha:],\*]+)(?:$|\s+)} $stext {} stext
				} else {
					set dlang "*"
				}
				
				if {$type == 2 && (($dtype == "*" && $dname == "*" && $dlang == "*") || [string length [string trim $stext]] != 0)} {put_help; return 0}
				
				set find 0
				set error 0
				set update 0
				foreach _ [get_lversion] {
					foreach {ftype fname flang fversion fauthor fdate ffiles furl fdiscription} $_ break
					
					if {$type == 2} {
						
						if {$dtype == "*"} {
							if {$ftype != "mod" && $ftype != "lang"} continue
						} else {
							if {[lsearch -exact [split $dtype ,] $ftype] < 0} continue
						}
						if {$dname != "*"} {
							if {[lsearch -exact [split $dname ,] $fname] < 0} continue
						}
						if {$dlang != "*" && $flang != "*"} {
							if {[lsearch -exact [split $dlang ,] $flang] < 0} continue
						}
						
					}
					if {[lsearch -exact $ccs(ltype) $ftype] < 0} {continue}
					set name $fname
					if {$ftype == "lang"} {append name ",$flang"}
					
					set cversion [get_version $ftype $name]
					if {$type == 3 && $cversion == ""} continue
					if {![compare_version $cversion $fversion]} continue
					
					set find 1
					put_msg [sprintf ccs #195 $ftype $fname $flang $fdate $cversion $fversion]
					foreach {sfile dfile} $ffiles {
						set file [string map [list %pscr $ccs(scrdir) %plib $ccs(libdir) %plang $ccs(langdir) %pmod $ccs(moddir) %is $ccs(info_script)] $dfile]
						if {[update_file $furl/$sfile $file]} {
							incr update
							put_log "$furl/$sfile to $file v$fversion (successfull)."
						} else {
							incr error
							put_log "$furl/$sfile to $file v$fversion (\0034unsuccessfull\003)."
						}
					}
				}
				if {!$find} {
					put_msg [sprintf ccs #189]
					return 1
				} else {
					put_msg [sprintf ccs #196 $update $error]
					if {$error > 0} {
						put_msg [sprintf ccs #197]
					} else {
						put_msg [sprintf ccs #166]
						save
						put_msg [sprintf ccs #167]
						rehash
					}
					return 1
				}
				
			}
			4 {
				
				for {set i 0} {$i <= 6} {incr i} {
					foreach _ $ccs(urls) {
						
						set data [get_httpdata "$_/ccs.r${i}-template.tcl"]
						if {[string is space $data]} continue
						set data [encoding convertfrom cp1251 $data]
						
						if {[file exists "$ccs(ccsdir)/ccs.r${i}.tcl"]} {
							set file "ccs.r${i}-template.tcl"
						} else {
							set file "ccs.r${i}.tcl"
						}
						if {[catch {
							savefile "$ccs(ccsdir)/$file" $data
						} errMsg]} {
							put_msg [sprintf ccs #192 $errMsg]
						} else {
							put_msg [sprintf ccs #191 "$ccs(ccsdir)/$file"]
						}
						break
						
					}
				}
				
			}
		}
		
	}
	
	#############################################################################################################
	# Процедуры команд управления помощью (HELP).
	
	proc cmd_help {} {
		importvars [list onick ochan obot snick shand schan command stext]
		variable ccs
		
		set lcommands [list]
		foreach _ [concat $ccs(commands) $ccs(scr_commands)] {
			set lalias [list]
			foreach alias $ccs(alias,$_) {
				lappend lalias [string map [list %pref_ $ccs(pref_pub)] $alias]
				lappend lalias [string map [list %pref_ $ccs(pref_msg)] $alias]
				lappend lalias [string map [list %pref_ ""] $alias]
			}
			foreach alias $lalias {
				if {[string match -nocase $stext $alias]} {lappend lcommands $_; break}
			}
		}
		
		if {[llength $lcommands] > 0} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 0; set par_scr 0
		} elseif {[string equal -nocase $stext "all"]} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 0; set par_scr 0
		} elseif {[string equal -nocase $stext "limit"]} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 1; set par_scr 0
		} elseif {[string equal -nocase $stext "scr"] || [string equal -nocase $stext "script"] || [string equal -nocase $stext "scripts"]} {
			set par_access 1; set par_commands 1; set par_group 0; set par_limit 0; set par_scr 1
		} else {
			set par_access		[regexp -nocase -all -- {-a(?:ccess)?} $stext]
			set par_commands	[regexp -nocase -all -- {-c(?:ommands)?} $stext]
			set par_group		[regexp -nocase -all -- {-g(?:roup)?\ +([\w]+)} $stext -> group]
			set par_limit		[regexp -nocase -all -- {-l(?:imit)?} $stext]
			set par_scr			[regexp -nocase -all -- {-s(?:cript(?:s)?)?} $stext]
			if {$par_group && [lsearch -exact $ccs(groups) [string tolower $group]] < 0} \
				{put_msg [sprintf ccs #177 $group [join $ccs(groups)]] -speed 3; return 0}
			if {!$par_group && $ccs(help_group)} {put_msg [sprintf ccs #178 [join $ccs(groups)]] -speed 3; return 0}
		}
		
		if {$par_limit && [check_isnull $schan]} {put_msg [sprintf ccs #200] -speed 3; return 0}
		
		set find 0
		if {$par_access || $par_commands || $par_group || $par_limit || $par_scr} {
			if {[llength $lcommands] > 0} {
				foreach _ $lcommands {
					set lout_text [get_help $_ "pub" $par_access $par_commands [expr [llength $lcommands] == 1]]
					if {[llength $lout_text] > 0} {
						if {!$find && [llength $lcommands] > 1} {
							put_msg [sprintf ccs #101 $::ccs::version $::ccs::date $::ccs::author \
								$ccs(pref_pub) $ccs(pref_msg) $ccs(pref_dcc) \
								$ccs(pref_pubcmd) $ccs(pref_msgcmd) $ccs(pref_dcccmd)] -speed 3
						}
						foreach _ $lout_text {put_msg $_ -speed 3}; set find 1
					}
				}
			} else {
				if {$par_scr} {set lcommands $ccs(scr_commands)} else {set lcommands $ccs(commands)}
				foreach _ $lcommands {
					if {![use_command $_]} continue
					if {$par_group && ![string equal -nocase $group $ccs(group,$_)]} continue
					if {$par_limit && ![check_matchattr $shand $schan $ccs(flags,$_)]} continue
					
					set lout_text [get_help $_ "pub" $par_access $par_commands 0]
					if {[llength $lout_text] > 0} {
						if {!$find} {
							put_msg [sprintf ccs #101 $::ccs::version $::ccs::date $::ccs::author \
								$ccs(pref_pub) $ccs(pref_msg) $ccs(pref_dcc) \
								$ccs(pref_pubcmd) $ccs(pref_msgcmd) $ccs(pref_dcccmd)] -speed 3 -ochan $onick
						}
						foreach _ $lout_text {put_msg $_ -speed 3 -ochan $onick}; set find 1
					}
				}
			}
		}
		if {!$find} {put_help; return 0}
		put_log ""
		return 1
		
	}
	
	proc update_file {url filename} {
		importvars [list onick ochan obot snick shand schan]
		variable ccs
		
		set data [get_httpdata $url]
		if {[string is space $data]} {return 0}
		set data [encoding convertfrom cp1251 $data]
		
		if {[catch {
			savefile $filename $data -bak
		} errMsg]} {put_msg [sprintf ccs #192 $errMsg]; return 0}
		return 1
		
	}
	
	proc savefile {filename data args} {
		variable ccs
		global errorInfo
		
		set sbak [expr [lsearch $args -bak] >= 0]
		set slist [expr [lsearch $args -list] >= 0]
		set sappend [expr [lsearch $args -append] >= 0]
		
		catch {file mkdir [file dirname $filename]}
		if {[catch {
			if {$sbak && [file exists $filename]} {
				catch {file mkdir $ccs(bakdir)}
				file rename $filename "$ccs(bakdir)/[get_filename $filename]~bak[clock format [unixtime] -format %y%m%d%H%M%S]"
			}
			set fileio [open $filename [expr {$sappend ? "a" : "w"}]]
			if {$slist} {
				foreach _ $data {puts $fileio $_}
			} else {
				puts $fileio $data
			}
			flush $fileio
			close $fileio
		} errMsg]} {
			debug "can't write file (data): \002$filename\002"
			debug "($errMsg)"
			return -code error -errorinfo $errorInfo $errMsg
		}
		return -code ok
		
	}
	
	proc loadfile {filename args} {
		global errorInfo
		
		if {[catch {
			set fid [open $filename r]
			set data [read $fid]
			close $fid
		} errMsg]} {
			debug "can't load file (data): \002$filename\002"
			debug "($errMsg)"
			return -code error -errorinfo $errorInfo $errMsg
		}
		return -code ok $data
		
	}
	
	proc get_lversion {} {
		importvars [list onick ochan obot snick shand schan]
		variable ccs
		
		foreach url $ccs(urls) {
			put_msg [sprintf ccs #193 "$url/$ccs(file_ccsversion)"]
			if {[string is space [set data [get_httpdata "$url/$ccs(file_ccsversion)"]]]} continue
			foreach _ [split $data \n] {
				
				if {[string is space $_]} continue
				foreach {ftype fname flang fversion fauthor fdate ffiles fdiscription} $_ break
				
				if {[lsearch -exact $ccs(ltype) $ftype] < 0} {continue}
				set name $fname
				if {$ftype == "lang"} {append name ",$flang"}
				
				if {![info exists fileinfo($ftype,version,$name)] || [compare_version $fileinfo($ftype,version,$name) $fversion]} {
					set fileinfo($ftype,name,$name)			$fname
					set fileinfo($ftype,lang,$name)			$flang
					set fileinfo($ftype,version,$name)		$fversion
					set fileinfo($ftype,author,$name)		$fauthor
					set fileinfo($ftype,date,$name)			$fdate
					set fileinfo($ftype,files,$name)		$ffiles
					set fileinfo($ftype,url,$name)			$url
					set fileinfo($ftype,discription,$name)	$fdiscription
				}
				
			}
		}
		
		set lversion [list]
		foreach type $ccs(ltype) {
			foreach _ [array names fileinfo -glob "$type,name,*"] {
				set name [join [lrange [split $_ ,] 2 end] ,]
				lappend lversion [list $type $fileinfo($type,name,$name) \
					$fileinfo($type,lang,$name) $fileinfo($type,version,$name) \
					$fileinfo($type,author,$name) $fileinfo($type,date,$name) \
					$fileinfo($type,files,$name) $fileinfo($type,url,$name) \
					$fileinfo($type,discription,$name)]
			}
		}
		return $lversion
		
	}
	
	proc get_httpdata {url} {
		importvars [list onick ochan obot shandn]
		
		if {[catch {
			#put_msg [sprintf ccs #193 $url]
			set token [::http::geturl $url \
				-timeout 60000 \
				-blocksize 32768 \
				-binary true]
			
			set errid	[::http::status $token]
			set ncode	[::http::ncode $token]
			set errtxt	[::http::error $token]
			set data	[::http::data $token]
			#set code	[::http::code $token]
			::http::cleanup $token
			
			if {$errid == "ok" && $ncode == 200} {
			} else {
				set data ""
				put_msg [sprintf ccs #194 "$errid $ncode $errtxt"]
			}
		} errMsg]} {
			set data ""
			put_msg [sprintf ccs #194 $errMsg]
		}
		return $data
		
	}
	
	#############################################################################################################
	# Процедуры авторизации пользователей (AUTH).
	
	# Процедура авторизации по нику/хендлу
	proc addauth {shand snick shost} {
		variable ccs
		
		set authnick [getuser $shand XTRA AuthNick]
		if {[lsearch -exact $authnick $snick!$shost] >= 0} {return 0}
		lappend authnick $snick!$shost
		setuser $shand XTRA AuthNick $authnick
		chattr $shand +$ccs(flag_auth)
		return 1
		
	}
	
	# Процедура снятия авторизации по нику/хендлу
	proc delauth {shand snick shost} {
		variable ccs
		
		set authnick [getuser $shand XTRA AuthNick]
		if {[set ind [lsearch -exact $authnick $snick!$shost]] < 0} {return 0}
		set authnick [lreplace $authnick $ind $ind]
		setuser $shand XTRA AuthNick $authnick
		if {[llength $authnick] == 0} {chattr $shand -$ccs(flag_auth)}
		return 1
		
	}
	
	proc msg_identauth {nick uhost hand text} {
		variable ccs
		global network botnick strict-host
		
		set snick $nick
		set shand $hand
		set shost $uhost
		set schan "*"
		set onick $nick
		set ochan "*"
		set text [string trim $text]
		set command "IDENTAUTH"
		
		if {![check_isnull $shand]} {put_msg [sprintf ccs #112 [get_nick $snick $shost]]; return 0}
		if {![regexp -- {^(?:([^\ ]*)\s+)?([^\ ]+)$} $text -> dhand pass]} {put_msg [sprintf ccs #114 $botnick]; return 0}
		
		if {[check_isnull $dhand]} {set dhand $snick}
		if {![validuser $dhand]} {put_msg [sprintf ccs #123 $dhand]; return 0}
		if {![passwdok $dhand $pass]} {put_msg [sprintf ccs #132 [get_nick $snick $shand]]; put_log "(\0034unsuccessfull\003)"; return 0}
		
		if {${strict-host} == 0} {
			set hm "$snick![regsub {^~} $shost {}]"
		} else {
			set hm "$snick!$shost"
		}
		setuser $dhand HOSTS $hm
		set shand $dhand
		
		if {![addauth $shand $snick $shost]} {put_msg [sprintf ccs #130]; return 0}
		if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsaddauth $snick $shost $network}
		put_msg [sprintf ccs #131 [get_nick $snick $shand] $ccs(pref_pub) $ccs(pref_msg) \
				$ccs(pref_dcc) $ccs(pref_pubcmd) $ccs(pref_msgcmd) $ccs(pref_dcccmd)]
		
		if {![onchan $snick]} {
			after $ccs(time_auth_notonchan) [list [namespace origin autoauthoff] $snick $uhost $shand 0]
		}
		put_log "ON"
		return 0
		
	}
	
	# авторизация и удаление авторизации через команду, поралельно идет рассылка по ботнету
	proc msg_auth {nick uhost hand text} {
		variable ccs
		global network botnick
		
		set snick $nick
		set shand $hand
		set shost $uhost
		set schan "*"
		set onick $nick
		set ochan "*"
		set text [string trim $text]
		set command "AUTH"
		
		if {[info exists ccs(authprocs)]} {
			foreach _ $ccs(authprocs) {if {[proc_exists $_]} {catch {$_ $nick $uhost $hand $text}}}
		}
		
		if {[check_isnull $shand]} {put_msg [sprintf ccs #127]; return 0}
		if {![regexp -- {^([^\ ]*)$} $text -> pass]} {put_msg [sprintf ccs #121 $botnick]; return 0}
		
		if {$pass == ""} {
			if {![delauth $shand $snick $shost]} {put_msg [sprintf ccs #128]; return 0}
			if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsdelauth $snick $shost $network 1}
			put_msg [sprintf ccs #129 [get_nick $snick $shand]]
			put_log "OFF"
		} else {
			if {[passwdok $shand -]} {put_msg [sprintf ccs #212 [get_nick $snick $shand] $botnick]; return 0}
			if {![passwdok $shand $pass]} {put_msg [sprintf ccs #132 [get_nick $snick $shand]]; put_log "(\0034unsuccessfull\003)"; return 0}
			if {![addauth $shand $snick $shost]} {put_msg [sprintf ccs #130]; return 0}
			if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsaddauth $snick $shost $network}
			put_msg [sprintf ccs #131 [get_nick $snick $shand] $ccs(pref_pub) $ccs(pref_msg) \
				$ccs(pref_dcc) $ccs(pref_pubcmd) $ccs(pref_msgcmd) $ccs(pref_dcccmd)]
			
			if {![onchan $snick]} {
				after $ccs(time_auth_notonchan) [list [namespace origin autoauthoff] $snick $uhost $shand 0]
			}
			put_log "ON"
			
		}
		return 0
		
	}
	
	proc nick_auth {nick uhost hand chan newnick} {
		global network
		
		set snick $nick
		set shand $hand
		set shost $uhost
		set schan "*"
		set onick $newnick
		set ochan "*"
		set command "AUTH"
		
		if {[nick2hand $newnick] != $shand} {
			if {![delauth $shand $snick $shost]} {return 0}
			if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsdelauth $snick $shost $network 0}
			put_msg [sprintf ccs #211]
			put_log "OFF"
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
		variable ccs
		after $ccs(time_auth_part) [list [namespace origin autoauthoff] $nick $uhost $hand 0]
	}
	
	proc kick_auth {nick uhost hand chan target reason} {
		variable ccs
		after $ccs(time_auth_part) [list [namespace origin autoauthoff] $target [getchanhost $target] [nick2hand $target] 0]
	}
	
	# бинд срабатывающий при выходе юзера из ирц
	proc sign_auth {nick uhost hand chan text} {
		variable ccs
		after $ccs(time_auth_part) [list [namespace origin autoauthoff] $nick $uhost $hand 1]
	}
	
	proc splt_auth {nick uhost hand chan} {
		variable ccs
		after $ccs(time_auth_part) [list [namespace origin autoauthoff] $nick $uhost $hand 1]
	}
	
	# снятие авторизации при выходе юзера, так же рассылка в ботнет о снятии авторизации
	proc autoauthoff {snick shost shand quiet} {
		global network
		
		set schan "*"
		set onick $snick
		set ochan "*"
		set command "AUTOAUTH"
		
		if {[onchan $snick]} {return 0}
		if {![delauth $shand $snick $shost]} {return 0}
		if {[proc_exists "putbot_authall"]} {putbot_authall $shand ccsdelauth $snick $shost $network 0}
		if {!$quiet} {put_msg [sprintf ccs #126]}
		put_log "OFF"
		
	}
	
	#############################################################################################################
	# Дополнительные процедуры и функции (PROC).
	
	# Функция получения хостмаски из хоста
	proc get_mask {uhost ind} {
		variable ccs
		
		set a [string first ! $uhost]
		set b [string first @ $uhost]
		set nick [string range $uhost 0 [expr $a-1]]
		set ident [string range $uhost [expr $a+1] [expr $b-1]]
		set host [string range $uhost [expr $b+1] end]
		
		set theretilde [regsub {^~} $ident {} nident]
		
		if {[string length $nident] > [expr $ccs(identlen)-[expr {$theretilde ? 2 : 1}]]} {
			set nident *[string range $nident 0 [expr $ccs(identlen)-3]]*
		} else {
			set nident *$nident
		}
		
		set maddr [maskhost $uhost]
		set mhost [string range $maddr [expr [string first @ $maddr]+1] end]
		switch -exact -- $ind {
			0 {return $nick!$ident@$host}
			1 {return *!$ident@$host}
			2 {return *!$nident@$host}
			3 {return *!*@$host}
			4 {return *!$nident@$mhost}
			5 {return *!*@$mhost}
			6 {return $address}
			7 {return $nick!$nident@$host}
			8 {return $nick!*@$host}
			9 {return $nick!$nident@$mhost}
			10 {return $nick!*@$mhost}
			default {return $uhost}
		}
		
	}
	
	# Функция проверки и получения хендла из указаного ника/хендла
	proc get_hand {dnick args} {
		importvars [list onick ochan obot snick shand schan] $args [list quiet 0]
		
		if {[onchan $dnick]} {
			if {[check_isnull [set dhand [nick2hand $dnick]]]} {
				if {![validuser $dnick]} {if {!$quiet} {put_msg [sprintf ccs #123 $dnick]}; return ""}
				if {!$quiet} {put_msg [sprintf ccs #122 $dnick $dnick]}
				return $dnick
			} else {
				if {![string equal -nocase $dnick $dhand] && [validuser $dnick]} \
					{if {!$quiet} {put_msg [sprintf ccs #124 $dnick $dhand $dnick $dhand]}; return ""}
				return $dhand
			}
		} else {
			if {![validuser $dnick]} {if {!$quiet} {put_msg [sprintf ccs #125 $dnick]}; return ""}
			return $dnick
		}
		
	}
	
	# Функция получения уровня доступа
	proc get_accesshand {shand schan {useowner 0}} {
		
		if {[check_isnull $shand]} {return 0}
		
		set powner 0
		if {$useowner} {
			global owner
			foreach _ [split $owner ", "] {
				if {![string is space $_] && [string equal -nocase $_ $shand]} {set powner 1; break}
			}
		}
		
		if {$powner} {
			return 9
		} elseif {[matchattr $shand n]} {
			return 8
		} elseif {[matchattr $shand m]} {
			return 7
		} elseif {[matchattr $shand o]} {
			return 6
		} elseif {[matchattr $shand l]} {
			return 5
		} elseif {![check_isnull $schan] && [matchattr $shand -|n $schan]} {
			return 4
		} elseif {![check_isnull $schan] && [matchattr $shand -|m $schan]} {
			return 3
		} elseif {![check_isnull $schan] && [matchattr $shand -|o $schan]} {
			return 2
		} elseif {![check_isnull $schan] && [matchattr $shand -|l $schan]} {
			return 1
		} else {
			return 0
		}
		
	}
	
	# Функция получения установленного параметра
	proc get_options {param {schan ""}} {
		variable ccs
		
		if {[check_isnull $schan] || ![validchan $schan]} {
			if {[info exists ccs($param)] && $ccs($param) >= 0} {return $ccs($param)}
		} else {
			set cset [channel get $schan ccs-$param]
			if {![string is space $cset] && $cset >= 0} {return $cset}
			if {[info exists ccs($param)] && $ccs($param) >= 0} {return $ccs($param)}
		}
		return 0
		
	}
	
	# Функция получения помощи по команде
	proc get_help {command type par_access par_commands full} {
		importvars [list shand schan]
		variable ccs
		global botnick
		
		set lout_text [list]
		set out_text ""
		
		set alias [string map [list %pref_ $ccs(pref_$type)] $ccs(alias,$command)]
		
		append out_text "\002[lindex $alias 0]"
		if {$type != "pub"} {
			set use_chan [get_var use_chan $command 1]
			switch -exact -- $use_chan {
				1 {append out_text " <chan>"}
				2 {append out_text " <chan|*>"}
				3 {append out_text " \[chan\]"}
			}
		}
		set arg [get_textlang $shand $schan args $command]
		append out_text "[expr {[string is space $arg] ? "" : " $arg"}]\002"
		
		if {$full} {set help2 [get_textlang $shand $schan help2 $command]} else {set help2 "null"}
		
		if {$help2 == "null"} {
			set help [get_textlang $shand $schan help $command]
			append out_text " - [string map [list %pref_ $ccs(pref_pub) %botnick $botnick %groups [join $ccs(groups) ", "]] $help]."
		}
		
		if {$par_commands} {if {[llength $alias] > 1} {append out_text [sprintf ccs #185 [join [lrange $alias 1 end] ", "]]}}
		if {$par_access} {append out_text [sprintf ccs #186 [join $ccs(flags,$command) ", "]]}
		
		lappend lout_text [string trim $out_text]
		if {$help2 != "null"} {
			foreach _ $help2 {
				lappend lout_text [string map [list %pref_ $ccs(pref_pub) %botnick $botnick %groups [join $ccs(groups) ", "]] $_]
			}
		}
		return $lout_text
		
	}
	
	# Функция получения строки представления имени пользователя с хендлом
	proc get_nick {snick shand {pref \002}} {
		if {![check_isnull $snick] && ![check_isnull $shand]} {
			if {$snick == $shand} {return "$pref$snick$pref"} else {return "$pref$snick$pref ($pref$shand$pref)"}
		} elseif {![check_isnull $snick] && [check_isnull $shand]} {
			return "$pref$snick$pref"
		} elseif {[check_isnull $snick] && ![check_isnull $shand]} {
			return "$pref$shand$pref"
		}
	}
	
	proc proc_exists {name} {
		if {[info procs $name] == [list $name]} {return 1} else {return 0}
	}
	
	proc get_var {par command default} {
		variable ccs
		if {[info exists ccs($par,$command)]} {return $ccs($par,$command)} else {return $default}
	}
	
	# Функция получения текста на выбранный язык для пользователя
	proc get_textlang {shand schan par1 par2} {
		variable ccs
		
		set usecolors [get_options usecolors $schan]
		
		set llang [list]
		if {![check_isnull $shand]} {
			foreach _ [getuser $shand XTRA ccs-default_lang] {
				if {[string is space $_]} continue
				if {[lsearch -exact $llang $_] < 0} {lappend llang $_}
			}
		}
		if {![check_isnull $schan] && [validchan $schan]} {
			foreach _ [channel get $schan ccs-default_lang] {
				if {[string is space $_]} continue
				if {[lsearch -exact $llang $_] < 0} {lappend llang $_}
			}
		}
		if {[info exists ccs(default_lang)]} {
			foreach _ $ccs(default_lang) {
				if {[string is space $_]} continue
				if {[lsearch -exact $llang $_] < 0} {lappend llang $_}
			}
		}
		
		foreach _ $llang {
			if {!$usecolors && [info exists ccs(bw$par1,$_,$par2)]} {return $ccs(bw$par1,$_,$par2)}
			if {[info exists ccs($par1,$_,$par2)]} {return $ccs($par1,$_,$par2)}
		}
		
		return "null"
		
	}
	
	proc get_dirname {name} {
		return [string range $name 0 [expr [string last "/" $name]-1]]
	}
	
	proc get_filename {name} {
		return [string range $name [expr [string last "/" $name]+1] end]
	}
	
	proc get_token {id} {
		variable ccs
		
		if {![info exists ccs(token,$id)]} {
			set ccs(token,$id) 1
		} else {
			incr ccs(token,$id)
		}
		return "$id$ccs(token,$id)"
		
	}
	
	proc clear_token {id token} {
		variable ccs
		
		set ind [string range $token [string length $id] end]
		if {$ccs(token,$id) == $ind} {incr ccs(token,$id) -1}
		
	}
	
	proc notavailable-isop {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {[isop $dnick $dchan]} {
			if {$snick == $dnick} {put_msg [sprintf ccs #133 $schan]} else {put_msg [sprintf ccs #134 $dnick $dchan]}
			return 1
		}
		return 0
	}
	
	proc notavailable-getting_users {} {
		importvars [list snick shand schan onick ochan obot command]
		if {[getting-users]} {put_msg [sprintf ccs #117]; return 1}
		return 0
	}
	
	proc notavailable-isbotnick {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick
		if {[isbotnick $dnick]} {return 1}
		return 0
	}
	
	proc notavailable-notonchan {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {![onchan $dnick $dchan]} {put_msg [sprintf ccs #119 $dnick $dchan]; return 1}
		return 0
	}
	
	proc notavailable-protect {} {
		variable ccs
		importvars [list snick shand schan onick ochan obot command]
		upvar dhand dhand dchan dchan
		if {[check_isnull $dhand] && (([check_isnull $dchan] && [matchattr $dhand $ccs(flag_protect)]) \
			|| (![check_isnull $dchan] && [matchattr $dhand $ccs(flag_protect) $dchan])) && ![matchattr $shand n]} {
			put_msg [sprintf ccs #179 $dhand]; return 1
		}
		return 0
	}
	
	proc notavailable-locked {} {
		variable ccs
		importvars [list snick shand schan onick ochan obot command]
		upvar dhand dhand
		if {[check_isnull $dhand] && [matchattr $dhand $ccs(flag_locked)] && ![matchattr $shand n]} {
			put_msg [sprintf ccs #116 $shand]; return 1
		}
		return 0
	}
	
	# Запрет если уровень доступа меньше
	proc notavailable-nopermition0 {} {
		variable ccs
		importvars [list snick shand schan onick ochan obot command]
		upvar dchan dchan dhand dhand dnick dnick
		set saccess [get_accesshand $shand $dchan 1]
		if {[info exists ccs(override_level,$command)] && $ccs(override_level,$command) > $saccess} {set saccess $ccs(override_level,$command)}
		set daccess [get_accesshand $dhand $dchan]
		if {($saccess <= $daccess)} {put_msg [sprintf ccs #102 $command [get_nick $dnick $dhand]]; return 1}
		return 0
	}
	
	# Запрет если уровень доступа меньше и действия производится не над собой
	proc notavailable-nopermition1 {} {
		variable ccs
		importvars [list snick shand schan onick ochan obot command]
		upvar dhand dhand dchan dchan dnick dnick
		if {$shand == $dhand} {return 0}
		set saccess [get_accesshand $shand $dchan 1]
		if {[info exists ccs(override_level,$command)] && $ccs(override_level,$command) > $saccess} {set saccess $ccs(override_level,$command)}
		set daccess [get_accesshand $dhand $dchan]
		if {($saccess <= $daccess)} {put_msg [sprintf ccs #102 $command [get_nick $dnick $dhand]]; return 1}
		return 0
	}
	
	proc notavailable-notisop {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {![isop $dnick $dchan]} {
			if {$snick == $dnick} {put_msg [sprintf ccs #136]} else {put_msg [sprintf ccs #137 $dnick $dchan]}
			return 1
		}
		return 0
	}
	
	proc notavailable-ishalfop {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {[ishalfop $dnick $dchan]} {
			if {$snick == $dnick} {put_msg [sprintf ccs #138 $dchan]} else {put_msg [sprintf ccs #139 $dnick $dchan]}
			return 1
		}
		return 0
	}
	
	proc notavailable-notishalfop {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {![ishalfop $dnick $dchan]} {
			if {$snick == $dnick} {put_msg [sprintf ccs #140]} else {put_msg [sprintf ccs #141 $dnick $dchan]}
			return 1
		}
		return 0
	}
	
	proc notavailable-isvoice {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {[isvoice $dnick $dchan]} {
			if {$snick == $dnick} {put_msg [sprintf ccs #142 $dchan]} else {put_msg [sprintf ccs #143 $dnick $dchan]}
			return 1
		}
		return 0
	}
	
	proc notavailable-notisvoice {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dnick dnick dchan dchan
		if {![isvoice $dnick $dchan]} {
			if {$snick == $dnick} {put_msg [sprintf ccs #144 $dchan]} else {put_msg [sprintf ccs #145 $dnick $dchan]}
			return 1
		}
		return 0
	}
	
	proc notavailable-validhandle {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dhand dhand dnick dnick
		if {![check_isnull $dhand]} {put_msg [sprintf ccs #169 [get_nick $dnick $dhand]]; return 1}
		return 0
	}
	
	proc notavailable-notvalidhandle {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dhand dhand
		if {[check_isnull $dhand]} {return 1}
		return 0
	}
	
	proc notavailable-validchan {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dchan dchan
		if {[validchan $dchan]} {put_msg [sprintf ccs #170 $dchan]; return 1}
		return 0
	}
	
	proc notavailable-notisbot {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dhand dhand dnick dnick
		if {![matchattr $dhand b]} {put_msg [sprintf ccs #188 [get_nick $dnick $dhand]]; return 1}
		return 0
	}
	
	proc notavailable-bitch {} {
		importvars [list snick shand schan onick ochan obot command]
		upvar dchan dchan dnick dnick
		if {[channel get $dchan bitch] && ![matchattr [nick2hand $dnick] o|o $dchan]} {
			put_msg [sprintf ccs #135 $dnick $dchan]; return 1
		}
		return 0
	}
	
	proc check_notavailable {lo args} {
		global botnick
		importvars [list snick shand schan onick ochan obot command]
		
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
	
	# Функция проверки пустого значения для хендла/канала
	proc check_isnull {str} {
		if {$str == "" || $str == "*"} {return 1} else {return 0}
	}
	
	# Функция проверки авторизации
	proc check_auth {snick shand shost {sidx 0} {sbot *}} {
		variable ccs
		
		if {[string is integer $sidx] && $sidx > 0 && [valididx $sidx]} {
			return 1
		}
		if {[matchattr $shand $ccs(flag_auth_perm)] && [check_isnull $sbot]} {
			return 1
		}
		if {[matchattr $shand $ccs(flag_auth)]} {
			set authnick [getuser $shand XTRA AuthNick]
			set ind [lsearch -exact $authnick $snick!$shost]
			if {$ind >= 0} {return 1}
		}
		if {![check_isnull $sbot] && [matchattr $shand $ccs(flag_auth_botnet)]} {
			set authnick [getuser $shand XTRA AuthBot]
			set ind [lsearch -exact $authnick $sbot]
			if {$ind >= 0} {return 1}
		}
		global botnick
		importvars [list onick ochan obot]
		put_msg [sprintf ccs #120]
		put_msg [sprintf ccs #121 $botnick]
		return 0
		
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
	
	proc compare_version {version1 version2} {
		
		set dec1 [split $version1 .]; set dec2 [split $version2 .]
		foreach a1 $dec1 a2 $dec2 {
			if {[string is space [set a1 [string trimleft $a1 0]]]} {set a1 0}
			if {[string is space [set a2 [string trimleft $a2 0]]]} {set a2 0}
			
			if {$a2 > $a1} {return 1} elseif {$a2 < $a1} {return 0}
		}
		return 0
		
	}
	
	proc get_version {type name} {
		variable ccs
		if {[info exists ccs($type,version,$name)]} {return $ccs($type,version,$name)} else {return ""}
	}
	
	proc addfileinfo {type name author version date {description ""}} {
		variable ccs
		if {![info exists ccs($type,name,$name)]} {set ccs($type,name,$name) 1}
		set ccs($type,author,$name)			$author
		set ccs($type,version,$name)		$version
		set ccs($type,date,$name)			$date
		set ccs($type,description,$name)	$description
		set ccs($type,info_script,$name)	[info script]
	}
	
	# Удалить
	proc addmod {name author version date {description ""}} {addfileinfo mod $name $author $version $date $description}
	proc addlang {name lang author version date {description ""}} {addfileinfo lang "$name,$lang" $author $version $date $description}
	
	proc get_fileinfo {type {only_on 0}} {
		variable ccs
		set l [list]
		foreach _ [array names ccs -glob "$type,name,*"] {
			if {$only_on && !$ccs($_)} continue
			if {[llength [split $_ ,]] > 3} {
				lappend l [lrange [split $_ ,] 2 end]
			} else {
				lappend l [lindex [split $_ ,] 2]
			}
		}
		return $l
	}
	
	proc importvars {lo {la {}} {ln {}}} {
		
		set lvars [list]
		foreach {var value} $ln {uplevel [list set $var $value]; lappend lvars $var}
		foreach {flag value} $la {
			if {[string index $flag 0] == "-"} {
				set var [string range $flag 1 end]
				uplevel [list set $var $value]
				lappend lvars $var
			}
		}
		foreach var $lo {
			if {[lsearch $lvars $var] < 0} {
				set value [uplevel 2 "if {\[info exists $var\]} {set $var} else {set $var \"\"}"]
				uplevel [list set $var $value]
			}
		}
		
	}
	
	#############################################################################################################
	# Процедуры вывода сообщений
	
	proc put_log {text args} {
		importvars [list snick shand schan command] $args [list level 1]
		
		set lout [list]
		if {![check_isnull $snick] && ![check_isnull $shand]} {
			lappend lout "<<$snick[expr {$snick != $shand ? " ($shand)" : ""}]>>"
		} elseif {![check_isnull $snick]} {
			lappend lout "<<$snick>>"
		} elseif {![check_isnull $shand]} {
			lappend lout "<<($shand)>>"
		}
		
		if {![check_isnull $schan]} {lappend lout "!$schan!"}
		if {$command != ""} {lappend lout [string toupper $command]}
		lappend lout $text
		
		debug [join $lout] $level
		
	}
	
	proc put_msg {text args} {
		variable ccs
		importvars [list onick ochan obot] $args [list quiet 1 speed 2 mode ""]
		
		valid_out $onick $ochan $obot
		
		if {[use_botnet $obot]} {
			foreach {dbothand shand thand} $obot break
			if {[islinked $dbothand]} {
				if {[check_notavailable {-notvalidpasscmdbot} -dbotnick $dbothand -dbothand $dbothand -quiet 1 +dbotpass dbotpass]} {return 0}
				if {[proc_exists "send_ccstext"]} {send_ccstext $dbothand $dbotpass $thand $shand $onick $ochan $quiet $text}
				return
			} else {
				put_log "PUT_MSG not link $dbothand"
			}
		}
		
		if {($onick == $ochan && $mode == "") || $mode == "user"} {
			if {[string is integer $onick]} {
				put_msgdest $onick $text -type dcc
			} else {
				put_msgdest $onick $text -speed $speed -type privmsg
			}
		} elseif {($quiet && $mode == "") || $mode == "notice"} {
			put_msgdest $onick $text -speed $speed -type notice
		} elseif {(!$quiet && $mode == "") || $mode == "chan"} {
			put_msgdest $ochan $text -speed $speed -type privmsg
		}
		
	}
	
	proc put_msgdest {nick text args} {
		variable ccs
		importvars [list] $args [list speed 2 type privmsg]
		
		set text [string map [list {\002} "\002" {\037} "\037" {\026} "\026" {\003} "\003" {\017} "\017"] $text]
		
		set list_out [list]
		
		if {[string length $text] <= $ccs(msg_len)} {
			lappend list_out $text
		} else {
			
			set str_out ""
			set str_color ""
			set new 1
			foreach _0 [split $text] {
				
				if {$new} {set _1 $_0; set new 0} else {set _1 " $_0"}
				
				if {[string length "$_0"] > $ccs(msg_len)} {
					# слово больше длины строки, чтобы не терять место прибвляем к прошлой строке и начинаем дробить
					set str_tmp "$str_out$_1"
					while {[string length $str_tmp] > $ccs(msg_len)} {
						set str_out [string range "$str_color$str_tmp" 0 [expr $ccs(msg_len)-1]]
						set str_tmp [string range "$str_color$str_tmp" $ccs(msg_len) end]
						lappend list_out "$str_color$str_out"
						foreach {block color} [regexp -all -inline -- {(\003\d{1,2}(?:,\d{1,2})?|\003|\037|\026|\017|\002|\d{1,2}(?:,\d{1,2})?|||||)} $str_out] {
							append str_color "$color"
						}
						while {[regexp -all -- {[\017](.*?)$} $str_color -> str_color] == 1} {}
						regsub -all -- {} $str_color {} str_color; regsub -all -- {\037\037} $str_color {} str_color
						regsub -all -- {} $str_color {} str_color; regsub -all -- {\002\002} $str_color {} str_color
						regsub -all -- {} $str_color {} str_color; regsub -all -- {\026\026} $str_color {} str_color
					}
					set str_out $str_tmp
				} elseif {[string length "$str_color$str_out$_1"] > $ccs(msg_len)} {
					# новое слово не влезает в строку, выводим то что есть
					lappend list_out "$str_color$str_out"
					foreach {block color} [regexp -all -inline -- {(\003\d{1,2}(?:,\d{1,2})?|\003|\037|\026|\017|\002|\d{1,2}(?:,\d{1,2})?|||||)} $str_out] {
						append str_color "$color"
					}
					while {[regexp -all -- {[\017](.*?)$} $str_color -> str_color] == 1} {}
					regsub -all -- {} $str_color {} str_color; regsub -all -- {\037\037} $str_color {} str_color
					regsub -all -- {} $str_color {} str_color; regsub -all -- {\002\002} $str_color {} str_color
					regsub -all -- {} $str_color {} str_color; regsub -all -- {\026\026} $str_color {} str_color
					
					set str_out $_0
				} else {
					append str_out $_1
				}
				
			}
			
			if {![string is space $str_out]} {lappend list_out "$str_color$str_out"}
			
		}
		
		if {$type == "privmsg"} {
			set put_out "PRIVMSG [join $nick ","] :"
		} elseif {$type == "notice"} {
			set put_out "NOTICE $nick :"
		} elseif {$type == "dcc" && [valididx $nick]} {
			set put_out ""
		} else {
			return
		}
		
		foreach _ $list_out {
			set msg $put_out$_
			if {$type == "dcc"} {
				putdcc $nick $msg
			} elseif {$ccs(fast) || $speed == 0} {
				append msg "\n"
				putdccraw 0 [string length $msg] $msg
			} elseif {$speed == 1} {
				putquick $msg
			} elseif {$speed == 2} {
				putserv $msg
			} elseif {$speed == 3} {
				puthelp $msg
			}
		}
		
	}
	
	proc put_help {} {
		importvars [list onick ochan obot snick shand schan command]
		
		if {[string equal $onick $ochan]} {set type "msg"} else {set type "pub"}
		set lout_text [get_help $command $type 1 1 1]
		
		if {[llength $lout_text] > 0} {foreach _ $lout_text {put_msg $_ -speed 3}}
		
	}
	
	proc sprintf {name text args} {
		variable ccs
		
		if {[string index $text 0] == "#"} {
			importvars [list shand schan]
			if {![info exists schan]} {set schan "*"}
			set textlang [get_textlang $shand $schan "text,$name" $text]
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
	
	
	#############################################################################################################
	# Процедуры блокировки по времени
	
	proc limit {id par {time 1} {include 0}} {
		variable ccs
		if {[info exists ccs(limit_i,$id,$par)]} {return 1}
		if {![info exists ccs(limit_i,$id,$par)] && $include} {
			set ccs(limit_i,$id,$par) [list [after [expr $time*1000] [list [namespace origin limit_unset] $id $par]] $time]
			set ccs(limit_t,$id,$par) [expr [clock seconds] + $time]
		}
		return 0
	}
	
	proc limit_exp_time {id par} {
		variable ccs
		if {![info exists ccs(limit_t,$id,$par)]} {return 0}
		return [expr $ccs(limit_t,$id,$par) - [clock seconds]]
	}
	
	proc limit_unset {id par} {
		variable ccs
		if {[info exists ccs(limit_i,$id,$par)]} {unset ccs(limit_i,$id,$par)}
		if {[info exists ccs(limit_t,$id,$par)]} {unset ccs(limit_t,$id,$par)}
	}
	
	#############################################################################################################
	# Процедуры поднятия и убивания биндов
	
	proc fixbind {} {
		variable ccs
		
		set ccs(authprocs) [list]
		
		foreach _ [binds auth] {
			
			if {[lindex $_ 0] != "msg"} continue
			set p [lindex $_ 4]
			if {$p != [namespace origin msg_auth]} {
				if {[string range $p 0 1] != "::"} {set p "::$p"}
				lappend ccs(authprocs) $p
			}
			
		}
		bind msg -|- auth			[namespace origin msg_auth]
		
	}
	
	proc fixstick {chan ind} {
		
		if {[ischanjuped $chan]} return
		if {![botonchan $chan]} {
			incr ind
			if {$ind > 4} return
			after 3000 [list [namespace origin fixstick] $chan $ind]
		}
		if {[botisop $chan] || [botishalfop $chan]} {
			foreach _ [banlist $chan] {
				foreach {what comment expire added timeactive by} $_ break
				if {[isbansticky $what $chan] && ![ischanban $what $chan]} {
					putquick "MODE $chan +b $what"
				}
			}
			foreach _ [banlist] {
				foreach {what comment expire added timeactive by} $_ break
				if {[isbansticky $what] && ![ischanban $what $chan]} {
					putquick "MODE $chan +b $what"
				}
			}
			foreach _ [exemptlist $chan] {
				foreach {what comment expire added timeactive by} $_ break
				if {[isexemptsticky $what $chan] && ![ischanexempt $what $chan]} {
					putquick "MODE $chan +e $what"
				}
			}
			foreach _ [exemptlist] {
				foreach {what comment expire added timeactive by} $_ break
				if {[isexemptsticky $what] && ![ischanexempt $what $chan]} {
					putquick "MODE $chan +e $what"
				}
			}
			foreach _ [invitelist $chan] {
				foreach {what comment expire added timeactive by} $_ break
				if {[isinvitesticky $what $chan] && ![ischaninvite $what $chan]} {
					putquick "MODE $chan +I $what"
				}
			}
			foreach _ [invitelist] {
				foreach {what comment expire added timeactive by} $_ break
				if {[isinvitesticky $what] && ![ischaninvite $what $chan]} {
					putquick "MODE $chan +I $what"
				}
			}
			
		}
		
	}
	
	proc mode_fixstick {nick uhost hand chan mode target} {
		variable ccs
		if {$ccs(fixstick) && [isbotnick $target] && ($mode == "+o" || $mode == "+h")} {fixstick $chan 0}
	}
	
	proc join_fixstick {nick uhost hand chan} {
		variable ccs
		if {$ccs(fixstick) && [isbotnick $nick]} {after 3000 [list [namespace origin fixstick] $chan 0]}
	}
	
	proc binds_up {} {
		variable ccs
		
		set curr 0
		set ccs(groups) [list]
		
		foreach command [concat $ccs(commands) $ccs(scr_commands)] {
			if {![use_command $command]} continue
			if {[lsearch -exact $ccs(groups) $ccs(group,$command)] < 0} {lappend ccs(groups) $ccs(group,$command)}
			
			foreach _ $ccs(alias,$command) {
				
				# Прописываем бинды управления для PUB команд
				incr curr
				bind pub -|- [string map [list %pref_ $ccs(pref_pub)] $_] [namespace current]::pub_cmd_$command
				eval "
					proc [namespace current]::pub_cmd_$command {nick uhost hand chan text} { 
						launch_cmd \$nick \$hand \$uhost \$chan \$nick \$chan \[list\] \$text \"$command\"
						return 0
					}
				"
				
				# Прописываем бинды управления для MSG команд
				incr curr
				bind msg -|- [string map [list %pref_ $ccs(pref_msg)] $_] [namespace current]::msg_cmd_$command
				eval "
					proc [namespace current]::msg_cmd_$command {nick uhost hand text} {
						launch_cmd \$nick \$hand \$uhost \"*\" \$nick \$nick \[list\] \$text \"$command\"
						return 0
					}
				"
				
				if {$ccs(pref_dcc) != "."} {
					# Прописываем бинды управления для DCC команд
					incr curr 2
					bind filt -|- "[string map [list %pref_ $ccs(pref_dcc)] $_]" [namespace current]::filt_cmd_$command
					bind filt -|- "[string map [list %pref_ $ccs(pref_dcc)] $_] *" [namespace current]::filt_cmd_$command
					eval "
						proc [namespace current]::filt_cmd_$command {idx text} {
							set hand \[idx2hand \$idx\]
							set nick \[hand2nick \$hand\]
							set uhost \[getchanhost \$nick\]
							set text \[join \[lrange \[split \$text\] 1 end\]\]
							launch_cmd \$nick \$hand \$uhost \"*\" \$idx \$idx \[list\] \$text \"$command\"
							return \"\"
						}
					"
				}
				
			}
			
		}
		
		incr curr 11
		bind msg -|- auth			[namespace origin msg_auth]
		bind msg -|- identauth		[namespace origin msg_identauth]
		bind part $ccs(flag_auth) *	[namespace origin part_auth]
		bind sign $ccs(flag_auth) *	[namespace origin sign_auth]
		bind kick - *				[namespace origin kick_auth]
		bind nick $ccs(flag_auth) *	[namespace origin nick_auth]
		bind splt $ccs(flag_auth) *	[namespace origin splt_auth]
		
		bind evnt -|- prerehash		[namespace origin prerehash]
		bind evnt -|- init-server	[namespace origin init_server]
		
		bind mode - *				[namespace origin mode_fixstick]
		bind join - *				[namespace origin join_fixstick]
		
		after 3000 [list [namespace origin fixbind]]
		
		foreach _ [concat [get_fileinfo mod 1] [get_fileinfo scr 1]] {
			if {[proc_exists "binds_up_$_"]} {binds_up_$_}
		}
		debug "$curr binds is up"
		
	}
	
	proc prerehash {type} {
		binds_down
	}
	
	proc init_server {type} {
		variable ccs
		
		foreach shand [userlist] {
			if {![matchattr $shand $ccs(flag_auth)] && ![matchattr $shand $ccs(flag_auth_botnet)]} continue
			chattr $shand "-$ccs(flag_auth)$ccs(flag_auth_botnet)"
			setuser $shand XTRA AuthBot [list]
			setuser $shand XTRA AuthNick [list]
			put_log "(auto) Init log out" -level 3
		}
		
	}
	
	proc binds_down {} {
		
		set curr 0
		foreach _ [binds "[namespace current]::*"] {
			incr curr
			unbind [lindex $_ 0] [lindex $_ 1] [lindex $_ 2] [lindex $_ 4]
		}
		debug "$curr binds is down"
		
	}
	
	proc binds_rename {} {
		
		set lbinds {
			{addhost}	{}		{die}		{n}		{go}		{}		{hello}		{}		
			{help}		{}		{ident}		{}		{info}		{}		{invite}	{o|o}	
			{jump}		{m}		{key}		{o|o}	{memory}	{m}		{op}		{}		
			{halfop}	{}		{pass}		{}		{rehash}	{m}		{reset}		{m}		
			{save}		{m}		{status}	{m|m}	{voice}		{}		{who}		{}		
			{whois}		{}		
		}
		foreach {name flag} $lbinds {bind_raname $name $flag}
		
	}
	
	proc bind_raname {name flag} {
		variable ccs
		
		if {$flag == ""} {set flag "-|-"}
		if {![info exists ccs(unbind,$name)] || [string is space $ccs(unbind,$name)]} {
			return
		} elseif {$ccs(unbind,$name) == "-1"} {
			unbind msg $flag $name *msg:$name
		} elseif {$ccs(unbind,$name) == "1"} {
			bind msg $flag $name *msg:$name
		} else {
			unbind msg $flag $name *msg:$name
			bind msg $flag $ccs(unbind,$name) *msg:$name
		}
		
	}
	
	#############################################################################################################
	# Начальная подгатовка переменных и загрузка модулей
	
	addfileinfo mod ccs $author $version $date
	
	sourcefile r1 $ccs(ccsdir) ccs.r1.tcl 0
	sourcefile lib $ccs(libdir) ccs.lib.*.tcl 1 2
	sourcefile r2 $ccs(ccsdir) ccs.r2.tcl 0
	sourcefile mod $ccs(moddir) ccs.mod.*.tcl 1 2
	sourcefile r3 $ccs(ccsdir) ccs.r3.tcl 0
	sourcefile scr $ccs(scrdir) ccs.scr.*.tcl 1 2
	sourcefile r4 $ccs(ccsdir) ccs.r4.tcl 0
	sourcefile lang $ccs(langdir) ccs.lang.*.tcl 1 3
	if {[file exists $ccs(ccsdir)/ccs.addonce.tcl] && \
		[file isfile $ccs(ccsdir)/ccs.addonce.tcl] && \
		![file exists $ccs(ccsdir)/ccs.r5.tcl]} {
		catch {file rename $ccs(ccsdir)/ccs.addonce.tcl $ccs(ccsdir)/ccs.r5.tcl}
	}
	sourcefile r5 $ccs(ccsdir) ccs.r5.tcl 0
	#sourcefile addonce $ccs(ccsdir) ccs.addonce.tcl 0
	
	binds_up
	binds_rename
	sourcefile r6 $ccs(ccsdir) ccs.r6.tcl 0
	
	debug "v$version \[$date\] by $author loaded"
	
}
