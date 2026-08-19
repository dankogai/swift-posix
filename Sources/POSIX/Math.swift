/// Math.swift — <math.h> and <fenv.h>.
///
/// These exist because, like Perl, Swift's standard library does not
/// provide the full C math repertoire (no `sin`, `pow`, … without
/// Foundation).  Functions with an exact Swift-native equivalent are
/// implemented natively; the rest are thin wrappers over libm.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

// MARK: trigonometric / transcendental (libm)

/// identical to C's `acos(3)`.
public func acos(_ x: Double) -> Double { C.acos(x) }
/// identical to C's `acosh(3)`.
public func acosh(_ x: Double) -> Double { C.acosh(x) }
/// identical to C's `asin(3)`.
public func asin(_ x: Double) -> Double { C.asin(x) }
/// identical to C's `asinh(3)`.
public func asinh(_ x: Double) -> Double { C.asinh(x) }
/// identical to C's `atan(3)`.
public func atan(_ x: Double) -> Double { C.atan(x) }
/// identical to C's `atan2(3)`.
public func atan2(_ y: Double, _ x: Double) -> Double { C.atan2(y, x) }
/// identical to C's `atanh(3)`.
public func atanh(_ x: Double) -> Double { C.atanh(x) }
/// identical to C's `cbrt(3)`.
public func cbrt(_ x: Double) -> Double { C.cbrt(x) }
/// identical to C's `cos(3)`.
public func cos(_ x: Double) -> Double { C.cos(x) }
/// identical to C's `cosh(3)`.
public func cosh(_ x: Double) -> Double { C.cosh(x) }
/// identical to C's `erf(3)`.
public func erf(_ x: Double) -> Double { C.erf(x) }
/// identical to C's `erfc(3)`.
public func erfc(_ x: Double) -> Double { C.erfc(x) }
/// identical to C's `exp(3)`.
public func exp(_ x: Double) -> Double { C.exp(x) }
/// identical to C's `exp2(3)`.
public func exp2(_ x: Double) -> Double { C.exp2(x) }
/// identical to C's `expm1(3)`.
public func expm1(_ x: Double) -> Double { C.expm1(x) }
/// identical to C's `hypot(3)`.
public func hypot(_ x: Double, _ y: Double) -> Double { C.hypot(x, y) }
/// identical to C's `lgamma(3)` (thread-safe; the sign is discarded).
public func lgamma(_ x: Double) -> Double {
    var sign: CInt = 0
    return lgamma_r(x, &sign)
}
/// identical to C's `log(3)`.
public func log(_ x: Double) -> Double { C.log(x) }
/// identical to C's `log10(3)`.
public func log10(_ x: Double) -> Double { C.log10(x) }
/// identical to C's `log1p(3)`.
public func log1p(_ x: Double) -> Double { C.log1p(x) }
/// identical to C's `log2(3)`.
public func log2(_ x: Double) -> Double { C.log2(x) }
/// identical to C's `pow(3)`.
public func pow(_ x: Double, _ y: Double) -> Double { C.pow(x, y) }
/// identical to C's `sin(3)`.
public func sin(_ x: Double) -> Double { C.sin(x) }
/// identical to C's `sinh(3)`.
public func sinh(_ x: Double) -> Double { C.sinh(x) }
/// identical to C's `tan(3)`.
public func tan(_ x: Double) -> Double { C.tan(x) }
/// identical to C's `tanh(3)`.
public func tanh(_ x: Double) -> Double { C.tanh(x) }
/// identical to C's `tgamma(3)`.
public func tgamma(_ x: Double) -> Double { C.tgamma(x) }

// MARK: rounding, decomposition, and friends (Swift-native)

/// identical to C's `ceil(3)`.
public func ceil(_ x: Double) -> Double { x.rounded(.up) }
/// identical to C's `floor(3)`.
public func floor(_ x: Double) -> Double { x.rounded(.down) }
/// identical to C's `trunc(3)`.
public func trunc(_ x: Double) -> Double { x.rounded(.towardZero) }
/// identical to C's `round(3)` (halves away from zero).
public func round(_ x: Double) -> Double { x.rounded(.toNearestOrAwayFromZero) }
/// identical to C's `rint(3)` (halves to even).
public func rint(_ x: Double) -> Double { x.rounded(.toNearestOrEven) }
/// identical to C's `nearbyint(3)`.
public func nearbyint(_ x: Double) -> Double { x.rounded(.toNearestOrEven) }
/// identical to C's `lround(3)`.
public func lround(_ x: Double) -> Int { Int(x.rounded(.toNearestOrAwayFromZero)) }
/// identical to C's `lrint(3)`.
public func lrint(_ x: Double) -> Int { Int(x.rounded(.toNearestOrEven)) }
/// identical to C's `sqrt(3)`.
public func sqrt(_ x: Double) -> Double { x.squareRoot() }
/// identical to C's `fabs(3)`.
public func fabs(_ x: Double) -> Double { x.magnitude }
/// identical to C's `fmod(3)`.
public func fmod(_ x: Double, _ y: Double) -> Double { x.truncatingRemainder(dividingBy: y) }
/// identical to C's `remainder(3)`.
public func remainder(_ x: Double, _ y: Double) -> Double { x.remainder(dividingBy: y) }
/// identical to C's `remquo(3)`; returns the remainder and the low quotient bits.
public func remquo(_ x: Double, _ y: Double) -> (remainder: Double, quotient: Int) {
    var q: CInt = 0
    let r = remquo(x, y, &q)
    return (r, Int(q))
}
/// identical to C's `fma(3)`.
public func fma(_ x: Double, _ y: Double, _ z: Double) -> Double { z.addingProduct(x, y) }
/// identical to C's `fmax(3)` (NaN-ignoring maximum).
public func fmax(_ x: Double, _ y: Double) -> Double { Double.maximum(x, y) }
/// identical to C's `fmin(3)` (NaN-ignoring minimum).
public func fmin(_ x: Double, _ y: Double) -> Double { Double.minimum(x, y) }
/// identical to C's `fdim(3)`: the positive difference.
public func fdim(_ x: Double, _ y: Double) -> Double {
    if x.isNaN || y.isNaN { return .nan }
    return x > y ? x - y : 0
}
/// identical to C's `copysign(3)`: the magnitude of `x` with the sign of `y`.
public func copysign(_ x: Double, _ y: Double) -> Double { Double(signOf: y, magnitudeOf: x) }
/// identical to C's `nextafter(3)`.
public func nextafter(_ x: Double, _ y: Double) -> Double {
    if x < y { return x.nextUp }
    if x > y { return x.nextDown }
    return y
}
/// identical to C's `frexp(3)`; returns the mantissa in [0.5, 1) and the exponent.
public func frexp(_ x: Double) -> (mantissa: Double, exponent: Int) {
    var e: CInt = 0
    let m = frexp(x, &e)
    return (m, Int(e))
}
/// identical to C's `ldexp(3)`: x * 2**exp.
public func ldexp(_ x: Double, _ exp: Int) -> Double { ldexp(x, CInt(exp)) }
/// identical to C's `scalbn(3)`: x * 2**exp.
public func scalbn(_ x: Double, _ exp: Int) -> Double { scalbn(x, CInt(exp)) }
/// identical to C's `modf(3)`; returns the fractional and integral parts.
public func modf(_ x: Double) -> (fractional: Double, integral: Double) {
    var i: Double = 0
    let f = modf(x, &i)
    return (f, i)
}
/// identical to C's `logb(3)`.
public func logb(_ x: Double) -> Double { C.logb(x) }
/// identical to C's `ilogb(3)`.
public func ilogb(_ x: Double) -> Int { Int(C.ilogb(x)) }
/// identical to C's `nan(3)`.
public func nan(_ tag: String = "") -> Double { tag.withCString { nan($0) } }

// MARK: classification (Swift-native, swifty return types)

/// identical to C's `fpclassify(3)`, but returns Swift's
/// `FloatingPointClassification` instead of an `FP_*` integer.
public func fpclassify(_ x: Double) -> FloatingPointClassification { x.floatingPointClass }
/// true iff the value is NaN.
public func isnan(_ x: Double) -> Bool { x.isNaN }
/// true iff the value is ±infinity.
public func isinf(_ x: Double) -> Bool { x.isInfinite }
/// true iff the value is finite.
public func isfinite(_ x: Double) -> Bool { x.isFinite }
/// true iff the value is normal (not zero, subnormal, infinite, or NaN).
public func isnormal(_ x: Double) -> Bool { x.isNormal }
/// true iff the sign bit is set.
public func signbit(_ x: Double) -> Bool { x.sign == .minus }
/// identical to C's `isgreater` macro.
public func isgreater(_ x: Double, _ y: Double) -> Bool { x > y }
/// identical to C's `isgreaterequal` macro.
public func isgreaterequal(_ x: Double, _ y: Double) -> Bool { x >= y }
/// identical to C's `isless` macro.
public func isless(_ x: Double, _ y: Double) -> Bool { x < y }
/// identical to C's `islessequal` macro.
public func islessequal(_ x: Double, _ y: Double) -> Bool { x <= y }
/// identical to C's `islessgreater` macro.
public func islessgreater(_ x: Double, _ y: Double) -> Bool { x < y || x > y }
/// identical to C's `isunordered` macro.
public func isunordered(_ x: Double, _ y: Double) -> Bool { x.isNaN || y.isNaN }

// MARK: <fenv.h> rounding mode

/// identical to C's `fegetround(3)`.
public func fegetround() -> CInt { C.fegetround() }
/// identical to C's `fesetround(3)`.
@discardableResult
public func fesetround(_ mode: CInt) -> CInt { C.fesetround(mode) }

// (FE_* and M_* constants are re-exported in Platform.swift)

// MARK: constants

public let HUGE_VAL = Double.infinity
public let INFINITY = Double.infinity
public let NAN = Double.nan
