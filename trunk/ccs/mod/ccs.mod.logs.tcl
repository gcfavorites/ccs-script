##################################################################################################################
## ������ ����������� � ����
##################################################################################################################
# ������ ��������� ���������:
#	v1.2.5
# - �������� ���������� �� ��������� ��� ���������� �����

if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"logs"
addfileinfo mod $modname "Buster <buster@buster-net.ru> (c)" \
				"1.2.5" \
				"14-Mar-2009" \
				"������ ����������� (���������� ���� �������� ������������� � ����)."

if {$ccs(mod,name,$modname)} {
	
	#############################################################################################################
	# ��� ����� � ���� ������� �����. �� ��������� � ����� �� �������� � ������ ccs.log
	set ccs(logsfile)			"$ccs(datadir)/ccs.log"
	
	#############################################################################################################
	# ������������ ������� ���������, ������� ���������� ���������� � ��� ����
	set ccs(logslevel)			3
	
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
		
		if {$ccs(logslevel) >= $level} {
			if {[catch {
				savefile $ccs(logsfile) "\[[clock format [unixtime] -format "%d-%b-%y %H:%M:%S"]\] [join $lout]" -append
			} errMsg]} {
				return 0
			}
		}
		return 1
		
	}
	
}