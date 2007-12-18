#!/usr/bin/env perl

use ExtUtils::MakeMaker;

# the POE::Test::Loops tests check for this file to determine whether
# we want to run network tests. for now, always run them.
open(TOUCH,"+>run_network_tests") and close TOUCH;

sub MY::postamble {
   package MY;
   "\ngentests :\n" .
#   "\tcvs2cl\n" .
   "\tpoe-gen-tests --dirbase t/ --loop Glib\n" .
   "\n"
}

WriteMakefile(
   MAKEFILE => 'Makefile',
   VERSION_FROM => 'lib/POE/Loop/Glib.pm',
   NAME => 'POE::Loop::Glib',
   PREREQ_PM => {
      'POE' => '0.30',
      'Glib' => '0',
   },

   dist => {
      COMPRESS     =>'gzip',
      SUFFIX       =>'gz',
      DIST_DEFAULT => 'all manifest tardist',
   },

   test => {
      TESTS => "t/*.t t/Glib/*.t",
   }
);
