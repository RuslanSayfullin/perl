#!/usr/bin/perl

use warnings;

my ($sum, $len)=(0, 0);

for my $x(@ARGV)
{
	($sum, $len)=($sum+$x, $len+1);
}

my $avg=NAN;	# любое значение
$avg=$sum/$len if $len;

print "$avg\n";
