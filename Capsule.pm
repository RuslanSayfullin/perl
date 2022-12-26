package Capsule;

our $tolerance=1E-8;

sub new
{
	my $class=shift;
	my $self=[];
	return bless $self, $class;
}

sub known
{
	my $self=shift;
	$self->simplify;
	return @$self==1;
}

sub value
{
	my $self=shift;
	if($self->known)
	{
		return $self->[0];
	}
	else
	{
		return;
	}
}

sub simplify
{
	my $self=shift;
	return if @$self<3;
	for(my $i=0; $i<$#$self; $i+=2)
	{
		if(@{$self->[$i+1]})
		{
			my @capsule=@{$self->[$i+1]};
			for(my $j=0; $j<@capsule; $j+=2)
			{
				$capsule[$j]*=$self->[$i];
			}
			$self->[-1]+=pop @capsule;
			splice @$self, $i, 2, @capsule;
			redo;
		}
	}
	outer: for(my $i=0; $i<$#$self; $i+=2)
	{
		for(my $j=0; $j<$i; $j+=2)
		{
			if($self->[$j+1]==$self->[$i+1])
			{
				$self->[$j]+=$self->[$i];
				splice @$self, $i, 2;
				redo outer;
			}
		}
	}
	for(my $i=0; $i<$#$self; $i+=2)
	{
		unless($self->[$i])
		{
			splice @$self, $i, 2;
			redo;
		}
	}
}

sub equation
{
	(my $eqn=bless [@_], 'Capsule')->simplify;
	if($eqn->known)
	{
		if(abs($eqn->[0])>$tolerance)
		{
			die "Несовместное уравнение (off=$eqn->[0])!\n";
		}
		# warn "Избыточное уравнение!\n";
	}
	else
	{
		my $coefficient=shift @$eqn;
		my $var=shift @$eqn;
		@$var=@$eqn;
		for(my $i=0; $i<=$#$var; $i+=2)
		{
			$var->[$i]/=-$coefficient;
		}
	}
}

return 1;

