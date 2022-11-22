#!/usr/bin/perl

use warnings;

my $n=shift or die "$0: Укажите число в командной строке\n";

my @primes=(2);

print "2\n" if $n>=2;

for(my $i=3; $i<=$n; $i+=2)
{
	my $flag=1;
	for my $j(@primes)
	{
		last if $j**2>$i;
		if($i % $j==0)
		{
			$flag=0;
			last;
		}
	}
	if($flag)
	{
		push @primes, $i;
		print "$i\n";
	}
}
