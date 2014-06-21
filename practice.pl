#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Carvo;

my $msg = "Input (e|j|e2|j2|q).";
print "$msg\n";

while (my $in = <>) {
    if ($in =~ /^(q)$/) {
        print "Your score is $Carvo::point pt!\nBye bye!\n";
        last;
    } elsif ($in =~ /^(e|e2|j|j2|\n)$/) {
        Carvo::tutor(Generator::switch("$1"));
    } else {
        print "Please input a correct one.\n";
    }
}
