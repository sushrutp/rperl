#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]
my string_arrayref $flintstones_and_rubbles = [qw(fred betty barney dino wilma pebbles bamm-bamm)];
my integer_arrayref $input_indices = [];

print 'Please input zero or more integers, separated by <ENTER>, ended by <CTRL-D>:' . "\n";

while (my string $input_string = <STDIN>) {
    push @{$input_indices}, string_to_integer($input_string);
}

print "\n";
print 'Flintstones & Rubbles:' . "\n";

foreach my integer $input_index (@{$input_indices}) {
    print $flintstones_and_rubbles->[($input_index - 1)] . "\n";
}