#!/usr/bin/perl

use warnings;

my $n=shift // die "Нужно неотрицательное число!\n";

print(('*' x $n, "\n") x $n);
