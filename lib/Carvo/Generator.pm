#!/usr/bin/env perl
use strict;
use warnings;

package Generator {

    my %convert;
    my ($line, $fh, $convert);

    sub data2hash {
        %convert = ();
        while ($line = <$fh>) {
            if ($line =~ /^  "(.+)": "(.+)"$/) {
                $convert{$1} = $2;
            }
        }
    }
    sub replace_d2h {
        %convert = ();
        while ($line = <$fh>) {
            if ($line =~ /^  "(.+)": "(.+)"$/) {
                $convert{$2} = $1;
            }
        }
    }

    sub switch {
        my $sw = shift;
        if ($sw =~ /((2)|(4))/) {
            open $fh, '<', 'data/large.json' or die $!;
            if ($1 =~ /^(2)$/) {
                data2hash();
            } elsif ($1 =~ /^(4)$/) {
                replace_d2h();
            }
            return $convert = \%convert;
            close $fh;
        } elsif ($sw =~ /(1|3|\n)/) {
            open $fh, '<', 'data/short.json' or die $!;
            if ($1 =~ /^(1|\n)$/) {
                data2hash();
            } elsif ($1 =~ /^(3)$/) {
                replace_d2h();
            }
            return $convert = \%convert;
            close $fh;
        }
    }
}

1;
