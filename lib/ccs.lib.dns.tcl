if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

pkg_add lib {dns} "Buster <buster@buster-net.ru> (c)" "1.0.0" "14-Mar-2009" \
	"���������� � ��������� ��������� DNS ��������"

if {[package versions [namespace current]::dns] == ""} {
	package ifneeded [namespace current]::dns 1.0.0 "namespace eval [namespace current] {source [info script]}"
	return
}

package require [namespace current]::ip 2.0.0

namespace eval dns {
	
	variable author			"Buster <buster@buster-net.ru> (c)"
	variable version		"1.0.0"
	variable date			"14-Mar-2009"
	variable description	"���������� � ��������� ��������� DNS ��������"
	# ����� ������� ����� �� tcllib-1.11.1 dns.tcl by Pat Thoyts <patthoyts@users.sourceforge.net>
	
	variable options
	
	set options(port)		53
	set options(timeout)	10000
	set options(protocol)	tcp
	set options(nameserver)	localhost
	
	# We can use either ceptcl or tcludp for UDP support.
	if {![catch {package require udp 1.0.4} msg]} { ;# tcludp 1.0.4+
		# If TclUDP 1.0.4 or better is available, use it.
		set options(protocol) udp
	} else {
		if {![catch {package require ceptcl} msg]} {
			set options(protocol) udp
		}
	}
	
	variable types
	array set types { 
		A 1  NS 2  MD 3  MF 4  CNAME 5  SOA 6  MB 7  MG 8  MR 9 
		NULL 10  WKS 11  PTR 12  HINFO 13  MINFO 14  MX 15  TXT 16
		SPF 16 AAAA 28 SRV 33 IXFR 251 AXFR 252  MAILB 253  MAILA 254
		ANY 255 * 255
	} 
	
	variable classes
	array set classes { IN 1  CS 2  CH  3  HS 4  * 255}
	
	variable uid
	if {![info exists uid]} {
		set uid 0
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Configure the DNS package. In particular the local nameserver will need
	#  to be set. With no options, returns a list of all current settings.
	#
	proc configure {args} {
		variable options
		
		if {[llength $args] < 1} {
			set r {}
			foreach opt [lsort [array names options]] {
				lappend r -$opt $options($opt)
			}
			return $r
		}
		
		set cget 0
		if {[llength $args] == 1} {
			set cget 1
		}
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-n* -
				-ser* {
					if {$cget} {
						return $options(nameserver) 
					} else {
						set options(nameserver) [Pop args 1] 
					}
				}
				-po*  { 
					if {$cget} {
						return $options(port)
					} else {
						set options(port) [Pop args 1] 
					}
				}
				-ti*  { 
					if {$cget} {
						return $options(timeout)
					} else {
						set options(timeout) [Pop args 1]
					}
				}
				-pr*  {
					if {$cget} {
						return $options(protocol)
					} else {
						set proto [string tolower [Pop args 1]]
						if {[string compare udp $proto] == 0 \
								&& [string compare tcp $proto] == 0} {
							return -code error "invalid protocol \"$proto\":\
								protocol must be either \"udp\" or \"tcp\""
						}
						set options(protocol) $proto 
					}
				}
				--    { Pop args ; break }
				default {
					set opts [join [lsort [array names options]] ", -"]
					return -code error "bad option [lindex $args 0]:\
							must be one of -$opts"
				}
			}
			Pop args
		}
		
		return
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Create a DNS query and send to the specified name server. Returns a token
	#  to be used to obtain any further information about this query.
	#
	proc resolve {query args} {
		variable uid
		variable options
		
		# get a guaranteed unique and non-present token id.
		set id [incr uid]
		while {[info exists [set token [namespace current]::$id]]} {
			set id [incr uid]
		}
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		
		# Setup token/state defaults.
		set state(id)          $id
		set state(query)       $query
		set state(qdata)       ""
		set state(opcode)      0;                   # 0 = query, 1 = inverse query.
		set state(-type)       A;                   # DNS record type (A address)
		set state(-class)      IN;                  # IN (internet address space)
		set state(-recurse)    1;                   # Recursion Desired
		set state(-command)    {};                  # asynchronous handler
		set state(-timeout)    $options(timeout);   # connection timeout default.
		set state(-nameserver) $options(nameserver);# default nameserver
		set state(-port)       $options(port);      # default namerservers port
		set state(-protocol)   $options(protocol);  # which protocol udp/tcp
		
		while {[string match -* [lindex $args 0]]} {
			switch -glob -- [lindex $args 0] {
				-n* - ns -
				-ser* { set state(-nameserver) [Pop args 1] }
				-po*  { set state(-port) [Pop args 1] }
				-ti*  { set state(-timeout) [Pop args 1] }
				-co*  { set state(-command) [Pop args 1] }
				-cl*  { set state(-class) [Pop args 1] }
				-ty*  { set state(-type) [Pop args 1] }
				-pr*  { set state(-protocol) [Pop args 1] }
				-re*  { set state(-recurse) [Pop args 1] }
				-inv* { set state(opcode) 1 }
				-status {set state(opcode) 2}
				-data { set state(qdata) [Pop args 1] }
				default {
					set opts [join [lsort [array names state -*]] ", "]
					return -code error "bad option [lindex $args 0]: \
							must be $opts"
				}
			}
			Pop args
		}
		
		if {$state(-nameserver) == {}} {
			return -code error "no nameserver specified"
		}
		
		if {$state(-protocol) == "udp"} {
			if {[llength [package provide ceptcl]] == 0 \
					&& [llength [package provide udp]] == 0} {
				return -code error "udp support is not available,\
					get ceptcl or tcludp"
			}
		}
		
		# Check for reverse lookups
		set v [[namespace parent]::ip::version $state(query)]
		if {$v > 0} {
			set state(query) [[namespace parent]::ip::ip_to_arpa$v $state(query)]
			set state(-type) PTR
		}
		
		BuildMessage $token
		
		if {$state(-protocol) == "tcp"} {
			TcpTransmit $token
			if {$state(-command) == {}} {
				wait $token
			}
		} else {
			UdpTransmit $token
		}
		
		return $token
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Return a list of domain names returned as results for the last query.
	#
	proc name {token} {
		set r {}
		Flags $token flags
		array set reply [Decode $token]
		
		switch -exact -- $flags(opcode) {
			0 {
				# QUERY
				foreach answer $reply(AN) {
					array set AN $answer
					if {![info exists AN(type)]} {set AN(type) {}}
					switch -exact -- $AN(type) {
						MX - NS - PTR {
							if {[info exists AN(rdata)]} {lappend r [list $AN(type) $AN(rdata)]}
						}
						default {
							if {[info exists AN(name)]} {
								lappend r [list $AN(type) $AN(name)]
							}
						}
					}
				}
			}
			1 {
				# IQUERY
				foreach answer $reply(QD) {
					array set QD $answer
					lappend r $QD(name)
				}
			}
			default {
				return -code error "not supported for this query type"
			}
		}
		return $r
	}
	
	# Description:
	#  Return a list of the IP addresses returned for this query.
	#
	proc address {token} {
		set r {}
		array set reply [Decode $token]
		foreach answer $reply(AN) {
			array set AN $answer
			
			if {[info exists AN(type)]} {
				switch -exact -- $AN(type) {
					"A" {
						lappend r [list $AN(type) $AN(rdata)]
					}
					"AAAA" {
						lappend r [list $AN(type) $AN(rdata)]
					}
				}
			}
		}
		return $r
	}
	
	# Description:
	#  Return a list of all CNAME results returned for this query.
	#
	proc cname {token} {
		set r {}
		array set reply [Decode $token]
		foreach answer $reply(AN) {
			array set AN $answer

			if {[info exists AN(type)]} {
				if {$AN(type) == "CNAME"} {
					lappend r [list $AN(type) $AN(rdata)]
				}
			}
		}
		return $r
	}
	
	# Description:
	#   Return the decoded answer records. This can be used for more complex
	#   queries where the answer isn't supported byb cname/address/name.
	proc result {token args} {
		array set reply [eval [linsert $args 0 Decode $token]]
		return $reply(AN)
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Get the status of the request.
	#
	proc status {token} {
		upvar #0 $token state
		return $state(status)
	}
	
	# Description:
	#  Get the error message. Empty if no error.
	#
	proc error {token} {
		upvar #0 $token state
		if {[info exists state(error)]} {
		return $state(error)
		}
		return ""
	}
	
	# Description
	#  Get the error code. This is 0 for a successful transaction.
	#
	proc errorcode {token} {
		upvar #0 $token state
		set flags [Flags $token]
		set ndx [lsearch -exact $flags errorcode]
		incr ndx
		return [lindex $flags $ndx]
	}
	
	# Description:
	#  Reset a connection with optional reason.
	#
	proc reset {token {why reset} {errormsg {}}} {
		upvar #0 $token state
		set state(status) $why
		if {[string length $errormsg] > 0 && ![info exists state(error)]} {
			set state(error) $errormsg
		}
		catch {fileevent $state(sock) readable {}}
		Finish $token
	}
	
	# Description:
	#  Wait for a request to complete and return the status.
	#
	proc wait {token} {
		upvar #0 $token state
		
		if {$state(status) == "connect"} {
			vwait [subst $token](status)
		}
		
		return $state(status)
	}
	
	# Description:
	#  Remove any state associated with this token.
	#
	proc cleanup {token} {
		upvar #0 $token state
		if {[info exists state]} {
			catch {close $state(sock)}
			catch {after cancel $state(after)}
			unset state
		}
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Dump the raw data of the request and reply packets.
	#
	proc dump {args} {
		if {[llength $args] == 1} {
			set type -reply
			set token [lindex $args 0]
		} elseif { [llength $args] == 2 } {
			set type [lindex $args 0]
			set token [lindex $args 1]
		} else {
			return -code error "wrong # args:\
				should be \"dump ?option? methodName\""
		}
		
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		
		set result {}
		switch -glob -- $type {
			-qu*    -
			-req*   {
				set result [DumpMessage $state(request)]
			}
			-rep*   {
				set result [DumpMessage $state(reply)]
			}
			default {
				error "unrecognised option: must be one of \
						\"-query\", \"-request\" or \"-reply\""
			}
		}
		
		return $result
	}
	
	# Description:
	#  Perform a hex dump of binary data.
	#
	proc DumpMessage {data} {
		set result {}
		binary scan $data c* r
		foreach c $r {
			append result [format "%02x " [expr {$c & 0xff}]]
		}
		return $result
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Contruct a DNS query packet.
	#
	proc BuildMessage {token} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		variable types
		variable classes
		variable options
		
		if {! [info exists types($state(-type))] } {
			return -code error "invalid DNS query type"
		}
		
		if {! [info exists classes($state(-class))] } {
			return -code error "invalid DNS query class"
		}
		
		set qdcount 0
		set qsection {}
		set nscount 0
		set nsdata {}
		
		# Pack the query: QNAME QTYPE QCLASS
		set qsection [PackName $state(query)]
		append qsection [binary format SS \
							 $types($state(-type))\
							 $classes($state(-class))]
		incr qdcount
		
		if {[string length $state(qdata)] > 0} {
			set nsdata [eval [linsert $state(qdata) 0 PackRecord]]
			incr nscount
		}
		
		switch -exact -- $state(opcode) {
			0 {
				# QUERY
				set state(request) [binary format SSSSSS $state(id) \
					[expr {($state(opcode) << 11) | ($state(-recurse) << 8)}] \
										$qdcount 0 $nscount 0]
				append state(request) $qsection $nsdata
			}
			1 {
				# IQUERY
				set state(request) [binary format SSSSSS $state(id) \
					[expr {($state(opcode) << 11) | ($state(-recurse) << 8)}] \
					0 $qdcount 0 0 0]
				append state(request) \
					[binary format cSSI 0 \
						 $types($state(-type)) $classes($state(-class)) 0]
				switch -exact -- $state(-type) {
					A {
						append state(request) \
							[binary format Sc4 4 [split $state(query) .]]
					}
					PTR {
						append state(request) \
							[binary format Sc4 4 [split $state(query) .]]
					}
					default {
						return -code error "inverse query not supported for this type"
					}
				}
			}
			default {
				return -code error "operation not supported"
			}
		}
		
		return
	}
	
	# Pack a human readable dns name into a DNS resource record format.
	proc PackName {name} {
		set data ""
		foreach part [split [string trim $name .] .] {
			set len [string length $part]
			append data [binary format ca$len $len $part]
		}
		append data \x00
		return $data
	}
	
	# Pack a character string - byte length prefixed
	proc PackString {text} {
		set len [string length $text]
		set data [binary format ca$len $len $text]
		return $data
	}
	
	# Pack up a single DNS resource record. See RFC1035: 3.2 for the format
	# of each type.
	# eg: PackRecord name wiki.tcl.tk type MX class IN rdata {10 mail.example.com}
	#
	proc PackRecord {args} {
		variable types
		variable classes
		array set rr {name "" type A class IN ttl 0 rdlength 0 rdata ""}
		array set rr $args
		set data [PackName $rr(name)]
		
		switch -exact -- $rr(type) {
			CNAME - MB - MD - MF - MG - MR - NS - PTR {
				set rr(rdata) [PackName $rr(rdata)] 
			}
			HINFO { 
				array set r {CPU {} OS {}}
				array set r $rr(rdata)
				set rr(rdata) [PackString $r(CPU)]
				append rr(rdata) [PackString $r(OS)]
			}
			MINFO {
				array set r {RMAILBX {} EMAILBX {}}
				array set r $rr(rdata)
				set rr(rdata) [PackString $r(RMAILBX)]
				append rr(rdata) [PackString $r(EMAILBX)]
			}
			MX {
				foreach {pref exch} $rr(rdata) break
				set rr(rdata) [binary format S $pref]
				append rr(rdata) [PackName $exch]
			}
			TXT {
				set str $rr(rdata)
				set len [string length [set str $rr(rdata)]]
				set rr(rdata) ""
				for {set n 0} {$n < $len} {incr n} {
					set s [string range $str $n [incr n 253]]
					append rr(rdata) [PackString $s]
				}
			}
			NULL {}
			SOA {
				array set r {MNAME {} RNAME {}
					SERIAL 0 REFRESH 0 RETRY 0 EXPIRE 0 MINIMUM 0}
				array set r $rr(rdata)
				set rr(rdata) [PackName $r(MNAME)]
				append rr(rdata) [PackName $r(RNAME)]
				append rr(rdata) [binary format IIIII $r(SERIAL) \
									  $r(REFRESH) $r(RETRY) $r(EXPIRE) $r(MINIMUM)]
			}
		}
		
		# append the root label and the type flag and query class.
		append data [binary format SSIS $types($rr(type)) \
						 $classes($rr(class)) $rr(ttl) [string length $rr(rdata)]]
		append data $rr(rdata)
		return $data
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Transmit a DNS request over a tcp connection.
	#
	proc TcpTransmit {token} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		
		# setup the timeout
		if {$state(-timeout) > 0} {
			set state(after) [after $state(-timeout) \
								  [list [namespace origin reset] \
									   $token timeout\
									   "operation timed out"]]
		}
		
		# Sometimes DNS servers drop TCP requests. So it's better to
		# use asynchronous connect
		set s [socket -async $state(-nameserver) $state(-port)]
		fileevent $s writable [list [namespace origin TcpConnected] $token $s]
		set state(sock) $s
		set state(status) connect

		return $token
	}
	
	proc TcpConnected {token s} {
		variable $token
		upvar 0 $token state
		
		fileevent $s writable {}
		if {[catch {fconfigure $s -peername}]} {
		# TCP connection failed
			Finish $token "can't connect to server"
			return
		}
		
		fconfigure $s -blocking 0 -translation binary -buffering none
		
		# For TCP the message must be prefixed with a 16bit length field.
		set req [binary format S [string length $state(request)]]
		append req $state(request)
		puts -nonewline $s $req
		
		fileevent $s readable [list [namespace current]::TcpEvent $token]
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Transmit a DNS request using UDP datagrams
	#
	# Note:
	#  This requires a UDP implementation that can transmit binary data.
	#  As yet I have been unable to test this myself and the tcludp package
	#  cannot do this.
	#
	proc UdpTransmit {token} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		
		# setup the timeout
		if {$state(-timeout) > 0} {
			set state(after) [after $state(-timeout) \
								  [list [namespace origin reset] \
									   $token timeout\
									  "operation timed out"]]
		}
		
		if {[llength [package provide ceptcl]] > 0} {
			# using ceptcl
			set state(sock) [cep -type datagram $state(-nameserver) $state(-port)]
			fconfigure $state(sock) -blocking 0
		} else {
			# using tcludp
			set state(sock) [udp_open]
			udp_conf $state(sock) $state(-nameserver) $state(-port)
		}
		fconfigure $state(sock) -translation binary -buffering none
		set state(status) connect
		puts -nonewline $state(sock) $state(request)
		
		fileevent $state(sock) readable [list [namespace current]::UdpEvent $token]
		
		return $token
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Tidy up after a tcp transaction.
	#
	proc Finish {token {errormsg ""}} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		global errorInfo errorCode
		
		if {[string length $errormsg] != 0} {
		set state(error) $errormsg
		set state(status) error
		}
		catch {close $state(sock)}
		catch {after cancel $state(after)}
		if {[info exists state(-command)] && $state(-command) != {}} {
		if {[catch {eval $state(-command) {$token}} err]} {
			if {[string length $errormsg] == 0} {
			set state(error) [list $err $errorInfo $errorCode]
			set state(status) error
			}
		}
			if {[info exists state(-command)]} {
				unset state(-command)
			}
		}
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Handle end-of-file on a tcp connection.
	#
	proc Eof {token} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		set state(status) eof
		Finish $token
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Process a DNS reply packet (protocol independent)
	#
	proc Receive {token} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		
		binary scan $state(reply) SS id flags
		set status [expr {$flags & 0x000F}]
		
		switch -- $status {
			0 {
				set state(status) ok
				Finish $token 
			}
			1 { Finish $token "Format error - unable to interpret the query." }
			2 { Finish $token "Server failure - internal server error." }
			3 { Finish $token "Name Error - domain does not exist" }
			4 { Finish $token "Not implemented - the query type is not available." }
			5 { Finish $token "Refused - your request has been refused by the server." }
			default {
				Finish $token "unrecognised error code: $err"
			}
		}
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  file event handler for tcp socket. Wait for the reply data.
	#
	proc TcpEvent {token} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		set s $state(sock)
		
		if {[eof $s]} {
			Eof $token
			return
		}
		
		set status [catch {read $state(sock)} result]
		if {$status != 0} {
			Finish $token "error reading data: $result"
		} elseif { [string length $result] >= 0 } {
			if {[catch {
				# Handle incomplete reads - check the size and keep reading.
				if {![info exists state(size)]} {
					binary scan $result S state(size)
					set result [string range $result 2 end]
				}
				append state(reply) $result
				# check the length and flags and chop off the tcp length prefix.
				if {[string length $state(reply)] >= $state(size)} {
					binary scan $result S id
					set id [expr {$id & 0xFFFF}]
					# bug #1158037 - doing this causes problems > 65535 requests!
					#Receive [namespace current]::$id
					Receive $token
				}
			} err]} {
				Finish $token "Event error: $err"
			}
		} elseif { [eof $state(sock)] } {
			Eof $token
		} elseif { [fblocked $state(sock)] } {
		} else {
			Finish $token "Event error: this can't happen!"
		}
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  file event handler for udp sockets.
	proc UdpEvent {token} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		set s $state(sock)
		
		set payload [read $state(sock)]
		append state(reply) $payload
		
		binary scan $payload S id
		set id [expr {$id & 0xFFFF}]
		# bug #1158037 - doing this causes problems > 65535 requests!
		Receive $token
	}
	
	# -------------------------------------------------------------------------
	proc Flags {token {varname {}}} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		
		if {$varname != {}} {
			upvar $varname flags
		}
		
		array set flags {query 0 opcode 0 authoritative 0 errorcode 0
			truncated 0 recursion_desired 0 recursion_allowed 0}
		
		binary scan $state(reply) SSSSSS mid hdr nQD nAN nNS nAR
		
		set flags(response)           [expr {($hdr & 0x8000) >> 15}]
		set flags(opcode)             [expr {($hdr & 0x7800) >> 11}]
		set flags(authoritative)      [expr {($hdr & 0x0400) >> 10}]
		set flags(truncated)          [expr {($hdr & 0x0200) >> 9}]
		set flags(recursion_desired)  [expr {($hdr & 0x0100) >> 8}]
		set flags(recursion_allowed)  [expr {($hdr & 0x0080) >> 7}]
		set flags(errorcode)          [expr {($hdr & 0x000F)}]
		
		return [array get flags]
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Decode a DNS packet (either query or response).
	#
	proc Decode {token args} {
		# FRINK: nocheck
		variable $token
		upvar 0 $token state
		
		array set opts {-rdata 0 -query 0}
		while {[string match -* [set option [lindex $args 0]]]} {
			switch -exact -- $option {
				-rdata { set opts(-rdata) 1 }
				-query { set opts(-query) 1 }
				default {
					return -code error "bad option \"$option\":\
						must be -rdata"
				}
			}
			Pop args
		}
		
		if {$opts(-query)} {
			binary scan $state(request) SSSSSSc* mid hdr nQD nAN nNS nAR data
		} else {
			binary scan $state(reply) SSSSSSc* mid hdr nQD nAN nNS nAR data
		}
		
		set fResponse      [expr {($hdr & 0x8000) >> 15}]
		set fOpcode        [expr {($hdr & 0x7800) >> 11}]
		set fAuthoritative [expr {($hdr & 0x0400) >> 10}]
		set fTrunc         [expr {($hdr & 0x0200) >> 9}]
		set fRecurse       [expr {($hdr & 0x0100) >> 8}]
		set fCanRecurse    [expr {($hdr & 0x0080) >> 7}]
		set fRCode         [expr {($hdr & 0x000F)}]
		set flags ""
		
		if {$fResponse} {set flags "QR"} else {set flags "Q"}
		set opcodes [list QUERY IQUERY STATUS]
		lappend flags [lindex $opcodes $fOpcode]
		if {$fAuthoritative} {lappend flags "AA"}
		if {$fTrunc} {lappend flags "TC"}
		if {$fRecurse} {lappend flags "RD"}
		if {$fCanRecurse} {lappend flags "RA"}
		
		set info "ID: $mid\
				  Fl: [format 0x%02X [expr {$hdr & 0xFFFF}]] ($flags)\
				  NQ: $nQD\
				  NA: $nAN\
				  NS: $nNS\
				  AR: $nAR"
		set ndx 12
		set r {}
		set QD [ReadQuestion $nQD $state(reply) ndx]
		lappend r QD $QD
		set AN [ReadAnswer $nAN $state(reply) ndx $opts(-rdata)]
		lappend r AN $AN
		set NS [ReadAnswer $nNS $state(reply) ndx $opts(-rdata)]
		lappend r NS $NS
		set AR [ReadAnswer $nAR $state(reply) ndx $opts(-rdata)]
		lappend r AR $AR
		return $r
	}
	
	# -------------------------------------------------------------------------
	proc Expand {data} {
		set r {}
		binary scan $data c* d
		foreach c $d {
			lappend r [expr {$c & 0xFF}]
		}
		return $r
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#  Pop the nth element off a list. Used in options processing.
	#
	proc Pop {varname {nth 0}} {
		upvar $varname args
		set r [lindex $args $nth]
		set args [lreplace $args $nth $nth]
		return $r
	}
	
	# -------------------------------------------------------------------------
	# Description:
	#   Reverse a list. Code from http://wiki.tcl.tk/tcl/43
	#
	if {[info command lreverse] == ""} {
		proc lreverse l {
			set r {}
			set i [llength $l]
			while {[incr i -1]} {lappend r [lindex $l $i]}
			lappend r [lindex $l 0]
		}
	}
	# -------------------------------------------------------------------------
	
	proc KeyOf {arrayname value {default {}}} {
		upvar $arrayname array
		set lst [array get array]
		set ndx [lsearch -exact $lst $value]
		if {$ndx != -1} {
			incr ndx -1
			set r [lindex $lst $ndx]
		} else {
			set r $default
		}
		return $r
	}
	
	# -------------------------------------------------------------------------
	# Read the question section from a DNS message. This always starts at index
	# 12 of a message but may be of variable length.
	#
	proc ReadQuestion {nitems data indexvar} {
		variable types
		variable classes
		upvar $indexvar index
		set result {}
		
		for {set cn 0} {$cn < $nitems} {incr cn} {
			set r {}
			lappend r name [ReadName data $index offset]
			incr index $offset
			
			# Read off QTYPE and QCLASS for this query.
			set ndx $index
			incr index 3
			binary scan [string range $data $ndx $index] SS qtype qclass
			set qtype [expr {$qtype & 0xFFFF}]
			set qclass [expr {$qclass & 0xFFFF}]
			incr index
			lappend r type [KeyOf types $qtype $qtype] \
					  class [KeyOf classes $qclass $qclass]
			lappend result $r
		}
		return $result
	}
	
	# -------------------------------------------------------------------------
	# Read an answer section from a DNS message. 
	#
	proc ReadAnswer {nitems data indexvar {raw 0}} {
		variable types
		variable classes
		upvar $indexvar index
		set result {}
		
		for {set cn 0} {$cn < $nitems} {incr cn} {
			set r {}
			lappend r name [ReadName data $index offset]
			incr index $offset
			
			# Read off TYPE, CLASS, TTL and RDLENGTH
			binary scan [string range $data $index end] SSIS type class ttl rdlength
			
			set type [expr {$type & 0xFFFF}]
			set type [KeyOf types $type $type]
			
			set class [expr {$class & 0xFFFF}]
			set class [KeyOf classes $class $class]
			
			set ttl [expr {$ttl & 0xFFFFFFFF}]
			set rdlength [expr {$rdlength & 0xFFFF}]
			incr index 10
			set rdata [string range $data $index [expr {$index + $rdlength - 1}]]
			
			if {! $raw} {
				switch -- $type {
					A {
						set rdata [join [Expand $rdata] .]
					}
					AAAA {
						set rdata [[namespace parent]::ip::contract [[namespace parent]::ip::ToString $rdata]]
					}
					NS - CNAME - PTR {
						set rdata [ReadName data $index off] 
					}
					MX {
						binary scan $rdata S preference
						set exchange [ReadName data [expr {$index + 2}] off]
						set rdata [list $preference $exchange]
					}
					SRV {
						set x $index
						set rdata [list priority [ReadUShort data $x off]]
						incr x $off
						lappend rdata weight [ReadUShort data $x off]
						incr x $off
						lappend rdata port [ReadUShort data $x off]
						incr x $off
						lappend rdata target [ReadName data $x off]
						incr x $off
					}
					TXT {
						set rdata [ReadString data $index $rdlength]
					}
					SOA {
						set x $index
						set rdata [list MNAME [ReadName data $x off]]
						incr x $off 
						lappend rdata RNAME [ReadName data $x off]
						incr x $off
						lappend rdata SERIAL [ReadULong data $x off]
						incr x $off
						lappend rdata REFRESH [ReadLong data $x off]
						incr x $off
						lappend rdata RETRY [ReadLong data $x off]
						incr x $off
						lappend rdata EXPIRE [ReadLong data $x off]
						incr x $off
						lappend rdata MINIMUM [ReadULong data $x off]
						incr x $off
					}
				}
			}
			
			incr index $rdlength
			lappend r type $type class $class ttl $ttl rdlength $rdlength rdata $rdata
			lappend result $r
		}
		return $result
	}
	
	# Read a 32bit integer from a DNS packet. These are compatible with
	# the ReadName proc. Additionally - ReadULong takes measures to ensure 
	# the unsignedness of the value obtained.
	#
	proc ReadLong {datavar index usedvar} {
		upvar $datavar data
		upvar $usedvar used
		set r {}
		set used 0
		if {[binary scan $data @${index}I r]} {
			set used 4
		}
		return $r
	}
	
	proc ReadULong {datavar index usedvar} {
		upvar $datavar data
		upvar $usedvar used
		set r {}
		set used 0
		if {[binary scan $data @${index}cccc b1 b2 b3 b4]} {
			set used 4
			# This gets us an unsigned value.
			set r [expr {($b4 & 0xFF) + (($b3 & 0xFF) << 8) 
						 + (($b2 & 0xFF) << 16) + ($b1 << 24)}] 
		}
		return $r
	}
	
	proc ReadUShort {datavar index usedvar} {
		upvar $datavar data
		upvar $usedvar used
		set r {}
		set used 0
		if {[binary scan [string range $data $index end] cc b1 b2]} {
			set used 2
			# This gets us an unsigned value.
			set r [expr {(($b2 & 0xff) + (($b1 & 0xff) << 8)) & 0xffff}] 
		}
		return $r
	}
	
	# Read off the NAME or QNAME element. This reads off each label in turn, 
	# dereferencing pointer labels until we have finished. The length of data
	# used is passed back using the usedvar variable.
	#
	proc ReadName {datavar index usedvar} {
		upvar $datavar data
		upvar $usedvar used
		set startindex $index
		
		set r {}
		set len 1
		set max [string length $data]
		
		while {$len != 0 && $index < $max} {
			# Read the label length (and preread the pointer offset)
			binary scan [string range $data $index end] cc len lenb
			set len [expr {$len & 0xFF}]
			incr index
			
			if {$len != 0} {
				if {[expr {$len & 0xc0}]} {
					binary scan [binary format cc [expr {$len & 0x3f}] [expr {$lenb & 0xff}]] S offset
					incr index
					lappend r [ReadName data $offset junk]
					set len 0
				} else {
					lappend r [string range $data $index [expr {$index + $len - 1}]]
					incr index $len
				}
			}
		}
		set used [expr {$index - $startindex}]
		return [join $r .]
	}
	
	proc ReadString {datavar index length} {
		upvar $datavar data
		set startindex $index
		
		set r {}
		set max [expr {$index + $length}]
		
		while {$index < $max} {
			binary scan [string range $data $index end] c len
			set len [expr {$len & 0xFF}]
			incr index
			
			if {$len != 0} {
				append r [string range $data $index [expr {$index + $len - 1}]]
				incr index $len
			}
		}
		return $r
	}
	
	# -------------------------------------------------------------------------
	
	# Support for finding the local nameservers
	#
	# For unix we can just parse the /etc/resolv.conf if it exists.
	# Of course, some unices use /etc/resolver and other things (NIS for instance)
	# On Windows, we can examine the Internet Explorer settings from the registry.
	#
	switch -exact $::tcl_platform(platform) {
		windows {
			proc nameservers {} {
				package require registry
				set base {HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services}
				set param "$base\\Tcpip\\Parameters"
				set interfaces "$param\\Interfaces"
				set nameservers {}
				if {[string equal $::tcl_platform(os) "Windows NT"]} {
					AppendRegistryValue $param NameServer nameservers
					AppendRegistryValue $param DhcpNameServer nameservers
					foreach i [registry keys $interfaces] {
						AppendRegistryValue "$interfaces\\$i" NameServer nameservers
						AppendRegistryValue "$interfaces\\$i" DhcpNameServer nameservers
					}
				} else {
					set param "$base\\VxD\\MSTCP"
					AppendRegistryValue $param NameServer nameservers
				}
				return $nameservers
			}
			proc AppendRegistryValue {key val listName} {
				upvar $listName lst
				if {![catch {registry get $key $val} v]} {
					foreach ns [split $v ", "] {
						if {[lsearch -exact $lst $ns] == -1} {
							lappend lst $ns
						}
					}
				}
			}
		}
		unix {
			proc nameservers {} {
				set nameservers {}
				if {[file readable /etc/resolv.conf]} {
					set f [open /etc/resolv.conf r]
					while {![eof $f]} {
						gets $f line
						if {[regexp {^\s*nameserver\s+(.*)$} $line -> ns]} {
							lappend nameservers $ns
						}
					}
					close $f
				}
				if {[llength $nameservers] < 1} {
					lappend nameservers 127.0.0.1
				}
				return $nameservers
			}
		}
		default {
			proc nameservers {} {
				return -code error "command not supported for this platform."
			}
		}
	}
	
	catch {configure -nameserver [lindex [nameservers] 0]}
	
}

package provide [namespace current]::dns $dns::version