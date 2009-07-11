####################################################################################################
## Модуль переименования, блокирования стандартных биндов бота
####################################################################################################

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

set _name	{rebind}
pkg_add mod $_name "Buster <buster@buster-net.ru> (c)" "1.4.0" "01-Jul-2009" \
	"Модуль переименования, блокирования стандартных биндов бота."

if {[pkg_info mod $_name on]} {
	
	################################################################################################
	# Удаление, восстановление, переопределение стандартных приватных команд бота.
	#          -1 - удаление стандартного бинда;
	#           1 - восстановление стандартного бинда;
	#         имя - удаление стандартного бинда и создание нового с переопределенным именем;
	#  n/a(пусто) - не трогать бинд.
	
	variable rebind
	
	set rebind(addhost)	"1"
	set rebind(die)		"-1"
	set rebind(go)		"-1"
	set rebind(hello)	""
	set rebind(help)	"-1"
	set rebind(ident)	"1"
	set rebind(info)	"-1"
	set rebind(invite)	"-1"
	set rebind(jump)	"-1"
	set rebind(key)		"-1"
	set rebind(memory)	""
	set rebind(op)		"-1"
	set rebind(halfop)	"-1"
	set rebind(pass)	"1"
	set rebind(rehash)	"-1"
	set rebind(reset)	"-1"
	set rebind(save)	"-1"
	set rebind(status)	"-1"
	set rebind(voice)	"-1"
	set rebind(who)		"-1"
	set rebind(whois)	"-1"
	
	proc bind_raname {name flag} {
		variable rebind
		
		if {$flag == ""} {set flag "-|-"}
		if {![info exists rebind($name)] || [string is space $rebind($name)]} {
			return
		} elseif {$rebind($name) == "-1"} {
			unbind msg $flag $name *msg:$name
		} elseif {$rebind($name) == "1"} {
			bind msg $flag $name *msg:$name
		} else {
			unbind msg $flag $name *msg:$name
			bind msg $flag $rebind($name) *msg:$name
		}
		
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
	
	proc main_$_name {} {
		
		binds_rename
		
	}
	
}