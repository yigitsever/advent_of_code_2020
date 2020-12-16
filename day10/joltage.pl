use strict;
use warnings;
use DDP;
use Smart::Comments;

my @lines = <>;

my @jolts = map { s/\n$//r } @lines;
@jolts = sort { $a <=> $b } @jolts;

# p @jolts;

my %diffs;

my $curr = 0;

foreach my $joltage (@jolts) {
    $diffs{$joltage - $curr}++;
    $curr = $joltage;
}

# and the built-in adapter
$diffs{3}++;

p %diffs;

print($diffs{1} * $diffs{3});
