#!/usr/bin/perl

use warnings;

sub nextPermutation($)
{
	my $p=shift;
	my $i=$#$p-1;
	$i-- while $i>=0 and $p->[$i]>$p->[$i+1];
	if($i>=0)
	{
		my $j=$i+1;
		$j++ while $j<$#$p and $p->[$j+1]>$p->[$i];
		@$p[$i, $j]=@$p[$j, $i];
		push @$p, reverse splice @$p, $i+1;
		return $p;
	}
	return;
}

my $n=shift;
die "$0: Нужно неотрицательное число!\n" unless defined($n) and $n>=0;

for(my $p=[1..$n]; defined $p; $p=nextPermutation($p))
{
	print "@$p\n";
}

