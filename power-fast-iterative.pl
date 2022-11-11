#!/usr/bin/perl

use warnings;

my ($x, $n)=@ARGV;

my $p=1;

while($n)
{
	if($n % 2)
	{
		$p*=$x;
		$n--;
	}
	$n/=2;
	$x*=$x;
}

print "$p\n";
