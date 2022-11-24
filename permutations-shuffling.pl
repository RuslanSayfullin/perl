#!/usr/bin/perl

use warnings;

sub nextShuffle($)
{
	my $shuffle=shift;
	for(my $i=1; $i<@$shuffle; $i++)
	{
		if($shuffle->[$i]<$i)
		{
			$shuffle->[$i]++;
			return $shuffle;
		}
		else
		{
			$shuffle->[$i]=0;
		}
	}
	return;
}

my $n=shift;
die "$0: Нужно неотрицательное число!\n" unless defined($n) and $n>=0;

for(my $shuffle=[(0) x $n]; defined $shuffle; $shuffle=nextShuffle($shuffle))
{
	my @p=(1..$n);
	@p[$_, $shuffle->[$_]]=@p[$shuffle->[$_], $_] for 0..$n-1;
	print "@p\n";
}

