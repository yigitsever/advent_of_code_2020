use strict;
use warnings;
use Smart::Comments;
use DDP;

my $batch;
{
    local $/;
    open my $fh, '<', "input" or die "no input present, $!";
    $batch = <$fh>;
}

my $all_yeses = 0;

while ($batch =~ m/((?:[^\n][\n]?)+)/gm ) {
    my $group_answers = $1;

    # count the newlines = number of people
    my $peeps = $1 =~ tr/\n//;

    chomp $group_answers;

    my %counts;
    while ($group_answers =~ m/^(\w+)$/mg) {
        my $person_answers = $1;
        ++$counts{$_} for split(//, $person_answers);
    }

    $all_yeses += scalar grep { $_ == $peeps } values %counts;
}

print $all_yeses;
