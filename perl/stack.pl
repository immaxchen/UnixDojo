#!/bin/env perl

use strict;
use warnings;

my %cols = map { $_ => 1 } split ":", $ARGV[0];

my @head = split " ", <STDIN>;

while (my $line = <STDIN>) {

    chomp $line;

    my @cell = split " ", $line;

    for my $c (sort keys %cols) {

        for (my $i = 0; $i <= $#cell; $i++) {

            exists $cols{$i+1} or print "$cell[$i] ";
        }

        print "$head[$c-1] $cell[$c-1]\n";
    }
}
