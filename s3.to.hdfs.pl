#!/usr/bin/perl

$s3File = shift; die if not $s3File;
$tgtD   = "s3Buf";
$tgtF   = $s3File; $tgtF=~s/^.+\//$tgtD\//g; $tgtF=~s/tar/sz/g;

$tmpD = `uuidgen`; chomp $tmpD; die if not $tmpD;

mkdir $tmpD; chdir $tmpD;
system("aws s3 cp $s3File - | tar x --transform 's,/,.,g'");

$cmd = join("", map{chomp; s/^/qpacket_to_alpacket /; s/$/; /; $_} `ls`);

system("{ ".$cmd."} | snzip | hdfs dfs -put - $tgtF");

chdir "..";
system("rm -rf $tmpD");
