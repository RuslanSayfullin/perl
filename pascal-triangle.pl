#!/usr/bin/perl

use warnings;

my $n=shift or die "$0: Нужно целое положительное число!\n";

my @a=(1);

for(1..$n)
{
	print join("\t", @a), "\n";
	unshift @a, 0;
	for(my $i=0; $i<@a-1; $i++)
	{
		$a[$i]+=$a[$i+1];
	}
}

