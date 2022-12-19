#!/usr/bin/perl

use warnings;

sub parseRomanHelper($$)
{
	my $fragment=shift;
	return 0 unless $fragment;
	my $d=shift;

	if($d==1)
	{
		$fragment=~tr/XLC/IVX/;
	}
	elsif($d==2)
	{
		$fragment=~tr/CDM/IVX/;
	}
	elsif($d==3)
	{
		$fragment=~tr/M/I/;
	}

	$d=10**$d;
	return $d*length($fragment) if $fragment=~m/^I{1,3}$/;
	return $d*4 if $fragment eq 'IV';
	return $d*(4+length($fragment)) if $fragment=~m/^VI{0,3}$/;
	return $d*9;
}

sub parseRoman($)
{
	if(shift=~m/^(M{0,3})(D?C{0,3}|C[DM])(L?X{0,3}|X[LC])(V?I{0,3}|I[VX])$/)
	{
		return parseRomanHelper($1, 3)
			+parseRomanHelper($2, 2)
			+parseRomanHelper($3, 1)
			+parseRomanHelper($4, 0);
	}
	return;
}

##################################################

die "$0: Требуется римское число\n"
	unless defined(my $roman=shift);
die "$0: Неправильное римское число: «$roman»\n"
	unless defined(my $decimal=parseRoman($roman));

print "$decimal\n";

