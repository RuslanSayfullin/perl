#!/usr/bin/perl

use warnings;

sub bubbleEnhancedSort
{
	my $right=$#_;
	while($right)
	{
		my $lastSwap=0;
		for(my $i=0; $i<$right; $i++)
		{
			if($_[$i]>$_[$i+1])
			{
				@_[$i, $i+1]=@_[$i+1, $i];
				$lastSwap=$i;
			}
		}
		$right=$lastSwap;
	}
	return @_;
}

print "$_\n" for bubbleEnhancedSort(@ARGV);

