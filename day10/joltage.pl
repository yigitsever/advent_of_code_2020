use strict;
use warnings;
use DDP;
use Smart::Comments;
use List::Util qw(sum min);

my @jolts = sort { $a <=> $b } map { int } <>;

@jolts = (0, @jolts, $jolts[-1] + 3);

my %diffs;

my $curr = 0;

foreach my $joltage (@jolts) {
    $diffs{$joltage - $curr}++;
    $curr = $joltage;
}

p %diffs;

print($diffs{1} * $diffs{3});

my @memoi = (1);
for my $k (1..$#jolts) {
    push @memoi, sum map {$memoi[$k-$_]} grep {$jolts[$k-$_]+3 >= $jolts[$k]} 1..min($k,3);
}

print "\n$memoi[-1]"
