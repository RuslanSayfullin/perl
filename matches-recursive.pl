#!/usr/bin/perl

use warnings;

sub matches
{
	my $t=shift;
	my $s=shift;

	if($s eq '')
	{
		if($t eq '')
		{
			return 1;
		}
		elsif(substr($t, 0, 1) eq '?')
		{
			return 0;
		}
		elsif(substr($t, 0, 1) eq '*')
		{
			return matches(substr($t, 1), $s);
		}
		elsif(substr($t, 0, 1) eq '[')
		{
			my $i=index $t, ']';
			if($i>0)
			{
				return 0;
			}
			else
			{
				die "Непарная открывающая квадратная скобка!\n";
			}
		}
		elsif(substr($t, 0, 1) eq ']')
		{
			die "Непарная закрывающая квадратная скобка!\n";
		}
		else
		{
			return 0;
		}
	}
	else
	{
		if($t eq '')
		{
			return 0;
		}
		elsif(substr($t, 0, 1) eq '?')
		{
			return matches(substr($t, 1), substr($s, 1));
		}
		elsif(substr($t, 0, 1) eq '*')
		{
			return (matches(substr($t, 1), $s)
					or matches($t, substr($s, 1)));
		}
		elsif(substr($t, 0, 1) eq '[')
		{
			my $i=index $t, ']';
			if($i>0)
			{
				my $chars=substr($t, 1, $i-1);
				return (index($chars, substr($s, 0, 1))>=0
						and matches(substr($t, $i+1), substr($s, 1)));
			}
			else
			{
				die "Непарная открывающая квадратная скобка!\n";
			}
		}
		elsif(substr($t, 0, 1) eq ']')
		{
			die "Непарная закрывающая квадратная скобка!\n";
		}
		else
		{
			return (substr($t, 0, 1) eq substr($s, 0, 1)
					and matches(substr($t, 1), substr($s, 1)));
		}
	}

}

print matches(@ARGV)? "Да\n": "Нет\n";

