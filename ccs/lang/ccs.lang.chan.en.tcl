
if {[namespace current] == "::"} {putlog "\002\00304Do not source [info script]";return}

set modname		"chan"
set modlang		"en"
addlang $modname $modlang \
				"Kein <kein-of@yandex.ru> (c)" \
				"1.2.2" \
				"28-Jul-2008"

if {$ccs(lang,name,$modname,$modlang)} {
	
	set ccs(args,en,channels) {}
	set ccs(help,en,channels) {List all channels}
	set ccs(help2,en,channels) {
		{List all channels where bot is on (bot status and amount of channel users)}
	}
	
	set ccs(args,en,chanadd) {<channel>}
	set ccs(help,en,chanadd) {Adds \002channel\002 in to a bot's chans db}
	
	set ccs(args,en,chandel) {<channel>}
	set ccs(help,en,chandel) {Removes \002channel\002 from a bot's chans db}
	
	set ccs(args,en,rejoin) {}
	set ccs(help,en,rejoin) {Tells bot rejoin to the channel.}
	
	set ccs(args,en,chanset) {<[+/-]option> [value]}
	set ccs(help,en,chanset) {Change channel \002options\002 (for example: «+bitch» or «flood-chan 5:10»). Works like partyline's «.chanset» command.}
	
	set ccs(args,en,chaninfo) {[option]}
	set ccs(help,en,chaninfo) {Shows \002option's\002 status on the channel. If you do not specify optional parameter, will be shown all options on the channel.}
	
	#############################################################################################################
	#############################################################################################################
	#############################################################################################################
	
	set ccs(text,chan,en,#101) "Channels: %s."
	set ccs(text,chan,en,#102) "Channel \002%s\002 has been deleted."
	set ccs(text,chan,en,#103) "Channel \002%s\002 has been added."
	set ccs(text,chan,en,#104) "Channel \002%s\002 does not exist."
	set ccs(text,chan,en,#105) "Channel \002%s\002 is permanent (config-defined) and cannot be deleted (but you still can set +inactive)."
	set ccs(text,chan,en,#106) "Option \002%s\002 does not exist!"
	set ccs(text,chan,en,#107) "Successfully sets \002%s\002"
	set ccs(text,chan,en,#108) "Current option status: \002%s\002"
	
}