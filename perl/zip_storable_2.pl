# perl zip_storable_2.pl > hash.storable.gz

use strict;
use warnings;

use Storable ("nstore_fd");

my $hash = {a => 1, b => 2, c => [3, 4, 5]};

open(FH, "|-", "gzip --stdout --force");

nstore_fd $hash, \*FH;

close(FH);

