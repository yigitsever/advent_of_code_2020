use strict;
use warnings;
use Smart::Comments;
use DDP;
use List::Util 'sum';

my $batch;
{
    local $/;
    open my $fh, '<', "input" or die "no input present, $!";
    $batch = <$fh>;
}

my $total_yes = 0;

while ($batch =~ m/((?:[^\n][\n]?)+)/gm ) {
    my $group_answers = $1;
    chomp $group_answers;

    my %counts;
    while ($group_answers =~ m/^(\w+)$/mg) {
        my $person_answers = $1;
        $counts{$_} = 1 for split(//, $person_answers);
    }
    # p %counts;

    $total_yes += sum values %counts
}

print $total_yes;
