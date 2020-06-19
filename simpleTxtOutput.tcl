#https://www.tcl.tk/man/tcl8.5/tutorial/Tcl1.html
#puts "Hello, World in quotes"
#puts {Hello in Braces}
#puts Helloworld

proc COMMENTED_OUT {} {

	set fruit Cauliflower
	puts $fruit

	set fruit "This is a string"

	set Y 1.24

	puts $fruit
	puts $Y

	puts "..............................."

	set label "The value in Y is: "
	puts "$label $Y"


	set Z Albany
	set Z_LABEL "The Capitol of New York is: "

	puts "\n................. examples of differences between \" and \{"
	puts "$Z_LABEL $Z"
	puts {$Z_LABEL $Z}

	puts "\n....... examples of differences in nesting \{ and \" "
	puts "$Z_LABEL {$Z}"
	puts {Who said, "What this country needs is a good $0.05 cigar!"?}

	puts "\n................. examples of escape strings"
	puts {There are no substitutions done within braces \n \r \x0a \f \v}
	puts {But, the escaped newline at the end of a\
	string is still evaluated as a space}
}

proc sum {arg1 arg2} {
    set x [expr {$arg1 + $arg2}];
    return $x
}

puts " The sum of 2 + 3 is: [sum 2 3]\n\n"

proc for {a b c} {
    puts "The for command has been replaced by a puts";
    puts "The arguments were: $a\n$b\n$c\n"
}

for {set i 1} {$i < 10} {incr i}