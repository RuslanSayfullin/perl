package BitSetSimple;

sub new()
{
	my $class=shift;
	my $string='';
	return bless \$string, $class; 
}

sub get($)
{
	my $self=shift;
	my $i=shift;
	return 0 if length $$self<=int($i/8);
	return ord(substr $$self, int($i/8), 1)&(1<<($i % 8));
}

sub set($$)
{
	my $self=shift;
	my $i=shift;
	my $value=shift;
	while(length $$self<=int($i/8))
	{
		$$self.="\0";
	}
	my $byte=ord substr $$self, int($i/8), 1;
	if($value)
	{
		$byte|=(1<<($i % 8));
	}
	else
	{
		$byte&=~(1<<($i % 8));
	}
	substr $$self, int($i/8), 1, chr $byte;
	while(length $$self and (substr $$self, -1) eq "\0")
	{
		chop $$self;
	}
}

sub isMember($)
{
	return shift->get(shift);
}

sub add($)
{
	shift->set(shift, 1);
}

sub delete($)
{
	shift->set(shift, 0);
}

sub toString()
{
	my $self=shift;
	my $string='';
	for(my $i=0; $i<8*length $$self; $i++)
	{
		$string.="$i," if $self->get($i);
	}
	chop $string if (substr $string, -1) eq ',';
	return "{$string}";
}

return 1;

