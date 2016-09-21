#!/usr/bin/env perl

use strict;
use warnings;

my $del = $ARGV[0] or "\s+";

while (<STDIN>) {
    chomp;
    print join " & ", split /$del/;
    print " \\\\", "\n";
}
