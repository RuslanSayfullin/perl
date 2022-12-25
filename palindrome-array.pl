#!/usr/bin/perl

use warnings;

package Lexicon::Array;

use IO::File;

sub new(;$)
{
	my $class=shift;
	my $self=[];
	bless $self, $class;
	my $fileName=shift;
	if(defined $fileName)
	{
		my $file=IO::File->new($fileName, '<:utf8');
		my $word;
		while(defined($word=$file->getline))
		{
			chomp $word;
			$self->add($word);
		}
	}
	return $self;
}

sub add(@)
{
	my $self=shift;
	push @$self, @_;
}

sub suitableWords($$)
{
	my $self=shift;
	my $side=shift;
	my $string=shift;
	unless($side)
	{
		return grep { $_=~m/^$string/ or $string=~m/^$_/ } @$self;
	}
	else
	{
		return grep { $_=~m/$string$/ or $string=~m/$_$/ } @$self;
	}
}

##################################################

package Palindrome;

sub new()
{
	return bless [[], []], shift;
}

sub copy()
{
	my $self=shift;
	my $copy=Palindrome->new;
	@{$copy->[$_]}=@{$self->[$_]} for 0, 1;
	return $copy;
}

sub totalWords()
{
	my $self=shift;
	return @{$self->[0]}+@{$self->[1]};
}

sub isPalindrome()
{
	my $self=shift;
	my $string=join '', @{$self->[0]}, @{$self->[1]};
	return $string eq reverse $string;
}

sub toString()
{
	my $self=shift;
	return join ' ', @{$self->[0]}, @{$self->[1]};
}

sub quality()
{
	my $self=shift;
	my %words;
	$words{$_}++ for @{$self->[0]}, @{$self->[1]};
	return (length join '', keys %words)/$self->totalWords;
}

sub whatToDo()
{
	my $self=shift;
	my $left=join '', @{$self->[0]};
	my $right=join '', @{$self->[1]};
	if(length($left)<=length($right))
	{
		return (0, substr(scalar(reverse($right)), length($left)));
	}
	else
	{
		return (1, scalar(reverse(substr($left, length($right)))));
	}
}

sub add($$)
{
	my $self=shift;
	my $side=shift;
	my $word=shift;
	unless($side)
	{
		push @{$self->[0]}, $word;
	}
	else
	{
		unshift @{$self->[1]}, $word;
	}
}

##################################################

package main;

use utf8;
use open IO=>':utf8';
use open ':std';

{
	my $spin=0;
	sub spinner($)
	{
		my $s=shift;
		$spin++;
		$spin %= 4;
		print "\e[K", $s, substr('\\-/|', $spin, 1), "\r";
		flush STDOUT;
	}
}

my $n=shift;
my $wordsFileName=shift;
my $quality=shift;
my $words=Lexicon::Array->new($wordsFileName);

my @palindromes=(Palindrome->new);

my $counter=0;
while(@palindromes)
{
	my $palindrome=shift @palindromes;
	$counter++;
	#die $palindrome->totalWords;
	if($palindrome->totalWords==$n)
	{
		print "\e[31m", $palindrome->quality, "\t", $palindrome->toString, "\e[m\n"
			if $palindrome->isPalindrome and $palindrome->quality>=$quality;
		next;
	}
	my ($side, $s)=$palindrome->whatToDo;
	for my $w($words->suitableWords($side, $s))
	{
		my $p=$palindrome->copy;
		$p->add($side, $w);
		unshift @palindromes, $p;
	}
	#spinner(0+@palindromes);
	STDERR->print("\e[K", $counter, '/', 0+@palindromes, "\r");
}

