#!/usr/bin/perl

use warnings;

my @s=(0);

while(<STDIN>)
{
	my @r=split ' ';
	$r[$_]+=$s[$s[$_-1]>$s[$_]? $_-1: $_] for 1..$#r-1;
	$r[$_]+=$s[$_] for -1, 0;
	@s=@r;
}

my $max=-INFINITY;
for(@s)
{
	$max=$_ if $_>$max;
}
print "$max\n";
