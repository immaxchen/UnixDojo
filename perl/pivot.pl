#!/bin/env perl

# printf "aa bb cc dd\n11 33 55 77\n22 44 66 88\n" | perl pivot.pl 1:2 3 4

use strict;
use warnings;

my $delimiter = " ";
my $separator = "-";
my $nullvalue = "NA";

sub maxcol {

    my $line = shift;
    my $cmax = 0;

    for (@$line) {

        my @cell = split $delimiter, $_;

        $cmax = @cell > $cmax ? @cell : $cmax;
    }

    return $cmax;
}

sub expand {

    my %keys = map { $_ => 1 } split ",", shift;
    my $cmax = shift;

    for my $c (keys %keys) {

        if ($c =~ /(\d*):(\d*)/) {

            my $s = $1 ne "" ? $1 : 1;
            my $e = $2 ne "" ? $2 : $cmax;

            $keys{$_} = 1 for $s .. $e;

            delete $keys{$c};
        }
    }

    return \%keys;
}

sub concat {

    my $data = shift;
    my $keys = shift;

    return join $separator, map { $data->[$_-1] // $nullvalue } sort keys %$keys;
}

sub main {

    chomp( my @line = <STDIN> );

    my $cmax = maxcol \@line;

    my $idxs = expand $ARGV[0], $cmax;
    my $cols = expand $ARGV[1], $cmax;
    my $vals = expand $ARGV[2], $cmax;

    my $name = {};
    my $dict = {};

    for (my $i = 1; $i <= $#line; $i++) {

        my @cell = split $delimiter, $line[$i];

        my $idx = concat \@cell, $idxs;
        my $col = concat \@cell, $cols;
        my $val = concat \@cell, $vals;

        $name->{$col} = 1;
        $dict->{$idx}->{$col} = $val;
    }

    my @head = split $delimiter, $line[0];

    print concat \@head, $idxs;
    print $delimiter.$_ for sort keys %$name;
    print "\n";

    for my $idx (sort keys %$dict) {

        print $idx;
        print $delimiter.($dict->{$idx}->{$_} // $nullvalue) for sort keys %$name;
        print "\n";
    }
}

main();
