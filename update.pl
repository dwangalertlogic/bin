#!/usr/bin/perl

$listF = "~/list.worker";
@nodes = map{$_=~s/^.+?\s//g;chomp;$_} `cat $listF`;

$dir = shift; die if not $dir;

foreach $n (@nodes) {
        print "****** $n ******\n";
	system("rsync -avr $dir $n:");
}
