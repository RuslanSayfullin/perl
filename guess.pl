
#!/usr/bin/perl

use warnings;

do
{
	print "Загадайте число от 0 до 99.\n\n";

	($a, $b)=(0, 99);

	do
	{
		$m=int(($a+$b)/2);
		print "Ваше число больше $m? (y/n) ";
		if(<STDIN> eq "y\n")
		{
			$a=$m+1;
		}
		else
		{
			$b=$m;
		}
	}
	while($a<$b);

	print "Вы загадали число $a.\n\nПродолжаем? (y/n) ";

}
while(<STDIN> eq "y\n");
