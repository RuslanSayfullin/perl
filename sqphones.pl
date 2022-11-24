#!/usr/bin/perl

use warnings;

sub sqPhones
{
	my $n=shift;
	return ('') unless $n;
	my @sqPhones;

	for(my $i=0; (my $h=length(my $head=$i**2))<=$n; $i++)
	{
		for my $tail(sqPhones($n-$h))
		{
			$tail="-$tail" if $h<$n;
			push @sqPhones, $head.$tail;
		}
	}
	return @sqPhones;
}

print "$_\n" for sqPhones(shift);

