# the only interesting thing here is that we load Glib first, so POE
# uses the right loop.

use Glib;
use POE qw(Loop::Glib); # this is another way to specify which loop to use
use POE::Kernel { loop => 'Glib' }; # and yet another way.

my $s => POE::Session->create (
	inline_states => {
		_start => sub {
			$_[KERNEL]->yield('foo');
		},
		foo => sub {
			print "bar\n";
		},
	},
);

$poe_kernel->run;
