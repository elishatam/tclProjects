#BatchReProcess.tcl



global verbose
set verbose 1


#Name: put {str}
#Summary: Output message into tk message box
#Args: string (Example: "panelx")
#Return: None
proc put {str} {
    global verbose
    if {$verbose} {
        tk_messageBox -message $str
    }
}


# -------- User inferface  ---------------

set statustext ""
wm title . "Status Window"
frame .top -borderwidth 10
pack .top -side top -fill x 
label .top.statuslabel -text "Status" -width 8
entry .top.status -textvariable statustext -width 120 -relief sunken -bg #eff -fg black
pack  .top.statuslabel .top.status -side left
update

proc writelog {logfile msg} {
   #RDWR - open file for both reading and writing
   set Log [open $logfile {RDWR APPEND CREAT} ]
   if { $Log == "" } { put "ERROR OPENING $Log"; exit }
   puts $Log  $msg ;#Append msg to $Log
   # puts $Log \n  ;#Append newline
   close $Log
}


set datasrcDir1 {\\fpanelfs1\FPTestData\Imagers}
# set datasrcDir1 {P:\Imagers}

set targetDir {D:\Data\LC04\Dark_Images}
set logFile {D:\Data\LC04\Dark_Images\FileTransferLog.txt}

set panelList {
C48S17-0103
C48S17-0201
C48S17-0202
C48S17-0501
C48S17-0503
C48S17-0504
C48S17-0601
C48S17-0603
C48S17-1603
C48S17-1604
C48S17-1703
C48S17-1802
C48S17-1803
C49S01-0101
C49S01-1304
C49S01-1501
C49S01-1603
C49S01-1604
C49S01-1701
C49S01-1703
D09S20-0303
D09S20-0304
D09S20-0403
D09S20-0404
}

set counter 0
#foreach varlist list body
foreach panelid $panelList {

    incr counter
    set statustext "$panelid   No. $counter  of [llength $panelList]"
    update
    
    set msg $counter
    append msg \t $panelid
    
    #add to path to create new folder based on panelid C48S17-0103
    #Add directory with 1st letter of panelid (C---)
    #Add directory with 2nd letter of panelid (4--)
    #Add directory with panelid (C48S17-0103)
    #Add directory with "glass" (glass)
    # C:/Users/el991109/Documents/git/tclProjects/C---/C4--/C48S17-0103/glass
    set netdatafolder [file join $datasrcDir1 "[string range $panelid 0 0]---"  "[string range $panelid 0 1]--" $panelid "glass"]

    # tk_messageBox -message $netdatafolder
    
            if {[file isdirectory $netdatafolder]==0} {
                    append msg \t "No_Folder"
                    writelog $logFile $msg
                    continue
            }
    
        
    #save any file with D2*Dark*.viv name into filelist
    set filelist "" 
    catch {set filelist [glob -directory  $netdatafolder *-D2-*-Dark*.viv]}
        
    # tk_messageBox -message [lindex $filelist 0]
    
    if {[llength $filelist]==0} {
        append msg \t "No_Image"  ;#No dark images in this panelid glass directory
        writelog $logFile $msg  
        continue ;#Skip remaining for loop instructions and go to next index
        }
    set filesrc [lindex $filelist 0]  ;#Put index 0 file into filesrc
    
    set imgname [file tail $filesrc]  ;#Ignore beginning path stuff. 
                                       #Just get the last value = image name "*-D2-*-Dark*.viv"
    
    #filetarget = D:\Data\LC04\Dark_Images\-D2-*-Dark*.viv
    set filetarget [file join $targetDir $imgname]

                if {[file exists $filetarget]>0 } {
                    append msg \t "Image Exists"
                    writelog $logFile $msg
                    continue ;  #Skip remaining for loop instructions and go to next index
                }       


    #Copy filesrc to filetarget. Existing files will be overwritten    
    if [catch {file copy -force $filesrc $filetarget}] {
            append msg \t "Copy_Failed"
            writelog $logFile $msg
            continue
    }
    
    append msg \t "Complete"
    writelog $logFile $msg

}

tk_messageBox -message "Done"

exit