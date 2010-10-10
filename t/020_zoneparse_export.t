# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Net-DNS-ZoneParse.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('Net::DNS::ZoneParse', qw(:parser)) };

#########################

my $result = <<"RRS";
foo.example.com.		IN	CNAME	bar.example.com.
bar.example.com.		IN	A	10.0.0.1
RRS

#TODO make the generator realize domains in rdata?
my $ooresult = <<"ORRS";
\$ORIGIN	example.com
foo		IN	CNAME	bar.example.com.
bar		IN	A	10.0.0.1
ORRS

my $rrs = [
	Net::DNS::RR->new("foo.example.com. IN CNAME bar.example.com."),
	Net::DNS::RR->new("bar.example.com. IN A 10.0.0.1"),
];

is(writezone($rrs), $result, "Export using Function-Interface");

my $zoneparse = Net::DNS::ZoneParse->new();
$zoneparse->extent("example.com", $rrs);
is($zoneparse->writezone("example.com"), $ooresult,
       	"Export using Object oriented Interface");
