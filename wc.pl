#!/usr/bin/perl

use warnings;

my ($linesTotal, $wordsTotal, $charsTotal)=(0, 0, 0);
my $fileCount=0;

for my $filename(@ARGV)
{
	unless(open $fd, '<', $filename)
	{
		warn "$0: Невозможно открыть файл «$filename»: $!\n";
		next;
	}

	my ($lines, $words, $chars)=(0, 0, 0);

	$fileCount++;

	my $flag=0;
	my $c;

	while(read $fd, $c, 1)
	{
		$chars++;

		$lines++ if $c eq "\n";

		if($c=~m/\s/)
		{
			$words++ if $flag;
			$flag=0;
		}
		else
		{
			$flag=1;
		}
	}

	$linesTotal+=$lines;
	$wordsTotal+=$words;
	$charsTotal+=$chars;

	print "$filename\t$lines\t$words\t$chars\n";
	close $fd;
}

print "\nВсего\t$linesTotal\t$wordsTotal\t$charsTotal\n" if $fileCount>1;

