#!/usr/bin/perl

use warnings;

my @t;
push @t, [split ' '] for <STDIN>;

my $max=-INFINITY;
for my $x(0..2**@t-1)
{
	my $sum=0;
	my $i=0;
	for my $j(0..$#t)
	{
		$sum+=$t[$j][$i];
		$i+=$x % 2;
		$x=int($x/2);
	}
	$max=$sum if $sum>$max;
}
print "$max\n";
