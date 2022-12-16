#!/usr/bin/perl

use warnings;

my @t;
push @t, [split ' '] for <STDIN>;
my @m;

sub maxsum
{
	my ($j, $i)=@_;
	return -INFINITY if $i<0 or $i>$j;
	return $t[0][0] unless $j;
	return $m[$j][$i] if defined $m[$j][$i];
	#print "($j $i)\n";
	my $a=maxsum($j-1, $i-1);
	my $b=maxsum($j-1, $i);
	return $m[$j][$i]=$t[$j][$i]+($a>$b? $a: $b);
}

my $max=-INFINITY;
for my $i(0..$#t)
{
	my $sum=maxsum($#t, $i);
	$max=$sum if $sum>$max;
}
print "$max\n";
