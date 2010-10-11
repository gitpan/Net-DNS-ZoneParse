# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Net-DNS-ZoneParse.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 6;
BEGIN {
	use_ok('Net::DNS::ZoneParse');
	use_ok('Net::DNS::ZoneParse::Zone');
	use_ok('Net::DNS::ZoneParse::Parser::Native');
	SKIP: {
		eval { require Net::DNS::Zone::Parser; };
		if($@) {
			skip "Net::DNS::Zone::Parser isn't installed", 1;
		} else {
			use_ok('Net::DNS::ZoneParse::Parser::NetDNSZoneParser');
		}
	}
	SKIP: {
		eval { require Net::DNS::ZoneFile::Fast; };
		if($@) {
			skip "Net::DNS::ZoneFile::Fast isn't installed", 1;
		} else {
			use_ok('Net::DNS::ZoneParse::Parser::ZFFast');
		}
	}
	use_ok('Net::DNS::ZoneParse::Generator::Native');
};

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

