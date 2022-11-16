#!/usr/bin/perl

use warnings;

sub factorial
{
	return $_[0]? $_[0]*factorial($_[0]-1): 1;
}

print factorial(shift @ARGV), "\n";

