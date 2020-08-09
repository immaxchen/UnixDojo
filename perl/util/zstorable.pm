package zstorable;

use strict;
use warnings;

use Storable ("nstore_fd", "fd_retrieve");

use Exporter;
our @ISA = ("Exporter");
our @EXPORT = ("zstore", "zretrieve");

sub zstore {

    my $hash = shift;
    my $file = shift;

    open(FH, "|-", "gzip --stdout --force > \"$file\"");

    nstore_fd $hash, \*FH;

    close(FH);
}

sub zretrieve {

    my $file = shift;

    open(FH, "-|", "zcat \"$file\"");

    my $hash = fd_retrieve \*FH;

    close(FH);

    return $hash;
}

1;

