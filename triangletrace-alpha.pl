#!/usr/bin/perl

use warnings;

##################################################

package Tracer;
use Image::Magick;
use IO::File;
use Carp;

sub new($)
{
	my $class=shift;
	my %opts=@_;
	my $self={
			imageFileName=>$opts{imageFileName},
			skipFrames=>$opts{skipFrames},
			image=>Image::Magick->new,
			gifImage=>Image::Magick->new,
			triangles=>[],
			mutations=>0,
			mutationsMax=>$opts{mutations},
			step=>$opts{step},
			theta=>$opts{theta},
			decayFactor=>1-exp(-$opts{decay}),
			metric=>$opts{metric},
			looping=>1,
		};
	$self->{image}->Read($self->{imageFileName});# or die;
	bless $self, $class;
	for(1..$opts{triangles})
	{
		push @{$self->{triangles}},
			{
				points=>[
					rand($self->width), rand($self->height),
					rand($self->width), rand($self->height),
					rand($self->width), rand($self->height)
				],
				color=>[rand, rand, rand, rand],
			};
	}
	$self->{initialDeviation}=$self->{deviation}=$self->deviation;
	return $self;
}

sub width()
{
	return shift->{image}->Get('columns');
}

sub height()
{
	return shift->{image}->Get('rows');
}

sub mutateValue($$)
{
	my $self=shift;
	my $valueRef=shift;
	my $max=shift;
	$$valueRef+=(rand(2*$self->{step})-$self->{step})*$max;
	$$valueRef=$$valueRef<0? 0: $$valueRef;
	$$valueRef=$$valueRef>$max? $max: $$valueRef;
}

sub mutate()
{
	my $self=shift;
	$self->{mutations}++;
	my $i=int(rand(@{$self->{triangles}}));
	my $triangle=$self->{triangles}[$i];
	my $deviationOld=$self->{deviation};
	my $triangleOld={
			points=>[@{$triangle->{points}}],
			color=>[@{$triangle->{color}}],
		};
	$self->mutateValue(\$triangle->{points}[$_], $self->width-1)
		for 0, 2, 4;
	$self->mutateValue(\$triangle->{points}[$_], $self->height-1)
		for 1, 3, 5;
	$self->mutateValue(\$triangle->{color}[$_], 1) for 0..3;

	$self->{deviation}=$self->deviation;
	my $smile;
	if($self->{deviation}<$deviationOld)
	{
		$smile=':-)';
	}
	elsif($self->{deviation}>$deviationOld)
	{
		$smile=':-(';
		if(rand>exp(($deviationOld-$self->{deviation})/$self->{theta}))
		{
			$self->{deviation}=$deviationOld;
			$self->{triangles}[$i]=$triangleOld;
			$smile='8-(';
		}
	}
	else
	{
		$smile=':-|';
	}
	$self->status($smile);
	$self->{theta}*=$self->{decayFactor};
}

sub deviation()
{
	my $self=shift;
	my $svg=$self->toSVG;
	my $svgImage=Image::Magick->new;
	$svgImage->BlobToImage($svg);
	my $difference=$self->{image}->Compare(image=>$svgImage, metric=>$self->{metric});
	push @{$self->{gifImage}}, $svgImage->Clone
		unless $self->{mutations} % $self->{skipFrames};
	undef $svgImage;
	return $difference->Get('error');
}

sub toSVG()
{
	my $self=shift;
	my ($width, $height)=($self->width, $self->height);
	my $svg=<<__SVG__;
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height">
<g stroke="none">
__SVG__
	for my $triangle(@{$self->{triangles}})
	{
		my $hexColor=sprintf '%02X%02X%02X', map {255*$_} @{$triangle->{color}}[0..2];
		$svg.=<<__SVG__;
<polygon points="@{$triangle->{points}}" fill="#$hexColor" fill-opacity="$triangle->{color}[3]"/>
__SVG__
	}
	$svg.=<<__SVG__;
</g>
</svg>
__SVG__
	return $svg;
}

sub status($)
{
	my $self=shift;
	my $smile=shift;
	STDERR->printf(
			"\r\e[K\%d: D=\%02.2f\%\% (\%02.2f\%\%), T=\%e, \%dfps\t\%s",
			$self->{mutations},
			$self->{deviation}*100,
			$self->{deviation}/$self->{initialDeviation}*100,
			$self->{theta},
			$self->{mutations}/times,
			$smile
		);
}

sub interrupt()
{
	my $self=shift;
	my $answer;
	do
	{
		STDERR->print(<<__MESSAGE__);

***************************************
Прерывание. Что дальше?
	1 — продолжить
	2 — записать файл GIF и продолжить
	3 — записать файл GIF и завершить
	4 — завершить
__MESSAGE__
		STDERR->print('ваш выбор> ');
		$answer=STDIN->getline;
		chomp $answer;
	}
	while($answer!~m/^[1-4]$/i);
	if($answer>1)
	{
		exit if $answer==4;
		$self->writeGIF;
		$self->{looping}=0 if $answer==3;
	}
}

sub writeGIF()
{
	my $self=shift;
	my $gifFileName='XXX-'.time.'.gif';
	STDERR->print(<<__MESSAGE__);

***************************************
Записывается GIF файл. Ждите…
__MESSAGE__
	$self->{gifImage}->Write($gifFileName);
	STDERR->printf
		(<<__MESSAGE__,
Файл записан:	\%s
Кадров:		\%d
Размер:		\%d
***************************************
__MESSAGE__
			$gifFileName,
			$#{$self->{gifImage}}+1,
			-s $gifFileName
		);
}

sub run()
{
	my $self=shift;
	$SIG{INT}=sub { $self->interrupt; };
	$self->mutate
		while $self->{looping} and $self->{mutations}<$self->{mutationsMax};
	$self->writeGIF;
	STDERR->printf("Время работы программы:	\%f\n", times);
}

##################################################

package main;
use Getopt::Long qw/:config no_ignore_case bundling/;

sub help()
{
	STDERR->print(<<__HELP__);
triangletrace-alpha.pl ⟨опции⟩ ⟨файл⟩

⟨опции⟩:
	-t, --triangles ⟨натуральное число⟩
		количество треугольников (25)
	-m, --mutations ⟨натуральное число⟩
		количество мутаций до остановки программы (∞)
	-s, --step ⟨число⟩
		число от 0 до 1, максимальное относительное изменение
		всех величин при каждой мутации (1E-2)
	-T, --theta ⟨число⟩
		начальная температура (1E-4)
	-d, --decay ⟨положительное число⟩
		число, отвечающее за скорость остывания, чем оно больше,
		тем медленнее остывание (10)
	-M, --metric ⟨метрика⟩
		метрика, используемая для вычисления разности изображений,
		одна из AE, MAE, MEPP, MSE, PAE, PSNR, RMSE (MAE)
	-f, --skip-frames ⟨натуральное число⟩
		через сколько мутаций включать кадр в GIF файл (250)
	-h, --help
		показать эту подсказку

⟨файл⟩:
	имя графического файла
__HELP__
	exit;
}

my %opts=
	(
		triangles	=>25,
		metric		=>'mae',
		step		=>.01,
		theta		=>1E-4,
		skipFrames	=>250,
		decay		=>10,
		mutations	=>INFINITY,
	);

GetOptions
	(
		't|triangles=i'		=>\$opts{triangles},
		'm|mutations=i'		=>\$opts{mutations},
		'M|metric=s'		=>\$opts{metric},
		's|step=f'			=>\$opts{step},
		'T|theta=f'			=>\$opts{theta},
		'd|decay=f'			=>\$opts{decay},
		'f|skip-frames=i'	=>\$opts{skipFrames},
		'h|help'			=>\&help,
	);


$opts{imageFileName}=shift//help;

Tracer->new(%opts)->run;

