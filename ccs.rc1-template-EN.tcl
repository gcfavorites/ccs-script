if {[namespace current] == "::"} {putlog "\002\00304You shouldn't do just source [info script]"; return}
##################################################################################################################
# This file goes along with the main css.tcl file and loaded automatically if exist in the same folder where 
# css.tcl is (tho this file is not required by script itself).
# File contain so-called "first-set-of-script-settings" and it's main goal to make CCS settings system much
# simplier and easier. So, for example, when you did a script update all your settings will no be lost, because
# they is stored in the custom file and not in the script file body itself. Also, it is pretty useful for your
# own procedures, commands, etc (and main file stays untouched and unmodified).
# By default, every option is commented, so, if you want to change the value you need to uncomment it (by removing
# symbol '#' before directive).
##################################################################################################################
# Note that this settings template is loaded AFTER ccs-modules, custom ccs-scripts, css-libs and languages.
# So, that's allow you to customize some settings of the script (like ops privs and auth methods, etc).
##################################################################################################################
# !!! Do not forget to rename this template-file in to ccs.rc1.tcl (so, you need just remove "-template-EN"
# part from the filename) !!!
##################################################################################################################


# List of the commands params (#cmd_configure):
#
# -group
#   binds command availability to specified group (string);
#
# -use
#   enable/disable command (1 - enable, 0 - disable, default value 1
#   even if parameter is not defined);
#
# -use_auth
#   command usage requires authenfication (1 - enable, 0 - disable,
#   defaul value 1 even if parameter is not defined);
#
# -use_chan
#   defines that command will use channel name for some operations (public usage).
#   If command with -use_chan flag used via PM it will ask to specify a channel name
#   (defaul value 1 even if parameter is not defined);
#      0 - channel name is not used;
#      1 - channel name required;
#      2 - channel name or "*" required;
#      3 - channel name is not required;
#
# -flags
#   Flags required for specified command. Flag without "-|-" delimiter will be treated as global,
#   flags specified via "-|-" will include local access for specified command.
#   (custom flags: %v - user must be in bot's userlist);
#
# -alias
#   aliases for the command, %pref_ uses as default prefix.
#
# -block
#   Optional. Specifies time delay between command usage.
#
# -regexp
#   regular expression, выбирающее данные и передающее обрабатываемой процедуре
#
# -override_level
#   Overrides user level required for specified command. So, if user don't has required privs
#   (for example: command has custom required flag defined but user don't has one) this parameter
#   allows you to override such restriction and increase user access level.
#   Default levels for default flags:
#      0 - no permissions
#      1 - local l
#      2 - local o
#      3 - local m
#      4 - local n
#      5 - global l
#      6 - global o
#      7 - global m
#      8 - global n
#      9 - permanent owner ("set owner" directive)
#   It is not recomended to use value greater then value defined with -flags parameetr.
#   в параметре -flags
####################################################################################################
# General hostmask templates:
#      1: *!user@host
#      2: *!*user@host
#      3: *!*@host
#      4: *!*user@*.host
#      5: *!*@*.host
#      6: nick!user@host
#      7: nick!*user@host
#      8: nick!*@host
#      9: nick!*user@*.host
#     10: nick!*@*.host
####################################################################################################


	################################################################################################
	# General settings                                                                             #
	################################################################################################
	# 
	# All settings commented by default. Uncomment them if you want to use a custom value.
	#
	################################################################################################
	# Prefixes for all control commands. pub - channel prefix, msg - privmsg prefix, dcc - partyline.
	# Note: you cant define "." as partyline prefix.
	#configure -prefix_pub				"!"
	#configure -prefix_msg				"!"
	#configure -prefix_dcc				"!"
	
	################################################################################################
	# Prefixes for all control commands via botnet. pub - channel prefix, msg - privmsg prefix,
	# dcc - partyline. !Attention! commands without prefixes will not be defined.
	# Note: you cant define "." as partyline prefix.
	#configure -prefix_botnet_pub		"!!"
	#configure -prefix_botnet_msg		"!!"
	#configure -prefix_botnet_dcc		"!!"
	
	################################################################################################
	# Default language list for output messages/help system. You can override this value by channel
	# option ccs-default_lang and per-user setting. First value in the specified list has highest
	# priority.
	#configure -default_lang				{ru en}
	
	################################################################################################
	# "Flood-free' flags, forces bot to skip delayes between messages. Note: do not use this feature
	# if your bot don't has special privs on the server or Excess Flood will happen :P
	# (0 - slow and safe, 1 - fast and unsafe).
	#configure -fast						1
	
	################################################################################################
	# Maximum amount of notices (strings). When value exceeded bot will send privmsgs instead.
	#configure -max_notice				10
	
	################################################################################################
	# Admissible lenght of the message. When value exceeded bot will split message to multiple
	# messages
	#configure -msg_len					400
	
	################################################################################################
	# Maximum ident lenght. Required for correct hostmask detection.
	#configure -identlen					10
	
	################################################################################################
	# Limit help output by groups only. (1 - only by groups, 0 - general and by groups)
	#configure -help_group				0
	
	################################################################################################
	# Debug level (1 - common info; 2, 3, ... - custom/detailed info)
	#configure -debug					2
	
	################################################################################################
	# Enables/disables script for all channels by default. Specify 1 to make script available on
	# all channels or 0 to make it work only if channel has ccs-on_chan flag set.
	#configure -on_chan					1
	
	################################################################################################
	# Enables/disables colors in scripts/modules (if these present). Applies for privmsgs and partyline
	# as well. Use "0" for black-white or "1" for colorful. Can be ovveriden by "ccs-usecolors" flag.
	#configure -usecolors				1
	
	################################################################################################
	# How long we should keep user authorization if he still not joined any common channels where
	# bot is (milliseconds).
	#configure -time_auth_notonchan		300000
	
	################################################################################################
	# How long we should keep user authorization if he leave all common channels where bot is.
	#configure -time_auth_part			3000
	
	################################################################################################
	# Backup directory for old ccs-files (only actual if you updating script via autoupdate feature).
	# $dir_ccs here always point to root dir where ccs.tcl is.
	#configure -dir_bak					"$dir_ccs/bak"
	
	################################################################################################
	# Defines directory where all lang-files is (ccs.lang.*.tcl)
	# $dir_ccs here always point to root dir where ccs.tcl is.
	#configure -dir_lang					"$dir_ccs/lang"
	
	################################################################################################
	# Defines directory where all modules is (ccs.mod.*.tcl)
	# $dir_ccs here always point to root dir where ccs.tcl is.
	#configure -dir_mod					"$dir_ccs/mod"
	
	################################################################################################
	# Defines directory where all custom scripts is (ccs.scr.*.tcl)
	# $dir_ccs here always point to root dir where ccs.tcl is.
	#configure -dir_scr					"$dir_ccs/scr"
	
	################################################################################################
	# Defines directory where all libs is (ccs.libs.*.tcl)
	# $dir_ccs here always point to root dir where ccs.tcl is.
	#configure -dir_lib					"$dir_ccs/lib"
	
	################################################################################################
	# Defines directory where all script data will be stored.
	# $dir_ccs here always point to root dir where ccs.tcl is.
	#configure -dir_data					"$dir_ccs/data"
	
	################################################################################################
	# Custom user flags. There is no reason to change these values, but oh well...
	# Flag that defines user authorization on the bot via script
	#configure -flag_auth				"Q"
	# Flag that defines user authorization on the bot via botnet (ccs-feature too)
	#configure -flag_auth_botnet			"B"
	# Temporal flag defines that user's authorization is checking via botnet atm 
	#configure -flag_botnet_check		"O"
	# Permanent authorization flag (auto-identification by hostlist only, without manual password authorization)
	#configure -flag_auth_perm			"P"
	# Flag that protects user's handle from all changes by anyone below global owner level
	#configure -flag_locked				"L"
	# Flag that protects user form some abusive commands like kick, ban, etc. works correcly only if
	# command issued @ user handle (if current user handle differs from current user nick - it fails)
	#configure -flag_protect				"H|H"
	# Flags defines that bot acccepts remote commands via botnet (ccs-script feature)
	#configure -flag_cmd_bot				"U"
	
	################################################################################################
	# Minimal access flag for secret channels
	#configure -permission_secret_chan	"m|-"
	
	#cmd_configure update -group "system" -flags {n} -block 5 -alias {%pref_updateccs %pref_ccsupdate}
	#cmd_configure help -group "info" -use_botnet 0 -block 3 -flags {%v} -alias {%pref_helps}
	
	
	################################################################################################
	# Settings for BAN module                                                                      #
	################################################################################################
	
	################################################################################################
	# Show in ban reason expiration date? (0 - no, 1 - yes)
	#configure -bandate					1
	
	################################################################################################
	# How should we check permissions for unabn command?
	#   0 - anyone can remove ban if he has access ti unban cmd
	#   1 - only user who has the same access level able to remove ban
	#   2 - only creator or user who has higher access level able to remove ban
	# Specified here value can be overrided via "ccs-unban_level" channel option
	#configure -unban_level				0
	
	################################################################################################
	# Default mask template for channel bans. All available templates listed above.
	# Specified here value can be overrided via "ccs-banmask" channel option
	#configure -banmask					4
	
	#cmd_configure ban -group "ban" -flags {o|o} -block 1 -alias {%pref_ban}
	#cmd_configure unban -group "ban" -flags {o|o} -block 1 -alias {%pref_unban}
	#cmd_configure gban -group "ban" -flags {o} -block 1 -alias {%pref_gban}
	#cmd_configure gunban -group "ban" -flags {o} -block 1 -alias {%pref_gunban}
	#cmd_configure banlist -group "ban" -flags {o|o} -block 3 -alias {%pref_banlist %pref_bans}
	#cmd_configure resetbans -group "ban" -flags {o|o} -block 5 -alias {%pref_resetbans}
	
	
	################################################################################################
	# Setting for BASE module                                                                      #
	################################################################################################
	
	################################################################################################
	# Should we put in the kick reason who issued this command? (0 - no, 1 - yes).
	# Specified here value can be overrided via "ccs-vkickuser" channel option
	#configure -vkickuser				0
	
	################################################################################################
	# Should we prepend topic body with the name of the user who issued this command? (0 - no, 1 - yes).
	# Specified here value can be overrided via "ccs-vtopicuser" channel option
	#configure -vtopicuser				1
	
	#cmd_configure kick -group "mode" -flags {o|o} -block 1 -alias {%pref_kick}
	#cmd_configure inv -group "other" -flags {m|m} -block 5 -alias {%pref_inv}
	#cmd_configure topic -group "chan" -flags {o|o T|T} -block 3 -alias {%pref_topic}
	#cmd_configure addtopic -group "chan" -flags {o|o T|T} -block 5 -alias {%pref_addtopic %pref_добавить}
	#cmd_configure ops -group "info" -flags {-|-} -block 5 -use_botnet 0 -alias {%pref_ops}
	#cmd_configure admins -group "info" -flags {-|-} -block 5 -use_botnet 0 -alias {%pref_admins}
	#cmd_configure whom -group "info" -flags {p} -block 5 -use_botnet 0 -alias {%pref_whom}
	#cmd_configure whois -group "user" -flags {%v} -block 2 -alias {%pref_whois}
	#cmd_configure info -group "info" -flags {%v} -block 5 -alias {%pref_info}
	
	
	################################################################################################
	# Setting for BOTS module                                                                      #
	################################################################################################
	
	################################################################################################
	# Defines default template mask for new added bots
	#configure -addbotmask				4
	
	################################################################################################
	# Allow to output botnet structure as hierarchy tree? (1 - yes, 0 - no).
	# Note: do not use this feature if your bot has no special privs on the server (no flood control)
	#configure -botnettree				1
	
	################################################################################################
	# Time delay between botnet authorization checks
	#configure -time_botauth_check		900000
	
	################################################################################################
	# Time delay within we should wait for bot's reply about athorization status
	#configure -time_botauth_receive		10000
	
	################################################################################################
	# Codepage/charset which will be used for in/out messages in botnet. Actual only if bots ib the
	# botnet has different charsets. UTF is NOT supported.
	#configure -botnet_encoding			""
	
	################################################################################################
	# Unique code length for unique botnet message which prevent accidental messages mixing. If botnet
	# control uses very often (like while one message in progress, another one being send, etc) - better
	# to increase this value.
	#configure -botnet_lencode			3
	
	################################################################################################
	# Packet length for botnet message
	#configure -botnet_lensend			300
	
	################################################################################################
	# Maximum amount of in/out packets for one communication session. Made to prevents buffer overflow.
	#configure -botnet_maxsend			100
	
	################################################################################################
	# Timeout in ms within which we should wait for the message from the botnet
	#configure -botnet_timesend		5000
	
	#cmd_configure bots -group "botnet" -flags {%v} -block 5 -use_botnet 0 -alias {%pref_bots}
	#cmd_configure botattr -group "botnet" -flags {mt} -block 2 -alias {%pref_botattr}
	#cmd_configure chaddr -group "botnet" -flags {mt} -block 2 -alias {%pref_chaddr}
	#cmd_configure addbot -group "botnet" -flags {mt} -block 3 -alias {%pref_addbot}
	#cmd_configure delbot -group "botnet" -flags {mt} -block 3 -alias {%pref_delbot}
	#cmd_configure chbotpass -group "botnet" -flags {mt} -block 3 -alias {%pref_chbotpass}
	#cmd_configure listauth -group "botnet" -flags {mt} -block 3 -alias {%pref_listauth}
	#cmd_configure addauth -group "botnet" -flags {mt} -block 3 -alias {%pref_addauth}
	#cmd_configure delauth -group "botnet" -flags {mt} -block 3 -alias {%pref_delauth}
	
	
	################################################################################################
	# Settings for CHAN module                                                                     #
	################################################################################################
	
	################################################################################################
	# Path and filemask for files where we should store backup'd channel settings. %s works here as
	# command's <filename> parameter
	#configure -chansetfile				"$options(dir_data)/ccs.chanset.%s.dat"
	
	################################################################################################
	# Path and filemask for files where we should store channel settings template. %s works here as
	# template name
	#configure -chantemplatefile			"$options(dir_data)/ccs.chantemplate.%s.dat"
	
	################################################################################################
	# Should we save old settings/templates in the bak/ direcory? (1 - yes, 0 - no)
	#configure -bakchanset				1
	
	#cmd_configure channels -group "chan" -flags {o|o} -block 5 -alias {%pref_channels}
	#cmd_configure chanadd -group "chan" -flags {n} -block 3 -alias {%pref_chanadd %pref_addchan}
	#cmd_configure chandel -group "chan" -flags {n} -block 3 -alias {%pref_chandel %pref_delchan}
	#cmd_configure rejoin -group "chan" -flags {m|m} -block 3 -alias {%pref_rejoin}
	#cmd_configure chanset -group "chan" -flags {n|n} -block 1 -alias {%pref_set %pref_chanset}
	#cmd_configure chaninfo -group "chan" -flags {n|n} -block 5 -alias {%pref_chaninfo}
	#cmd_configure chansave -group "chan" -flags {n|n} -block 5 -alias {%pref_chansave}
	#cmd_configure chanload -group "chan" -flags {n|n} -block 5 -alias {%pref_chanload}
	#cmd_configure chancopy -group "chan" -flags {n|n} -block 5 -alias {%pref_chancopy}
	#cmd_configure templateadd -group "chan" -flags {n|n} -block 5 -alias {%pref_templateadd}
	#cmd_configure templatedel -group "chan" -flags {n|n} -block 5 -alias {%pref_templatedel}
	#cmd_configure templatelist -group "chan" -flags {n|n} -block 5 -alias {%pref_templatelist}
	
	
	################################################################################################
	# Settings for CHANSERV module                                                                 #
	################################################################################################
	
	################################################################################################
	# Commands templates
	#set chanserv(op)		"PRIVMSG ChanServ :OP %chan %nick"
	#set chanserv(deop)		"PRIVMSG ChanServ :DEOP %chan %nick"
	#set chanserv(hop)		"PRIVMSG ChanServ :HALFOP %chan %nick"
	#set chanserv(dehop)		"PRIVMSG ChanServ :DEHALFOP %chan %nick"
	#set chanserv(voice)		"PRIVMSG ChanServ :VOICE %chan %nick"
	#set chanserv(devoice)	"PRIVMSG ChanServ :DEVOICE %chan %nick"
	
	#set chanserv(op)		"ChanServ OP %chan %nick"
	#set chanserv(deop)		"ChanServ DEOP %chan %nick"
	#set chanserv(hop)		"ChanServ HALFOP %chan %nick"
	#set chanserv(dehop)		"ChanServ DEHALFOP %chan %nick"
	#set chanserv(voice)		"ChanServ VOICE %chan %nick"
	#set chanserv(devoice)	"ChanServ DEVOICE %chan %nick"
	
	#cmd_configure csop -group "chanserv" -flags {o|o} -block 1 -alias {%pref_csop}
	#cmd_configure csdeop -group "chanserv" -flags {o|o} -block 1 -alias {%pref_csdeop}
	#cmd_configure cshop -group "chanserv" -flags {l|l} -use 0 -block 1 -alias {%pref_cshop}
	#cmd_configure csdehop -group "chanserv" -flags {l|l} -use 0 -block 1 -alias {%pref_csdehop}
	#cmd_configure csvoice -group "chanserv" -flags {v|v o|o} -block 1 -alias {%pref_csvoice}
	#cmd_configure csdevoice -group "chanserv" -flags {v|v o|o} -block 1 -alias {%pref_csdevoice}
	
	
	################################################################################################
	# Settings for CHAT module                                                                     #
	################################################################################################
	
	################################################################################################
	# Port which will be used for DCC. Put 0 here to enable autolookup for available ports
	#configure -dccport					0
	
	################################################################################################
	# IP-address which will be used for DCC-request. Do not specify it to enable system defined IP
	#configure -dccip					""
	
	#cmd_configure chat -group "other" -flags {p} -block 5 -alias {%pref_chat}
	
	
	################################################################################################
	# Settings for EXEMPT module                                                                   #
	################################################################################################
	
	################################################################################################
	# Should we show expiration date in exception reason? (0 - no, 1 - yes)
	#configure -exemptdate				1
	
	################################################################################################
	# Default mask template for channel exceptions. All available templates listed below.
	# Specified here value can be overrided via "ccs-exemptmask" channel option
	# Hostmask templates:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#configure -exemptmask				4
	
	#cmd_configure exempt -group "exempt" -flags {o|o} -block 1 -alias {%pref_exempt}
	#cmd_configure unexempt -group "exempt" -flags {o|o} -block 1 -use_botnet 0 -alias {%pref_unexempt}
	#cmd_configure gexempt -group "exempt" -flags {o} -block 1 -alias {%pref_gexempt}
	#cmd_configure gunexempt -group "exempt" -flags {o} -block 1 -alias {%pref_gunexempt}
	#cmd_configure exemptlist -group "exempt" -flags {o|o} -block 5 -alias {%pref_exemptlist %pref_exempts}
	#cmd_configure resetexempts -group "exempt" -flags {o|o} -block 5 -alias {%pref_resetexempts}
	
	
	################################################################################################
	# Settings for IGNORE module                                                                      #
	################################################################################################
	
	################################################################################################
	# Should we show expiration date in ignore reason? (0 - no, 1 - yes)
	#configure -ignoredate				1
	
	################################################################################################
	# Default mask template for channel ignores. All available templates listed below.
	# Specified here value can be overrided via "ccs-ignoremask" channel option
	# Hostmask templates:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#configure -ignoremask				4
	
	#cmd_configure addignore -group "other" -flags {o} -block 3 -alias {%pref_addignore %pref_+ignore}
	#cmd_configure delignore -group "other" -flags {o} -block 1 -alias {%pref_delignore %pref_-ignore}
	#cmd_configure ignorelist -group "other" -flags {m} -block 3 -alias {%pref_ignorelist %pref_ignores}
	
	
	################################################################################################
	# Settings for INVITE module                                                                   #
	################################################################################################
	
	################################################################################################
	# Should we show expiration date in the invite reason? (0 - no, 1 - yes)
	#configure -invitedate				1
	
	################################################################################################
	# Default mask template for channel invites. All available templates listed below.
	# Specified here value can be overrided via "ccs-invitemask" channel option
	# Hostmask templates:
	# 1: *!user@host
	# 2: *!*user@host
	# 3: *!*@host
	# 4: *!*user@*.host
	# 5: *!*@*.host
	# 6: nick!user@host
	# 7: nick!*user@host
	# 8: nick!*@host
	# 9: nick!*user@*.host
	# 10: nick!*@*.host
	#configure -invitemask				4
	
	#cmd_configure invite -group "invite" -flags {o|o} -block 1 -alias {%pref_invite}
	#cmd_configure uninvite -group "invite" -flags {o|o} -block 1 -alias {%pref_uninvite}
	#cmd_configure ginvite -group "invite" -flags {o} -block 1 -alias {%pref_ginvite}
	#cmd_configure guninvite -group "invite" -flags {o} -block 1 -alias {%pref_guninvite}
	#cmd_configure invitelist -group "invite" -flags {o|o} -block 3 -alias {%pref_invitelist %pref_invites}
	#cmd_configure resetinvites -group "invite" -flags {o|o} -block 5 -alias {%pref_resetinvites}
	
	
	################################################################################################
	# Settings for LANG module                                                                     #
	################################################################################################
	
	#cmd_configure langlist -group "lang" -flags {%v} -block 3 -alias {%pref_langlist}
	#cmd_configure chansetlang -group "lang" -flags {m|m} -block 3 -alias {%pref_chansetlang}
	#cmd_configure chlang -group "lang" -flags {m} -block 3 -alias {%pref_chlang}
	
	
	################################################################################################
	# Settings for LINK module                                                                     #
	################################################################################################
	
	#cmd_configure link -group "botnet" -flags {nt} -block 5 -alias {%pref_link}
	#cmd_configure unlink -group "botnet" -flags {nt} -block 5 -alias {%pref_unlink %pref_dellink}
	
	
	################################################################################################
	# Settings for LOGS module                                                                     #
	################################################################################################
	
	################################################################################################
	# Path and filename for logfile. Bu default, logs everything in ccs.tcl root dir as ccs.log
	#configure -logsfile					"$options(dir_data)/ccs.log"
	
	################################################################################################
	# Debug level for logs messages
	#configure -logslevel				3
	
	
	################################################################################################
	# Settings for MODE module                                                                     #
	################################################################################################
	
	#cmd_configure op -group "mode" -flags {o|o} -block 1 -alias {%pref_op}
	#cmd_configure deop -group "mode" -flags {o|o} -block 1 -alias {%pref_deop}
	#cmd_configure hop -group "mode" -flags {l|l} -use 0 -block 1 -alias {%pref_hop}
	#cmd_configure dehop -group "mode" -flags {l|l} -use 0 -block 1 -alias {%pref_dehop}
	#cmd_configure voice -group "mode" -flags {v|v o|o} -block 1 -alias {%pref_voice}
	#cmd_configure devoice -group "mode" -flags {v|v o|o} -block 1 -alias {%pref_devoice}
	#cmd_configure allvoice -group "mode" -flags {m|m} -block 5 -alias {%pref_allvoice}
	#cmd_configure alldevoice -group "mode" -flags {m|m} -block 1 -alias {%pref_alldevoice}
	#cmd_configure mode -group "mode" -flags {o|o} -alias {%pref_mode}
	
	
	################################################################################################
	# Settings for REBIND module                                                                   #
	################################################################################################
	
	################################################################################################
	# Removes, restores and re-defines standart bot's binds
	#          -1 - removes standart bind;
	#           1 - restores standart bind;
	#        name - renames bind;
	#  n/a(empty) - don't touch bind.
	#set rebind(addhost)	"1"
	#set rebind(die)	"-1"
	#set rebind(go)		"-1"
	#set rebind(hello)	""
	#set rebind(help)	"-1"
	#set rebind(ident)	"1"
	#set rebind(info)	"-1"
	#set rebind(invite)	"-1"
	#set rebind(jump)	"-1"
	#set rebind(key)	"-1"
	#set rebind(memory)	""
	#set rebind(op)		"-1"
	#set rebind(halfop)	"-1"
	#set rebind(pass)	"1"
	#set rebind(rehash)	"-1"
	#set rebind(reset)	"-1"
	#set rebind(save)	"-1"
	#set rebind(status)	"-1"
	#set rebind(voice)	"-1"
	#set rebind(who)	"-1"
	#set rebind(whois)	"-1"
	
	
	################################################################################################
	# Settings for REGBAN module                                                                   #
	################################################################################################
	
	################################################################################################
	# File where we should store regban data.
	# $options(dir_data) has no explanation currently, blame Buster :P
	#configure -regbanfile				"$options(dir_data)/ccs.regban.dat"
	
	################################################################################################
	# Expiration timeout for processed WHO-requests/data. Too big value produces low load but also
	# produces high error rate sometimes. Too small value can miss replies from server.
	#configure -regbanwhohash			10000
	
	#cmd_configure regbanlist -group "regban" -flags {o} -block 3 -alias {%pref_regbanlist}
	#cmd_configure regban -group "regban" -flags {o} -block 3 -alias {%pref_regban %pref_addregban %pref_regbanadd}
	#cmd_configure regunban -group "regban" -flags {o} -block 3 -alias {%pref_regunban %pref_delregban %pref_unregban %pref_regbandel}
	#cmd_configure regbantest -group "regban" -flags {o} -block 5 -alias {%pref_regbantest %pref_testregban}
	#cmd_configure regbanaction -group "regban" -flags {o} -block 5 -alias {%pref_regbanaction %pref_actionregban}
	
	
	################################################################################################
	# Settings for SAY module                                                                      #
	################################################################################################
	
	#cmd_configure broadcast -group "other" -flags {o} -block 10 -alias {%pref_broadcast}
	#cmd_configure say -group "other" -flags {m} -block 3 -alias {%pref_say}
	#cmd_configure msg -group "other" -flags {m} -block 3 -alias {%pref_msg}
	#cmd_configure act -group "other" -flags {m} -block 3 -alias {%pref_act}
	
	
	################################################################################################
	# Settings for SYSTEM module                                                                   #
	################################################################################################
	
	#cmd_configure servers -group "system" -flags {m} -block 5 -alias {%pref_servers}
	#cmd_configure addserver -group "system" -flags {m} -block 1 -alias {%pref_addserver}
	#cmd_configure delserver -group "system" -flags {m} -block 1 -alias {%pref_delserver}
	#cmd_configure save -group "system" -flags {m} -block 3 -alias {%pref_save}
	#cmd_configure reload -group "system" -flags {m} -block 3 -alias {%pref_reload}
	#cmd_configure backup -group "system" -flags {m} -block 3 -alias {%pref_backup}
	#cmd_configure die -group "system" -flags {n} -use_chan 0 -alias {%pref_die}
	#cmd_configure rehash -group "system" -flags {m} -block 5 -alias {%pref_rehash}
	#cmd_configure restart -group "system" -flags {m} -use_chan 0 -alias {%pref_restart}
	#cmd_configure jump -group "system" -flags {m} -block 5 -alias {%pref_jump}
	
	
	################################################################################################
	# Settings for SYSTEM module                                                                   #
	################################################################################################
	
	#cmd_configure traf -group "info" -flags {%v} -block 3 -alias {%pref_traf}
	
	
	################################################################################################
	# Settings for USERS module                                                                    #
	################################################################################################
	
	################################################################################################
	# Default hostmask template for new users.
	# templates are the same as for ban/exempt
	#configure -addusermask				4
	
	################################################################################################
	# Should we allow local users delete local users under some conditions?
	# Here is how it works:
	# 1. User with local channel (mean: he has NO global flags at all) flags only issues userdel cmd.
	# 2. Script checks - does he has only local flags and does userdel cmd allowed for him ? If yes:
	# 3. Script checks - does target user has NO global flags? If yes:
	# 4. Does target user has lower access level? If so - bye-bye.
	# (1 - feature enabled, 0 - disabed)
	#configure -deluserchanrec			1
	
	################################################################################################
	# Who and what flags can set/remove (permission ladder)
	
	# n - creator/owner - user has absolute control. Only give this flag to people you trust completely.
	#set permission_flag(global,n)		{}
	#set permission_flag(local,n)		{n m}
	# m - master (master) - user has access to almost every feature of the bot.
	#set permission_flag(global,m)		{n}
	#set permission_flag(local,m)		{n|n m}
	# t - botnet-master (botnet-master) - user has access to all features dealing with the botnet.
	#set permission_flag(global,t)		{n m}
	# a - aop (auto-op) - user is opped automatically upon joining a channel.
	#set permission_flag(global,a)		{n m}
	#set permission_flag(local,a)		{n|n m|m}
	# o - op (op) - user has op access to all of the bot's channels.
	#set permission_flag(global,o)		{n m}
	#set permission_flag(local,o)		{n|n m|m}
	# y - autohop (auto-halfop) -  user is halfopped automatically upon joining a channel.
	#set permission_flag(global,y)		{n m o}
	#set permission_flag(local,y)		{n|n m|m o|o}
	# l - hop (halfop) - user has halfop access to all of the bot's channels.
	#set permission_flag(global,l)		{n m o}
	#set permission_flag(local,l)		{n|n m|m o|o}
	# g - autovoice (АВОИС) (auto-voice) - user is voiced automatically upon joining a channel.
	#set permission_flag(global,g)		{n m o l}
	#set permission_flag(local,g)		{n|n m|m o|o l|l}
	# v - voice (voice) (voice) - user gets +v automatically on +autovoice channels.
	#set permission_flag(global,v)		{n m o l}
	#set permission_flag(local,v)		{n|n m|m o|o l|l}
	# f - friend (friend) -  user is not punished for flooding, etc.
	#set permission_flag(global,f)		{n m o l}
	#set permission_flag(local,f)		{n|n m|m o|o l|l}
	# p - partyline (party) - user has access to the partyline (DCC).
	#set permission_flag(global,p)		{n}
	# q - quiet (quiet) - user does not get voice on +autovoice channels.
	#set permission_flag(global,q)		{n m o l}
	#set permission_flag(local,q)		{n|n m|m o|o l|l}
	# r - dehalfop (dehalfop) - user cannot gain halfops on any of the bot's channels
	#set permission_flag(global,r)		{n m o}
	#set permission_flag(local,r)		{n|n m|m o|o}
	# d - deop (deop) - user cannot gain ops on any of the bot's channels.
	#set permission_flag(global,d)		{n m}
	#set permission_flag(local,d)		{n|n m|m}
	# k - autockick (akick) (auto-kick) - user is kicked and banned automatically.
	#set permission_flag(global,k)		{n m}
	#set permission_flag(local,k)		{n|n m|m}
	# x - file transfer (xfer) - user has access to the file transfer area of the bot (if it exists) and can send and receive files to/from the bot." 
	#set permission_flag(global,x)		{n m}
	# j - (janitor) - user can perform maintenance in the file area of the bot (if it exists) -- like a "master" of the file area. Janitors have complete access to the filesystem.
	#set permission_flag(global,j)		{n m}
	# c - (common) - this marks a user who is connecting from a public site from which any number of people can use IRC. The user will now be recognized by NICKNAME.
	#set permission_flag(global,c)		{n m}
	# w (wasop-test) - user needs wasop test for +stopnethack procedure.
	#set permission_flag(global,w)		{n m}
	#set permission_flag(local,w)		{n|n m|m}
	# z (washalfop-test) - user needs washalfop test for +stopnethack procedure.
	#set permission_flag(global,z)		{n m}
	#set permission_flag(local,z)		{n|n m|m}
	# e (nethack-exempt) - user is exempted from stopnethack protection.
	#set permission_flag(global,e)		{n m}
	#set permission_flag(local,e)		{n|n m|m}
	# u - unshared (unshared) - user record will not by sent to other bots.
	#set permission_flag(global,u)		{n m t}
	# h - highlight (highlight) - use bold text in help/text files.
	#set permission_flag(global,h)		{n m}
	
	# Q  - user identified on bot. (custom CCS flag)"
	#set permission_flag(global,Q)		{n}
	# B - user identified on bot via botnet. (custom CCS flag)"
	#set permission_flag(global,B)		{n}
	# P - user has a permanent authorization. (custom CCS flag)"
	#set permission_flag(global,P)		{n}
	# L - user's handle has a protection from changes and only global bot owner can change his flags. (custom CCS flag)" 
	#set permission_flag(global,L)		{n}
	# H - user has a protection from some commands, like kick, ban, etc... (custom CCS flag)"
	#set permission_flag(global,H)		{n}
	#set permission_flag(local,H)		{n}
	
	#cmd_configure adduser -group "user" -flags {m} -block 3 -alias {%pref_adduser}
	#cmd_configure deluser -group "user" -flags {m} -block 3 -alias {%pref_deluser}
	#cmd_configure addhost -group "user" -flags {m} -block 1 -alias {%pref_addmask %pref_addhost %pref_+host}
	#cmd_configure delhost -group "user" -flags {m} -block 1 -alias {%pref_clearhosts %pref_delhost %pref_-host}
	#cmd_configure chattr -group "user" -flags {n|n m|m o|o l|l} -block 1 -alias {%pref_chattr}
	#cmd_configure userlist -group "user" -flags {o} -block 5 -alias {%pref_userlist}
	#cmd_configure resetpass -group "user" -flags {m} -block 3 -alias {%pref_resetpass}
	#cmd_configure chhandle -group "user" -flags {m} -block 3 -alias {%pref_chhandle}
	#cmd_configure setinfo -group "user" -flags {m|m} -block 3 -alias {%pref_setinfo}
	#cmd_configure delinfo -group "user" -flags {m|m} -block 1 -alias {%pref_delinfo}
	#cmd_configure match -group "user" -flags {lf|lf} -block 5 -alias {%pref_match}
	
	
	################################################################################################
	# Settings for WHOISIP script                                                                  #
	################################################################################################
	
	################################################################################################
	# Request timeout (period within we should wait for answer)
	#configure -whoisip_timeout			20000
	
	################################################################################################
	# Output info entries.
	#configure -whoisip_info {
	#	netname descr country person address city stateprov postalcode e-mail
	#	orgtechemail phone orgtechphone orgtechname orgname rtechname rtechemail
	#	rtechphone
	#}
	
	################################################################################################
	# DNS-lookups method.
	# 1 - use bot's default DNS-module (dns.so). No IPv6 support, NS/NS extries, canon names;
	# 2 - use ccs.lib.dns.tcl. Works properly only if your DNS-server understand requests via TCP
	#     (coz TCL can't use UDP) or your bot has custom package to process UDP-requests.
	#configure -mode_dns_reply			2
	
	#cmd_configure whoisip -group "info" -flags {-|-} -block 5 -use_botnet 0 -alias {%pref_whoisip}
