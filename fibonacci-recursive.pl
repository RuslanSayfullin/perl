#!/usr/bin/perl

use warnings;

sub fibonacci
{
	my $n=shift;
	return $n<2? $n: fibonacci($n-1)+fibonacci($n-2);
}

print fibonacci(shift), "\n";
