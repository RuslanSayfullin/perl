#!/usr/bin/perl

use warnings;

sub treeAddElement
{
	my $tree=shift;
	my $n=shift;
	if(@$tree)
	{
		treeAddElement($tree->[$n<$tree->[0]? 1: 2], $n);
	}
	else
	{
		@$tree=($n, [], []);
	}
}

sub treeToArray
{
	my $tree=shift;
	return () unless @$tree;
	return (treeToArray($tree->[1]), $tree->[0], treeToArray($tree->[2]));
}

sub treeSort
{
	my $tree=[];
	treeAddElement($tree, $_) for @_;
	return treeToArray($tree);
}

print "$_\n" for treeSort(@ARGV);
