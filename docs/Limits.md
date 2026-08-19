# `<limits.h>`, `<float.h>` — numeric constants

Defined natively from Swift's numeric types (so they are exact by
construction), exported for POSIX.pm parity:

```swift
// <limits.h>
CHAR_BIT                                  // 8
SCHAR_MAX  SCHAR_MIN  UCHAR_MAX
CHAR_MAX   CHAR_MIN
SHRT_MAX   SHRT_MIN   USHRT_MAX
INT_MAX    INT_MIN    UINT_MAX
LONG_MAX   LONG_MIN   ULONG_MAX
LLONG_MAX  LLONG_MIN  ULLONG_MAX
SSIZE_MAX

// <float.h>
FLT_RADIX                                 // 2
DBL_MAX  DBL_MIN  DBL_TRUE_MIN  DBL_EPSILON
DBL_MANT_DIG  DBL_MAX_EXP  DBL_MIN_EXP
FLT_MAX  FLT_MIN  FLT_TRUE_MIN  FLT_EPSILON
FLT_MANT_DIG
```

## Example

```swift
import POSIX

POSIX.INT_MAX          // 2147483647
POSIX.DBL_EPSILON      // 2.220446049250313e-16
POSIX.CHAR_BIT         // 8
```

## Notes

* In new Swift code prefer the native spellings (`Int32.max`,
  `Double.ulpOfOne`, …); these constants exist so POSIX-shaped code
  reads as written.
* Filesystem limits like `NAME_MAX` are runtime properties of a path —
  ask [`pathconf`](Unistd.md) instead.
