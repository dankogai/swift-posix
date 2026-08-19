/*:
 [Previous](@previous)

 # `<math.h>` — the full C99 repertoire

 Swift's standard library has no `sin`, `pow`, or `lgamma` without
 Foundation.  POSIX carries them all, `Double` in and out.
 */
import POSIX

POSIX.sin(POSIX.M_PI / 6)            // 0.5 (nearly)
POSIX.pow(2, 10)                     // 1024
POSIX.hypot(3, 4)                    // 5
POSIX.cbrt(27)                       // 3
POSIX.tgamma(5)                      // 4! = 24
POSIX.erf(1)
//: Out-parameters become tuples:
let (mantissa, exponent) = POSIX.frexp(8)     // (0.5, 4)
POSIX.ldexp(mantissa, exponent)               // 8 again
let (frac, int) = POSIX.modf(3.25)            // (0.25, 3.0)
let (rem, quo) = POSIX.remquo(7.5, 2)         // (-0.5, 4)
//: The rounding family, with C semantics:
POSIX.round(2.5)                     // 3 — halves away from zero
POSIX.rint(2.5)                      // 2 — halves to even
POSIX.floor(-3.1)                    // -4
POSIX.trunc(-3.9)                    // -3
POSIX.fmod(7.5, 2)                   // 1.5
POSIX.remainder(7.5, 2)              // -0.5
//: Classification is swifty — `fpclassify` returns Swift's own enum:
POSIX.fpclassify(1.0)                // .positiveNormal
POSIX.fpclassify(-0.0)               // .negativeZero
POSIX.isnan(POSIX.nan())
POSIX.isinf(POSIX.HUGE_VAL)
POSIX.signbit(-0.0)                  // true — try that with `<`!
//: And the floating-point environment:
POSIX.fesetround(POSIX.FE_DOWNWARD)
POSIX.fesetround(POSIX.FE_TONEAREST)
/*:
 [Next: Strings](@next)
 */
