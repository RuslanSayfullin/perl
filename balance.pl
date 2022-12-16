#!/usr/bin/perl

use warnings;

my $brackets='()[]{}';
my $charStack='';

my $char;
while(read STDIN, $char, 1)
{
	my $type=index($brackets, $char);
	next if $type==-1;
	unless($type % 2)
	{
		$charStack.=$char;
	}
	else
	{
		die "$0: Баланс нарушен: непарная закрывающая скобка\n"
			unless length $charStack
				and index($brackets, (chop $charStack).$char)>=0
	}
}

die "$0: Баланс нарушен: непарная открывающая скобка\n" if length $charStack;

