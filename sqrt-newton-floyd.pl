#!/usr/bin/perl

use warnings;

my $a=shift;
my $t=my $h=(1+$a)/2;

while()
{
	$t=($t+$a/$t)/2;
	$h=($h+$a/$h)/2 for 0, 1;
	last if $t==$h;
}
print "$t\n";

