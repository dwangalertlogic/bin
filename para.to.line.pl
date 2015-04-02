#!/usr/bin/perl

use strict;
use warnings;

{
	local $/ = '';
	while (<>) {
		s/^\s+//g;
		s/\s+$//sg;
		s/\s{0,}\n\s{0,}/<>/sg;
		print ;
		print "\n";
	}
}
