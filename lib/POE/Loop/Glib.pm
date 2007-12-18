# $Id: Glib.pm 22 2004-12-10 11:34:44Z martijn $

# Glib event loop bridge for POE::Kernel.

# Empty package to appease perl.
package POE::Loop::Glib;
use strict;

use POE::Kernel; # for MakeMaker
use vars qw($VERSION);
$VERSION = do {my@r=(0,q$Rev: 30 $=~/\d+/g);sprintf"%d."."%04d"x$#r,@r};

# Include common signal handling.
use POE::Loop::GlibCommon;

# Everything plugs into POE::Kernel.
package POE::Kernel;

use strict;

my $glib_mainloop;

#------------------------------------------------------------------------------
# Loop construction and destruction.

sub loop_attach_uidestroy {
  my ($self, $window) = @_;

  # Don't bother posting the signal if there are no sessions left.  I
  # think this is a bit of a kludge: the situation where a window
  # lasts longer than POE::Kernel should never occur.
  $window->signal_connect
    ( delete_event =>
      sub {
        if ($self->_data_ses_count()) {
          $self->_dispatch_event(
            $self, $self,
            EN_SIGNAL, ET_SIGNAL, [ 'UIDESTROY' ],
            __FILE__, __LINE__, time(), -__LINE__
          );
        }
        return 0;
      }
    );
}

sub loop_initialize {
  my $self = shift;

  $glib_mainloop = Glib::MainLoop->new unless (Glib::main_depth() > 0);
  Glib->install_exception_handler (\&ex);

}

sub loop_run {
  (defined $glib_mainloop) && $glib_mainloop->run;
  if (defined $POE::Kernel::_glib_loop_exception) {
	my $ex = $POE::Kernel::_glib_loop_exception;
	undef $POE::Kernel::_glib_loop_exception;
  	die $ex;
  }
}

sub loop_halt {
  (defined $glib_mainloop) && $glib_mainloop->quit;
}

our $_glib_loop_exception;

sub ex {
  $_glib_loop_exception = shift;
  &loop_finalize;
  &loop_halt;

  return 0;
}

1;

__END__

=head1 NAME

POE::Loop::Glib - a bridge that supports Glib's event loop from POE

=head1 SYNOPSIS

See L<POE::Loop>.

=head1 DESCRIPTION

This class is an implementation of the abstract POE::Loop interface.
It follows POE::Loop's public interface exactly.  Therefore, please
see L<POE::Loop> for its documentation.

=head1 SEE ALSO

L<POE>, L<POE::Loop>, L<Glib>, L<Glib::MainLoop>

=head1 AUTHORS & LICENSING

Please see L<POE> for more information about authors, contributors,
and POE's licensing.

=for poe_tests

{
	module => 'Glib',
}

=cut
