#!/bin/env perl

use strict;
use warnings;

use List::Util ("min","max","sum");

# TODO: set by input args
my $delimiter = " ";
my $separator = "-";
my $nullvalue = "NA";

# TODO: NA strategies - ignore, fill, return NA
my $fillvalue = 0;

sub maxcol {

    my $line = shift;
    my $cmax = 0;

    for (@$line) {

        my @cell = split $delimiter, $_;

        $cmax = @cell > $cmax ? @cell : $cmax;
    }

    return $cmax;
}

# TODO: select by column name
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

sub mean { return @_ > 0 ? sum(@_)/@_ : undef; }
sub std { my $m = mean(@_); return $#_ < 0 ? undef : $#_ < 1 ? 0 : ( sum(map { ($_-$m) ** 2 } @_)/$#_ ) ** 0.5; }
# TODO: pctl (percentile) - p50, p5, p95, etc

sub print_aggregate {

    my $opts = shift;
    my $data = shift;

    for my $opt (@$opts) {

        if    ($opt eq "count") { print $delimiter.@$data; }
        elsif ($opt eq "first") { print $delimiter.($data->[0]   // $nullvalue); }
        elsif ($opt eq "last" ) { print $delimiter.($data->[-1]  // $nullvalue); }
        elsif ($opt eq "min"  ) { print $delimiter.(min(@$data)  // $nullvalue); }
        elsif ($opt eq "max"  ) { print $delimiter.(max(@$data)  // $nullvalue); }
        elsif ($opt eq "sum"  ) { print $delimiter.(sum(@$data)  // $nullvalue); }
        elsif ($opt eq "mean" ) { print $delimiter.(mean(@$data) // $nullvalue); }
        elsif ($opt eq "std"  ) { print $delimiter.(std(@$data)  // $nullvalue); }
    }
}

sub main {

    ($#ARGV > 1) or die('USAGE: printf "zone job sex age\nwest dev M 28\neast dev F 20\neast dev F 30\n" | perl pivot.pl 1:2 3 4 --mean'."\n");

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
        my $col = concat \@cell, $cols; $name->{$col} = 1;

        for my $val (sort keys %$vals) {

            exists $dict->{$idx}->{$col}->{$val} or $dict->{$idx}->{$col}->{$val} = [];

            push @{$dict->{$idx}->{$col}->{$val}}, $cell[$val-1];
        }
    }

    my @head = split $delimiter, $line[0];

    print concat \@head, $idxs;
    print $delimiter.$_ for map { my $c = $_; map { my $v = $head[$_-1]; map { "$_($c.$v)" } @opts } sort keys %$vals } sort keys %$name;
    print "\n";

    for my $idx (sort keys %$dict) {

        print $idx;
        for my $col (sort keys %$name) {
        for my $val (sort keys %$vals) {

            my $cell = $dict->{$idx}->{$col}->{$val} // [];
            my @data = grep ! /^$nullvalue$/, @$cell;

            print_aggregate \@opts, \@data;
        }}
        print "\n";
    }
}

main();
