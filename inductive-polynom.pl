#!/usr/bin/perl

use warnings;

my $t=shift;
my ($polynom, $len)=(0, 0);

for my $x(@ARGV)
{
	($polynom, $len)=($polynom+$x*$t**$len, $len+1);
}

print "$polynom\n";

