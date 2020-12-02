use strict;
use warnings;

open my $fh, '<', "input" or die "no input present, $!";

my $valid = 0;

while (my $line = <$fh>) {
    chomp $line;
    if ($line =~ m/(?<idx_1>\d+)-(?<idx_2>\d+) (?<char>\w): (?<rest>\w+)/) {

        my $first = substr( $+{rest}, $+{idx_1} - 1 , 1 );
        my $second = substr( $+{rest}, $+{idx_2} - 1 , 1 );

        $valid++ if $first eq $+{char} xor $second eq $+{char};
    }
}

print("$valid");
