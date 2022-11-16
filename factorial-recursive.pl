#!/usr/bin/perl

use warnings;

sub factorial
{
	my $n=shift;
	return 1 unless $n;
	return $n*factorial($n-1);
}

print factorial(shift @ARGV), "\n";

