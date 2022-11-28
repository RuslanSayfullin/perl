#!/usr/bin/perl

use warnings;

my $a=shift;
my $x=(1+$a)/2;
my $y=0;

while()
{
	$y=$x;
	$x=($x+$a/$x)/2;
	last if $x>=$y;
}
print "$x\n";

