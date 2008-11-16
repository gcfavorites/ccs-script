
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"mode"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"14-Aug-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,op) {[юзир1,юзир2,...]}
	set ccs(help,pod,op) {Опнуть \002юзир\002а, если ник юзира ниуказан, то опает Вас}
	
	set ccs(args,pod,deop) {[юзир1,юзир2,...]}
	set ccs(help,pod,deop) {Деопнуть \002юзир\002а, если ник юзира ниуказан, то деопает Вас}
	
	set ccs(args,pod,hop) {[юзир1,юзир2,...]}
	set ccs(help,pod,hop) {Хопает \002юзир\002а, если ник юзира ниуказан, то хопает Вас}
	
	set ccs(args,pod,dehop) {[юзир1,юзир2,...]}
	set ccs(help,pod,dehop) {Снимаит хопа с \002юзир\002а, если ник юзира ниуказан, то снимаит хопа с Вас}
	
	set ccs(args,pod,voice) {[юзир1,юзир2,...]}
	set ccs(help,pod,voice) {Дайод войс \002юзир\002у, если ник юзира ниуказан, то дайод войс Вам}
	
	set ccs(args,pod,devoice) {[юзир1,юзир2,...]}
	set ccs(help,pod,devoice) {Атбираид войс у \002юзир\002а, если ник юзира ниуказан, то атбираид войс у Вас}
	
	set ccs(args,pod,allvoice) {}
	set ccs(help,pod,allvoice) {Раcдайод всем войсы на канали}
	
	set ccs(args,pod,alldevoice) {}
	set ccs(help,pod,alldevoice) {Снемаид са фсех войсы на канали}
	
	set ccs(args,pod,mode) {<[+/-]мод> [аргументы]}
	set ccs(help,pod,mode) {Изминяид рижим канала (напрямер, «%pref_mode +l 1»)}
	
	
	
}