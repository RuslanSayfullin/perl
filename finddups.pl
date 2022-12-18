#!/usr/bin/perl

use warnings;

my %collectedFiles;

sub compareFiles($$;$)
{
	my $name1=shift;
	my $name2=shift;
	my $bufferSize=shift // 512;
	unless(open $file1, '<', $name1)
	{
		warn "$0: Невозможно открыть «$name1»: $!\n";
		return;
	}
	unless(open $file2, '<', $name2)
	{
		warn "$0: Невозможно открыть «$name2»: $!\n";
		close $file1 or warn "$0: Невозможно закрыть «$name1»: $!";
		return;
	}
	my($buffer1, $buffer2);
	my $result=0;
	while()
	{
		my $n1=read $file1, $buffer1, $bufferSize;
		unless(defined $n1)
		{
			warn "$0: Невозможно прочитать «$name1»: $!\n";
			undef $result;
			last;
		}
		my $n2=read $file2, $buffer2, $bufferSize;
		unless(defined $n2)
		{
			warn "$0: Невозможно прочитать «$name2»: $!\n";
			undef $result;
			last;
		}
		last unless $n1 or $n2;
		if($buffer1 ne $buffer2)
		{
			$result=1;
			last;
		}
	}
	close $file2 or warn "$0: Невозможно закрыть «$name2»: $!";
	close $file1 or warn "$0: Невозможно закрыть «$name1»: $!";
	return $result;
}

sub find($);
sub find($)
{
	my $name=shift;
	if(-d $name)
	{
		my $dir;
		unless(opendir $dir, $name)
		{
			warn "$0: Невозможно открыть «$name»: $!\n";
			return;
		}
		$name='' if $name eq '/';
		for(readdir $dir)
		{
			next if $_ eq '.' or $_ eq '..';
			find("$name/$_");
		}
		closedir $dir;
	}
	elsif(-f $name)
	{
		push @{$collectedFiles{-s $name}->[0]}, $name;
	}
	else
	{
		warn "$0: «$name»: $!\n";
	}
}

sub findDups(@)
{
	push @_, '.' unless @_;
	find($_) for @_;
	for my $size(sort { $a<=>$b } keys %collectedFiles)
	{
		my $groups=$collectedFiles{$size};
		for(my $g=0; $g<@$groups; $g++)
		{
			my $group=$groups->[$g];
			for(my $i=1; $i<@$group; $i++)
			{
				push @{$groups->[$g+1]}, splice @$group, $i--, 1
					if compareFiles($group->[0], $group->[$i]);
			}
			if(@$group>1)
			{
				print "* Размер: $size\n";
				print "$_\n" for sort @$group;
				print "\n";
			}
		}
	}
}

findDups(@ARGV);

