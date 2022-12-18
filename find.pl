#!/usr/bin/perl

use warnings;

sub find($);
sub find($)
{
	my $name=shift;
	if(-d $name)
	{
		my $dir;
		unless(opendir $dir, $name)
		{
			warn "$0: Невозможно открыть «$name»: $!\n";
			return;
		}
		print "$name\n";
		$name='' if $name eq '/';
		for(readdir $dir)
		{
			next if $_ eq '.' or $_ eq '..';
			find("$name/$_");
		}
		closedir $dir;
	}
	elsif(-f $name)
	{
		print "$name\n";
	}
	else
	{
		warn "$0: «$name»: $!\n";
	}
}

find($_) for @ARGV;
find('.') unless @ARGV;

