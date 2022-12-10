#!/usr/bin/perl

use warnings;

my ($const, $last, $len)=(1, undef, 0);

for my $x(@ARGV)
{
	($const, $last, $len)
		=(
			($len==0 or $const and $last==$x),
			$x,
			$len+1
		);
}

print $const? '': 'не ', "постоянная\n";

