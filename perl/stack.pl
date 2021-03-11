#!/bin/env perl

use strict;
use warnings;

my $delimiter = " ";
my $separator = " ";
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

    ($#ARGV > 2) or die('USAGE: printf "aa bb cc dd\n11 33 55 77\n22 44 66 88\n" | perl stack.pl 1:2 3: tt vv'."\n");

    chomp( my @line = <STDIN> );

    my $cmax = maxcol \@line;

    my $idxs = expand $ARGV[0], $cmax;
    my $cols = expand $ARGV[1], $cmax;

    my @head = split $delimiter, $line[0];

    print concat \@head, $idxs;
    print $delimiter.$ARGV[2].$delimiter.$ARGV[3];
    print "\n";

    for (my $i = 1; $i <= $#line; $i++) {

        my @cell = split $delimiter, $line[$i];

        for my $c (sort keys %$cols) {

            print concat \@cell, $idxs;
            print $delimiter.($head[$c-1] // $nullvalue).$delimiter.($cell[$c-1] // $nullvalue);
            print "\n";
        }
    }
}

main();
