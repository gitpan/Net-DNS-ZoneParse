# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Net-DNS-ZoneParse.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 5;
BEGIN {
	use_ok('Net::DNS::ZoneParse');
	use_ok('Net::DNS::ZoneParse::Zone');
	use_ok('Net::DNS::ZoneParse::Parser::Native');
	use_ok('Net::DNS::ZoneParse::Parser::ZFFast');
	use_ok('Net::DNS::ZoneParse::Generator::Native');
};

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

