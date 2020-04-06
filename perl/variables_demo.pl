use strict;
use warnings;

use Data::Dumper;

$|=1;

sub main {

    # ===== regular declaration =====
    my $scalar = 1;
    my @array = (1, 3 .. 5);
    my %hash = (a=>1, b=>3, c=>5);

    print "===== unpack values =====\n";
    my ($item1, $item2) = @array;
    print "$item1\n";
    print "$item2\n";
    print "\n";

    print "===== get values =====\n";
    print "$scalar\n";
    print "$array[1]\n";
    print "$hash{c}\n";
    print "\n";

    print "===== call by values =====\n";
    print Dumper($scalar)."\n";
    print Dumper(@array)."\n";
    print Dumper(%hash)."\n";

    print "===== call by reference =====\n";
    print Dumper($scalar)."\n";
    print Dumper(\@array)."\n";
    print Dumper(\%hash)."\n";

    # ===== declare as reference =====
    my $p_scalar = 1;
    my $p_array = [1, 3 .. 5];
    my $p_hash = {a=>1, b=>3, c=>5};

    print "===== get values =====\n";
    print "$p_scalar\n";
    print "$p_array->[1]\n";
    print "$p_hash->{c}\n";
    print "\n";

    print "===== call by reference =====\n";
    print Dumper($p_scalar)."\n";
    print Dumper($p_array)."\n";
    print Dumper($p_hash)."\n";

    print "===== dereference =====\n";
    print Dumper($p_scalar)."\n";
    print Dumper(@{$p_array})."\n";
    print Dumper(%{$p_hash})."\n";
}

main();

