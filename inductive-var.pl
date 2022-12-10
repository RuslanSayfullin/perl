#!/usr/bin/perl

use warnings;

my ($sumsq, $sum, $len)=(0, 0, 0);

for my $x(@ARGV)
{
	($sumsq, $sum, $len)=($sumsq+$x**2, $sum+$x, $len+1);
}

my $var=NAN;	# любое значение
$var=$sumsq/$len-($sum/$len)**2 if $len;

print "$var\n";
