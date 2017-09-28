#!C:\Perl\bin\perl.exe -wT

print "Content-type : text/json\n\n";
use strict;
use CGI;
use DBI;
use JSON;
my $cgi = new CGI;

my $driver="SQLite";
my $database="assessmentDB.db";
my $dsn="DBI:$driver:dbname=$database";
my $userid="";
my $password="";

#DATABASE CONNECTION
my $dbh = DBI -> connect($dsn,$userid,$password,{RaiseError=>1});

my @output;

#SEARCH TEXT
my $txtSearch = $cgi->param('searchData');
 
#SELECTING VALUE FROM DATABASE
my $query=qq(select datetime,description from appointment where description like '%$txtSearch%');
my $query_handle = $dbh->prepare($query);

#EXECUTE THE QUERY
$query_handle->execute() or die $DBI::errstr;

while ( my $row = $query_handle->fetchrow_hashref ){
    push @output, $row;
}

#CONVERTING TO JSON
print to_json(\@output);

$dbh->disconnect();
