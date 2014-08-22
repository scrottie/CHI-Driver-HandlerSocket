#!perl -w
use strict;
use warnings;
use CHI::Driver::HandlerSocket::t::CHIDriverTests::MySQLHandlerSocket;

use ExtUtils::MakeMaker 'prompt';

my $database;
my $user;
my $pass;
my $host;

# Makefile.PL asks the user (if the user is reachable) for database login info to test with; that gets appeneded to the end of this file

while(my $line = readline DATA) {
    no warnings 'uninitialized';
    chomp $line;
    (my $k, my $v) = split /=/, $line, 2;
    $database = $v if $k eq 'database';
    $user = $v if $k eq 'user';
    $pass = $v if $k eq 'pass';
}

if($user and $pass ) {
    $database =~ /;host=(.+);*/o;
    $host = $1 if $1;
    CHI::Driver::HandlerSocket::t::CHIDriverTests::MySQLHandlerSocket->runtests(
        user => $user,
        pass => $pass,
        database => $database,
        host => $host,
    );
}
__DATA__
