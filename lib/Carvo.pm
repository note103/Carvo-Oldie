#!/usr/bin/env perl
use strict;
use warnings;
use Carvo::Generator;

package Carvo {
    our $point = 0;
    sub tutor {
        my $english = shift;
        my %english = %$english;
        my @words = sort (keys %english);
        my $words = \@words;
        my $quit = 'q|\n';
        my ($key, $num);
        my $port = 0;
        my $count = @words;
        my $limit = $count - 1;
        my $msg1 = 'Input (a number|a word|r[andom]|q[uit]).';
        my $msg2 = 'Input (a number|a word|r[andom]|enter[next]|q[uit]).';
        my $msg3 = 'Input (a number|a word|r[andom]|s[ame]|enter[next]|q[uit]).';
        my $msg4 = 'Input (e|j|e2|j2|q).';
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
                    print "\nGood!!\n$key($num): $english->{$key}\n\nYou got $point pt!\n$msg3\n";
                    last;
                } else {
                    print "\nNG! '$words->[$num]'\nAgain!\n";
                }
            }
        };

        while (my $in = <>) {
            if ($in =~ /^(q)$/) {
                print "Bye!\n$msg4\n";
                last;
            } elsif ($in =~ /^0$/) {
                print "$msg5\n";
            } elsif ($in =~ /^(\d+)$/) {
                $num = $1;
                $port = $num;
                if ($in > $limit) {
                    print "$msg6\n$msg1\n";
                    next;
                } else {
                    $key = $words->[$num];
                    print "$key\n";
                    $voice->();
                }
            } elsif ($in =~ /^(n|\n)$/) {
                if ($port >= $limit) {
                    print "$msg6\n$msg1\n";
                    next;
                } else {
                    $num = $port+1;
                    $port = $num;
                    $key = $words->[$num];
                    print "$key\n";
                    $voice->();
                }
            } elsif ($in =~ /^(r)$/) {
                my $random = int(rand($limit));
                $num = $random;
                $port = $num;
                $key = $words->[$random];
                print "$key\n";
                $voice->();
            } elsif ($in =~ /^(s)$/) {
                $num = $port;
                $port = $num;
                $key = $words->[$num];
                print "$key\n";
                $voice->();
            } elsif ($in =~ /^(\w+)$/) {
                $key = $1;
                if (exists($english{$key})) {
                    print "Here is '$key'. Write the answer.\n";
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
                            print "\nGood!!\n$key($num_get): $english->{$key}\n\nYou got $point pt!\n$msg3\n";
                            last;
                        } else {
                            print "\nNG! '$key'\nAgain!\n";
                        }
                    }
                } else {
                    print "Here is not '$key'.\n$msg3\n";
                }
            } else {
                print "Please input a correct one.\n";
            }
        }
    }
    sub score {
        return $point;
    }
}

1;
