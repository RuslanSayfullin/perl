#!/usr/bin/perl

use warnings;

sub levenshtein
{
	my ($a, $b)=@_;
	if(length($a) and length($b))
	{
		if(substr($a, 0, 1) eq substr($b, 0, 1))
		{
			return levenshtein(substr($a, 1), substr($b, 1));
		}
		else
		{
			my $da=levenshtein(substr($a, 1), $b);
			my $db=levenshtein($a, substr($b, 1));
			return 1+($da<$db? $da: $db);
		}
	}
	else
	{
		return length($a)||length($b);
	}
}

my ($a, $b)=@ARGV;
utf8::decode($_) for $a, $b;
print 1-levenshtein($a, $b)/(length($a)+length($b)), "\n";
