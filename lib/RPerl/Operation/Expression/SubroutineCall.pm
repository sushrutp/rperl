# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubroutineCall;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression);
use RPerl::Operation::Expression;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in SubroutineCall->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Expression_152' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $self )
                . ' found where Expression_152 expected, dying' )
            . "\n";
    }

    # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
    my object $name               = $self->{children}->[0];
    my string $left_paren         = $self->{children}->[1];
    my object $arguments_optional = $self->{children}->[2];
    my string $right_paren        = $self->{children}->[3];
    $rperl_source_group->{PMC} .= $name->{children}->[0] . $left_paren;

    # DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
    # NEED ANSWER: how to trigger ECOGEASxP182x? we must first declare a subroutine which will trigger ECOGEASxP181x instead...
    if (((substr $name, 0, 1) eq '_') and ($modes->{_symbol_table}->{_namespace} eq q{})) {
        die 'ERROR ECOGEASRP182a, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'call to global subroutine name ' . q{'} . $name . q{()'} .
            ' must not start with an underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name =~ m/^_[A-Z]/gxms) {
        die 'ERROR ECOGEASRP182b, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'call to subroutine name ' . q{'} . $name . q{()'} .
            ' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name =~ m/__/gxms) {
        die 'ERROR ECOGEASRP182c, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'call to subroutine name ' . q{'} . $name . q{()'} .
            ' must not include a double-underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }

    if ( exists $arguments_optional->{children}->[0] ) {
        $rperl_source_subgroup = $arguments_optional->{children}->[0]
            ->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_paren;
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::E::SC __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in SubroutineCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Expression_152' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ( ref $self )
                . ' found where Expression_152 expected, dying' )
            . "\n";
    }

    # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
    my object $name               = $self->{children}->[0];
    my string $left_paren         = $self->{children}->[1];
    my object $arguments_optional = $self->{children}->[2];
    my string $right_paren        = $self->{children}->[3];

    # DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
    # NEED ANSWER: how to trigger ECOGEASxP182x? we must first declare a subroutine which will trigger ECOGEASxP181x instead...
    if (((substr $name, 0, 1) eq '_') and ($modes->{_symbol_table}->{_namespace} eq q{})) {
        die 'ERROR ECOGEASCP182a, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'call to global subroutine name ' . q{'} . $name . q{()'} .
            ' must not start with an underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name =~ m/^_[A-Z]/gxms) {
        die 'ERROR ECOGEASCP182b, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'call to subroutine name ' . q{'} . $name . q{()'} .
            ' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name =~ m/__/gxms) {
        die 'ERROR ECOGEASCP182c, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'call to subroutine name ' . q{'} . $name . q{()'} .
            ' must not include a double-underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }

    # remove leading double-colon scope operator '::'
    my string $name_string = $name->{children}->[0];
    if ((substr $name_string, 0, 2) eq '::') {
        substr $name_string, 0, 2, '';
    }

    # replace RPerl system builtin functions with proper C++ name alternatives
    if (exists $rperloperations::BUILTINS->{$name_string}) {
        $name_string = $rperloperations::BUILTINS->{$name_string};
    }

    # replace all semicolons with underscores
    $name_string =~ s/:/_/gxms;

    # MongoDB support
    if ($name_string eq 'bson_build') {
        if ((not exists $modes->{_enable_mongodb}) or (not defined $modes->{_enable_mongodb}) or (not $modes->{_enable_mongodb})) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP093, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Found subroutine call to '
                . q{'} . $name_string . q{()'}
                . ' but MongoDB support is not enabled, perhaps you forgot to load MongoDB support via `use RPerl::Support::MongoDB;`, dying' )
                . "\n";
        }

#        RPerl::diag( 'in SubroutineCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), call to bson_build(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#        RPerl::diag( 'in SubroutineCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), call to bson_build(), have $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0] = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]) . "\n" );

        if ((exists $modes->{_bson_build_inside}) and
            (defined $modes->{_bson_build_inside}) and
            $modes->{_bson_build_inside}) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP094, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', already inside the same subroutine call, nesting disallowed for this subroutine, dying' ) . "\n";
        }

        elsif ((not defined $arguments_optional) or 
            ((ref $arguments_optional) ne '_OPTIONAL')) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP095a, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }
        elsif ((not exists $arguments_optional->{children}) or 
            (not defined $arguments_optional->{children}) or
            (scalar @{$arguments_optional->{children}}) != 1) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP096a, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }

        elsif ((not defined $arguments_optional->{children}->[0]) or
            ((ref $arguments_optional->{children}->[0]) ne 'ListElements_211')) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP095b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }
        elsif ((not exists $arguments_optional->{children}->[0]->{children}) or
            (not defined $arguments_optional->{children}->[0]->{children}) or
            ((scalar @{$arguments_optional->{children}->[0]->{children}}) != 2)) {  # the empty _STAR_LIST makes 2 elements instead of 1
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP096b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }

        elsif ((not defined $arguments_optional->{children}->[0]->{children}->[1]) or
            ((ref $arguments_optional->{children}->[0]->{children}->[1]) ne '_STAR_LIST')) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP095c, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }
        elsif ((not exists $arguments_optional->{children}->[0]->{children}->[1]->{children}) or
            (not defined $arguments_optional->{children}->[0]->{children}->[1]->{children}) or
            ((scalar @{$arguments_optional->{children}->[0]->{children}->[1]->{children}}) != 0)) {  # the empty _STAR_LST has 0 children elements
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP096c, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }

        elsif ((not defined $arguments_optional->{children}->[0]->{children}->[0]) or
            ((ref $arguments_optional->{children}->[0]->{children}->[0]) ne 'ListElement_212')) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP095d, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }
        elsif ((not exists $arguments_optional->{children}->[0]->{children}->[0]->{children}) or
            (not defined $arguments_optional->{children}->[0]->{children}->[0]->{children}) or
            ((scalar @{$arguments_optional->{children}->[0]->{children}->[0]->{children}}) != 1)) {
#            RPerl::diag( 'in SubroutineCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), call to bson_build(), have $arguments_optional->{children}->[0]->{children}->[0]->{children} = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional->{children}->[0]->{children}->[0]->{children}) . "\n" );
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP096d, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }

        elsif ((not defined $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]) or
            ((ref $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]) ne 'SubExpression_161')) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP095e, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }
        elsif ((not exists $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}) or
            (not defined $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}) or
            ((scalar @{$arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}}) != 1)) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP096e, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }

        elsif ((not defined $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]) or
            ((ref $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]) ne 'HashReference_232')) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP095f, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }
        elsif ((not exists $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}) or
            (not defined $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}) or
            ((scalar @{$arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}}) == 0)) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP096f, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In subroutine call to '
                . q{'} . $name_string . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, dying' ) . "\n";
        }

        $cpp_source_group->{CPP} .= 'bson_begin';

        if ( exists $arguments_optional->{children}->[0] ) {
            $modes->{_bson_build_top} = 1;
            $modes->{_bson_build_inside} = 1;
            $cpp_source_subgroup = $arguments_optional->{children}->[0]->{children}->[0]->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES__bson_build($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $modes->{_bson_build_inside} = 0;
        }

        $cpp_source_group->{CPP} .= ' << bson_end';
    }

    # normal subroutine call
    else {
        $cpp_source_group->{CPP} .= $name_string . $left_paren;

        if ( exists $arguments_optional->{children}->[0] ) {
            $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }

        $cpp_source_group->{CPP} .= $right_paren;
    }

    return $cpp_source_group;
}

1;    # end of class
