#!/usr/bin/perl

use warnings;

my($maxcount, $max)=(0, -INFINITY);

for my $x(@ARGV)
{
	($maxcount, $max)
		=(
			$x<$max? $maxcount: $x==$max? $maxcount+1: 1,
			$x>$max? $x: $max
		);
}

print "$maxcount\n";
