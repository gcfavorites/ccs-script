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
# Note that this settings template is loaded AFTER all CCS-binds.
##################################################################################################################
# !!! Do not forget to rename this template-file in to ccs.rc2.tcl (so, you need just remove "-template-EN"
# part from the filename) !!!
##################################################################################################################

################################################################################################
# Settings for DNS lib
################################################################################################
# How lib should interact with your DNS-server. These settings actual only if you use ccs.lib.dns.tcl
# instead of default dns.so. Note that default settings here can be incorrect in your case, thus,
#  change them. In most cases, under nix-based OSes IP-address for NS-server can be detected automatically.
# If your server doesn't accept TCP-requests then you need to install tcludp or ceptcl lib.
# The first one (tcludp) can be found here: http://sourceforge.net/project/showfiles.php?group_id=75201

#dns::configure -nameserver 172.17.7.1
#dns::configure -port 53
#dns::configure -timeout 10000
#dns::configure -protocol tcp 