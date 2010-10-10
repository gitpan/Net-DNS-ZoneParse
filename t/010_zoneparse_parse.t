# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Net-DNS-ZoneParse.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
use Test::Deep;
BEGIN { use_ok('Net::DNS::ZoneParse') };

#########################

my $result = [
	superhashof( {
		name => "example.com",
		class => "IN",
		type => "MX",
		ttl => 3600,
		preference => 1,
		exchange => "foo.example.com",
	}),
	superhashof( {
		name => "foo.example.com",
		class => "IN",
		type => "CNAME",
		cname => "bar.example.com",
	}),
	superhashof( {
		name => "bar.example.com",
		type => "A",
		address => "10.0.0.1",
	}),
	superhashof( {
		name => "example.com",
		class => "IN",
		type => "MX",
		ttl => 3500,
		preference => 10,
		exchange => "bar.example.com",
	}),
];

SKIP: {
	eval { require Net::DNS::ZoneFile::Fast; };

	skip "Net::DNS::ZoneFile::Fast isn't installed", 1 if $@;

	my $pos = tell(DATA);
	<DATA>;

	my @fres = @{$result}[1..3];
	cmp_deeply(Net::DNS::ZoneParse::parse({
			       	fh => \*DATA,
			       	parser => [ qw(ZFFast) ],
			}),
		noclass(\@fres), "Parsing via Net::DNS::ZoneFile::Fast");

	$. = 0;
	seek(DATA, $pos, 0);
};

my $zoneparse = Net::DNS::ZoneParse->new();
cmp_deeply($zoneparse->parse(\*DATA), noclass($result), "Parsing native");

__END__
example.com.	IN 3600 MX 1 foo.example.com.
foo.example.com. IN CNAME bar.example.com.
bar.example.com. A 10.0.0.1
example.com.	3500 IN MX 10 bar.example.com.
