== CCS - Channel Control Script ==
by Buster
v1.8.2
readme charset: windows-cp1251

Разделы:
--------
1. Описание
2. Быстрая установка
3. Обновление
4. Credits
--------

------------
1. ОПИСАНИЕ
------------

бла

-------------------------
2. БЫСТРАЯ УСТАНОВКА CCS
-------------------------

- Создайте поддиректорию ccs/ в директории scripts/ и скопируйте туда содержимое архива.
  В результате у вас должно получится нечто вроде:

/home/user/eggdrop/scripts/
или
C:\windrop\scripts\

-> ccs/
-----> bak/
-----> data/
-----> lang/
-----> lib/
-----> mod/
-----> scr/
-----> ChangeLog
-----> ccs.tcl
-----> ccs.rc0-template.tcl
-----> ccs.rc0-template-EN.tcl
-----> ccs.rc1-template.tcl
-----> ccs.rc1-template-EN.tcl
-----> ccs.rc2-template.tcl
-----> ccs.rc2-template-EN.tcl
-----> readme-RU.txt
<--

- Переименуйте файлы шаблонов ccs.rc*-template.tcl в ccs.rc*.tcl где "*" - приоритетный номер шаблона.
  Не меняйте это значение, оставьте по-умолчанию.
- Откройте переименованные файлы и посредством прямого редактирования настройте опции скрипта под себя.
- Добавьте в eggdrop.conf строчку вида:
  source scripts/ccs/ccs.tcl
- Перезапустите/рехашните бота.
- Справка доступна по командк !helps. Enjoy.

-------------
3. ОБНОВЛЕНИЕ
-------------
3.а Автообновление возможностями скрипта

блех

3.б Обновление через SVN

блух

3.б Миграция со старых версий на новые

блоп

-----------
3. CREDITS
-----------

Автор скрипта: Buster (buster@buster-net.ru)
WEB-ресурсы автора:
                    http://buster-net.ru/index.php?section=irc&theme=scripts
                    http://reserver.buster-net.ru/index.php?section=irc&theme=scripts
Forum:              http://forum.systemplanet.ru/viewtopic.php?f=3&t=3
SVN:                svn checkout http://ccs-script.googlecode.com/svn/trunk/
Тестеры:            Kein, Net_Storm, anaesthesia.
English translator: Kein (kein-of@yandex.ru)