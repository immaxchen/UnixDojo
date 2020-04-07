use strict;
use warnings;

use Text::CSV ("csv");

$|=1;

sub main {

    my $aoa = csv( in => "../data/sample.csv" );
    my $aoh = csv( in => "../data/sample.csv", headers => "auto" );

    csv( in => $aoa, out => "aoa.csv", sep_char => "," );
    csv( in => $aoh, out => "aoh.csv", sep_char => "," );

    foreach my $row (@{$aoa}) { print "@{$row}\n"; };
    foreach my $row (@{$aoh}) { print "@{[%{$row}]}\n"; };

}

main();

