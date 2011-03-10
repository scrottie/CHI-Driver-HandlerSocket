package CHI::Driver::DBI::t::CHIDriverTests::MySQL;
use strict;
use warnings;

use base qw(CHI::Driver::DBI::t::CHIDriverTests::Base);

sub required_modules { 
    return { 'DBD::mysql' => undef } 
}

our $dbh;

sub runtests {
    my $class = shift;
    my %opts = @_;
    $dbh = DBI->connect("DBI:mysql:database=$opts{database};host=localhost", $opts{user}, $opts{pass}) or 
        die "failed to connect to database: $DBI::errstr";
    $class->SUPER::runtests();
}

sub dbh { return $dbh; }

sub cleanup : Tests( shutdown ) {
    # unlink 't/dbfile.db';
}

1;
