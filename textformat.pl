#!/usr/bin/perl

use warnings;
use utf8;
use Getopt::Long qw/:config no_ignore_case bundling/;
use IO::File;
use Encode;
use open IO=>':locale';
use open ':std';

sub help()
{
	STDERR->print(<<__HELP__);
textformat.pl ⟨опции⟩ ⟨файл⟩

⟨опции⟩:
	-w, --width ⟨число⟩
		ширина текста (75 по умолчанию)
	-o, --output-file ⟨файл⟩
		выходной файл
		(«-» означает стандартный вывод, по умолчанию)
	-h, --help
		показать эту подсказку

⟨файл⟩:
	входной файл
	(«-» означает стандартный ввод, по умолчанию)
__HELP__
	exit;
}

my $width=75;
my $outputFileName='-';

GetOptions
	(
		'w|width=i'=>\$width,
		'o|output-file=s'=>\$outputFileName,
		'h|help!'=>\&help,
	)
	or warn "Ошибка в опциях командной строки.\n\n" and help();

my $line='';
my $word='';
my $lastChar="\n";

my $inputFileName=shift//'-';

my $in=($inputFileName eq '-')? STDIN: IO::File->new($inputFileName, '<:utf8')
	or die "$0: Невозможно открыть файл «$inputFileName» для чтения: ",
		decode_utf8($!), "\n";
my $out=($outputFileName eq '-')? STDOUT: IO::File->new($outputFileName, '>:utf8')
	or die "$0: Невозможно открыть файл «$outputFileName» для записи: ",
		decode_utf8($!), "\n";

while(defined(my $char=$in->getc))
{
	if($lastChar eq "\n")
	{
		if($char eq "\n")
		{
			if($line eq '')
			{
				$out->print("\n");
			}
			else
			{
				$out->print("$line\n\n");
			}
			$line='';
		}
		elsif($char ne ' ')
		{
			$word.=$char;
		}
	}
	elsif($lastChar ne ' ')
	{
		if($char ne ' ' and $char ne "\n")
		{
			$word.=$char;
		}
		else
		{
			if($line eq '')
			{
				$line=$word;
			}
			elsif(length($line)+length($word)<$width)
			{
				$line.=" $word";
			}
			else
			{
				$out->print("$line\n");
				$line=$word;
			}
			$word='';
		}
	}
	else
	{
		$word=$char if $char ne ' ' and $char ne "\n";
	}
	$lastChar=$char;
}

$out->print("$line\n");

