
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chanserv"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@ircworld.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,csop) {[nick]}
	set ccs(help,ru,csop) {Опает \002nick\002, если ник не указан, то опает Вас через ChanServ}
	
	set ccs(args,ru,csdeop) {[nick]}
	set ccs(help,ru,csdeop) {Деопает \002nick\002, если ник не указан, то деопает Вас через ChanServ}
	
	set ccs(args,ru,cshop) {[nick]}
	set ccs(help,ru,cshop) {Хопает \002nick\002, если ник не указан, то хопает Вас через ChanServ}
	
	set ccs(args,ru,csdehop) {[nick]}
	set ccs(help,ru,csdehop) {Снимает хопа с \002nick\002, если ник не указан, то снимает хопа с Вас через ChanServ}
	
	set ccs(args,ru,csvoice) {[nick]}
	set ccs(help,ru,csvoice) {Даёт войс \002nick\002у, если ник не указан, то даёт войс Вам через ChanServ}
	
	set ccs(args,ru,csdevoice) {[nick]}
	set ccs(help,ru,csdevoice) {Отбирает войс у \002nick\002а, если ник не указан, то отбирает войс у Вас через ChanServ}
	
}