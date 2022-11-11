#!/usr/bin/perl

use warnings;

if(@ARGV==2 or @ARGV==3)
{
	$from=shift;
	$to=pop;
	$step=@ARGV? shift: 1;
}
else
{
	die "Должно быть два или три числовых параметра!\n";
}

for($i=$from; ($step>0)? $i<=$to: $i>=$to; $i+=$step)
{
	print "$i\n";
}
