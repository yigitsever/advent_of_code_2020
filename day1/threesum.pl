use strict;
use warnings;
use DDP;
# use Smart::Comments;

open my $fh, '<', "input" or die "no input present, $!";
chomp(my @nums = <$fh>);
close $fh;

@nums = sort { $a <=> $b } @nums;

# fix one index, solve two sum problem
my $fixed_idx = 0;
my $l_idx = 1;
my $r_idx = $#nums;

my $total = $nums[$fixed_idx] + $nums[$l_idx] + $nums[$r_idx];

while ($total != 2020) {

    if ($total < 2020) {
        $l_idx++; # total too low, increase
    } else {
        $r_idx--; # total too high, decrease
    }

    # fixed index might not be correct
    if ($l_idx > $r_idx) {
        $fixed_idx++;
        $l_idx = $fixed_idx + 1;
        $r_idx = $#nums;
    }

    $total = $nums[$fixed_idx] + $nums[$l_idx] + $nums[$r_idx];
    ### $total

    ### $fixed_idx
    ### $l_idx
    ### $r_idx

    # print("fixed: $nums[$fixed_idx]\nleft: $nums[$l_idx]\nright: $nums[$r_idx]\n");
}

print $nums[$fixed_idx] * $nums[$l_idx] * $nums[$r_idx];
