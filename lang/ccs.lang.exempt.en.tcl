
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"exempt"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.1" \
				"26-Okt-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,exempt) {<nick/host> [expiry] [reason] [stick]}
	set ccs(help,en,exempt) {Sets a local (only current channel) exception for given \002nick\002 or \002host\002 (nick!ident@host). [Expiry] is always minutes, if you not specify [expiry] will be used default value from channel «exempt-time» directive. If you specify a \002stick\002, exception will be sticked on the channel.}
	
	set ccs(args,en,unexempt) {<host>}
	set ccs(help,en,unexempt) {Removes exception on the channel.}
	
	set ccs(args,en,gexempt) {<nick/host> [expiry] [reason] [stick]}
	set ccs(help,en,gexempt) {Sets a global (all bot's channels will be affected) exception for given \002nick\002 or \002host\002 (nick!ident@host). [Expiry] is always minutes, if you not specify [expiry], will be used one day period. If you specify a \002stick\002, exception will be sticked on the channels.}
	
	set ccs(args,en,gunexempt) {<host>}
	set ccs(help,en,gunexempt) {Removes a global exception}
	
	set ccs(args,en,exemptlist) {[global]}
	set ccs(help,en,exemptlist) {Output channel exceptionlist. If you specify \002global\002 will be shown global exceptionlist.}
	
	set ccs(args,en,resetexempts) {}
	set ccs(help,en,resetexempts) {Removes from channel all exceptions that's doesn't match to internal bot's exceptionlist}
	
	set ccs(text,exempt,en,#101) "Requested"
	set ccs(text,exempt,en,#102) "Added \002permanent\002%s exception: \037%s\037."
	set ccs(text,exempt,en,#103) "%s (expires at: %s)."
	set ccs(text,exempt,en,#104) "Added%s exception: \037%s\037 íà %s."
	set ccs(text,exempt,en,#105) "Removed%s exception: \002%s\002."
	set ccs(text,exempt,en,#106) "Exception \002%s\002 on the \002%s\002 does not exist."
	set ccs(text,exempt,en,#107) "Requested"
	set ccs(text,exempt,en,#108) "Added \002permanent\002 global%s exception: \037%s\037."
	set ccs(text,exempt,en,#109) "Added global%s exception: \037%s\037 on %s."
	set ccs(text,exempt,en,#110) "Removed global%s exception: \002%s\002"
	set ccs(text,exempt,en,#111) "Global exception \002%s\002 does not exist."
	set ccs(text,exempt,en,#112) "--- Global exception list%s ---"
	set ccs(text,exempt,en,#113) "--- Exception list for \002%s\002%s ---"
	set ccs(text,exempt,en,#114) "*** Empty ***"
	set ccs(text,exempt,en,#115) "\002Permanent\002 exception."
	set ccs(text,exempt,en,#116) "Expires on: %s."
	set ccs(text,exempt,en,#117) "» %s %s¤ reason: «%s» ¤ %s ¤ Exception was added %s ago ¤ Creator: \002%s\002.%s"
	set ccs(text,exempt,en,#118) "--- End of exceptions list ---"
	set ccs(text,exempt,en,#119) "All exceptions that's doesn't match to internal bot's exceptionlist has been removed."
	set ccs(text,exempt,en,#120) "\037stick\037"
	set ccs(text,exempt,ru,#121) "(Mask \002%s\002)"
	
}