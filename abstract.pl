use strict;
use 5.10.0;

while(<>){
	next unless /Abstract/../Keywords/;
	next if /\\[a-z]*section/;

	s/\\RR[\\]*/R/g;
	s/\$r\$/r/g;
	s/\\rR[\\]*/r-R/g;
	print;
}
