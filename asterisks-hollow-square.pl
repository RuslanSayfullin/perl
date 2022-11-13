#!/usr/bin/perl

use warnings;

my $n=shift // die "Нужно неотрицательное число!\n";

print '*' x $n, "\n" if $n;

for(1..$n-2)
{
	print '*', ' ' x ($n-2), "*\n";
}

print '*' x $n, "\n" if $n>1;

