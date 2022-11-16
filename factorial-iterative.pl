#!/usr/bin/perl

use warnings;

my $n=shift;
my $f=1;

for($i=2; $i<=$n; $i++)
{
	$f*=$i;
}

print "$f\n";

