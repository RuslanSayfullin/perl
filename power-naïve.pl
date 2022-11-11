#!/usr/bin/perl

use warnings;

my ($x, $n)=@ARGV;

my $p=1;
$p*=$x while $n--;

print "$p\n";

