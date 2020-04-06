package str;

use strict;
use warnings;


sub trim {
    @_ = $_ if not @_ and defined wantarray;
    @_ = @_ if defined wantarray;
    for (@_ ? @_ : $_) { s/^\s+//, s/\s+$// }
    return wantarray ? @_ : $_[0] if defined wantarray;
}


1;

