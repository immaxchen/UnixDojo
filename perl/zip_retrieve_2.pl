# perl zip_retrieve_2.pl hash.storable.gz

use strict;
use warnings;

use Storable ("fd_retrieve");
use Data::Dumper;

open(FH, "-|", "zcat $ARGV[0]");

my $hash = fd_retrieve \*FH;

close(FH);

print Dumper($hash);

