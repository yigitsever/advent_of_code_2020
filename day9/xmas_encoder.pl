use strict;
use warnings;
use DDP;
use Smart::Comments;
use Tie::File;
use List::Util qw(min max);

tie my @xmas, 'Tie::File', "input" or die "no input present, $!";

my %preamble;
# because it's easier this way trust me
my @also_queue;
my $goalnum;

foreach my $idx (0 .. $#xmas) {
    if ($idx < 25) {
        my $t = int($xmas[$idx]);
        $preamble{$t} = 1;
        push @also_queue, $t;
    } else {
        my $nextnum = int($xmas[$idx]);
        my $tester = 0;
        foreach my $num (keys %preamble) {
            $tester++;
            if (exists $preamble{$nextnum - $num}) {
                my $old = shift @also_queue;
                delete $preamble{$old};
                push @also_queue, $nextnum;
                $preamble{$nextnum} = 1;
                last;
            }
        }

        if (not scalar grep { $_ == $nextnum } @also_queue) {
            $goalnum = $nextnum;
            print("XMAS weak num: $goalnum\n");
            last;
        }
    }
}

# find the contiguous set

my @contiguous;
my $total = 0;

foreach my $curr (@xmas) {
    if ($total + $curr < $goalnum) {
        $total += $curr;
        push @contiguous, $curr;
    } elsif ($total + $curr > $goalnum) {
        while ($total + $curr > $goalnum) {
            my $evictee = shift @contiguous;
            if (not defined $evictee) {
                last;
            }
            $total -= $evictee;
        }
        push @contiguous, $curr;
        $total += $curr;
    }

    if ($total == $goalnum) {
        print(min(@contiguous) + max(@contiguous));
        p @contiguous;
        exit;
    }
}

untie @xmas;
