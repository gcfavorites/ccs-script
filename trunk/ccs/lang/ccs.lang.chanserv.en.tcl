
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"chanserv"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,csop) {[nick]}
	set ccs(help,en,csop) {Gives op status to a selected \002nick\002 via ChanServ, if nick is not specified gives op status to you}
	
	set ccs(args,en,csdeop) {[nick]}
	set ccs(help,en,csdeop) {Deops a selected \002nick\002 via ChanServ, if nick is not specified deops you}
	
	set ccs(args,en,cshop) {[nick]}
	set ccs(help,en,cshop) {Halfops a selected \002nick\002 via ChanServ, if nick is not specified halfops you}
	
	set ccs(args,en,csdehop) {[nick]}
	set ccs(help,en,csdehop) {Dehalfops a selected \002nick\002 via ChanServ, if nick is not specified dehalfops you}
	
	set ccs(args,en,csvoice) {[nick]}
	set ccs(help,en,csvoice) {Voices a selected \002nick\002 via ChanServ, if nick is not specified gives a voice for you}
	
	set ccs(args,en,csdevoice) {[nick]}
	set ccs(help,en,csdevoice) {Devoices a selected \002nick\002 via ChanServ, if nick is not specified devoices you}
	
}