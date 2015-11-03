#!/usr/bin/perl
use strict;
use warnings;
my $fastafile = $ARGV[0];
my $flagment = $ARGV[1];
my $seqname = "";
my $seqread = "";
my $pos = -1;
my @array = ();
open(IN,$fastafile) or die "Can't open $fastafile: $!\n";
while(<IN>){
	chomp;
	if(/^>/){
		if($seqname){
			$pos = index($seqread,$flagment);
		}
		while($pos >= 0){
			push(@array,$pos + 1);
			$pos = index($seqread,$flagment,$pos + 1);
		}
		if(@array){
			print "$seqname\n";
			foreach my $ele (@array){
				print "$ele\n";
			}
		}
		$seqname = $_;
		$seqread = "";
		@array = ();
	}elsif(/^[A-Z]/){
		$seqread .= $_;
	}
}
$pos = index($seqread,$flagment);
while($pos >= 0){
	push(@array,$pos + 1);
	$pos = index($seqread,$flagment,$pos + 1);
}
if(@array){
	print "$seqname\n";
	foreach my $ele (@array){
		print "$ele\n";
	}
}
close(IN)

