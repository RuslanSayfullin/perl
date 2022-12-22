#!/usr/bin/perl

use warnings;

sub matches
{
	my $template=shift;
	my $string=shift;

	my $re='';
	for(split '', $template)
	{
		if($_ eq '*')
		{
			$re.='.*';
		}
		elsif($_ eq '?')
		{
			$re.='.';
		}
		elsif(m/[\w\[\]]/)
		{
			$re.=$_;
		}
		else
		{
			$re.="\\$_";
		}
	}
	return $string=~m/^$re$/;
}

print matches(@ARGV)? "Да\n": "Нет\n";

