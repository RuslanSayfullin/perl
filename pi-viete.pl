#!/usr/bin/perl

use warnings;

my ($pi, $d)=(2, 0);

#my $i=1;
while()
{
	print "$pi\n";# unless $i++ % 1E5;
	$d=sqrt(2+$d);
	$pi*=2/$d;
}
