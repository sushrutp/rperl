#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer__array_ref $i_array;
$i_array = [ -20, -15, -10, -5, 0, 5, 10, 15, 20 ];
print $i_array->[ 1 + 3 + 4 ];