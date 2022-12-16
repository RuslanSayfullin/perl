#!/usr/bin/perl

use warnings;

my @t;
push @t, [split ' '] for <STDIN>;

sub maxsum
{
	my ($j, $i)=@_;
	return -INFINITY if $i<0 or $i>$j;
	#print "($j $i)\n";
	return $t[0][0] unless $j;
	my $a=maxsum($j-1, $i-1);
	my $b=maxsum($j-1, $i);
	return $t[$j][$i]+($a>$b? $a: $b);
}

my $max=-INFINITY;
for my $i(0..$#t)
{
	my $sum=maxsum($#t, $i);
	$max=$sum if $sum>$max;
}
print "$max\n";

