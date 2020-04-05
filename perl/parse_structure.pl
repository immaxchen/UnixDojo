use strict;
use warnings;
use Data::Dumper;
use Text::Balanced ("extract_bracketed");

$|=1;

sub trim {
    @_ = $_ if not @_ and defined wantarray;
    @_ = @_ if defined wantarray;
    for (@_ ? @_ : $_) { s/^\s+//, s/\s+$// }
    return wantarray ? @_ : $_[0] if defined wantarray;
}

sub parse_structure {

    my $dict = shift;
    my $text = shift;

    while ( my ($extracted, $remainder, $prefix) = extract_bracketed($text, "{}", "[^{}]*") ) {
        if ( ! $extracted ) { last; }

        trim $prefix; $prefix =~ s/.*[\r|\n]//g;
        trim $prefix;
        trim $extracted; $extracted =~ s/^{|}$//g;
        trim $extracted;

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

