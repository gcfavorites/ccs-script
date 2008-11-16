
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"chan"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.2" \
				"28-Jul-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,channels) {}
	set ccs(help,pod,channels) {Вывисти списак каналафф}
	set ccs(help2,pod,channels) {
		{Вывисти списак каналафф, на каторых сидид бот (иво статус на канале и каличистфо юзирафф на нём)}
	}
	
	set ccs(args,pod,chanadd) {<конал>}
	set ccs(help,pod,chanadd) {Дабаведь \002конал\002}
	
	set ccs(args,pod,chandel) {<конал>}
	set ccs(help,pod,chandel) {Стиредь \002конал\002 фпесту}
	
	set ccs(args,pod,rejoin) {}
	set ccs(help,pod,rejoin) {Дайод каманду боту пиризайти на конал}
	
	set ccs(args,pod,chanset) {<[+/-]парамидр> [значенийе]}
	set ccs(help,pod,chanset) {Изминяид \002парамидр\002 конала (напрямер, «+bitch» или «flood-chan 5:10»). Аналаг каманды «chanset» в кансоле}
	
	set ccs(args,pod,chaninfo) {[парамидр]}
	set ccs(help,pod,chaninfo) {Прасматриваит \002парамидр\002 канала. Если парамидр ниуказан, то будут паказаны фсе парамидры}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,chan,pod,#101) "Каналы: %s."
	set ccs(text,chan,pod,#102) "Канал \002%s\002 стерт фпезду."
	set ccs(text,chan,pod,#103) "Канал \002%s\002 зобабахан."
	set ccs(text,chan,pod,#104) "Канал \002%s\002 нипраписан на боти, идика нафег."
	set ccs(text,chan,pod,#105) "Канал \002%s\002 ивляица пастаянным и ниможыт быть удалйон с помощьйу скрипта (Вы можыте паставить +inactive)."
	set ccs(text,chan,pod,#106) "Настройке \002%s\002 нетунихуйа!"
	set ccs(text,chan,pod,#107) "Изминина флага канала \002%s\002"
	set ccs(text,chan,pod,#108) "Значенийе флага канала: \002%s\002"
	set ccs(text,chan,pod,#109) "Изминина настройка \002%s\002 канала на \"\002%s\002\""
	set ccs(text,chan,pod,#110) "Значенийе настройки \002%s\002 канала: \002%s\002"
	
}