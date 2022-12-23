#!/usr/bin/perl

use warnings;

package Animal;

sub new
{
	my $class=shift;
	my $self={name=>shift, sound=>shift};
	return bless $self, $class;
}

sub say
{
	my $self=shift;
	print "Здравствуйте, я $self->{name}. $self->{sound}!\n";
}

package main;

my $cat=Animal->new('Кошка', 'Мяу');
my $dog=Animal->new('Собака', 'Гав');
my $pig=Animal->new('Свинья', 'Хрю');
my $ram=Animal->new('Баран', 'Бее');
my $cow=Animal->new('Корова', 'Муу');
my $horse=Animal->new('Лошадь', 'И-го-го');

$_->say for $cat, $dog, $pig, $ram, $cow, $horse;
