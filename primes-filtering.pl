#!/usr/bin/perl

use warnings;
no warnings 'recursion';

package Sequence;

sub new
{
	my $n=2;
	return bless \$n, shift;
}

sub get
{
	my $self=shift;
	return $$self++;
}

##########

package Filter;

sub new
{
	my $class=shift;
	return bless {source=>shift, p=>shift}, $class;
}

sub get
{
	my $self=shift;
	my $n=$self->{source}->get;
	return ($n % $self->{p})? $n: $self->{source}->get;
}

##########

package main;

my $n=shift or die "Укажите число в командной строке\n";

my $sequence=Sequence->new;

while()
{
	my $p=$sequence->get;
	last if $p>$n;
	print "$p\n";
	$sequence=Filter->new($sequence, $p);
}
