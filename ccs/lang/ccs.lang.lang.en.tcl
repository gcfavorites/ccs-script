
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"lang"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.0" \
				"16-Jun-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,langlist) {[mod]}
	set ccs(help,en,langlist) {Shows the list of available languages for the specified module.}
	
	set ccs(args,en,chansetlang) {<lang/default>}
	set ccs(help,en,chansetlang) {Sets a channel's default language. Specify \002default\002 to reset the channel language to a script defined.}
	
	set ccs(args,en,chlang) {<nick/hand> <lang>}
	set ccs(help,en,chlang) {Sets the language for a given user. Specify the \002default\002 to reset his current language to a channel/script defined.}
	
	set ccs(text,lang,en,#101) "To get a list of the available languages, specify the module name: \002%s\002."
	set ccs(text,lang,en,#102) "Module name: \002%s\002, v%s \[%s\] by %s"
	set ccs(text,lang,en,#103) " - Language: \002%s\002, v%s \[%s\] by %s"
	set ccs(text,lang,en,#104) "Language \002%s\002 not found, valid languages is: \002%s\002."
	set ccs(text,lang,en,#105) "Language for channel \002%s\002 has been reset."
	set ccs(text,lang,en,#106) "Language for channel \002%s\002 sets to \002%s\002."
	set ccs(text,lang,en,#107) "Language for %s has been reset."
	set ccs(text,lang,en,#108) "Language for %s sets to \002%s\002."
	set ccs(text,lang,en,#109) "No language set for channel \002%s\002"
	set ccs(text,lang,en,#110) "Current \002%s\002 language is: \002%s\002."
	set ccs(text,lang,en,#111) "No language set for %s."
	set ccs(text,lang,en,#112) "Current %s's language is: \002%s\002."
	
}