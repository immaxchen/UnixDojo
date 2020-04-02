use strict;
use warnings;

$|=1;

# magic variables:
# $`
# $&
# $'
# $-[0]
# $+[0]

sub extract_section {

    my $input = shift;
    my $regex = shift; $regex = qr/$regex/;
    my $count = 0;
    my @lines = ();

    open(INPUT, '<', $input) or die("error opening: $input\n");

    while (my $line = <INPUT>) {
        if ($count == 0) {
            if ($line =~ $regex) {
                $line = "$&$'";
            } else {
                next;
            }
        }
        while ($line =~ /[{}]/g) {
            if ($& eq '{') { $count++ } else { $count-- }
            if ($count == 0) {
                push @lines, "$`$&";
                return join "", @lines;
            }
        }
        push @lines, $line;
    }

    close(INPUT);
    return "";
}

sub main {

    my $input = 'brackets.txt';
    my $regex = 'cccc {';
    my $taken = extract_section($input, $regex);
    print "$taken\n";

}

main();

