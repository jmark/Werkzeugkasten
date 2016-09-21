#!/usr/bin/env perl

binmode STDOUT, ":encoding(UTF-8)";
autoflush STDOUT, 1;

use v5.20;
use experimental qw/signatures postderef lexical_subs/;

use MIME::Words qw/decode_mimewords/;

use File::Copy qw/move/;
use File::Path qw/make_path/;
use File::Temp qw/tempfile/;
use File::Spec::Functions qw/canonpath/;
use File::Slurp qw/read_file write_file/;

my $i = 0;
my $INBOX_DIR = $ARGV[$i++] or die "No filter directory given!";
my $ROOT_DIR  = $ARGV[$i++] or die "No destination directory given!";
my $RULE_FILE = $ARGV[$i++] or die 'No rules file given!';

sub trim
{
    my @ret = map {s/^\s+|\s+$//g; $_} @_;
    return wantarray ? @ret : $ret[0];
}
    
sub fiddle($msg, $hd)
{
    my @ret = split /: /, join ' ', grep {/^$hd: /i} @$msg;
    shift @ret;
    return scalar decode_mimewords trim "@ret";
}

sub apply($rule, $msg)
{
    my ($targets, $regex) = @$rule;
    return grep {/$regex/i} map {fiddle $msg, $_} trim split /,/, $targets;
}

sub shelve($rule, $msg)
{
    my $dest = "$ROOT_DIR/".@$rule[2];
    -e $dest or make_path($dest)                    or die "Cannot create path '$dest': $!";
    my ($fh, $fn) = tempfile(DIR => $dest)          or die "Cannot create tempfile in '$dest': $!";
    write_file($fh,join '', @$msg)                  or die "Cannot write file to '$fn': $!";
    move($fn, canonpath("$dest/".(stat $fn)[1]))    or die "Cannot rename tempfile: $!";
}

sub triplelize(@list)
{
    my @ret = ();
    my $i = 0;
    #push @ret, [$list[$i++],$list[$i++],$list[$i++]] while ($i < @list);
    push @ret, [shift @list,shift @list,shift @list] while (@list);
    return @ret;
}

sub snuffle($file)
{
    my @msg = split /\x1e/, join '', map {s/^([\w-]+:)/\x1e$1/; $_} read_file $file;
    shift @msg;
    return \@msg;
}

my @rules = triplelize grep {!/^(#|\s*$)/} trim read_file $RULE_FILE;

for my $file (glob "$INBOX_DIR/*") {
    my $msg = snuffle $file;
    apply($_, $msg) and shelve($_, $msg) and unlink($file) and last for (@rules);
}
