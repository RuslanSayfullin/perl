#!/usr/bin/perl

use warnings;

my $prev;

while(<STDIN>)
{
	print if not defined $prev or $_ ne $prev;
	$prev=$_;
}
