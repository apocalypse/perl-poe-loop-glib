use inc::Module::Install;

name		'POE-Loop-Glib';
perl_version	'5.006';
all_from	'lib/POE/Loop/Glib.pm';


requires 'POE'	=> '1.0';
requires 'Glib'	=> '1.181';

configure_requires 'POE::Test::Loops' => '1.001';

test_requires 'Test::More' => '0';

recommends 'Win32::Console'	=> 0;
recommends 'Term::Readkey'	=> 0;
recommends 'Socket6'		=> 0;
recommends 'IO::Pty'		=> 0;

open (TOUCH, "+>run_network_tests") and close TOUCH;

#tests_recursive;
tests('t/*.t');
author_tests('t/author');
gen_loop_tests('t/', 'Glib');

# this gives POE::Kernel as well, so do it manually
# auto_provides;
provides('POE::Loop::Glib' => {file =>'lib/POE/Loop/Glib.pm'});

WriteAll;
