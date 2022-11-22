#!/usr/bin/perl

use warnings;

my $n=shift or die "$0: Укажите число в командной строке\n";

my @primes=(2, 3, 5, 7);

my $wheelSize=1;
$wheelSize*=$_ for @primes;

my @wheel;
	
outer: for my $n(2..$wheelSize+1)
{
	for my $p(@primes)
	{
		next outer unless $n % $p;
	}
	push @wheel, $n;
}

sub isPrime
{
	my $k=shift;
	for(@primes)
	{
		return 1 if $k==$_;
		return 0 unless $k % $_;
	}

	my @w=@wheel;
	while()
	{
		my $s=shift @w;
		return 1 if $s**2>$k;
		return 0 unless $k % $s;
		push @w, $s+$wheelSize;
	}
}

for(2..$n)
{
	print "$_\n" if isPrime($_);
}
