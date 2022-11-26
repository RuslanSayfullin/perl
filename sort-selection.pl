#!/usr/bin/perl

use warnings;

sub selectionSort
{
	for my $i(0..$#_-1)
	{
		my $k=$i;
		for my $j($i+1..$#_)
		{
			$k=$j if $_[$k]>$_[$j];
		}
		@_[$i, $k]=@_[$k, $i];
	}
	return @_;
}

print "$_\n" for selectionSort(@ARGV);
