#!/usr/bin/perl
use strict; use warnings;

use Test::More;
eval "use Test::Apocalypse";
if ( $@ ) {
	plan skip_all => 'Test::Apocalypse required for validating the distribution';
} else {
	require Test::NoWarnings; require Test::Pod; require Test::Pod::Coverage;	# lousy hack for kwalitee

	is_apocalypse_here( {
		deny => qr/^(?:(?:OutdatedPrereq|Dependencie)s|ModuleUsed|Strict|Fixme|Pod_Spelling)$/,
	} );
}
