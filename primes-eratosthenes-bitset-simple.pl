#!/usr/bin/perl

use warnings;
use BitSetSimple;

my $n=shift or die "Укажите число в командной строке\n";

my $sieve=BitSetSimple->new;
for(my $i=2; $i<=$n; $i++)
{
	$sieve->add($i);
}

for(my $p=2; $p<=$n; $p++)
{
	while(not $sieve->isMember($p) and $p<=$n)
	{
		$p++;
	}
	last if $p>$n;
	print "$p\n";
	for($i=2*$p; $i<=$n; $i+=$p)
	{
		$sieve->delete($i);
	}
}
