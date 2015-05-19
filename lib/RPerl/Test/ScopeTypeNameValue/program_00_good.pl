#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => []};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => ['unknown']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => ['unknown','unknown']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => ['unknown','integer']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => ['unknown','unknown','unknown','unknown','unknown']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => ['unknown','unknown','unknown','integer','unknown']};" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
my arrayref $u = [];
print Dumper( types($u) ) . "\n";
$u = [undef];
print Dumper( types($u) ) . "\n";
$u = [ undef, undef ];
print Dumper( types($u) ) . "\n";
$u = [ undef, 1 ];
print Dumper( types($u) ) . "\n";
$u = [ undef, undef, undef, undef, undef ];
print Dumper( types($u) ) . "\n";
$u = [ undef, undef, undef, 1, undef ];
print Dumper( types($u) ) . "\n";