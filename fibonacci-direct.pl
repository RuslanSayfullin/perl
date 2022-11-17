#!/usr/bin/perl

use warnings;

my $sqrt5=sqrt(5);
my $phi=(1+$sqrt5)/2;

my $n=shift;
my $f=$phi**$n/$sqrt5;
if($f<int($f)+.5)
{
	$f=int($f);
}
else
{
	$f=1+int($f);
}
print "$f\n";
