#!/usr/bin/perl

use warnings;

sub shuffle
{
	my %randoms;
	for(@_)
	{
		my $rand;
		do
		{
			$rand=rand;
		}
		while(exists $randoms{$rand});
		$randoms{$rand}=$_;
	}
	return @randoms{sort { $a<=>$b } keys %randoms};
}

print "$_\n" for shuffle(@ARGV);

