
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"mode"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.1" \
				"14-Aug-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,op) {[nick1,nick2,...]}
	set ccs(help,en,op) {Gives op status to a selected \002nick\002, if nick is not specified gives op status to you}
	
	set ccs(args,en,deop) {[nick1,nick2,...]}
	set ccs(help,en,deop) {Deops a selected \002nick\002, if nick is not specified deops you}
	
	set ccs(args,en,hop) {[nick1,nick2,...]}
	set ccs(help,en,hop) {Halfops a selected \002nick\002, if nick is not specified halfops you}
	
	set ccs(args,en,dehop) {[nick1,nick2,...]}
	set ccs(help,en,dehop) {Dehalfops a selected \002nick\002, if nick is not specified dehalfops you}
	
	set ccs(args,en,voice) {[nick1,nick2,...]}
	set ccs(help,en,voice) {Voices a selected \002nick\002, if nick is not specified gives a voice for you}
	
	set ccs(args,en,devoice) {[nick1,nick2,...]}
	set ccs(help,en,devoice) {Devoices a selected \002nick\002, if nick is not specified devoices you}
	
	set ccs(args,en,allvoice) {}
	set ccs(help,en,allvoice) {Gives a voice status for all channel members}
	
	set ccs(args,en,alldevoice) {}
	set ccs(help,en,alldevoice) {Devoices all channel members}
	
	set ccs(args,en,mode) {<[+/-]mode> [args]}
	set ccs(help,en,mode) {Sets/removes a channel mode(s) (for example «%pref_mode +l 1»)}
	
	
	
}