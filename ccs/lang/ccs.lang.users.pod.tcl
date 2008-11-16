
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"users"
set modlang		"pod"
addlang $modname $modlang \
				"adium <adium@mail.ru> (c)" \
				"1.2.1" \
				"30-Jul-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,pod,adduser) {<юзир> [хост]}
	set ccs(help,pod,adduser) {Дабавляит \002юзир\002а в юзирлист бота, если парамидр \002хост\002 ниуказан, то бот берёд хост *!?ident@*.host (челавег должын присуцтвавать на канале), если парамидр \002хост\002 указан, то наличийе юзира на канале ниабизатильно}
	
	set ccs(args,pod,deluser) {<юзир>}
	set ccs(help,pod,deluser) {Удалить \002юзир\002а из юзирлиста. Фниманиенах: шобы удалидь юзира, Вы далжны быть вышы иво аксэссам на фсех каналах, на каторых он праписан (тоисть если он +o на #chan1, а Вы там ни +m, то удалить юзира ниудасца)}
	
	set ccs(args,pod,addhost) {<юзир/хэндл> <хост>}
	set ccs(help,pod,addhost) {Дабавить \002хост\002 юзиру с никам \002юзир\002 или хэндлам \002хэндл\002}
	
	set ccs(args,pod,delhost) {<юзир/хэндл> <хост>}
	set ccs(help,pod,delhost) {Удалить выбранный \002хост\002 юзира. Вазможна использавание масак. * - удаляит фсе хосты}
	
	set ccs(args,pod,chattr) {<юзир> <+флаг/-флаг> [global]}
	set ccs(help,pod,chattr) {Изминидь флаге \002юзир\002а, если указан парамидр \002global\002, то изминяит глабальныйе флаги}
	
	set ccs(args,pod,userlist) {[-f -|флаги/флаги] [-h хост]}
	set ccs(help,pod,userlist) {Паказываит списак юзирафф па Вашым парамидрам. Аналак функции userlist ф TCL}
	
	set ccs(args,pod,resetpass) {<юзир>}
	set ccs(help,pod,resetpass) {Сбрасываит пароль юзиру (юзир сможыт забабахать пароль занава па команди /msg %botnick pass <новый пароль>}
	
	set ccs(args,en,chhandle) {<oldюзир> <newюзир>}
	set ccs(help,en,chhandle) {Изменйает хендл юзера с \002oldюзир\002 на \002newюзир\002.}
	
	set ccs(args,pod,setinfo) {<юзир/хэнд> <текст>}
	set ccs(help,pod,setinfo) {Зобобахать инфармацийу юзеру, каторая будит видна па команди %pref_whois и при входи юзира на канал, ф случаи +greet рижыма}
	
	set ccs(args,pod,delinfo) {<юзир/хэнд>}
	set ccs(help,pod,delinfo) {Стиредьнах инфармацыйу юзира \002юзир/хэнд\002}
	
	set ccs(text,users,pod,#101) "Нихуйанивижу \002%s\002, нимагу иво захриначить (нет хоста)."
	set ccs(text,users,pod,#102) "Юзир \002%s\002 был успешна захриначин с хостом \002%s\002."
	set ccs(text,users,pod,#103) "Я дабавил тибянах фсвой юзирлист. Миня завут \002%s\002 и ниибед."
	set ccs(text,users,pod,#104) "Шобы меня юузать - захреначь пароль камандай: \002/msg %s pass ваш_пароль\002."
	set ccs(text,users,pod,#105) "Шобы юузать каманды - нада платитьнах! Буш каждый рас при заходи в IRC идинтифицирафацца у минйа пакаманди \002/msg %s auth ваш_пароль\002."
	set ccs(text,users,pod,#106) "Более падробнуйу помащь Вы нихуйа нипалучите, но можыте рискнуть нобрадь\002%shelp\002 на любом из каналафф, где йа есть."
	set ccs(text,users,pod,#107) "Юзир \002%s\002 очинь тугой - лесам иво!"
	set ccs(text,users,pod,#108) "Сцаси болд скатина! Нихуйа ниудалишь %s."
	set ccs(text,users,pod,#109) "Стерднах и зобыт юзир %s."
	set ccs(text,users,pod,#110) "Хост \037%s\037 пришыд к юзиру \002%s\002 капронавыми нидками."
	set ccs(text,users,pod,#111) "Хост \002%s\002 стерднах у юзира \002%s\002."
	set ccs(text,users,pod,#112) "Ниадин хостнах нисавпал с маскай."
	set ccs(text,users,pod,#113) "Атвед на зопрос userlist (%s): %s"
	set ccs(text,users,pod,#114) "Недправ на изминенийе флага \002%s\002 длйа \002%s\002 - выпей йаду говнюг!"
	set ccs(text,users,pod,#115) "Новыйенах флаги для %s: \002%s\002"
	set ccs(text,users,pod,#116) "Пароль длйа юзира %s стерднах!"
	set ccs(text,users,pod,#117) "Твой пароль сбросил злобный хакирЪ %s. Устанави иво занава камандай \002/msg %s pass новый_пароль\002."
	set ccs(text,users,pod,#118) "Юзир \002%s\002 уже используется."
	set ccs(text,users,pod,#119) "Длйа %s был сменен хендл на \002%s\002."
	set ccs(text,users,pod,#120) "Инфармацийа длйа \002%s\002 зобабахана"
	set ccs(text,users,pod,#121) "Инфармацийа длйа \002%s\002 стержанах"
	
}