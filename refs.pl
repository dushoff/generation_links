use strict;
use 5.10.0;

use LWP::Simple;

# Download PubMed records that are indexed in MeSH for both asthma and 
# leukotrienes and were also published in 2009.

my $db = 'pubmed';
my $query = 'asthma[mesh]+AND+leukotrienes[mesh]+AND+2009[pdat]';

#assemble the esearch URL
my $base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
my $url = $base . "esearch.fcgi?db=$db&term=$query&usehistory=y";

#post the esearch URL
my $output = get($url);

#parse WebEnv and QueryKey
my $web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
my $key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);

say "Keys:" . $web;
say $key;

### include this code for ESearch-ESummary
#assemble the esummary URL
$url = $base . "esummary.fcgi?db=$db&query_key=$key&WebEnv=$web";

#post the esummary URL
my $docsums = get($url);
say "docsums: $docsums";

### include this code for ESearch-EFetch
#assemble the efetch URL
$url = $base . "efetch.fcgi?db=$db&query_key=$key&WebEnv=$web";
$url .= "&rettype=abstract&retmode=text";

#post the efetch URL
my $data = get($url);
say "data: $data";
