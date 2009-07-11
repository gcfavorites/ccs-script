
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chanserv"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang csop {[nick]}
	set_text -type help -- $_lang csop {Gives op status to a selected \002nick\002 via ChanServ, if nick is not specified gives op status to you}
	
	set_text -type args -- $_lang csdeop {[nick]}
	set_text -type help -- $_lang csdeop {Deops a selected \002nick\002 via ChanServ, if nick is not specified deops you}
	
	set_text -type args -- $_lang cshop {[nick]}
	set_text -type help -- $_lang cshop {Halfops a selected \002nick\002 via ChanServ, if nick is not specified halfops you}
	
	set_text -type args -- $_lang csdehop {[nick]}
	set_text -type help -- $_lang csdehop {Dehalfops a selected \002nick\002 via ChanServ, if nick is not specified dehalfops you}
	
	set_text -type args -- $_lang csvoice {[nick]}
	set_text -type help -- $_lang csvoice {Voices a selected \002nick\002 via ChanServ, if nick is not specified gives a voice for you}
	
	set_text -type args -- $_lang csdevoice {[nick]}
	set_text -type help -- $_lang csdevoice {Devoices a selected \002nick\002 via ChanServ, if nick is not specified devoices you}
	
}