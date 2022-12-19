#!/usr/bin/perl

use warnings;

my $n=shift or die "$0: Укажите число в командной строке\n";

for(2..$n)
{
	print "$_\n" if $_ % 2 and ('Q' x $_)!~m/^(QQ+?)\1+$/ or $_==2;
}

