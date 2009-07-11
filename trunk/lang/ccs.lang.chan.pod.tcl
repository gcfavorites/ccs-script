
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chan"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang channels {}
	set_text -type help -- $_lang channels {Вывисти списак каналафф}
	set_text -type help2 -- $_lang channels {
		{Вывисти списак каналафф, на каторых сидид бот (иво статус на канале и каличистфо юзирафф на нём)}
	}
	
	set_text -type args -- $_lang chanadd {<конал>}
	set_text -type help -- $_lang chanadd {Дабаведь \002конал\002}
	
	set_text -type args -- $_lang chandel {<конал>}
	set_text -type help -- $_lang chandel {Стиредь \002конал\002 фпесту}
	
	set_text -type args -- $_lang rejoin {}
	set_text -type help -- $_lang rejoin {Дайод каманду боту пиризайти на конал}
	
	set_text -type args -- $_lang chanset {<[+/-]парамидр> [значенийе]}
	set_text -type help -- $_lang chanset {Изминяид \002парамидр\002 конала (напрямер, «+bitch» или «flood-chan 5:10»). Аналаг каманды «chanset» в кансоле}
	
	set_text -type args -- $_lang chaninfo {[парамидр]}
	set_text -type help -- $_lang chaninfo {Прасматриваит \002парамидр\002 канала. Если парамидр ниуказан, то будут паказаны фсе парамидры}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #101 "Каналы: %s."
	set_text $_lang $_name #102 "Канал \002%s\002 стерт фпезду."
	set_text $_lang $_name #103 "Канал \002%s\002 зобабахан."
	set_text $_lang $_name #104 "Канал \002%s\002 нипраписан на боти, идика нафег."
	set_text $_lang $_name #105 "Канал \002%s\002 ивляица пастаянным и ниможыт быть удалйон с помощьйу скрипта (Вы можыте паставить +inactive)."
	set_text $_lang $_name #106 "Настройке \002%s\002 нетунихуйа!"
	set_text $_lang $_name #107 "Изминина флага канала \002%s\002"
	set_text $_lang $_name #108 "Значенийе флага канала: \002%s\002"
	set_text $_lang $_name #109 "Изминина настройка \002%s\002 канала на \"\002%s\002\""
	set_text $_lang $_name #110 "Значенийе настройки \002%s\002 канала: \002%s\002"
	
}