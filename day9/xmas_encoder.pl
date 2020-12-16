use strict;
use warnings;
use DDP;
use Smart::Comments;

open my $fh, '<', "input" or die "no input present, $!";

my %preamble;
# because it's easier this way trust me
my @also_queue;

foreach (1..25) {
    my $t = int(<$fh>);
    $preamble{$t} = 1;
    push @also_queue, int($t);
}

while (my $nextnum = <$fh>) {
    $nextnum = int($nextnum);
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
        print($nextnum);
        exit;
    }
}

