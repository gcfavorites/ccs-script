
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"exempt"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang exempt {<nick/host> [expiry] [reason] [stick]}
	set_text -type help -- $_lang exempt {Sets a local (only current channel) exception for given \002nick\002 or \002hostmask\002 (nick!ident@host). [expiry] is always minutes, if you do not specify [expiry] - will be used default value from channel «exempt-time» directive. If you specify a \002stick\002, exception will be sticked on the channel.}
	
	set_text -type args -- $_lang unexempt {<host>}
	set_text -type help -- $_lang unexempt {Removes exception on the channel.}
	
	set_text -type args -- $_lang gexempt {<nick/host> [expiry] [reason] [stick]}
	set_text -type help -- $_lang gexempt {Sets a global (all bot's channels will be affected) exception for given \002nick\002 or \002host\002 (nick!ident@host). [expiry] is always minutes, if you do not specify [expiry] - will be used one day period. If you specify a \002stick\002, exception will be sticked on the channels.}
	
	set_text -type args -- $_lang gunexempt {<host>}
	set_text -type help -- $_lang gunexempt {Removes a global exception}
	
	set_text -type args -- $_lang exemptlist {[global]}
	set_text -type help -- $_lang exemptlist {Output channel exception list. If you specify \002global\002 then global exception list will be shown. Wildcards as optional argument are allowed.}
	
	set_text -type args -- $_lang resetexempts {}
	set_text -type help -- $_lang resetexempts {Removes from channel all exceptions that's doesn't match to the bots's internal exception list.}
	
	set_text $_lang $_name #101 "Requested"
	set_text $_lang $_name #102 "Added \002permanent\002%s exception: \037%s\037."
	set_text $_lang $_name #103 "%s (expires at: %s)."
	set_text $_lang $_name #104 "Added%s exception: \037%s\037 на %s."
	set_text $_lang $_name #105 "Removed%s exception: \002%s\002."
	set_text $_lang $_name #106 "Exception \002%s\002 on the \002%s\002 does not exist."
	set_text $_lang $_name #107 "Requested"
	set_text $_lang $_name #108 "Added \002permanent\002 global%s exception: \037%s\037."
	set_text $_lang $_name #109 "Added global%s exception: \037%s\037 on %s."
	set_text $_lang $_name #110 "Removed global%s exception: \002%s\002"
	set_text $_lang $_name #111 "Global exception \002%s\002 does not exist."
	set_text $_lang $_name #112 "--- Global exception list%s ---"
	set_text $_lang $_name #113 "--- Exception list for \002%s\002%s ---"
	set_text $_lang $_name #114 "*** Empty ***"
	set_text $_lang $_name #115 "\002Permanent\002 exception."
	set_text $_lang $_name #116 "Expires on: %s."
	set_text $_lang $_name #117 "» %s %s¤ reason: «%s» ¤ %s ¤ Exception was added %s ago ¤ Creator: \002%s\002.%s"
	set_text $_lang $_name #118 "--- End of exceptions list ---"
	set_text $_lang $_name #119 "All exceptions that's doesn't match to internal bot's exceptionlist has been removed."
	set_text $_lang $_name #120 "\037stick\037"
	set_text $_lang $_name #121 "(Mask \002%s\002)"
	set_text $_lang $_name #122 "Выставил на канале: \002%s\002 %s назад."
	set_text $_lang $_name #123 "--- Channel exceptions ---"
	set_text $_lang $_name #124 "» \002%s\002 ¤ Выставил на канале: \002%s\002 %s назад."

}