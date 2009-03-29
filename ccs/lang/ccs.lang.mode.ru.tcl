
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set modname		"mode"
set modlang		"ru"
addlang $modname $modlang \
				"Buster <buster@buster-net.ru> (c)" \
				"1.2.2" \
				"14-Aug-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,ru,op) {[nick1,nick2,...]}
	set ccs(help,ru,op) {Опает \002nick\002, если ник не указан, то опает Вас}
	
	set ccs(args,ru,deop) {[nick1,nick2,...]}
	set ccs(help,ru,deop) {Деопает \002nick\002, если ник не указан, то деопает Вас}
	
	set ccs(args,ru,hop) {[nick1,nick2,...]}
	set ccs(help,ru,hop) {Хопает \002nick\002, если ник не указан, то хопает Вас}
	
	set ccs(args,ru,dehop) {[nick1,nick2,...]}
	set ccs(help,ru,dehop) {Снимает хопа с \002nick\002, если ник не указан, то снимает хопа с Вас}
	
	set ccs(args,ru,voice) {[nick1,nick2,...]}
	set ccs(help,ru,voice) {Даёт войс \002nick\002у, если ник не указан, то даёт войс Вам}
	
	set ccs(args,ru,devoice) {[nick1,nick2,...]}
	set ccs(help,ru,devoice) {Отбирает войс у \002nick\002а, если ник не указан, то отбирает войс у Вас}
	
	set ccs(args,ru,allvoice) {}
	set ccs(help,ru,allvoice) {Раздаёт всем войсы на канале}
	
	set ccs(args,ru,alldevoice) {}
	set ccs(help,ru,alldevoice) {Снимает со всех войсы на канале}
	
	set ccs(args,ru,mode) {<[+/-]mode> [args]}
	set ccs(help,ru,mode) {Изменяет режим канала (например, «%pref_mode +l 1»)}
	
	set ccs(text,mode,ru,#101) "У бота нету статуса оператора для выполнения команды."
	
}