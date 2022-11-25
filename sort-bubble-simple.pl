#!/usr/bin/perl

use warnings;

sub bubbleSort
{
	my $right=$#_;
	while($right)
	{
		for(my $i=0; $i<$right; $i++)
		{
			@_[$i, $i+1]=@_[$i+1, $i] if $_[$i]>$_[$i+1];
		}
		$right--;
	}
	return @_;
}

print "$_\n" for bubbleSort(@ARGV);
