#!/usr/bin/perl

use warnings;

my $s=0;
my $i=0;

while()
{
	print 4*$s, "\n" unless $i % 1E5;
	$s+=((-1)**$i)/(2*$i+1);
	$i++;
}
