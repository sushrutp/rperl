#ifndef __CPP__INCLUDED__types_h
#define __CPP__INCLUDED__types_h 1

// <<< TYPE DEFINES >>>
//#define __PERL__TYPES  // must choose exactly ONE of this,
#define __CPP__TYPES  // or this

# ifdef __CPP__TYPES

#include <RPerl/DataType/Number.cpp>	// -> Number.h
#include <RPerl/DataType/String.cpp>	// -> String.h
#include <RPerl/DataStructure/Array.cpp>	// -> Array.h
#include <RPerl/DataStructure/Hash.cpp>	// -> Hash.h

# endif

#endif