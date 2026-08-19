/// Limits.swift — <limits.h> and <float.h> constants, defined natively
/// from Swift's numeric types.

public let CHAR_BIT = 8
public let SCHAR_MAX = Int8.max
public let SCHAR_MIN = Int8.min
public let UCHAR_MAX = UInt8.max
public let CHAR_MAX = CChar.max
public let CHAR_MIN = CChar.min
public let SHRT_MAX = Int16.max
public let SHRT_MIN = Int16.min
public let USHRT_MAX = UInt16.max
public let INT_MAX = CInt.max
public let INT_MIN = CInt.min
public let UINT_MAX = UInt32.max
public let LONG_MAX = Int.max
public let LONG_MIN = Int.min
public let ULONG_MAX = UInt.max
public let LLONG_MAX = Int64.max
public let LLONG_MIN = Int64.min
public let ULLONG_MAX = UInt64.max
public let SSIZE_MAX = Int.max

public let FLT_RADIX = 2
public let DBL_MAX = Double.greatestFiniteMagnitude
public let DBL_MIN = Double.leastNormalMagnitude
public let DBL_TRUE_MIN = Double.leastNonzeroMagnitude
public let DBL_EPSILON = Double.ulpOfOne
public let DBL_MANT_DIG = Double.significandBitCount + 1
public let DBL_MAX_EXP = Double.greatestFiniteMagnitude.exponent + 1
public let DBL_MIN_EXP = Double.leastNormalMagnitude.exponent + 1
public let FLT_MAX = Float.greatestFiniteMagnitude
public let FLT_MIN = Float.leastNormalMagnitude
public let FLT_TRUE_MIN = Float.leastNonzeroMagnitude
public let FLT_EPSILON = Float.ulpOfOne
public let FLT_MANT_DIG = Float.significandBitCount + 1
