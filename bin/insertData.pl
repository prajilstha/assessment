#!C:\Perl\bin\perl.exe -wT

print "Content-type : text/html\n\n";
use DBI;
use strict;
use CGI;

my $driver="SQLite";
my $database="assessmentDB.db";
my $dsn="DBI:$driver:dbname=$database";
my $userid="";
my $password="";

#DATABASE CONNECTION
my $dbh = DBI -> connect($dsn,$userid,$password,{RaiseError=>1}) or die $DBI::errstr;


my $cgi = new CGI;

#FORM PARAMETERS
my $txtDate = $cgi->param('txtDate');
my $txtTime = $cgi->param('txtTime');
my $txtDescription = $cgi->param('txtDescription');

# Creating appointment table if it does not exist
$dbh->do("CREATE TABLE IF NOT EXISTS appointment(datetime Date,description VARCHAR(100))");
	

#INSERTING TO appointment TABLE
my $sth= $dbh -> prepare("insert into appointment(datetime, description) values (?,?);");

#EXECUTE INSERT STATEMENT COMBINING DATE AND TIME
$sth->execute($txtDate." ".$txtTime, $txtDescription) or die $DBI::errstr;

$dbh->disconnect();

#AUTO RE-DIRECT AFTER DATA ENTRY
my $url="http://localhost:8081/assessment/index.html";
my $t=0; # time until redirect activates
print "<META HTTP-EQUIV=refresh CONTENT=\"$t;URL=$url\">\n";