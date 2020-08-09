use strict;
use warnings;

use Data::Dumper;

use FindBin;

use lib "$FindBin::Bin/util";

use zstorable;

sub main {

    my $hash = {a => 1, b => 2, c => [3, 4, 5]};

    zstore $hash, "test-obj.zs";

    my $new_hash = zretrieve "test-obj.zs";

    print Dumper($new_hash);
}

main();

