
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"lang"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang langlist {[mod]}
	set_text -type help -- $_lang langlist {Shows the list of available languages (optional: for the specified module only).}
	
	set_text -type args -- $_lang chansetlang {<lang/default>}
	set_text -type help -- $_lang chansetlang {Sets a channel's default language. Specify \002default\002 to reset the channel language (will be used a value from conf).}
	
	set_text -type args -- $_lang chlang {<nick/hand> <lang>}
	set_text -type help -- $_lang chlang {Sets the language for a given user. Specify the \002default\002 to reset his current language to a channel/script defined.}
	
	set_text $_lang $_name #101 "To get a list of the available languages, specify the module name: \002%s\002."
	set_text $_lang $_name #102 "Module name: \002%s\002, v%s \[%s\] by %s"
	set_text $_lang $_name #103 " - Language: \002%s\002, v%s \[%s\] by %s"
	set_text $_lang $_name #104 "Language \002%s\002 not found, valid languages is: \002%s\002."
	set_text $_lang $_name #105 "Language for channel \002%s\002 has been reset."
	set_text $_lang $_name #106 "Language for channel \002%s\002 sets to \002%s\002."
	set_text $_lang $_name #107 "Language for %s has been reset."
	set_text $_lang $_name #108 "Language for %s sets to \002%s\002."
	set_text $_lang $_name #109 "No language set for channel \002%s\002"
	set_text $_lang $_name #110 "Current \002%s\002 language is: \002%s\002."
	set_text $_lang $_name #111 "No language set for %s."
	set_text $_lang $_name #112 "Current %s's language is: \002%s\002."
	
}