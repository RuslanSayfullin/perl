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

return 1;

