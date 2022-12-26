#!/usr/bin/perl

use warnings;

use utf8;
use open qw/:locale/;
use Image::Magick;
use Getopt::Long qw/:config no_ignore_case bundling/;

my $radius=100;
my $outputFile='Mandelbrot.png';
my $region='-2.4:-1.2:.8:1.2';
my $density=400;

sub help()
{
	STDERR->print(<<__HELP__);
mandelbrot.pl ⟨опции⟩

⟨опции⟩:
	-o, --output-file ⟨имя графического файла⟩
		имя выходного файла («$outputFile»)
	-r, --region ⟨umin⟩:⟨vmin⟩:⟨umax⟩:⟨vmax⟩
		прямоугольник на комплексной плоскости ($region)
	-d, --density ⟨целое число⟩
		количество пикселов на единичном отрезке ($density)
	-R, --radius ⟨вещественное число⟩
		радиус ($radius)
	-h, --help
		показать эту подсказку
__HELP__
	exit;
}

GetOptions
	(
		'o|output-file=s'	=>\$outputFile,
		'r|region=s'		=>\$region,
		'd|density=f'		=>\$density,
		'R|radius=f'		=>\$radius,
		'h|help'			=>\&help,
	);

my ($left, $bottom, $right, $top)=split ':', $region;
my $squaredRadius=$radius**2;

sub iterate($$)
{
	my ($u, $v)=@_;
	my ($tx, $ty)=my ($hx, $hy)=(0, 0);
	my $n=0;
	while()
	{
		($tx, $ty)=($tx**2-$ty**2+$u, 2*$tx*$ty+$v);
		($hx, $hy)=($hx**2-$hy**2+$u, 2*$hx*$hy+$v) for 0, 1;
		return 1/sqrt($n/4+1) if $tx**2+$ty**2>=$squaredRadius;
		return -1/sqrt($n/4+1) if (($tx-$hx)**2+($ty-$hy)**2)*$squaredRadius<1;
		$n++;
	}
}

my ($w, $h)=map { int($density*$_) } ($right-$left, $top-$bottom);

my $image=Image::Magick->new(size=>"${w}x$h");
$image->ReadImage('NULL:black');
$image->Color(color=>'black');
$image->Comment("region=$region density=$density radius=$radius");
$image->Set(depth=>8);

for my $i(0..$w-1)
{
	printf "\e[K\rГотово: \%d\%\%", $i/$w*100;
	STDOUT->flush;
	for my $j(0..$h-1)
	{
		my $jConjugate=2*$density*$top-$j;
		my $color;
		if($jConjugate<$j and $jConjugate>=0)
		{
			$color=[$image->GetPixel(x=>$i, y=>$jConjugate)];
		}
		else
		{
			my $value=iterate($i/$density+$left, -$j/$density+$top);
			$color=$value<0? [-$value, 0, 0]: [0, $value, 0];
		}
		$image->SetPixel(x=>$i, y=>$j, color=>$color);
	}
}

if((my $message=$image->Write($outputFile)) eq '')
{
	my $size=-s $outputFile;
	print "\e[K\rФайл «$outputFile» (${w}×$h, $size байт) записан.\n";
}
else
{
	die "\n$message\n";
}

