
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chanserv"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang csop {[юзир]}
	set_text -type help -- $_lang csop {Опаид \002юзир\002а, если юзир ниуказан, то опаид Вас чириз КанСерв}
	
	set_text -type args -- $_lang csdeop {[юзир]}
	set_text -type help -- $_lang csdeop {Диопайед \002юзир\002а, если юзир ниуказан, то диопайед Вас чириз КанСерв}
	
	set_text -type args -- $_lang cshop {[юзир]}
	set_text -type help -- $_lang cshop {Дайод яйса \002юзир\002у, если юзир ниуказан, то дайод яйса Вам чириз КанСерв}
	
	set_text -type args -- $_lang csdehop {[юзир]}
	set_text -type help -- $_lang csdehop {Атбирайед яйса у \002юзир\002а, если юзир ниуказан, то праизводид самакастрацийу чириз КанСерв}
	
	set_text -type args -- $_lang csvoice {[юзир]}
	set_text -type help -- $_lang csvoice {Дайод войс \002юзир\002у, если юзир ниуказан, то дайод войс Вам чириз КанСерв}
	
	set_text -type args -- $_lang csdevoice {[юзир]}
	set_text -type help -- $_lang csdevoice {Атбирайед войс у \002юзир\002а, если юзир ниуказан, то атбирайед войс у Вас чириз КанСерв}
	
}