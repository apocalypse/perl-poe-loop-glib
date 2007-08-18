use Glib;
use POE qw(Loop::Glib);


use Data::Dumper;
print Dumper \%INC;
my $count;
my $session = POE::Session->create (
	inline_states => {
		_start => sub {
			my ($kernel) = $_[KERNEL];

			$kernel->alias_set ('foo');
			$kernel->delay_add ('foo', 2);
		},
		foo => sub {
			my ($kernel) = $_[KERNEL];

			print "POE FOO $count\n";
			print "depth is " . Glib::main_depth;
			$count++;
			$kernel->delay_add ('foo', 2) unless ($count > 5);
		},
	},
);

POE::Kernel->run();

1;
