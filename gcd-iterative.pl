#!/usr/bin/perl

use warnings;

sub gcd
{
	my ($x, $y)=@_;
	while($x)
	{
		($x, $y)=($y, $x) if $x>$y;
		$y-=$x;
	}
	return $y;
}

my $gcd=shift;

while(@ARGV)
{
	$gcd=gcd($gcd, shift);
}

print "$gcd\n";

