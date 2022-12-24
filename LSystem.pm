package LSystem;
use warnings;
use base ('Turtle');

sub new($%)
{
	my $class=shift;
	my $self=Turtle->new;
	$self->{condition}=shift;
	%{$self->{rules}}=@_;
	return bless $self, $class;
}

sub iterate($)
{
	my $self=shift;
	my $n=shift;
	$self->{condition}=join
		(
			'',
			map $self->{rules}{$_}//$_,
				split(//, $self->{condition})
		)
		while $n--;
}

sub interpret(%)
{
	my $self=shift;
	my %actions=@_;
	for(split //, $self->{condition})
	{
		$actions{$_}->($self) if exists $actions{$_};
	}
}

return 1;

