
package Turtle;
use warnings;

use Math::Trig;
use POSIX;
use File::Temp;
use RGBColor;

sub new()
{
	my $class=shift;
	my $self
		={
			savestack=>[
					{
						x=>0,
						y=>0,
						direction=>0,
						linewitdh=>1,
						color=>RGBColor->new([0, 0, 0]),
						scale=>1,
					}
				],
			bbox=>{llx=>0, lly=>0, urx=>0, ury=>0},
			tmpfile=>File::Temp->new(template=>'Turtle-XXXXXXXX'),
		};
	bless $self, $class;
	return $self;
}

sub save()
{
	my $self=shift;
	push @{$self->{savestack}}, {};
	$self->writePostScript('gsave');
}

sub restore()
{
	my $self=shift;
	die "$0: Стек состояний пуст\n" if @{$self->{savestack}}==1;
	pop @{$self->{savestack}};
	$self->writePostScript('grestore');
}

sub setProperty($$)
{
	my $self=shift;
	my $property=shift;
	$self->{savestack}[-1]{$property}=shift;
}

sub getProperty($)
{
	my $self=shift;
	my $property=shift;
	my $savestack=$self->{savestack};
	for(my $i=$#$savestack; $i>=0; $i--)
	{
		return $savestack->[$i]{$property}
			if exists $savestack->[$i]{$property};
	}
}

sub setXY($$)
{
	my $self=shift;
	$self->setProperty('x', shift);
	$self->setProperty('y', shift);
}

sub getXY()
{
	my $self=shift;
	return ($self->getProperty('x'), $self->getProperty('y'));
}

sub setScale($)	{ shift->setProperty('scale', shift); }

sub getScale()	{ return shift->getProperty('scale'); }

sub setDirection($)	{ shift->setProperty('direction', shift); }

sub getDirection()	{ return shift->getProperty('direction'); }

sub setLineWidth($)
{
	my $self=shift;
	my $linewitdh=shift;
	$self->setProperty('linewitdh', $linewitdh);
	$self->writePostScript($linewitdh, 'setlinewidth');
}

sub getLineWidth()	{ return shift->getProperty('linewitdh'); }

sub setColor($)
{
	my $self=shift;
	my $color=RGBColor->new(shift);
	$self->setProperty('color', $color);
	$self->writePostScript(@$color, 'setrgbcolor');
}

sub getColor()	{ return shift->getProperty('color'); }

sub rotate($)
{
	my $self=shift;
	$self->setDirection($self->getDirection+shift);
}

sub jump($)
{
	my $self=shift;
	my $step=shift;
	$step*=$self->getScale;
	my ($x, $y)=$self->getXY;
	my $angleRad=deg2rad($self->getDirection);
	$self->setXY($x+$step*cos($angleRad), $y+$step*sin($angleRad));
}

sub forward($)
{
	my $self=shift;
	my $step=shift;
	my ($x, $y)=$self->getXY;
	$self->modifyBBox;
	$self->jump($step);
	$self->modifyBBox;
	$self->writePostScript
		(
			'newpath',
			$x, $y, 'moveto',
			$self->getXY, 'lineto',
			'stroke'
		);
}

sub modifyBBox()
{
	my $self=shift;
	my $lineWidthHalf=$self->getLineWidth/2;
	my ($x, $y)=$self->getXY;
	$self->{bbox}{llx}=min($self->{bbox}{llx}, $x-$lineWidthHalf);
	$self->{bbox}{lly}=min($self->{bbox}{lly}, $y-$lineWidthHalf);
	$self->{bbox}{urx}=max($self->{bbox}{urx}, $x+$lineWidthHalf);
	$self->{bbox}{ury}=max($self->{bbox}{ury}, $y+$lineWidthHalf);
}

sub min($$)	{ return $_[$_[0]<$_[1]? 0: 1];	}

sub max($$)	{ return $_[$_[0]>$_[1]? 0: 1]; }

sub writePostScript(@)
{
	shift->{tmpfile}->print("@_\n");
}

sub writePicture(;$$$)
{
	my $self=shift;

	my $outputFileName=shift//'TurtleOut.eps';
	my $device=shift//'epswrite';
	my $resolution=shift//72;

	my %bbox=%{$self->{bbox}};
	my @hiResBoundingBox=@bbox{sort keys %bbox};
	my $width=ceil(($bbox{urx}-$bbox{llx})*$resolution/72);
	my $height=ceil(($bbox{ury}-$bbox{lly})*$resolution/72);
	my @boundingBox
		=(
			floor($hiResBoundingBox[0]), floor($hiResBoundingBox[1]),
			ceil($hiResBoundingBox[2]), ceil($hiResBoundingBox[3])
		);

	open my $gsPipe, '|-',
		sprintf("gs -q -dNOPAUSE -dEPSCrop -sDEVICE=\"\%s\" -r\%s -o\"\%s\" -",
			$device, $resolution, $outputFileName);

	$gsPipe->print(<<__POSTSCRIPT__);
\%!PS-Adobe-3.0 EPSF-3.0;
\%\%BoundingBox: @boundingBox
\%\%HiResBoundingBox: @hiResBoundingBox
\%\%EndComments
1 setlinecap
__POSTSCRIPT__

	$self->{tmpfile}->flush;
	open my $tmpReader, '<', $self->{tmpfile}->filename;
	$gsPipe->print(<$tmpReader>);
	$tmpReader->close;

	$gsPipe->print("showpage\n");
	$gsPipe->print("\%\%EOF\n");
	$gsPipe->close
		or die "$0: Продолжать невозможно: GhostScript завершился с ошибкой\n";

	my $outputFileSize=-s $outputFileName;

	print(<<__REPORT__);
* Записан файл: «$outputFileName»
* Размер файла: $outputFileSize
* Устройство: $device
* Размер: ${width}×$height
* Разрешение: $resolution dpi
**
__REPORT__
}

return 1;
