#!/usr/bin/perl

use warnings;
use utf8;

sub permutations
{
	return ([]) unless my $n=shift;
	my @permutations;
	for(permutations($n-1))
	{
		for(my $i=0; $i<$n; $i++)
		{
			my @p=@$_;
			splice @p, $i, 0, $n;
			push @permutations, \@p;
		}
	}
	return @permutations;
}

my $n=shift;
die "$0: Нужно неотрицательное число!\n" unless defined($n) and $n>=0;

print "@$_\n" for permutations($n);

