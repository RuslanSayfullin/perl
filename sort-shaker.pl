#!/usr/bin/perl

use warnings;

sub shakerSort
{
	my $left=0;
	my $right=$#_;

	while($left<$right)
	{
		my $lastSwap;

		for(my $i=$lastSwap=$left; $i<$right; $i++)
		{
			if($_[$i]>$_[$i+1])
			{
				@_[$i, $i+1]=@_[$i+1, $i];
				$lastSwap=$i;
			}
		}
		$right=$lastSwap;

		for(my $i=$lastSwap=$right; $i>$left; $i--)
		{
			if($_[$i]<$_[$i-1])
			{
				@_[$i, $i-1]=@_[$i-1, $i];
				$lastSwap=$i;
			}
		}
		$left=$lastSwap;
	}
	return @_;
}

print "$_\n" for shakerSort(@ARGV);
