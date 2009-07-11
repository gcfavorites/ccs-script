
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"mode"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang op {[nick1,nick2,...]}
	set_text -type help -- $_lang op {Gives op status to a selected \002nick\002, if nick is not specified gives op status to you}
	
	set_text -type args -- $_lang deop {[nick1,nick2,...]}
	set_text -type help -- $_lang deop {Deops a selected \002nick\002, if nick is not specified deops you}
	
	set_text -type args -- $_lang hop {[nick1,nick2,...]}
	set_text -type help -- $_lang hop {Halfops a selected \002nick\002, if nick is not specified halfops you}
	
	set_text -type args -- $_lang dehop {[nick1,nick2,...]}
	set_text -type help -- $_lang dehop {Dehalfops a selected \002nick\002, if nick is not specified dehalfops you}
	
	set_text -type args -- $_lang voice {[nick1,nick2,...]}
	set_text -type help -- $_lang voice {Voices a selected \002nick\002, if nick is not specified gives a voice for you}
	
	set_text -type args -- $_lang devoice {[nick1,nick2,...]}
	set_text -type help -- $_lang devoice {Devoices a selected \002nick\002, if nick is not specified devoices you}
	
	set_text -type args -- $_lang allvoice {}
	set_text -type help -- $_lang allvoice {Gives a voice status for all channel members}
	
	set_text -type args -- $_lang alldevoice {}
	set_text -type help -- $_lang alldevoice {Devoices all channel members}
	
	set_text -type args -- $_lang mode {<[+/-]mode> [args]}
	set_text -type help -- $_lang mode {Sets/removes a channel mode(s) (for example «%pref_mode +l 1»)}
	
}