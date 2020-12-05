use strict;
use warnings;
# use Smart::Comments;

open my $fh, '<', "input" or die "no input present, $!";

my $right_m = 3;
my $toboggan = 0;

my $trees = 0;

while (my $line = <$fh>) {
    chomp $line;

    ### $line
    my $curr = substr($line, $toboggan, 1);
    ### $curr

    if ($curr eq "#") {
        $trees++;
    }

    ### $toboggan

    $toboggan = ($toboggan + $right_m) % 31;

}

print($trees);

