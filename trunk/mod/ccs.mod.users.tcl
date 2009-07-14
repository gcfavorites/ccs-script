####################################################################################################
## Модуль управления пользователями
####################################################################################################
# Список последних изменений:
#	v1.2.6
# - Добавлена команда !match показывающая список юзеров, сидящих на канале, с указанной хостмаской
#	v1.2.4
# - Для команды !delhost теперь по умолчанию используется указание полной хостмаски, чтобы указать
#   маску хостмаски необходимо перед маской поставить ключ -m

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{users}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.1" "14-Jul-2009" \
	"Модуль управления юзер листом бота."

if {[pkg_info mod $_name on]} {
	
	if {[info exists permission_flag]} {unset permission_flag}
	variable permission_flag
	
	################################################################################################
	# Значение, которое определяет маску, по которой будут добавляться новые пользователи.
	# Соответствие значений числа и маски, такое же, как и при указании маски бана.
	set options(addusermask)		4
	
	################################################################################################
	# Разрешить удаление юзеров пользователями с локальными провами в том случае, если на канале,
	# на котором отсутствуют права, когда то находился удаляемый юзер. То есть если посмотреть
	# .whois удаляемого юзера то можно увидеть что он был на определенном канале X при этом
	# храниться время последнего визита LAST но на этом канале у него отсуствуют права
	# (в поле FLAGS стоит "-")
	set options(deluserchanrec)		1
	
	################################################################################################
	# Список прав доступа на редактирование флагов.
	
	# n - владелец или овнер - Пользователь с наивысшим доступом к боту. Ему доступны все возможные функции.
	set permission_flag(global,n)		{}
	set permission_flag(local,n)		{n m}
	# m - мастер (master) - Пользователь, которому доступны почти все команды и функции.
	set permission_flag(global,m)		{n}
	set permission_flag(local,m)		{n|n m}
	# t - ботнет-мастер (botnet-master) - Пользователь, которому доступны команды ботнета.
	set permission_flag(global,t)		{n m}
	# a - автооп (АОП) (auto-op) - Пользователь, который будет получать статус оператора при входе на канал.
	set permission_flag(global,a)		{n m}
	set permission_flag(local,a)		{n|n m|m}
	# o - оператор (ОП) (op) - Пользователь, имеющий статус оператора на всех каналах
	set permission_flag(global,o)		{n m}
	set permission_flag(local,o)		{n|n m|m}
	# y - автополуоп (auto-halfop) - Пользователь, который будет получать статус полуопа при входе на канал
	set permission_flag(global,y)		{n m o}
	set permission_flag(local,y)		{n|n m|m o|o}
	# l - полуоп (halfop) - Пользователь, имеющий статус полуопа на всех каналах.
	set permission_flag(global,l)		{n m o}
	set permission_flag(local,l)		{n|n m|m o|o}
	# g - автовоис (АВОИС) (auto-voice) - Пользователь, который будет получать голос (воис) при входе на канал
	set permission_flag(global,g)		{n m o l}
	set permission_flag(local,g)		{n|n m|m o|o l|l}
	# v - голос (воис) (voice) - Пользователь, который будет получать голос (воис) на каналах +autovoice
	set permission_flag(global,v)		{n m o l}
	set permission_flag(local,v)		{n|n m|m o|o l|l}
	# f - друг (friend) - Пользователь, который не будет кикнут за флуд и т.п.
	set permission_flag(global,f)		{n m o l}
	set permission_flag(local,f)		{n|n m|m o|o l|l}
	# p - патилайн (party) - Пользователь, у которого есть доступ в патилайн (DCC)
	set permission_flag(global,p)		{n}
	# q - тихий (quiet) - Пользователь, которые не будет получать голос (воис) на каналах +autovoice
	set permission_flag(global,q)		{n m o l}
	set permission_flag(local,q)		{n|n m|m o|o l|l}
	# r - ДЕполуоп (dehalfop) - Пользователь, которому нельзя брать статус полуопа. Статус будет сниматься автоматически.
	set permission_flag(global,r)		{n m o}
	set permission_flag(local,r)		{n|n m|m o|o}
	# d - ДЕоп (deop) - Пользователь, которому нельзя брать статус оператора (ОПа). Статус будет сниматься автоматически.
	set permission_flag(global,d)		{n m}
	set permission_flag(local,d)		{n|n m|m}
	# k - автокик (акик) (auto-kick) - Пользователь будет автоматически кикнут и забанен при заходе на канал
	set permission_flag(global,k)		{n m}
	set permission_flag(local,k)		{n|n m|m}
	# x - передача файлов (xfer) - Пользователь, которому разрещено отправлять/принимать файлы.
	set permission_flag(global,x)		{n m}
	# j - (janitor) Пользователь, который имеет полный доступ к файловой системе. Модуль filesystem
	set permission_flag(global,j)		{n m}
	# c - (common) Пользователь, который ходит в IRC с публичного сайта, с которого несколько пользователей. Например у всех пользователей хост *!some@some.host.dom Пользователи будут идентифицироваться по нику.
	set permission_flag(global,c)		{n m}
	# w (wasop-test) Пользователь, для которого обязательно надо проверять был ил он ОПом до сплита для +stopnethack каналов
	set permission_flag(global,w)		{n m}
	set permission_flag(local,w)		{n|n m|m}
	# z (washalfop-test) Пользователь, для которого нужно проверять, был ли он полуопом до сплита для +stopnethack каналов
	set permission_flag(global,z)		{n m}
	set permission_flag(local,z)		{n|n m|m}
	# e (nethack-exempt) Пользователь, которого не нужно проверять при stopnethack процедуре
	set permission_flag(global,e)		{n m}
	set permission_flag(local,e)		{n|n m|m}
	# u - не шарить (unshared) - Пользовательская запись не будет передаваться по ботнету если включен шаринг.
	set permission_flag(global,u)		{n m t}
	# h - подсветка (highlight) - Пользователь, для которого будет использоваться болд в хелпах
	set permission_flag(global,h)		{n m}
	
	set permission_flag(global,Q)		{n}
	set permission_flag(global,B)		{n}
	set permission_flag(global,P)		{n}
	set permission_flag(global,L)		{n}
	set permission_flag(global,H)		{n}
	set permission_flag(local,H)		{n}
	
	cmd_configure adduser -control -group "user" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_adduser} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))?$} {-> dnick dhost}}
	
	cmd_configure deluser -control -group "user" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_deluser} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cmd_configure addhost -control -group "user" -flags {m} -block 1 -use_chan 0 \
		-alias {%pref_addmask %pref_addhost %pref_+host} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick dhost}}
	
	cmd_configure delhost -control -group "user" -flags {m} -block 1 -use_chan 0 \
		-alias {%pref_clearhosts %pref_delhost %pref_-host} \
		-regexp {{^([^\ ]+)(?:\ +(-m))?(?:\ +([^\ ]+))$} {-> dnick dmaskflag dhost}}
	
	cmd_configure chattr -control -group "user" -flags {n|n m|m o|o l|l} -block 1 -use_chan 3 \
		-alias {%pref_chattr} \
		-regexp {{^([^\ ]+)(?:\ +([a-z\+\-]+))(?:\ +(global))?$} {-> dnick sflag sglobal}}
	
	cmd_configure userlist -control -group "user" -flags {o} -block 5 -use_chan 3 \
		-alias {%pref_userlist}
	
	cmd_configure resetpass -control -group "user" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_resetpass} \
		-regexp {{^([^\ ]+)$} {-> dnick}}
	
	cmd_configure chhandle -control -group "user" -flags {m} -block 3 -use_chan 0 \
		-alias {%pref_chhandle} \
		-regexp {{^([^\ ]+)(?:\ +([^\ ]+))$} {-> dnick newhandle}}
	
	cmd_configure setinfo -control -group "user" -flags {m|m} -block 3 \
		-alias {%pref_setinfo} \
		-regexp {{^([^\ ]+)(?:\ +(.*?))$} {-> dnick sinfo}}
	
	cmd_configure delinfo -control -group "user" -flags {m|m} -block 1 \
		-alias {%pref_delinfo} \
		-regexp {{^([^\ ]+)$} {-> dnick sinfo}}
	
	cmd_configure match -control -group "user" -flags {lf|lf} -block 5 -use_chan 3 \
		-alias {%pref_match} \
		-regexp {{^(.+?)$} {-> smask}}
	
	################################################################################################
	################################################################################################
	################################################################################################
	
	################################################################################################
	# Процедуры команд управления пользователями (USER).
	
	proc cmd_adduser {} {
		upvar out out
		variable options
		importvars [list snick shand schan command dnick dhost]
		
		set dhand [get_hand -quiet 1 -- $dnick]
		if {[check_notavailable {-getting_users -validhandle} -dnick $dnick -dhand $dhand]} {return 0}
		
		if {[string is space $dhost]} {
			if {![onchan $dnick]} {put_msg [sprintf users #101 $dnick]; return 0}
			set dhost "$dnick![getchanhost $dnick]"
			set dhost [get_mask $dhost $options(addusermask)]
		}
		
		if {![adduser $dnick $dhost]} {put_msg [sprintf users #107 $dnick]; return 0}
		put_msg [sprintf users #102 $dnick $dhost]
		
		if {[onchan $dnick]} {
			global botnick
			
			put_msgdest $dnick [sprintf users #103 $botnick]
			put_msgdest $dnick [sprintf users #104 $botnick]
			put_msgdest $dnick [sprintf users #105 $botnick]
			put_msgdest $dnick [sprintf users #106 $options(prefix_pub)]
		}
		put_log "$dnick ($dhost)"
		return 1
		
	}
	
	proc cmd_deluser {} {
		upvar out out
		variable options
		importvars [list snick shand schan command dnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand]} {return 0}
		
		set denied 0
		foreach n [channels] {
			set saccess [get_accesshand $shand $schan 1]
			set daccess [get_accesshand $dhand $schan]
			if {[haschanrec $dhand $n] && !($options(deluserchanrec) && $saccess == 0 && $daccess == 0) && ($saccess <= $daccess)} {
				set denied 1
				break
			}
		}
		if {$denied} {
			put_msg [sprintf users #108 [StrNick -nick $dnick -hand $dhand]]
			put_log "$dhand - \0034unsuccessfull\003!"
			return 0
		} else {
			deluser $dhand
			put_msg [sprintf users #109 [StrNick -nick $dnick -hand $dhand]]
			put_log "$dhand"
			return 1
		}
		
	}
	
	proc cmd_addhost {} {
		upvar out out
		importvars [list snick shand schan command dnick dhost]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		setuser $dhand HOSTS $dhost
		put_msg [sprintf users #110 $dhost $dhand]
		put_log "$dhand: $dhost"
		return 1
		
	}
	
	proc cmd_delhost {} {
		upvar out out
		importvars [list snick shand schan command dnick dmaskflag dhost]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		set findhost 0
		foreach line [getuser $dhand HOSTS] {
			if {($dmaskflag == "" && [string equal -nocase $dhost $line]) || \
				($dmaskflag != "" && [string match -nocase $dhost $line])} {
				set findhost 1
				delhost $dhand $line
				put_msg [sprintf users #111 $line $dhand]
				put_log "$dhand: $line"
			}
		}
		if {!$findhost} {put_msg [sprintf users #112]; return 0}
		return 1
		
	}
	
	proc cmd_userlist {} {
		upvar out out
		importvars [list snick shand schan command text]
		
		set sflags ""
		set lptext ""
		set useflags [regexp -nocase -- {-f ([^\ ]+)} $text -> sflags]
		regsub -- {-f ([^\ ]+)} $text {} text
		set usehost [regexp -nocase -- {-h ([^\ ]+)} $text -> dhost]
		regsub -- {-h ([^\ ]+)} $text {} text
		
		if {![string is space $text]} {put_help; return}
		
		if {[check_isnull $schan]} {
			set luser [userlist $sflags]
			if {$useflags} {lappend lptext "flags: \002$sflags\002"}
		} else {
			set luser [userlist $sflags $schan]
			if {$useflags} {lappend lptext "flags for $schan: \002$sflags\002"}
		}
		if {$usehost} {lappend lptext "host: \002$dhost\002"}
		
		
		
		set louser [list]
		foreach _ $luser {
			
			if {$usehost} {
				set lhost [getuser $_ HOSTS]
				set find 0
				foreach h $lhost {
					if {[string match -nocase $dhost $h]} {set find 1}
				}
				if {!$find} {continue}
			}
			lappend louser $_
			
		}
		
		if {[llength $lptext] == 0} {lappend lptext "-"}
		
		put_msg [sprintf users #113 [join $lptext ", "] [join $louser ", "]]
		put_log "$text"
		return 1
		
	}
	
	proc cmd_match {} {
		upvar out out
		variable options
		importvars [list snick shand schan command smask]
		
		if {[check_isnull $schan]} {
			if {[check_matchattr $shand $schan $options(permission_secret_chan)]} {
				set lchan [channels]
			} else {
				set lchan [list]
				foreach _ [channels] {
					if {![channel get $_ secret]} {lappend lchan $_}
				}
			}
		} else {
			set lchan [list $schan]
		}
		
		set find 0
		foreach _0 $lchan {
			set luser [list]
			foreach _1 [chanlist $_0] {
				if {[string match -nocase $smask "$_1![getchanhost $_1 $_0]"]} {
					lappend luser "$_1![getchanhost $_1 $_0]"
					set find 1
				}
			}
			if {[llength $luser] > 0} {put_msg "\002$_0\002: [join $luser ", "]"}
		}
		
		if {!$find} {put_msg [sprintf users #122]}
		put_log "$smask"
		return 1
		
	}
	
	proc cmd_chattr {} {
		upvar out out
		variable permission_flag
		importvars [list snick shand schan command dnick sflag sglobal]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		set global [expr ![string is space $sglobal]]
		if {$global} {
			set typeflag global
		} else {
			if {[check_isnull $schan]} {put_help; return 0}
			set typeflag local
		}
		for {set x 0} {$x < [string length $sflag]} {incr x} {
			
			set curflag [string index $sflag $x]
			if {$curflag != "+" && $curflag != "-"} {
				set allow 0
				
				if {[info exists permission_flag($typeflag,$curflag)]} {
					if {[check_matchattr $shand $schan $permission_flag($typeflag,$curflag)]} {set allow 1}
				} else {set allow 1}
				
				if {!$allow} {put_msg [sprintf users #114 $curflag $dhand]; return}
			}
			
		}
		
		if {$global} {
			set newflags [chattr $dhand $sflag]
			put_msg [sprintf users #115 [StrNick -nick $dnick -hand $dhand] $newflags]
			put_log "$dhand: $newflags"
			return 1
		} else {
			set newflags [chattr $dhand |$sflag $schan]
			put_msg [sprintf users #115 [StrNick -nick $dnick -hand $dhand] $newflags]
			put_log "$dhand: $newflags"
			return 1
		}
		
	}
	
	proc cmd_resetpass {} {
		upvar out out
		importvars [list snick shand schan command dnick]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition1 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		setuser $dhand PASS
		global botnick
		put_msg [sprintf users #116 [StrNick -nick $dnick -hand $dhand]]
		set ddnick [hand2nick $dhand]
		if {![check_isnull $ddnick]} {
			put_msgdest -type notice -- $ddnick [sprintf users #117 [StrNick -nick $snick -hand $shand] $botnick]
		}
		put_log "$dhand"
		return 1
		
	}
	
	proc cmd_chhandle {} {
		upvar out out
		importvars [list snick shand schan command dnick newhandle]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition1 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan ""]} {return 0}
		
		if {[validuser $newhandle]} {put_msg [sprintf users #118 $newhandle]; return 0}
		chhandle $dhand $newhandle
		if {[string match $shand $dhand]} {
			set shand $newhandle
		}
		put_msg [sprintf users #119 [StrNick -nick $dnick -hand $dhand] $newhandle]
		put_log "$dhand to $newhandle"
		return 1
		
	}
	
	proc cmd_setinfo {} {
		upvar out out
		importvars [list snick shand schan command dnick sinfo]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		setchaninfo $dhand $schan $sinfo
		put_msg [sprintf users #120 $dhand]
		put_log "$dhand, text: $sinfo"
		return 1
		
	}
	
	proc cmd_delinfo {} {
		upvar out out
		importvars [list snick shand schan command dnick sinfo]
		
		set dhand [get_hand $dnick]
		if {[check_notavailable {-getting_users -locked -nopermition0 -notvalidhandle} -shand $shand -dnick $dnick -dhand $dhand -dchan $schan]} {return 0}
		
		setchaninfo $dhand $schan ""
		put_msg [sprintf users #121 $dhand]
		put_log "$dhand"
		return 1
		
	}
	
}