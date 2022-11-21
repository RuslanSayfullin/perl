#!/usr/bin/perl

use warnings;

for my $n(@ARGV)
{
	print "$n:";

	my $k=2;
	while($k<=$n)
	{
		if($n % $k==0)
		{
			print " $k";
			$n/=$k;
		}
		else
		{
			$k+=($k==2)? 1: 2;
		}
	}

	print "\n";
}

