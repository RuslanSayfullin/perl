#!/usr/bin/perl

use warnings;

sub gcd
{
	my ($x, $y)=@_;
	return $y unless $x;
	return ($x>=$y)? gcd($x-$y, $y): gcd($x, $y-$x);
}

my $gcd=shift;

while(@ARGV)
{
	$gcd=gcd($gcd, shift);
}

print "$gcd\n";
