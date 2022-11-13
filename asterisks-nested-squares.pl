#!/usr/bin/perl

use warnings;

my $n=shift // die "Нужно неотрицательное число!\n";

my $d;
for my $j(0..$n-1)
{
	for my $i(0..$n-1)
	{
		$d=$j;
		$d=$i if $i<$d;
		$d=$n-$j-1 if $n-$j-1<$d;
		$d=$n-$i-1 if $n-$i-1<$d;
		print($d%2? ' ': '*');
	}
	print "\n";
}

