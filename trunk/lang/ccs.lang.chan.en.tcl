
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chan"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.1" \
				"30-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang channels {}
	set_text -type help -- $_lang channels {List all channels}
	set_text -type help2 -- $_lang channels {
		{List all channels where bot is on (bot's status and amount of channel users)}
	}
	
	set_text -type args -- $_lang chanadd {<channel>}
	set_text -type help -- $_lang chanadd {Adds \002channel\002 in to a bot's chans db}
	
	set_text -type args -- $_lang chandel {<channel>}
	set_text -type help -- $_lang chandel {Removes \002channel\002 from a bot's chans db}
	
	set_text -type args -- $_lang rejoin {}
	set_text -type help -- $_lang rejoin {Tells bot to rejoin the channel.}
	
	set_text -type args -- $_lang chanset {<[+/-]option> [value]}
	set_text -type help -- $_lang chanset {Change channel \002options\002 (for example: «+bitch» or «flood-chan 5:10»). Works like partyline's «.chanset» command.}
		set_text -type help2 -- $_lang chanset {
		{Change channel \002options\002 (for example: «+bitch» or «flood-chan 5:10»). Works like partyline's «.chanset» command.}
	}
	
	set_text -type args -- $_lang chaninfo {[option]}
	set_text -type help -- $_lang chaninfo {Lists all the settings for the bot on the given channel.}
	set_text -type help2 -- $_lang chaninfo {
		{Lists all the settings for the bot on the given channel. If you do not specify optional parameter, will be shown all options of the channel. Global mask symbols \"*\" and \"?\" are allowed.}
	}
	
	set_text -type args -- $_lang chansave {<filename> [template_name]}
	set_text -type help -- $_lang chansave {Saves current channel settings into file.}
	set_text -type help2 -- $_lang chansave {
		{Saves current channel settings into file. If you specify a template name then only template options (options included into pre-defined template) will be saved.}
	}
	
	set_text -type args -- $_lang chanload {<filename> [template_name]}
	set_text -type help -- $_lang chanload {Restores channel settings from a file.}
	set_text -type help2 -- $_lang chanload {
		{Restores channel settings from a file. If you specify a template name then only template options (options included into pre-defined template) will be restored.}
	}
	
	set_text -type args -- $_lang chancopy {<destination_channel> [template_name]}
	set_text -type help -- $_lang chancopy {Copies current channel options to another channel.}
	set_text -type help2 -- $_lang chancopy {
		{Copies current channel options to another channel. If you specify a template name then only template options (options included into pre-defined template) will be copied.}
	}
	
	set_text -type args -- $_lang chantemplateadd {<template_name> <option1 option2 ...>}
	set_text -type help -- $_lang chantemplateadd {Adds into specified template a set of options or creates template if it doesn't exist.}
	
	set_text -type args -- $_lang chantemplatedel {<template_name> <option1 option2 ...>}
	set_text -type help -- $_lang chantemplatedel {Removes from specified template a set of options.}
	
	set_text -type args -- $_lang chantemplatelist {<template_name>}
	set_text -type help -- $_lang chantemplatelist {Lists all options included into specified template.}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set_text $_lang $_name #101 "Channels: %s."
	set_text $_lang $_name #102 "Channel \002%s\002 has been deleted."
	set_text $_lang $_name #103 "Channel \002%s\002 has been added."
	set_text $_lang $_name #104 "Channel \002%s\002 does not exist."
	set_text $_lang $_name #105 "Channel \002%s\002 is permanent (config-defined) and cannot be deleted (but you still can set +inactive)."
	set_text $_lang $_name #106 "Option \002%s\002 does not exist!"
	set_text $_lang $_name #107 "Successfully sets \002%s\002"
	set_text $_lang $_name #108 "Current option status: \002%s\002"
	set_text $_lang $_name #109 "Channel option \002%s\002 changed to \"\002%s\002\""
	set_text $_lang $_name #110 "Channel option \002%s\002 currently has values: \"\002%s\002\""
	set_text $_lang $_name #111 "All \002%s\002 settings saved into file \"\002%s\002\""
	set_text $_lang $_name #112 "All \002%s\002 settings saved into file \"\002%s\002\", used template \"\002%s\002\""
	set_text $_lang $_name #113 "All \002%s\002 settings sucesssfully restored from file \"\002%s\002\""
	set_text $_lang $_name #114 "All \002%s\002 settings sucesssfully restored from file \"\002%s\002\", used template \"\002%s\002\""
	set_text $_lang $_name #115 "Settings for channel \002%s\002 have been partially restored from file \"\002%s\002\". Here is list of ignored/skipped options: \002%s\002"
	set_text $_lang $_name #116 "Settings for channel \002%s\002 have been partially restored from file \"\002%s\002\", used template \"\002%s\002\". Here is list of ignored/skipped options: \002%s\002"
	set_text $_lang $_name #117 "All settings from \002%s\002 have been copied and applied for \002%s\002"
	set_text $_lang $_name #118 "All settings from \002%s\002 have been copied and applied for \002%s\002, used template \"\002%s\002\""
	set_text $_lang $_name #119 "File \"\002%s\002\" does not exist."
	set_text $_lang $_name #120 "Template-file \"\002%s\002\" does not exist."
	set_text $_lang $_name #121 "No options have been write into template \"\002%s\002\"; %s."
	set_text $_lang $_name #122 "No options have been removed from template \"\002%s\002\"; %s."
	set_text $_lang $_name #123 "New options have been written into \"\002%s\002\" template; %s."
	set_text $_lang $_name #124 "Specified options have been sucessfully removed from template \"\002%s\002\"; %s."
	set_text $_lang $_name #125 "new: \002%s\002"
	set_text $_lang $_name #126 "invalid: \002%s\002"
	set_text $_lang $_name #127 "old: \002%s\002"
	set_text $_lang $_name #128 "deleted: \002%s\002"
	set_text $_lang $_name #129 "missing: \002%s\002"
	set_text $_lang $_name #130 "List of options in template \"\002%s\002\": \002%s\002."
	set_text $_lang $_name #131 "Result options list: \002%s\002."
	
}