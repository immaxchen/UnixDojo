#!/bin/env perl

use strict;
use warnings;

use List::Util ("min","max","sum");

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

sub avg { return @_ > 0 ? sum(@_)/@_ : undef; }
sub std { my $m = avg(@_); return $#_ < 0 ? undef : $#_ < 1 ? 0 : ( sum(map { ($_-$m) ** 2 } @_)/$#_ ) ** 0.5; }

sub print_aggregate {

    my $opts = shift;
    my $data = shift;

    for my $opt (@$opts) {

        if    ($opt eq "count") { print $delimiter.@$data; }
        elsif ($opt eq "first") { print $delimiter.($data->[0]  // $nullvalue); }
        elsif ($opt eq "last" ) { print $delimiter.($data->[-1] // $nullvalue); }
        elsif ($opt eq "min"  ) { print $delimiter.(min(@$data) // $nullvalue); }
        elsif ($opt eq "max"  ) { print $delimiter.(max(@$data) // $nullvalue); }
        elsif ($opt eq "sum"  ) { print $delimiter.(sum(@$data) // $nullvalue); }
        elsif ($opt eq "avg"  ) { print $delimiter.(avg(@$data) // $nullvalue); }
        elsif ($opt eq "std"  ) { print $delimiter.(std(@$data) // $nullvalue); }
    }
}

sub main {

    ($#ARGV > 1) or die('USAGE: printf "zone job sex age\nwest dev M 28\neast dev F 20\neast dev F 30\n" | perl pivot.pl 1:2 3 4 --avg'."\n");

    chomp( my @line = <STDIN> );

    my $cmax = maxcol \@line;

    my $idxs = expand $ARGV[0], $cmax;
    my $cols = expand $ARGV[1], $cmax;
    my $vals = expand $ARGV[2], $cmax;

    my @opts = @ARGV[3 .. $#ARGV]; $#opts > -1 or @opts = ("--count"); s/^--// for @opts;

    my $name = {};
    my $dict = {};

    for (my $i = 1; $i <= $#line; $i++) {

        my @cell = split $delimiter, $line[$i];

        my $idx = concat \@cell, $idxs;
        my $col = concat \@cell, $cols;
        my $val = concat \@cell, $vals;

        $name->{$col} = 1;

        exists $dict->{$idx}->{$col} or $dict->{$idx}->{$col} = [];

        push @{$dict->{$idx}->{$col}}, $val;
    }

    my @head = split $delimiter, $line[0];

    my $v = concat \@head, $vals;

    print concat \@head, $idxs;
    print $delimiter.$_ for map { my $t = $_; map { "$_($t.$v)" } @opts } sort keys %$name;
    print "\n";

    for my $idx (sort keys %$dict) {

        print $idx;
        for my $col (sort keys %$name) {

            my $cell = $dict->{$idx}->{$col} // [];
            my @data = grep ! /^$nullvalue$/, @$cell;

            print_aggregate \@opts, \@data;
        }
        print "\n";
    }
}

main();
