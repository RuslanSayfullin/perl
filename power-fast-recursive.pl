#!/usr/bin/perl

use warnings;

sub power
{
	my ($x, $n)=@_;
	return 1 if $n==0;
	return $x if $n==1;
	return $x*power($x*$x, ($n-1)/2) if $n % 2;
	return power($x*$x, $n/2);
}

print power(@ARGV), "\n";

