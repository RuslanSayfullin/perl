#!/usr/bin/perl

use warnings;

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

if(@ARGV==2)
{
	print "Файлы «$ARGV[0]» и «$ARGV[1]» различаются\n"
		if compareFiles($ARGV[0], $ARGV[1]);
}
else
{
	warn "$0: Требуется ровно два параметра в командной строке\n";
}

