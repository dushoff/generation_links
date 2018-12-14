use 5.10.0;
use strict;

while(<>){
	next if /^\s*month/;
	next if /^\s*number/;
	## s/author[ =]*{/$&MANUAL and /;
	print;
}
