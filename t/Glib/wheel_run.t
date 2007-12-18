#!/usr/bin/perl -w
# $Id$

use strict;
use lib qw(./mylib);
use Test::More;
use POSIX qw(_exit);

BEGIN {
  eval 'use Glib';
  if ($@) {
    $| = 1;
    print qq(1..0 # Skip Could not load Glib\n);
    CORE::exit(0);
  }
}

require 'wheel_run.pm';

_exit 0 if $^O eq 'MSWin32';
CORE::exit 0;
