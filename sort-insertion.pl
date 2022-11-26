#!/usr/bin/perl

use warnings;

sub insertionSort
{
	for my $i(0..$#_)
	{
		for my $j(0..$i-1)
		{
			if($_[$j]>$_[$i])
			{
				while($j<$i)
				{
					@_[$i, $i-1]=@_[$i-1, $i];
					$i--;
				}
				last;
			}
		}
	}
	return @_;
}

print "$_\n" for insertionSort(@ARGV);
