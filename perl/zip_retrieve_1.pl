# perl zip_retrieve_1.pl <(zcat hash.storable.gz)

use strict;
use warnings;

use Storable ("retrieve");
use Data::Dumper;

my $hash = retrieve $ARGV[0];

print Dumper($hash);

