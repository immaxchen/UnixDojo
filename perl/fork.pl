#!/bin/env perl

use strict;
use warnings;

$|=1;

sub dispatch {
    my $children = shift;
    my $pn = scalar @$children;
    my $pi = 0;
    while (my $line = <STDIN>) {
        $pi = $pi % $pn;
        print { $children->[$pi] } $line;
        $pi++;
    }
}

sub dowork {
    my $cnt = 0;
    while (my $line = <STDIN>) {
        $cnt++;
    }
    print "$cnt\n";
}

sub main {
    my $pn = shift;
    my @children = ();
    my $pid = 1;
    for my $pi (1 .. $pn) {
        if ($pid) { # parent
            $pid = open(my $child, "|-") // die "Can't fork: $!";
            push @children, $child;
        }
    }
    if ($pid) { # parent
        dispatch \@children;
        close $_ for @children;
        wait for @children;
    } else { # child
        close $_ for @children;
        dowork;
        exit;
    }
}

unless (caller) {
    ($#ARGV == 0) or die "Error: need exactly 1 input argument (process count)\n";
    $ARGV[0] > 0 or die "Error: incorrect number for process count\n";
    main($ARGV[0]);
}
