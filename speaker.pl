#!/usr/bin/perl

use warnings;

sub speakFile($$)
{
	my $mpv=shift;
	open my $file, '<:utf8', shift;
	my $query='';
	while(my $line=<$file>)
	{
		chomp $line;
		while($line=~m/(\p{L}+)/g)
		{
			if(length($query)+length($1)<100)
			{
				$query.=' ' if $query;
				$query.=$1;
			}
			else
			{
				speakWords($mpv, $query);
				$query=$1;
			}
		}
	}
	speakWords($mpv, $query) if $query;
}

sub speakWords($$)
{
	my $mpv=shift;
	my $text=urlEncode(shift);
	$mpv->print("http://translate.google.com/translate_tts?client=tw-ob&tl=ru&ie=UTF-8&q=$text\n");
}

sub urlEncode($)
{
	my $text=shift;
	utf8::encode($text);
	my $result;
	for(split //, $text)
	{
		if(m/\w/)
		{
			$result.=$_;
		}
		elsif($_ eq ' ')
		{
			$result.='+';
		}
		else
		{
			$result.=sprintf('%%%2X', ord);
		}
	}
	return $result;
}

open my $mpv, '|-', 'mpv --really-quiet --gapless-audio -playlist=-';
speakFile($mpv, $_) for @ARGV;
close $mpv;
