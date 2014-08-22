package CHI::Driver::HandlerSocket::t::CHIDriverTests::MySQLHandlerSocket;
use strict;
use warnings;

use base qw(CHI::Driver::HandlerSocket::t::CHIDriverTests::Base);

sub testing_driver_class    { 'CHI::Driver::HandlerSocket' }

sub required_modules { 
    return { 'DBD::mysql' => undef, 'Net::HandlerSocket' => undef, } 
}

our $dbh;
our $host;

sub runtests {
    my $class = shift;
    my %opts = @_;
    $dbh = DBI->connect("DBI:mysql:database=$opts{database}", $opts{user}, $opts{pass}) or 
        die "failed to connect to database: $DBI::errstr";
    $host = $opts{host} // 'localhost';
    $class->SUPER::runtests();
}

sub dbh { return $dbh; }
sub host { return $host; }

sub cleanup : Tests( shutdown ) {
    # unlink 't/dbfile.db';
}

1;
