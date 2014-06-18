#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Carvo;

my $msg = "Input (e|j|e2|j2|q).\n";
print "$msg\n";

while (my $in = <>) {
    if ($in =~ /^(q)$/) {
        print "Bye bye!\n";
        last;
    } elsif ($in =~ /^(e|e2|j|j2|\n)$/) {
        Carvo::tutor(Generator::switch("$1"));
    } else {
        print "Please input a correct one.\n";
    }
}
