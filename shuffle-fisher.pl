#!/usr/bin/perl

use warnings;

sub fisherShuffle
{
	for(my $i=$#_; $i>0; $i--)
	{
		my $j=int(rand($i+1));
		@_[$i, $j]=@_[$j, $i];
	}
	return @_;
}

print "$_\n" for fisherShuffle(@ARGV);

