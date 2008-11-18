
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"chanserv"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,csop) {[юзир]}
	set ccs(help,pod,csop) {Опаид \002юзир\002а, если юзир ниуказан, то опаид Вас чириз КанСерв}
	
	set ccs(args,pod,csdeop) {[юзир]}
	set ccs(help,pod,csdeop) {Диопайед \002юзир\002а, если юзир ниуказан, то диопайед Вас чириз КанСерв}
	
	set ccs(args,pod,cshop) {[юзир]}
	set ccs(help,pod,cshop) {Дайод яйса \002юзир\002у, если юзир ниуказан, то дайод яйса Вам чириз КанСерв}
	
	set ccs(args,pod,csdehop) {[юзир]}
	set ccs(help,pod,csdehop) {Атбирайед яйса у \002юзир\002а, если юзир ниуказан, то праизводид самакастрацийу чириз КанСерв}
	
	set ccs(args,pod,csvoice) {[юзир]}
	set ccs(help,pod,csvoice) {Дайод войс \002юзир\002у, если юзир ниуказан, то дайод войс Вам чириз КанСерв}
	
	set ccs(args,pod,csdevoice) {[юзир]}
	set ccs(help,pod,csdevoice) {Атбирайед войс у \002юзир\002а, если юзир ниуказан, то атбирайед войс у Вас чириз КанСерв}
	
}