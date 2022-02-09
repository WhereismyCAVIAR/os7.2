#!/usr/bin/perl 
require 5.002;
use strict;
BEGIN { $ENV{PATH} = '/usr/ucb:/bin' }
use Socket;
use Socket6;
use Carp;
use IO::Select;

sub logmsg { print "$0 $$: @_ at ", scalar localtime, "\n" }

my $host = shift || in6addr_any();
my $port = shift || 2345;
my $proto = getprotobyname('tcp');

my @res = getaddrinfo($host, $port, AF_UNSPEC, SOCK_STREAM, PF_UNSPEC, AI_PASSIVE);
my ($family, $socktype, $proto, $saddr, $canonname);
my @socket;
my (@host);
while (scalar(@res) >= 5) {
    ($family, $socktype, $proto, $saddr, $canonname, @res) = @res;
    my ($host, $port) = getnameinfo($saddr,NI_NUMERICHOST | NI_NUMERICSERV);
    print "$host : $port\n";
}
