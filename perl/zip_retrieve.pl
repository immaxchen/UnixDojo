# perl zip_retrieve.pl <(zcat hash.storable.gz)

use strict;
use warnings;

use Storable ("nstore_fd", "retrieve");
use Data::Dumper;

my $hash = retrieve $ARGV[0];

print Dumper($hash);

