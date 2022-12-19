#!/usr/bin/perl

use warnings;

sub toRomanHelper($$)
{
	my $n=shift;
	my $d=shift;

	my $i=qw/I X C M/[$d];
	my $v=qw/V L D/[$d];
	my $x=qw/X C M/[$d];

	return $i x $n if $n>=0 and $n<=3;
	return ($i x (5-$n)).$v if $n==4;
	return $v.($i x ($n-5)) if $n>=5 and $n<=8;
	return $i.$x;
}

sub toRoman($)
{
	my $n=shift;
	return if $n!~m/^\d+$/ or $n>=4000;

	my $roman='';
	for(my $d=0; $n; $n=int($n/10))
	{
		$roman=toRomanHelper($n % 10, $d++).$roman;
	}
	return $roman;
}

##################################################

die "$0: Требуется натуральное число от 1 до 3999\n"
	unless defined(my $decimal=shift);
die "$0: Неправильное число: «$decimal»\n"
	unless defined(my $roman=toRoman($decimal));

print "$roman\n";
