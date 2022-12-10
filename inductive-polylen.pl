#!/usr/bin/perl

use warnings;

my ($polylen, $lastx, $lasty, $len)=(0, undef, undef, 0);

while(<STDIN>)
{
	chomp;
	my ($x, $y)=split /\s+/;
	($polylen, $lastx, $lasty, $len)
		=(
			$len? $polylen+sqrt(($x-$lastx)**2+($y-$lasty)**2): 0,
			$x,
			$y,
			$len+1
		);
}

print "$polylen\n";

