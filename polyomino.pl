#!/usr/bin/perl

use warnings;
package Polyomino;
use utf8;

sub new($)
{
	my $class=shift;
	my $string=shift;
	return bless \$string, $class;
}

sub canonize()
{
	my $self=shift;
	my $str=my $strMin=$$self;
	for(1..$self->perimeter)
	{
		$str=~s/^(.)(.*)$/$2$1/;
		for(1..4)
		{
			$str=~tr/RULD/ULDR/;
			$strMin=$str if $strMin gt $str;
		}
	}
	$$self=$strMin;
}

sub offshut($)
{
	my $self=shift;
	my $n=shift;
	my $polyomino=__PACKAGE__->new($$self);
	my $c=substr($$polyomino, $n, 1);
	substr($$polyomino, $n, 1, {R=>'DRU', L=>'ULD', U=>'RUL', D=>'LDR'}->{$c});
	while
		(
			$$polyomino=~s/RL|UD|DU|LR//g
				or $$polyomino=~s/^R(.*)L$/$1/
				or $$polyomino=~s/^L(.*)R$/$1/
				or $$polyomino=~s/^U(.*)D$/$1/
				or $$polyomino=~s/^D(.*)U$/$1/
		)
	{}
	undef $polyomino unless $polyomino->isSimple;
	$polyomino->canonize if defined $polyomino;
	return $polyomino;
}

sub toString()
{
	my $self=shift;
	return $$self;
}

sub boundingBox()
{
	my $self=shift;
	my ($llx, $lly, $urx, $ury)=(0, 0, 0, 0);
	my ($x, $y)=(0, 0);
	for(split //, $$self)
	{
		if($_ eq 'R')		{ $x++; }
		elsif($_ eq 'U')	{ $y++; }
		elsif($_ eq 'L')	{ $x--; }
		elsif($_ eq 'D')	{ $y--; }
		$llx=$x if $llx>$x;
		$lly=$y if $lly>$y;
		$urx=$x if $urx<$x;
		$ury=$y if $ury<$y;
	}
	return ($llx, $lly, $urx, $ury);
}

sub toSVG()
{
	my $self=shift;
	my ($llx, $lly, $urx, $ury)=$self->boundingBox;
	my @viewBox=($llx-.5, -$ury-.5, $urx-$llx+1, $ury-$lly+1);
	my $cellSize=36;
	$_*=$cellSize for @viewBox;
	my ($width, $height)=@viewBox[2, 3];
	my $path='';
	while($$self=~m/((.)\2*)/g)
	{
		$path.={R=>'h ', U=>'v -', L=>'h -', D=>'v '}->{$2}
			.($cellSize*length $1).' ';
	}
	return <<__SVG__;
<svg:svg
	version="1.1"
	viewBox="@viewBox"
	width="$width"
	height="$height"
	>
	<svg:path d="M 0 0 ${path}z"/>
</svg:svg>
__SVG__
}

sub toASCII()
{
	my $self=shift;
	my ($i, $j)=$self->boundingBox;
	($i, $j)=(-$i, -$j);
	my @intersections;
	for my $c(split //, $$self)
	{
		if($c eq 'R')
		{
			$i++;
		}
		elsif($c eq 'U')
		{
			push @{$intersections[$j++]}, $i;
		}
		elsif($c eq 'L')
		{
			$i--;
		}
		elsif($c eq 'D')
		{
			push @{$intersections[--$j]}, $i;
		}
	}

	my $string='';
	for(reverse @intersections)
	{
		my @row=sort { $a<=>$b } @$_;
		my $rowString='';
		while(@row)
		{
			my ($start, $stop)=splice @row, 0, 2;
			$rowString.=(' ' x ($start-length $rowString));
			$rowString.=('▒' x ($stop-$start));
		}
		$string.="$rowString\n";
	}
	return $string;
}

sub perimeter()
{
	my $self=shift;
	return length $$self;
}

sub isSimple()
{
	my $self=shift;
	my $perimeter=$self->perimeter;
	for(my $k=1; $k<$perimeter; $k++)
	{
		for(my $l=4; $l<=$perimeter-12; $l+=2)
		{
			my $subpath=substr($$self x 2, $k, $l);
			return 0 if
				($subpath=~tr/R//)==($subpath=~tr/L//)
					and ($subpath=~tr/U//)==($subpath=~tr/D//)
		}
	}
	return 1;
}

##################################################

package main;
use open IO=>':locale';
use open ':std';
use Getopt::Long;
use IO::File;

sub findPolyominoes($);
sub findPolyominoes($)
{
	my $n=shift;
	return (Polyomino->new('DRUL')) if $n==1;
	my %polyominoes;
	for(findPolyominoes($n-1))
	{
		for(my $k=0; $k<$_->perimeter; $k++)
		{
			my $polyomino=$_->offshut($k);
			$polyominoes{$polyomino->toString}=$polyomino
				if defined $polyomino;
		}
	}
	return sort {$a->toString cmp $b->toString} values %polyominoes;
}

sub toXHTMLFile($;$)
{
	my $n=shift;
	my $fileName=shift;
	my $file=$fileName eq '-'? STDOUT: IO::File->new($fileName, '>:utf8');
	$file->print(<<__XHTML__);
<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg">
<head>
<title>$n-полимино</title>
<style type="text/css">
\@namespace url("http://www.w3.org/1999/xhtml");
\@namespace svg url("http://www.w3.org/2000/svg");
body
{
	font-size: 20pt;
}

svg|path
{
	fill: red;
	stroke: black;
}
</style>
</head>
<body>
<table>
__XHTML__

	my $i=0;
	for(findPolyominoes($n))
	{
		$file->print
			(
				"<tr>\n",
				"<td>", $i++, "</td>\n",
				"<td>\n", $_->toSVG, "</td>\n",
				"<td><code>", $_->toString, "</code></td>\n",
				"</tr>\n"
			);
	}
	$file->print(<<__XHTML__);
</table>
</body>
</html>
__XHTML__
}

sub toASCIIFile($;$)
{
	my $n=shift;
	my $fileName=shift;
	my $file=$fileName eq '-'? STDOUT: IO::File->new($fileName, '>');
	my $i=0;
	for(findPolyominoes($n))
	{
		$file->print
			(
				'=' x $n, ' ',
				$i++, "\t[$$_]\n",
				$_->toASCII
			);
	}
}

sub help()
{
	STDERR->print(<<__HELP__);
polyomino.pl ⟨опции⟩ ⟨число⟩

⟨опции⟩:
	-o, --output-file ⟨файл⟩
		файл для вывода
	-f, --format ⟨формат⟩
		формат вывода, XHTML или ASCII
	-h
		показать эту подсказку

⟨число⟩:
	натуральное число
__HELP__
	exit;
}

##########

my %options;
GetOptions
	(
		'o|output-file=s'=>\$options{'output-file'},
		'f|format=s'=>\$options{'format'},
		'h|help!'=>\$options{'help'},
	);

my $n=shift or help;

$options{'output-file'}=$options{'output-file'}//'-';
$options{'format'}=$options{'format'}//'ASCII';

unless(defined $options{'format'})
{
	help;
}
elsif($options{'format'} eq 'XHTML')
{
	toXHTMLFile($n, $options{'output-file'});
}
elsif($options{'format'} eq 'ASCII')
{
	toASCIIFile($n, $options{'output-file'});
}
else
{
	help;
}

