#!/usr/bin/env perl

use ExtUtils::MakeMaker;

sub MY::postamble {
   package MY;
   "\npredist: all\n" .
#   "\tcvs2cl\n" .
   "\t\$(MAKE) manifest\n" .
   "\t\$(MAKE) tardist\n"
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
      DIST_DEFAULT => 'predist',
   },
);
