# `<math.h>`, `<fenv.h>` — mathematics

The full C99 repertoire, `Double` in and out.  These exist because,
like Perl, Swift's standard library does not provide them (no `sin`,
`pow`, or `lgamma` without Foundation).

## Transcendental

```swift
acos  acosh  asin  asinh  atan  atanh        // (Double) -> Double
cos   cosh   sin   sinh   tan   tanh
exp   exp2   expm1 log    log10 log1p log2
cbrt  erf    erfc  lgamma tgamma sqrt
atan2(_ y: Double, _ x: Double) -> Double
hypot(_ x: Double, _ y: Double) -> Double
pow(_ x: Double, _ y: Double) -> Double
```

`lgamma` uses `lgamma_r` internally, so it is thread-safe (the sign is
discarded, as in Perl).

## Rounding

```swift
ceil   floor  trunc                    // toward +∞ / -∞ / zero
round                                  // halves away from zero
rint   nearbyint                       // halves to even
lround(_ x: Double) -> Int             // like round, to Int
lrint(_ x: Double) -> Int              // like rint, to Int
```

## Decomposition and manipulation

```swift
fabs(_ x: Double) -> Double
fmod(_ x: Double, _ y: Double) -> Double
remainder(_ x: Double, _ y: Double) -> Double
remquo(_ x: Double, _ y: Double) -> (remainder: Double, quotient: Int)
fma(_ x: Double, _ y: Double, _ z: Double) -> Double
fmax(_ x: Double, _ y: Double) -> Double     // NaN-ignoring
fmin(_ x: Double, _ y: Double) -> Double     // NaN-ignoring
fdim(_ x: Double, _ y: Double) -> Double     // positive difference
copysign(_ x: Double, _ y: Double) -> Double
nextafter(_ x: Double, _ y: Double) -> Double
frexp(_ x: Double) -> (mantissa: Double, exponent: Int)  // mantissa in [0.5, 1)
ldexp(_ x: Double, _ exp: Int) -> Double     // x * 2**exp
scalbn(_ x: Double, _ exp: Int) -> Double
modf(_ x: Double) -> (fractional: Double, integral: Double)
logb(_ x: Double) -> Double
ilogb(_ x: Double) -> Int
nan(_ tag: String = "") -> Double
```

## Classification

```swift
fpclassify(_ x: Double) -> FloatingPointClassification  // Swift's enum!
isnan  isinf  isfinite  isnormal  signbit   // (Double) -> Bool
isgreater isgreaterequal isless islessequal islessgreater isunordered
                                            // (Double, Double) -> Bool
```

## Floating-point environment

```swift
fegetround() -> CInt
fesetround(_ mode: CInt) -> CInt   // @discardableResult
// constants: FE_TONEAREST, FE_TOWARDZERO, FE_UPWARD, FE_DOWNWARD
```

## Constants

`M_E M_LOG2E M_LOG10E M_LN2 M_LN10 M_PI M_PI_2 M_PI_4 M_1_PI M_2_PI
M_2_SQRTPI M_SQRT2 M_SQRT1_2 HUGE_VAL INFINITY NAN`

## Example

```swift
import POSIX

POSIX.pow(2, 10)                     // 1024.0
let (m, e) = POSIX.frexp(8)          // (0.5, 4)
POSIX.ldexp(m, e)                    // 8.0
POSIX.round(2.5)                     // 3.0 — away from zero
POSIX.rint(2.5)                      // 2.0 — to even
POSIX.fpclassify(-0.0)               // .negativeZero
```

## Notes

* `div`/`ldiv` are C-specific and unimplemented — use
  `quotientAndRemainder(dividingBy:)`.
* Where a Swift-native operation is exactly equivalent (`floor`,
  `sqrt`, `fma`, …) the implementation is native; the transcendentals
  call libm.
