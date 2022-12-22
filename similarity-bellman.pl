#!/usr/bin/perl

use warnings;

sub levenshtein
{
	my ($a, $b)=@_;

	my @bellman;
	my $la=length $a;
	my $lb=length $b;

	$bellman[$_][0]=$_ for 0..$la;
	$bellman[0][$_]=$_ for 0..$lb;

	for my $j(1..$lb)
	{
		for my $i(1..$la)
		{
			$bellman[$i][$j]=$bellman[$i-1][$j]+1;
			$bellman[$i][$j]=$bellman[$i][$j-1]+1
				if $bellman[$i][$j]>$bellman[$i][$j-1]+1;

			if(substr($a, $i-1, 1) eq substr($b, $j-1, 1))
			{
				$bellman[$i][$j]=$bellman[$i-1][$j-1]
					if $bellman[$i][$j]>$bellman[$i-1][$j-1];
			}
		}
	}
	return $bellman[$la][$lb];
}

my ($a, $b)=@ARGV;
utf8::decode($_) for $a, $b;
print 1-levenshtein($a, $b)/(length($a)+length($b)), "\n";

