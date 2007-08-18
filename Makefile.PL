#!/usr/bin/env perl

use ExtUtils::MakeMaker;

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
      DIST_DEFAULT => 'all gentests  manifest tardist',
   },

   test => {
      TESTS => "t/*.t t/Glib/*.t",
   }
);
