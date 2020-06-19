#https://www.tcl.tk/man/tcl8.5/tutorial/Tcl1.html
#puts "Hello, World in quotes"
#puts {Hello in Braces}
#puts Helloworld

proc put {str} {
    global verbose
    if {$verbose} {
        tk_messageBox -message $str
    }
}

proc writelog {logfile msg} {
   #RDWR - open file for both reading and writing
   set Log [open $logfile {RDWR APPEND CREAT} ]
   if { $Log == "" } { put "ERROR OPENING $Log"; exit }
   puts $Log  $msg ;#Append msg to $Log
   puts $Log \n    ;#Append newline
   close $Log
}

#writelog "testFile.txt" "hello"

set panelList {
C48S17-0103
C48S17-0201
C48S17-0202
C48S17-0501
}

#puts $panelList

#append panelList \t "hi"

#puts $panelList

set panelid "C48S17-0501"
set datasrcDir1 {C:\Users\el991109\Documents\git\tclProjects}
#set netdatafolder [file join $datasrcDir1 "hello"]
set netdatafolder [file join $datasrcDir1 "[string range $panelid 0 0]---"  "[string range $panelid 0 1]--" $panelid "glass"]

puts $netdatafolder

set filelist "" 
catch {set filelist [glob -directory  $datasrcDir1 *File*.txt]}
puts $filelist

set filesrc [lindex $filelist 0]
set imgname [file tail $filesrc]  
puts $imgname