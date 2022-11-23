#!/usr/bin/perl

use warnings;

my ($p, $q)=split '/', shift;

print int($p/$q);

if($p %= $q)
{
	print ',';
}
else
{
	print "\n";
	exit;
}

my @p;
while()
{
	for(my $i=0; $i<@p; $i++)
	{
		if($p==$p[$i])
		{
			print for map { int(10*$_/$q) } @p[0..$i-1];
			if($p)
			{
				print '(';
				print for map { int(10*$_/$q) } @p[$i..$#p];
				print ')';
			}
			print "\n";
			exit;
		}
	}
	push @p, $p;
	$p=(10*$p) % $q;
}

