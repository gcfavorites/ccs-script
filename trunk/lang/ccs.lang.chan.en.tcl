
if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]";return}

set _name		"chan"
set _lang		"en"
pkg_add lang [list $_name $_lang] \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.4.0" \
				"01-Jul-2009"

if {[pkg_info lang [list $_name $_lang] on]} {
	
	set_text -type args -- $_lang channels {}
	set_text -type help -- $_lang channels {List all channels}
	set_text -type help2 -- $_lang channels {
		{List all channels where bot is on (bot status and amount of channel users)}
	}
	
	set_text -type args -- $_lang chanadd {<channel>}
	set_text -type help -- $_lang chanadd {Adds \002channel\002 in to a bot's chans db}
	
	set_text -type args -- $_lang chandel {<channel>}
	set_text -type help -- $_lang chandel {Removes \002channel\002 from a bot's chans db}
	
	set_text -type args -- $_lang rejoin {}
	set_text -type help -- $_lang rejoin {Tells bot to rejoin the channel.}
	
	set_text -type args -- $_lang chanset {<[+/-]option> [value]}
	set_text -type help -- $_lang chanset {Change channel \002options\002 (for example: «+bitch» or «flood-chan 5:10»). Works like partyline's «.chanset» command.}
	
	set_text -type args -- $_lang chaninfo {[option]}
	set_text -type help -- $_lang chaninfo {Shows \002option's\002 status on the channel. If you do not specify optional parameter, will be shown all options on the channel.}
	
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
	
}