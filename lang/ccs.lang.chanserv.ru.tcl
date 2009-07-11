
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chanserv"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang csop {[nick]}
	set_text -type help -- $_lang csop {Опает \002nick\002, если ник не указан, то опает Вас через ChanServ}
	
	set_text -type args -- $_lang csdeop {[nick]}
	set_text -type help -- $_lang csdeop {Деопает \002nick\002, если ник не указан, то деопает Вас через ChanServ}
	
	set_text -type args -- $_lang cshop {[nick]}
	set_text -type help -- $_lang cshop {Хопает \002nick\002, если ник не указан, то хопает Вас через ChanServ}
	
	set_text -type args -- $_lang csdehop {[nick]}
	set_text -type help -- $_lang csdehop {Снимает хопа с \002nick\002, если ник не указан, то снимает хопа с Вас через ChanServ}
	
	set_text -type args -- $_lang csvoice {[nick]}
	set_text -type help -- $_lang csvoice {Даёт войс \002nick\002у, если ник не указан, то даёт войс Вам через ChanServ}
	
	set_text -type args -- $_lang csdevoice {[nick]}
	set_text -type help -- $_lang csdevoice {Отбирает войс у \002nick\002а, если ник не указан, то отбирает войс у Вас через ChanServ}
	
}