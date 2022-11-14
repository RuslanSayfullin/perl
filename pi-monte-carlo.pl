#!/usr/bin/perl

use warnings;

my $i=my $j=0;

while()
{
	$i++;
	$j++ if rand()**2+rand()**2<1;
	print 4*$j/$i, "\n" unless $i % 1E5;
}

