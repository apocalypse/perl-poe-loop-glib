#!/usr/bin/env perl

use ExtUtils::MakeMaker;

# the POE::Test::Loops tests check for this file to determine whether
# we want to run network tests. for now, always run them.
#open(TOUCH,"+>run_network_tests") and close TOUCH;
#
#system(
#	"poe-gen-tests", "--dirbase", "t/", "--loop", "Glib"
#) and die $!;


WriteMakefile(
   MAKEFILE => 'Makefile',
   AUTHOR => 'Martijn van Beers  <martijn@cpan.org>',
   LICENSE => 'GPL',
   VERSION_FROM => 'lib/POE/Loop/Glib.pm',
   ABSTRACT_FROM => 'lib/POE/Loop/Glib.pm',
   NAME => 'POE::Loop::Glib',
   PREREQ_PM => {
      'POE' => '0.30',
      'Glib' => '0',
#      'POE::Test::DondeEstan' => '0',
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
