
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"mode"
set _lang		"ru"
pkg_add lang [list $_name $_lang] \
				"Buster <buster@buster-net.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang op {[nick1,nick2,...]}
	set_text -type help -- $_lang op {Опает \002nick\002, если ник не указан, то опает Вас}
	
	set_text -type args -- $_lang deop {[nick1,nick2,...]}
	set_text -type help -- $_lang deop {Деопает \002nick\002, если ник не указан, то деопает Вас}
	
	set_text -type args -- $_lang hop {[nick1,nick2,...]}
	set_text -type help -- $_lang hop {Хопает \002nick\002, если ник не указан, то хопает Вас}
	
	set_text -type args -- $_lang dehop {[nick1,nick2,...]}
	set_text -type help -- $_lang dehop {Снимает хопа с \002nick\002, если ник не указан, то снимает хопа с Вас}
	
	set_text -type args -- $_lang voice {[nick1,nick2,...]}
	set_text -type help -- $_lang voice {Даёт войс \002nick\002у, если ник не указан, то даёт войс Вам}
	
	set_text -type args -- $_lang devoice {[nick1,nick2,...]}
	set_text -type help -- $_lang devoice {Отбирает войс у \002nick\002а, если ник не указан, то отбирает войс у Вас}
	
	set_text -type args -- $_lang allvoice {}
	set_text -type help -- $_lang allvoice {Раздаёт всем войсы на канале}
	
	set_text -type args -- $_lang alldevoice {}
	set_text -type help -- $_lang alldevoice {Снимает со всех войсы на канале}
	
	set_text -type args -- $_lang mode {<[+/-]mode> [args]}
	set_text -type help -- $_lang mode {Изменяет режим канала (например, «%pref_mode +l 1»)}
	
	set_text $_lang $_name #101 "У бота нету статуса оператора для выполнения команды."
	
}