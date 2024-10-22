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

my $valid = 0;

# the file has to end with a empty line...
while ($batch =~ m/((?:[^\n][\n]?)+)/gm ) {
    my $person_passport = $1;
    my %passport;

    if ($person_passport =~ m/byr:(?<byr>\d{4})\s/) {
        if ($+{byr} >= 1920 and $+{byr} <= 2002) {
            $passport{"byr"} = $+{byr};
        }
    }

    if ($person_passport =~ m/iyr:(?<iyr>\d{4})\s/) {
        if ($+{iyr} >= 2010 and $+{iyr} <= 2020) {
            $passport{"iyr"} = $+{iyr};
        }
    }

    if ($person_passport =~ m/eyr:(?<eyr>\d{4})\s/) {
        if ($+{eyr} >= 2020 and $+{eyr} <= 2030) {
            $passport{"eyr"} = $+{eyr};
        }
    }

    if ($person_passport =~ m/hgt:(?<hgt>\d+)(?<unit>\w{2})\s/) {
        if ($+{unit} eq "cm") {
            if ($+{hgt} >= 150 and $+{hgt} <= 193) {
                $passport{"hgt"} = "$+{hgt}" . $+{unit};
            }
        } elsif ($+{unit} eq "in") {
            if ($+{hgt} >= 59 and $+{hgt} <= 76) {
                $passport{"hgt"} = "$+{hgt}" . $+{unit};
            }
        }
    }

    if ($person_passport =~ m/hcl:(?<hcl>#[a-f0-9]{6})\s/) {
        $passport{"hcl"} = $+{hcl};
    }

    if ($person_passport =~ m/ecl:(?<ecl>amb|blu|brn|gry|grn|hzl|oth)\s/) {
        $passport{"ecl"} = $+{ecl};
    }

    if ($person_passport =~ m/pid:(?<pid>[0-9]{9})\s/) {
        $passport{"pid"} = $+{pid};
    }

    if (keys %passport == 7) {
        $valid++;
        $valids{$passport{"pid"}} = \%passport;
    }
}

print("$valid");
