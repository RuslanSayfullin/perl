#!/usr/bin/perl

use warnings;

my $n=shift or die "$0: Укажите число в командной строке\n";

my @sieve=2..$n;

while(@sieve)
{
	while(@sieve and $sieve[0]==0)
	{
		shift @sieve;
	}
	last unless @sieve;
	print my $p=shift @sieve, "\n";
	for(my $i=$p-1; $i<@sieve; $i+=$p)
	{
		$sieve[$i]=0;
	}
}

