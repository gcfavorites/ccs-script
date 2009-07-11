
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"users"
set _lang		"pod"
pkg_add lang [list $_name $_lang] \
				"adium <adium@mail.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang adduser {<юзир> [хост]}
	set_text -type help -- $_lang adduser {Дабавляит \002юзир\002а в юзирлист бота, если парамидр \002хост\002 ниуказан, то бот берёд хост *!?ident@*.host (челавег должын присуцтвавать на канале), если парамидр \002хост\002 указан, то наличийе юзира на канале ниабизатильно}
	
	set_text -type args -- $_lang deluser {<юзир>}
	set_text -type help -- $_lang deluser {Удалить \002юзир\002а из юзирлиста. Фниманиенах: шобы удалидь юзира, Вы далжны быть вышы иво аксэссам на фсех каналах, на каторых он праписан (тоисть если он +o на #chan1, а Вы там ни +m, то удалить юзира ниудасца)}
	
	set_text -type args -- $_lang addhost {<юзир|хэндл> <хост>}
	set_text -type help -- $_lang addhost {Дабавить \002хост\002 юзиру с никам \002юзир\002 или хэндлам \002хэндл\002}
	
	set_text -type args -- $_lang delhost {<юзир|хэндл> <хост>|<-m хостмаска>}
	set_text -type help -- $_lang delhost {Удалить выбранный \002хост\002 юзира. Вазможна использавание масак. * - удаляит фсе хосты}
	
	set_text -type args -- $_lang chattr {<юзир> <+флаг|-флаг> [global]}
	set_text -type help -- $_lang chattr {Изминидь флаге \002юзир\002а, если указан парамидр \002global\002, то изминяит глабальныйе флаги}
	
	set_text -type args -- $_lang userlist {[-f гфлаги|лфлаги] [-h хост]}
	set_text -type help -- $_lang userlist {Паказываит списак юзирафф па Вашым парамидрам. Аналак функции userlist ф TCL}
	
	set_text -type args -- $_lang resetpass {<юзир>}
	set_text -type help -- $_lang resetpass {Сбрасываит пароль юзиру (юзир сможыт забабахать пароль занава па команди /msg %botnick pass <новый пароль>}
	
	set_text -type args -- $_lang chhandle {<oldюзир> <newюзир>}
	set_text -type help -- $_lang chhandle {Изменйает хендл юзера с \002oldюзир\002 на \002newюзир\002.}
	
	set_text -type args -- $_lang setinfo {<юзир|хэнд> <текст>}
	set_text -type help -- $_lang setinfo {Зобобахать инфармацийу юзеру, каторая будит видна па команди %pref_whois и при входи юзира на канал, ф случаи +greet рижыма}
	
	set_text -type args -- $_lang delinfo {<юзир|хэнд>}
	set_text -type help -- $_lang delinfo {Стиредьнах инфармацыйу юзира \002юзир|хэнд\002}
	
	set_text $_lang $_name #101 "Нихуйанивижу \002%s\002, нимагу иво захриначить (нет хоста)."
	set_text $_lang $_name #102 "Юзир \002%s\002 был успешна захриначин с хостом \002%s\002."
	set_text $_lang $_name #103 "Я дабавил тибянах фсвой юзирлист. Миня завут \002%s\002 и ниибед."
	set_text $_lang $_name #104 "Шобы меня юузать - захреначь пароль камандай: \002/msg %s pass ваш_пароль\002."
	set_text $_lang $_name #105 "Шобы юузать каманды - нада платитьнах! Буш каждый рас при заходи в IRC идинтифицирафацца у минйа пакаманди \002/msg %s auth ваш_пароль\002."
	set_text $_lang $_name #106 "Более падробнуйу помащь Вы нихуйа нипалучите, но можыте рискнуть нобрадь\002%shelp\002 на любом из каналафф, где йа есть."
	set_text $_lang $_name #107 "Юзир \002%s\002 очинь тугой - лесам иво!"
	set_text $_lang $_name #108 "Сцаси болд скатина! Нихуйа ниудалишь %s."
	set_text $_lang $_name #109 "Стерднах и зобыт юзир %s."
	set_text $_lang $_name #110 "Хост \002%s\002 пришыд к юзиру \002%s\002 капронавыми нидками."
	set_text $_lang $_name #111 "Хост \002%s\002 стерднах у юзира \002%s\002."
	set_text $_lang $_name #112 "Ниадин хостнах нисавпал с маскай."
	set_text $_lang $_name #113 "Атвед на зопрос userlist (%s): %s"
	set_text $_lang $_name #114 "Недправ на изминенийе флага \002%s\002 длйа \002%s\002 - выпей йаду говнюг!"
	set_text $_lang $_name #115 "Новыйенах флаги для %s: \002%s\002"
	set_text $_lang $_name #116 "Пароль длйа юзира %s стерднах!"
	set_text $_lang $_name #117 "Твой пароль сбросил злобный хакирЪ %s. Устанави иво занава камандай \002/msg %s pass новый_пароль\002."
	set_text $_lang $_name #118 "Юзир \002%s\002 уже используется."
	set_text $_lang $_name #119 "Длйа %s был сменен хендл на \002%s\002."
	set_text $_lang $_name #120 "Инфармацийа длйа \002%s\002 зобабахана"
	set_text $_lang $_name #121 "Инфармацийа длйа \002%s\002 стержанах"
	
}