#!/usr/bin/perl

use warnings;

my $a=shift;

my $tleft=my $hleft=0;
my $tright=my $hright=(1+$a)/2;
my ($tmid, $hmid);

while()
{
	$tmid=($tleft+$tright)/2;
	($tmid**2<$a? $tleft: $tright)=$tmid;

	for(0, 1)
	{
		$hmid=($hleft+$hright)/2;
		($hmid**2<$a? $hleft: $hright)=$hmid;
	}

	last if $tmid==$hmid;
}

print "$tmid\n";
