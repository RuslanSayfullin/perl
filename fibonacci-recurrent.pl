#!/usr/bin/perl

use warnings;

my $n=shift;
my ($a, $b)=(0, 1);

($a, $b)=($b, $a+$b) while $n--;
print "$a\n";

