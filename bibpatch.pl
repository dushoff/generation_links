use 5.10.0;
use strict;

while(<>){
	## s/author[ =]*{/$&AUTO and /;
	s/(year[ =]*{[0-9]*) [^}]*/$1/;
	print;
}
