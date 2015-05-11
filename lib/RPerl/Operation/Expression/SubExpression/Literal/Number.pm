# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Literal::Number;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression::Literal);
use RPerl::Operation::Expression::SubExpression::Literal;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Literal::Number->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $value           = $self->{children}->[0];
    my string $value_type = type($value);
    if ($value_type eq 'integer') {
        $rperl_source_group->{PMC} .= integer_to_string($value);
    }
    elsif ($value_type eq 'number') {
        $rperl_source_group->{PMC} .= number_to_string($value);
    }
    else {
        $rperl_source_group->{PMC} .= $value;
    }


    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{<<< RP::O::E::SE::L::N DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{<<< RP::O::E::SE::L::N DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;
