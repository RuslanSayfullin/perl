#!/usr/bin/perl

use warnings;

push @ARGV, '' unless @ARGV;

for my $fileName(@ARGV)
{
	my $file;
	if($fileName eq '')
	{
		$file=STDIN;
	}
	else
	{
		unless(open $file, '<', $fileName)
		{
			warn "Невозможно открыть файл «$fileName»: $!\n";
			next;
		}
	}
	print while read $file, $_, 4096;
	close $file or warn "Невозможно закрыть файл «$fileName»: $!\n";
}
