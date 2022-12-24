package LSystem::Lazy::Filter;

sub new($$)
{
	my $class=shift;
	my $source=shift;
	my $rules=shift;
	my $self={
		buffer=>'',
		source=>$source,
		rules=>$rules,
	};
	return bless $self, $class;
}

sub getc()
{
	my $self=shift;
	while($self->{buffer} eq '')
	{
		my $char=$self->{source}->getc;
		return unless defined $char;
		$self->{buffer}=$self->{rules}{$char}//$char;
	}
	return substr($self->{buffer}, 0, 1, '');
}

package LSystem::Lazy;
use warnings;
use base ('Turtle');
use IO::File;

sub new($%)
{
	my $class=shift;
	my $self=Turtle->new;
	my $axiom=shift;
	$self->{source}=IO::File->new(\$axiom, '<');
	%{$self->{rules}}=@_;
	return bless $self, $class;
}

sub iterate($)
{
	my $self=shift;
	my $n=shift;
	$self->{source}=LSystem::Lazy::Filter->new($self->{source}, $self->{rules})
		while $n--;
}

sub interpret(%)
{
	my $self=shift;
	my %actions=@_;
	while(my $char=$self->{source}->getc)
	{
		$actions{$char}->($self) if exists $actions{$char};
	}
}

return 1;

