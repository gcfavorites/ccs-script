
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"mode"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang op {[юзир1,юзир2,...]}
	set_text -type help -- $_lang op {Опнуть \002юзир\002а, если ник юзира ниуказан, то опает Вас}
	
	set_text -type args -- $_lang deop {[юзир1,юзир2,...]}
	set_text -type help -- $_lang deop {Деопнуть \002юзир\002а, если ник юзира ниуказан, то деопает Вас}
	
	set_text -type args -- $_lang hop {[юзир1,юзир2,...]}
	set_text -type help -- $_lang hop {Хопает \002юзир\002а, если ник юзира ниуказан, то хопает Вас}
	
	set_text -type args -- $_lang dehop {[юзир1,юзир2,...]}
	set_text -type help -- $_lang dehop {Снимаит хопа с \002юзир\002а, если ник юзира ниуказан, то снимаит хопа с Вас}
	
	set_text -type args -- $_lang voice {[юзир1,юзир2,...]}
	set_text -type help -- $_lang voice {Дайод войс \002юзир\002у, если ник юзира ниуказан, то дайод войс Вам}
	
	set_text -type args -- $_lang devoice {[юзир1,юзир2,...]}
	set_text -type help -- $_lang devoice {Атбираид войс у \002юзир\002а, если ник юзира ниуказан, то атбираид войс у Вас}
	
	set_text -type args -- $_lang allvoice {}
	set_text -type help -- $_lang allvoice {Раcдайод всем войсы на канали}
	
	set_text -type args -- $_lang alldevoice {}
	set_text -type help -- $_lang alldevoice {Снемаид са фсех войсы на канали}
	
	set_text -type args -- $_lang mode {<[+/-]мод> [аргументы]}
	set_text -type help -- $_lang mode {Изминяид рижим канала (напрямер, «%pref_mode +l 1»)}
	
}