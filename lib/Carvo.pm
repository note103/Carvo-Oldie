#!/usr/bin/env perl
use strict;
use warnings;
use Carvo::Generator;

package Carvo {
    our $point = 0;
    our $miss = 0;
    our $total = $point + $miss;
    our ($times, $hits, $errors) = qw(times hits errors);
    sub tutor {
        my $english = shift;
        my %english = %$english;
        my @words = sort (keys %english);
        my $words = \@words;
        my $quit = 'q|\n';
        my ($key, $num);
        my $count = @words;
        my $limit = $count - 1;
        my $port = 0;
        my $msg1 = 'Input (a number|r[andom]|q[uit]).';
        my $msg2 = 'Input (a number|r[andom]|enter[next]|q[uit]).';
        my $msg3 = 'Input (a number|r[andom]|s[ame]|enter[next]|q[uit]).';
        my $msg4 = 'Input (1|2|3|4|q).';
        my $msg5 = "You can choose a number from 1-$limit.";
        my $msg6 = "Too big! $msg5";
        my $msg_pt;
        print "$msg2\n$msg5\n";
        my $voice = sub {
            while (my $in2 = <>) {
                if ($in2 =~ /^($quit)$/) {
                    print "$key($num): $english->{$key}\n$msg3\n";
                    last;
                } elsif ($in2 =~ /^($english->{$key})$/) {
                    $point++;
                    $total = $point + $miss;
                    plural($total, $point, $miss);
                    print "\nGood!!\n$key($num): $english->{$key}\n\nYou tried $total $times. $point $hits and $miss $errors.\n$msg3\n";
                    last;
                } else {
                    $miss++;
                    print "\nNG! '$words->[$num]'\nAgain!\n";
                }
            }
        };

        while (my $in = <>) {
            if ($in =~ /^(q)$/) {
                print "\nBye!\n$msg4\n";
                last;
            } elsif ($in =~ /^0$/) {
                print "\n$msg5\n";
            } elsif ($in =~ /^(\d+)$/) {
                $num = $1;
                $port = $num;
                if ($in > $limit) {
                    print "\n$msg6\nThis is random select.\n";
                    my $random = int(rand($limit));
                    $num = $random;
                    $port = $num;
                    $key = $words->[$num];
                    print "\n$key\n";
                    $voice->();
                } else {
                    $key = $words->[$num];
                    print "\n$key\n";
                    $voice->();
                }
            } elsif ($in =~ /^(n|\n)$/) {
                if ($port == $limit) {
                    print "\nYou exceeded the maximum. Return to the beggining.\n$msg2\n";
                    $port = 1;
                    next;
                } else {
                    $num = $port+1;
                    $port = $num;
                    $key = $words->[$num];
                    print "\n$key\n";
                    $voice->();
                }
            } elsif ($in =~ /^(r)$/) {
                my $random = int(rand($limit));
                $num = $random;
                $port = $num;
                $key = $words->[$num];
                print "\n$key\n";
                $voice->();
            } elsif ($in =~ /^(s)$/) {
                $num = $port;
                $port = $num;
                $key = $words->[$num];
                print "\n$key\n";
                $voice->();
            } elsif ($in =~ /^(\w+)$/) {
                $key = $1;
                if (exists($english{$key})) {
                    print "\nHere is '$key'. Write the answer.\n";
                    my $num_get = num_get($key, @words);
                    sub num_get {
                        my($str, @arr) = @_;
                        my $i = 0;
                        for (@arr) {
                            if($str eq $arr[$i]){
                                return $i;
                            } else {
                                $i++;
                            }
                        }
                    }
                    while (my $in2 = <>) {
                        if ($in2 =~ /^($quit)$/) {
                            print "$key($num_get): $english->{$key}\n$msg2\n";
                            last;
                        } elsif ($in2 =~ /^($english->{$key})$/) {
                            $point++;
                            $total = $point + $miss;
                            plural($total, $point, $miss);
                            print "\nGood!!\n$key($num_get): $english->{$key}\n\nYou tried $total $times. $point $hits and $miss $errors.\n$msg3\n";
                            last;
                        } else {
                            $miss++;
                            print "\nNG! '$key'\nAgain!\n";
                        }
                    }
                } else {
                    print "\nHere is not '$key'.\n$msg3\n";
                }
            } elsif ($in =~ /^([\W\D]+)$/) {
                print "\nPlease input a correct one.\nThis is random select.\n";
                my $random = int(rand($limit));
                $num = $random;
                $port = $num;
                $key = $words->[$num];
                print "\n$key\n";
                $voice->();
            } else {
                print "\nPlease input a correct one.\n";
            }
        }
    }
    sub score {
        return $point;
    }
    sub plural {
        ($times, $hits, $errors) = @_;
        unless ($times == 1) {
            $times = 'times';
        } else {
            $times = 'time';
        }
        unless ($point == 1) {
            $hits = 'hits';
        } else {
            $hits = 'hit';
        }
        unless ($miss == 1) {
            $errors = 'errors';
        } else {
            $errors = 'error';
        }
    }
}

1;
