#!/usr/bin/perl

use warnings;

sub solve
{
	my $b=pop @_;
	my @a=map {$_-1} @_;
	my @x;

	my $re='^';
	$re.="(Q*)\\$_\{".$a[$_-1].'}' for 1..@a;
	$re.='$';

	if(('Q' x $b)=~m/$re/)
	{
		push @x, length ${$_} for 1..@a;
	}
	return @x;
}

die "$0: Требуется несколько положительных чисел в командной строке!\n"
	unless(@ARGV);

die "$0: Не могу решить уравнение!\n" unless my @solution=solve(@ARGV);
print "@solution\n";

