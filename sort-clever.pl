#!/usr/bin/perl

use warnings;

print "$_\n" for sort { $a<=>$b } @ARGV;

