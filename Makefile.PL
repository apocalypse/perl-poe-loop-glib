use inc::Module::Install;

name		'POE-Loop-Glib';
all_from	'lib/POE/Loop/Glib.pm';


requires	'POE'			=> '1.0';
requires	'Glib'			=> '1.181';
#requires	'POE::Test::DondeEstan'	=> '0';

test_requires	'Test::More'	=> '0';
test_requires	'Test::Pod'	=> '1.00';

open (TOUCH, "+>run_network_tests") and close TOUCH;

tests_recursive;

WriteAll;
