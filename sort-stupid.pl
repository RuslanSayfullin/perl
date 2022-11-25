#!/usr/bin/perl

use warnings;

sub stupidSort
{
	my $flag=1;
	while($flag)
	{
		for(my $i=0; $i<@_-1; $i++)
		{
			if($_[$i]>$_[$i+1])
			{
				@_[$i, $i+1]=@_[$i+1, $i];
				last;
			}
		}
		$flag=0;
	}
	return @_;
}

print "$_\n" for stupidSort(@ARGV);
