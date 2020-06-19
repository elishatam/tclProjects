#Batch Process.tcl


load "C:/tcldlls/tcl_viv_statistics.dll"
load "C:/tcldlls/tcl_viv_image_process"

source "C:/tclscripts/statusbar.tcl"

global verbose
set verbose 1
proc put {str} {
	global verbose
	if {$verbose} {
		tk_messageBox -message $str
	}
}

proc writelog {logfile msg} {
   set Log [open $logfile {CREAT RDWR APPEND} ]
   if { $Log == "" } { put "ERROR OPENING $Log"; exit }
   puts $Log  $msg 
   # puts $Log \n
   close $Log
}

set dataDir {D:\Data\LC04\Dark_Images}

set reportFile [file join $dataDir leaky_pixel_count.txt]


set filelist ""
set filelist [glob -directory  $dataDir *Dark*.viv]

	
	set filecount [llength $filelist]
	set count 0
	
	
	
	foreach f $filelist {
		incr count

		# set outfilename [file join $reportDir $outfname]
		set statustext "Processing [file tail $f],  $count of $filecount"
		update
		 
			
		# extract panel sn#	from "LC04_541S09_1504-D2-10-Dark.viv"	 
		# construct panel serial #
		
		set panelsn ""
		append panelsn [string range [file tail $f] 5 10] "-"	[string range [file tail $f] 12 15]		
		
		
		set msg $panelsn				
	
		    append msg \t [count_pixels_between_lsl_usl $f 6000 100000 10 2465 10 3061] \t [count_pixels_between_lsl_usl $f 8000 100000 10 2465 10 3061] \t [count_pixels_between_lsl_usl $f 10000 100000 10 2465 10 3061] \t [count_pixels_between_lsl_usl $f 12000 100000 10 2465 10 3061] \
			
		writelog $reportFile $msg
		
	}

	# put alldata in spreadsheet format
		
	

exit