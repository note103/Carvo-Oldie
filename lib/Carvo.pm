#!/usr/bin/env perl
use strict;
use warnings;
use Carvo::Generator;

package Carvo {
    sub tutor {
        my $english = shift;
        my %english = %$english;
        my @words = sort (keys %english);
        my $words = \@words;
        my $quit = 'q|d|\n';
        my ($key, $num);
        my $port = 0;
        my $count = @words;
        my $limit = $count - 1;
        print "The biggest number is $limit.\n";
        my $voice = sub {
            while (my $in2 = <>) {
                if ($in2 =~ /^($quit)$/) {
                    print "$key($num): $english->{$key}\nNext!\n";
                    last;
                } elsif ($in2 =~ /^($english->{$key})$/) {
                    print "Good!!\n$key($num): $english->{$key}\nKeep at it!\n";
                    last;
                } else {
                    print "NG! '$words->[$num]'\nAgain!\n";
                }
            }
        };

        while (my $in = <>) {
            if ($in =~ /^(q|d)$/) {
                print "Bye!\n";
                last;
            } elsif ($in =~ /^(\d+)$/) {
                $num = $1;
                $port = $num;
                if ($in > $limit) {
                    print "Too big number! More small!\n";
                    next;
                } else {
                    $key = $words->[$num];
                    print "$key\n";
                    $voice->();
                }
            } elsif ($in =~ /^(n|\n)$/) {
                if ($port >= $limit) {
                    print "Too big number! More small!\n";
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
                    print "Here is '$key'. What's mean in Japanese?\n";
                    while (my $in2 = <>) {
                        if ($in2 =~ /^($quit)$/) {
                            print "$key: $english->{$key}\nNext!\n";
                            last;
                        } elsif ($in2 =~ /^($english->{$key})$/) {
                            print "Good!!\n$key: $english->{$key}\nKeep at it!\n";
                            last;
                        } else {
                            print "NG! '$key'\nAgain!\n";
                        }
                    }
                } else {
                    print "Here is not '$key'. Next!\n";
                }
            } else {
                print "Please input a number or a correct keyword.\n";
            }
        }
    }
}

1;