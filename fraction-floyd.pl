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

# первый этап
my $t=my $h=$p;
do
{
	$t=(10*$t) % $q;
	$h=(10*$h) % $q for 0, 1;
}
until($t==$h);

# второй этап
$t=$p;
until($t==$h)
{
	print int(10*$t/$q);
	$t=(10*$t) % $q;
	$h=(10*$h) % $q;
}

# третий этап
if($h)
{
	print '(';
	do
	{
		print int(10*$h/$q);
		$h=(10*$h) % $q;
	}
	until($t==$h);
	print ')';
}

print "\n";

