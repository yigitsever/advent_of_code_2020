use strict;
use warnings;
# use Smart::Comments;
use DDP;

open my $fh, '<', "input" or die "no input present, $!";
chomp(my @forest = <$fh>);
close $fh;
my $len = scalar @forest;

my @right_ms = qw/1 3 5 7 1/;
my @down_ms = qw/ 1 1 1 1 2/;
my $runs = $#right_ms;

my $all_trees = 1;

foreach my $run (0..$runs) {

    my $toboggan = 0;
    my $trees = 0;
    my $down_mov = $down_ms[$run];
    my $right_mov = $right_ms[$run];

    for (my $line = 0; $line < $len; $line += $down_mov) {
        my $curr = substr($forest[$line], $toboggan, 1);
        if ($curr eq "#") {
            $trees++;
        }
        $toboggan = ($toboggan + $right_mov) % 31;
    }
    $trees ||= 1;
    $all_trees *= $trees;
    ### this run is
    ### $right_mov
    ### $down_mov
    ### got: $trees
    ### so far: $all_trees
}

print("$all_trees");
