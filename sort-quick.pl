#!/usr/bin/perl

use warnings;

sub recursiveSort
{
	return () unless @_;
	my $key=shift;
	my @left;
	my @right;
	for(@_)
	{
		if($_<$key)	{ push @left, $_; }
		else		{ push @right, $_; }
	}
	return (recursiveSort(@left), $key, recursiveSort(@right));
}

print "$_\n" for recursiveSort(@ARGV);

