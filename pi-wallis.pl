#!/usr/bin/perl

use warnings;

my $pi=2;
my $i=2;

while()
{
	print "$pi\n" unless $i % 1E5;
	$pi*=$i**2/($i-1)/($i+1);
	$i+=2;
}

