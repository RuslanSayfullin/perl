#!/usr/bin/perl

use warnings;

my $s=0;
my $i=1;

while()
{
	print sqrt(6*$s), "\n" unless $i % 1E5;
	$s+=1/$i**2;
	$i++;
}

