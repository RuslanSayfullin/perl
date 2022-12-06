#!/usr/bin/perl

use warnings;

my ($sum, $avg)=(0, 1);

for my $x(@ARGV)
{
	($avg, $sum)=($avg*($sum+$x)/($sum+$avg), $sum+$x);
}

print "$avg\n";

