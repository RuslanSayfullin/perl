#!/usr/bin/perl

use warnings;

my $n=shift // die "Нужно неотрицательное число!\n";

for(1..$n)
{
	for(1..$n)
	{
		print '*';
	}
	print "\n";
}

