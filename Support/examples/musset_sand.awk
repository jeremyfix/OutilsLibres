BEGIN { ORS = " " } 
{ print $1 }
END { print "? \n" }
