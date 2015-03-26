#!/usr/bin/perl

$listF = "~/list.worker";
@nodes = map{$_=~s/^.+?\s//g;chomp;$_} `cat $listF`;

$cmd = shift; die if not $cmd;
foreach $n (@nodes) {
	print "****** $n ******\n";
	system("ssh $n \"$cmd\"");
}
