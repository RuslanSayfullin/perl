#!/usr/bin/perl

use warnings;

my ($len, $avg)=(0, 0);

for my $x(@ARGV)
{
	($avg, $len)=(($avg*$len+$x)/($len+1), $len+1);
}

print "$avg\n";
