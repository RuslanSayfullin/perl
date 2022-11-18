#!/usr/bin/perl

use warnings;

my @fibonacci;

sub fibonacci
{
	my $n=shift;
	return $fibonacci[$n] if defined $fibonacci[$n];
	return $fibonacci[$n]=$n<2? $n: fibonacci($n-1)+fibonacci($n-2);
}

print fibonacci(shift), "\n";
