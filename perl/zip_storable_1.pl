# perl zip_storable_1.pl | gzip > hash.storable.gz

use strict;
use warnings;

use Storable ("nstore_fd");

my $hash = {a => 1, b => 2, c => [3, 4, 5]};

nstore_fd $hash, \*STDOUT;

