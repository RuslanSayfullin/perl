#!/usr/bin/perl

use warnings;

my ($sigma2, $sum)=(0, 0);

for my $x(@ARGV)
{
	($sigma2, $sum)=($sigma2+$x*$sum, $sum+$x);
}

print "$sigma2\n";

