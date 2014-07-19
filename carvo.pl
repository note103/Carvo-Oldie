#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Carvo;

my $msg = "
    Select a number of courses from 1 to 4.\n
    1: English question & Japanese answer - Short version
    2: English question & Japanese answer - Large version
    3: Japanese question & English answer - Short version
    4: Japanese question & English answer - Large version
    q: Exit";

print "$msg\n\n";

while (my $in = <>) {
    if ($in =~ /^(q)$/) {
        print "
    Total score:
    $Carvo::total $Carvo::times
    $Carvo::point $Carvo::hits
    $Carvo::miss $Carvo::errors\n\nBye bye!\n\n";
        last;
    } elsif ($in =~ /^([1-4]|\n)$/) {
        Carvo::tutor(Generator::switch("$1"));
    } else {
        print "Please input a correct one.\n";
    }
}
