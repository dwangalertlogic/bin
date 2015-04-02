#!/usr/bin/perl

$s3File = shift; die if not $s3File;
$tgtD   = "s3buf";
$tgtF   = $s3File; $tgtF=~s/^.+\//$tgtD\//g; $tgtF=~s/tar/gz/g;

$tmpD = `uuidgen`; chomp $tmpD; die if not $tmpD;
$tmpD = "tmp.".$tmpD; # make for easy removal

mkdir $tmpD; chdir $tmpD;
system("aws s3 cp $s3File - | tar x --transform 's,/,.,g'");

$cmd = join("", map{chomp; s/^/qpacket_to_alpacket /; s/$/\| para.to.line.pl ; /; $_} `ls`);
open(FL, ">run.sh");
print FL "{ ".$cmd."} | gzip | hdfs dfs -put - $tgtF";
close(FL);
system(". ./run.sh");

chdir "..";
system("rm -rf $tmpD");
