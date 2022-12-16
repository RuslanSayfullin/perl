#!/usr/bin/perl

use warnings;

my ($a, $b, $c, $d)=(1, 0, 0, 1);
my $n=1;

while()
{
	($a, $b, $c, $d)=($b, $a*$n**2+$b*2, $d, $c*$n**2+$d*2);
	($a, $b, $c, $d)=map { $_/$c } ($a, $b, $c, $d);
	$n+=2;
	print 4/($b/$d+1), "\n";
}
