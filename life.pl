#!/usr/bin/perl

use warnings;

my @field;

my $width;
my $height;

sub init
{
	$SIG{INT}=\&term;

	$width=$ENV{COLUMNS} // 80;
	$height=$ENV{LINES} // 25;

	print "\e[?25l\e[2J";

	for(my $y=0; $y<$height; $y++)
	{
		for(my $x=0; $x<$width; $x++)
		{
			$field[$y][$x]=int rand 2;
		}
	}
}

sub term
{
	print "\e[?25h\e[1;1H\e[0m\e[2JThank you!\n";
	exit;
}

sub step
{
	my @newField;
	for(my $y=0; $y<$height; $y++)
	{
		for(my $x=0; $x<$width; $x++)
		{
			my $neighbours=neighbours($x, $y);
			if($field[$y][$x])
			{
				$newField[$y][$x]
					=($neighbours>=2 and $neighbours<=3)? 1: 0;
			}
			else
			{
				$newField[$y][$x]=($neighbours==3)? 1: 0;
			}
		}
	}
	@field=@newField;
}

sub neighbours
{
	my $x=shift;
	my $y=shift;
	return $field[$y][($x+1) % $width]
		+$field[($y+1) % $height][($x+1) % $width]
		+$field[($y+1) % $height][$x]
		+$field[($y+1) % $height][($x-1) % $width]
		+$field[$y][($x-1) % $width]
		+$field[($y-1) % $height][($x-1) % $width]
		+$field[($y-1) % $height][$x]
		+$field[($y-1) % $height][($x+1) % $width];
}

sub frame
{
	print "\e[1;1H";

	for(my $y=0; $y<$height; $y++)
	{
		my $y_=$y+1;
		for(my $x=0; $x<$width; $x++)
		{
			my $x_=$x+1;
			print "\e[$y_;${x_}H";
			print $field[$y][$x]? "\e[1;33m0": "\e[0;34mo";
		}
	}
}

##################################################

init;

while()
{
	frame;
	step;
}

