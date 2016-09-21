#!/usr/bin/env perl

binmode STDOUT, ":encoding(UTF-8)";
autoflush STDOUT, 1;

use v5.20;
use experimental qw/signatures postderef lexical_subs/;

use Config::Tiny;
use Net::POP3;

use MIME::Words qw/decode_mimewords/;

use File::Copy qw/move/;
use File::Path qw/make_path/;
use File::Temp qw/tempfile/;
use File::Spec::Functions qw/canonpath/;
use File::Slurp qw/read_file write_file/;

my $config_file = $ARGV[0] or die 'no config file given!';
my %config = %{Config::Tiny->read($config_file)->{_}};

my $dest = glob($config{inbox});

my $pop = Net::POP3->new($config{server}, SSL=>1, Debug => 0) or die "Cannot access to POP3 Server '$config{pop}': $!";
defined ($pop->login($config{login}, $config{pass})) or die "Invalid login or password: $!\n";

while (my @msgids = keys %{$pop->list}) {
    for my $id (@msgids) {
        my @msg = @{($pop->get($id) || do {warn "Cannot read email $id: $!n";next;})};

        sub trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s; }
        sub fiddle { my $hd = shift; (split /: /,(grep {/^$hd: /i} @msg)[0], 2)[1];}

        my $subject = decode_mimewords trim fiddle 'Subject';
        my $from    = decode_mimewords trim fiddle 'From';

        say $from;
        say '    ', $subject;

        my ($fh, $fn) = tempfile(DIR => $dest);
        write_file($fh,join '', @msg);

        move($fn, canonpath("$dest/".(stat $fn)[1])) or die "Cannot rename tempfile: $!\n";

        $pop->delete($id);
    }
}

$pop->quit;
