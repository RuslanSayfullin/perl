#!/usr/bin/perl

use warnings;

sub levenshtein
{
	my ($a, $b)=@_;
	my $la=length $a;
	my $lb=length $b;

	my @agenda=([0, 0, 0]);
	my $result=INFINITY;

	while(@agenda)
	{
		my ($i, $j, $cost)=@{pop @agenda};
		if($i==$la or $j==$lb)
		{
			$result=$cost+$la+$lb-$i-$j
				if $cost+$la+$lb-$i-$j<$result;
			next;
		}
		if(substr($a, $i, 1) eq substr($b, $j, 1))
		{
			push @agenda, [$i+1, $j+1, $cost];
		}
		else
		{
			push @agenda, [$i+1, $j, $cost+1], [$i, $j+1, $cost+1];
		}
	}
	return $result;
}

my ($a, $b)=@ARGV;
utf8::decode($_) for $a, $b;
print 1-levenshtein($a, $b)/(length($a)+length($b)), "\n";
