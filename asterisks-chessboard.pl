#!/usr/bin/perl

use warnings;

my $n=shift // die "Нужно неотрицательное число!\n";

for my $j(0..$n-1)
{
	for my $i(0..$n-1)
	{
		print((($i+$j)%2)? ' ': '*');
	}
	print "\n";
}
