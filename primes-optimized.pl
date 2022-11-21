#!/usr/bin/perl

use warnings;

my $n=shift or die "$0: Укажите число в командной строке\n";

print "2\n" if $n>=2;

for(my $i=3; $i<=$n; $i+=2)
{
	my $flag=1;
	for(my $j=3; $j**2<=$i; $j+=2)
	{
		if($i % $j==0)
		{
			$flag=0;
			last;
		}
	}
	print "$i\n" if $flag;
}

