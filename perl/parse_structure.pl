use strict;
use warnings;

use Text::Balanced ("extract_bracketed");
use Data::Dumper;
use FindBin;

use lib "$FindBin::Bin";
use util::str;

$|=1;

sub parse_structure {

    my $dict = shift;
    my $text = shift;

    while ( my ($extracted, $remainder, $prefix) = extract_bracketed($text, "{}", "[^{}]*") ) {
        if ( ! $extracted ) { last; }

        str::trim $prefix; $prefix =~ s/.*[\r|\n]//g;
        str::trim $prefix;
        str::trim $extracted; $extracted =~ s/^{|}$//g;
        str::trim $extracted;

        if ( $extracted =~ /{.*}/ ) {
            $dict->{$prefix} = parse_structure({}, $extracted);
        } else {
            $dict->{$prefix} = $extracted;
        }
    }

    return $dict;
}

sub main {

    my $file = 'brackets.txt';

    my $text = do {
        local $/ = undef;
        open(INPUT, '<', $file) or die("error opening: $file\n");
        <INPUT>;
    };

    my $dict = parse_structure({}, $text);
    print Dumper($dict);
}

main();

