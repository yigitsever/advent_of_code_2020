use strict;
use warnings;

open my $fh, '<', "input" or die "no input present, $!";

my $valid = 0;

while (my $line = <$fh>) {
    chomp $line;
    if ($line =~ m/(?'first'\d+)-(?'second'\d+) (?'char'\w): (?'rest'\w+)/) {

        my $first = $+{first};
        my $second = $+{second};

        # https://www.effectiveperlprogramming.com/2010/12/count-the-number-of-things-in-a-string/
        my $count = () = $+{rest} =~ /$+{char}/g;

        $valid++ if $count >= $first and $count <= $second;
    }
}

print("$valid");
