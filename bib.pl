use strict;
use 5.10.0;
use BibTeX::Parser;
    use IO::File;
use LWP::Simple;
use Time::HiRes;

my $fh = IO::File->new($ARGV[0]);

my $parser = BibTeX::Parser->new($fh);
my $db = 'pubmed';
my $base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
my $cgi = 'esearch.fcgi?';
my $dq = '"';

while (my $entry = $parser->next ) {
	if ($entry->parse_ok) {
		say $entry->key . ": ";
		next unless $entry->type eq "ARTICLE";

		my @query;
		foreach my $au ($entry->author){
			push @query, $au->last;
		}
		my $query = join " AND ", @query ;

		my $title =  $entry->field("title");
		$query .= " AND $title";

		say "QUERY: $query";

		#post the esearch URL
		my $url = $base . $cgi. "db=$db&term=$query";
		## Time::HiRes::sleep(0.4); #.1 seconds
		sleep 1;
		my $output = get($url);
		say "Output: $output";

	} else {
		warn "Error parsing file: " . $entry->error;
	}
}
