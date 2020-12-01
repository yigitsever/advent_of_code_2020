use strict;
use warnings;
use DDP;
use Smart::Comments;

open my $fh, '<', "input" or die "no input present, $!";
chomp(my @nums = <$fh>);
close $fh;

@nums = sort { $a <=> $b } @nums;

my $l_idx = 0;
my $r_idx = $#nums;

my $total = $nums[$l_idx] + $nums[$r_idx];

while ($total != 2020) {

    if ($total < 2020) {
        $l_idx++; # total too low, increase
    } else {
        $r_idx--; # total too high, decrease
    }

    $total = $nums[$l_idx] + $nums[$r_idx];
}

print $nums[$l_idx] * $nums[$r_idx];
