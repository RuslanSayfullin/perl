#!/usr/bin/perl

use warnings;
use Capsule;

sub resistance
{
	my (@I, @U);

	for my $i(0..$#_)
	{
		$I[$i]=Capsule->new;
		$U[$_]//=Capsule->new for @{$_[$i]}[0, 1];
	}

	Capsule::equation(1, $U[0], 0);

	for my $i(0..$#I)
	{
		Capsule::equation(-1, $U[$_[$i][0]], 1, $U[$_[$i][1]], -$_[$i][2], $I[$i], 0);
	}

	for my $u(0..$#U)
	{
		my @equation=();
		for my $i(0..$#I)
		{
			if($_[$i][0]==$u)
			{
				push @equation, -1, $I[$i];
			}
			elsif($_[$i][1]==$u)
			{
				push @equation, 1, $I[$i];
			}
		}
		if($u==0)
		{
			push @equation, 1;
		}
		elsif($u==1)
		{
			push @equation, -1;
		}
		else
		{
			push @equation, 0;
		}
		Capsule::equation(@equation);
	}
	return $U[1]->value;
}

open my $circuitFile, '<', shift;
print resistance(map { chomp; [split /\s+/] } <$circuitFile>), "\n";
close $circuitFile;

