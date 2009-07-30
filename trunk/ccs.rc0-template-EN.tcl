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
# Note that this settings template is loaded BEFORE ccs-modules, custom ccs-scripts, css-libs and languages.
# So, that's allow you to disable some of these features (like disable a lib or custom script for a while).
##################################################################################################################
# !!! Do not forget to rename this template-file in to ccs.rc0.tcl (so, you need just remove "-template-EN"
# part from the filename) !!!
##################################################################################################################

	#############################################################################################################
	# Should we load a "ban" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,ban) 0
	
	#############################################################################################################
	# Should we load a "base" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,base) 0
	
	#############################################################################################################
	# Should we load a "bots" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,bots) 0
	
	#############################################################################################################
	# Should we load a "chan" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,chan) 0
	
	#############################################################################################################
	# Should we load a "chanserv" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,chanserv) 0
	
	#############################################################################################################
	# Should we load a "chat" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,chat) 0
	
	#############################################################################################################
	# Should we load an "exempt" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,exempt) 0
	
	#############################################################################################################
	# Should we load an "ignore" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,ignore) 0
	
	#############################################################################################################
	# Should we load an "invite" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,invite) 0
	
	#############################################################################################################
	# Should we load a "lang" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,lang) 0
	
	#############################################################################################################
	# Should we load a "link" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,link) 0
	
	#############################################################################################################
	# Should we load a "logs" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,logs) 0
	
	#############################################################################################################
	# Should we load a "mode" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,mode) 0
	
	#############################################################################################################
	# Should we load a "regban" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,regban) 0
	
	#############################################################################################################
	# Should we load a "say" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,say) 0
	
	#############################################################################################################
	# Should we load a "system" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,system) 0
	
	#############################################################################################################
	# Should we load a "traf" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,traf) 0
	
	#############################################################################################################
	# Should we load an "users" module? (0 - enable, 1 - disable)
	#set ccs(mod,name,users) 0
	
	#############################################################################################################
	# Should we load a "whoisip" module? (0 - enable, 1 - disable)
	#set ccs(scr,name,whoisip) 0


	#############################################################################################################
	# Should we load language "en" for module "ban"? (0 - enable, 1 - disable)
	#set ccs(lang,name,ban,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "ban"? (0 - enable, 1 - disable)
	#set ccs(lang,name,ban,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "ban"? (0 - enable, 1 - disable)
	#set ccs(lang,name,ban,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "base"? (0 - enable, 1 - disable)
	#set ccs(lang,name,base,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "base"? (0 - enable, 1 - disable)
	#set ccs(lang,name,base,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "base"? (0 - enable, 1 - disable)
	#set ccs(lang,name,base,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "bots" (0 - enable, 1 - disable)
	#set ccs(lang,name,bots,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "bots" (0 - enable, 1 - disable)
	#set ccs(lang,name,bots,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "bots" (0 - enable, 1 - disable)
	#set ccs(lang,name,bots,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "ccs" (0 - enable, 1 - disable)
	#set ccs(lang,name,ccs,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "ccs" (0 - enable, 1 - disable)
	#set ccs(lang,name,ccs,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "ccs" (0 - enable, 1 - disable)
	#set ccs(lang,name,ccs,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "chan" (0 - enable, 1 - disable)
	#set ccs(lang,name,chan,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "chan" (0 - enable, 1 - disable)
	#set ccs(lang,name,chan,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "chan" (0 - enable, 1 - disable)
	#set ccs(lang,name,chan,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "chanserv" (0 - enable, 1 - disable)
	#set ccs(lang,name,chanserv,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "chanserv" (0 - enable, 1 - disable)
	#set ccs(lang,name,chanserv,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "chanserv" (0 - enable, 1 - disable)
	#set ccs(lang,name,chanserv,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "chat" (0 - enable, 1 - disable)
	#set ccs(lang,name,chat,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "chat" (0 - enable, 1 - disable)
	#set ccs(lang,name,chat,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "chat" (0 - enable, 1 - disable)
	#set ccs(lang,name,chat,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "exempt" (0 - enable, 1 - disable)
	#set ccs(lang,name,exempt,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "exempt" (0 - enable, 1 - disable)
	#set ccs(lang,name,exempt,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "exempt" (0 - enable, 1 - disable)
	#set ccs(lang,name,exempt,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "ignore" (0 - enable, 1 - disable)
	#set ccs(lang,name,ignore,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "ignore" (0 - enable, 1 - disable)
	#set ccs(lang,name,ignore,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "ignore" (0 - enable, 1 - disable)
	#set ccs(lang,name,ignore,ru) 0

	#############################################################################################################
	# Should we load language "ru" for module "invite" (0 - enable, 1 - disable)
	#set ccs(lang,name,invite,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "lang" (0 - enable, 1 - disable)
	#set ccs(lang,name,lang,en) 0

	#############################################################################################################
	# Should we load language "ru" for module "lang" (0 - enable, 1 - disable)
	#set ccs(lang,name,lang,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "link" (0 - enable, 1 - disable)
	#set ccs(lang,name,link,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "link" (0 - enable, 1 - disable)
	#set ccs(lang,name,link,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "link" (0 - enable, 1 - disable)
	#set ccs(lang,name,link,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "mode" (0 - enable, 1 - disable)
	#set ccs(lang,name,mode,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "mode" (0 - enable, 1 - disable)
	#set ccs(lang,name,mode,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "mode" (0 - enable, 1 - disable)
	#set ccs(lang,name,mode,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "regban" (0 - enable, 1 - disable)
	#set ccs(lang,name,regban,en) 0

	#############################################################################################################
	# Should we load language "ru" for module "regban" (0 - enable, 1 - disable)
	#set ccs(lang,name,regban,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "say" (0 - enable, 1 - disable)
	#set ccs(lang,name,say,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "say" (0 - enable, 1 - disable)
	#set ccs(lang,name,say,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "say" (0 - enable, 1 - disable)
	#set ccs(lang,name,say,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "system" (0 - enable, 1 - disable)
	#set ccs(lang,name,system,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "system" (0 - enable, 1 - disable)
	#set ccs(lang,name,system,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "system" (0 - enable, 1 - disable)
	#set ccs(lang,name,system,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "traf" (0 - enable, 1 - disable)
	#set ccs(lang,name,traf,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "traf" (0 - enable, 1 - disable)
	#set ccs(lang,name,traf,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "traf" (0 - enable, 1 - disable)
	#set ccs(lang,name,traf,ru) 0

	#############################################################################################################
	# Should we load language "en" for module "users" (0 - enable, 1 - disable)
	#set ccs(lang,name,users,en) 0

	#############################################################################################################
	# Should we load language "pod" for module "users" (0 - enable, 1 - disable)
	#set ccs(lang,name,users,pod) 0

	#############################################################################################################
	# Should we load language "ru" for module "users" (0 - enable, 1 - disable)
	#set ccs(lang,name,users,ru) 0
