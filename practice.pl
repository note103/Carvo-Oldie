#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Carvo;

print "Input 'e' or 'j' or 'e2' or 'j2'.\n";

while (my $in = <>) {
    if ($in =~ /^(q|d)$/) {
        print "Bye bye!\n";
        last;
    } elsif ($in =~ /^(e|e2|j|j2|\n)$/) {
        Carvo::tutor(Generator::switch("$1"));
    } else {
        print "Please input a correct one.\n";
    }
}
