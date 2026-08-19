import Testing
import POSIXGlobals

@Suite struct MathTests {
    @Test func transcendentals() {
        #expect(abs(sin(M_PI)) < 1e-15)
        #expect(cos(0) == 1)
        #expect(abs(tan(M_PI_4) - 1) < 1e-15)
        #expect(acos(1) == 0)
        #expect(asin(0) == 0)
        #expect(atan(1) == M_PI_4)
        #expect(atan2(1, 1) == M_PI_4)
        #expect(exp(0) == 1)
        #expect(abs(exp(1) - M_E) < 1e-15)
        #expect(log(M_E) == 1)
        #expect(log10(1000) == 3)
        #expect(log2(8) == 3)
        #expect(abs(expm1(1e-10) - 1e-10) < 1e-20)
        #expect(abs(log1p(1e-10) - 1e-10) < 1e-20)
        #expect(pow(2, 10) == 1024)
        #expect(abs(cbrt(27) - 3) < 1e-14) // glibc's cbrt is 1 ulp off
        #expect(hypot(3, 4) == 5)
        #expect(sinh(0) == 0)
        #expect(cosh(0) == 1)
        #expect(tanh(0) == 0)
        #expect(asinh(0) == 0)
        #expect(acosh(1) == 0)
        #expect(atanh(0) == 0)
        #expect(tgamma(5) == 24)
        #expect(abs(lgamma(1)) < 1e-15)
        #expect(erf(0) == 0)
        #expect(erfc(0) == 1)
    }

    @Test func roundingAndParts() {
        #expect(floor(3.7) == 3)
        #expect(floor(-3.1) == -4)
        #expect(ceil(3.1) == 4)
        #expect(trunc(-3.9) == -3)
        #expect(round(2.5) == 3)
        #expect(rint(2.5) == 2)
        #expect(nearbyint(3.5) == 4)
        #expect(lround(2.5) == 3)
        #expect(lrint(2.5) == 2)
        #expect(fmod(7.5, 2) == 1.5)
        #expect(remainder(7.5, 2) == -0.5)
        let (rem, quo) = remquo(7.5, 2)
        #expect(rem == -0.5 && quo & 3 == 0) // quotient 4: low bits 00
        #expect(sqrt(16) == 4)
        #expect(fabs(-2.5) == 2.5)
        #expect(fma(2, 3, 4) == 10)
        #expect(fmax(1, 2) == 2)
        #expect(fmin(1, 2) == 1)
        #expect(fmax(.nan, 2) == 2)
        #expect(fdim(5, 3) == 2)
        #expect(fdim(3, 5) == 0)
        #expect(copysign(3, -1) == -3)
        #expect(nextafter(1, 2) == 1.0.nextUp)
        #expect(nextafter(1, 0) == 1.0.nextDown)
        #expect(nextafter(1, 1) == 1)
    }

    @Test func decomposition() {
        let (m, e) = frexp(8)
        #expect(m == 0.5 && e == 4)
        #expect(ldexp(0.5, 4) == 8)
        #expect(scalbn(1, 10) == 1024)
        // two-step 2**n would overflow here; real ldexp must not
        #expect(ldexp(1e-300, 2000).isFinite)
        let (f, i) = modf(3.25)
        #expect(f == 0.25 && i == 3)
        #expect(logb(8) == 3)
        #expect(ilogb(8) == 3)
        #expect(signbit(-0.0))
        #expect(!signbit(0.0))
    }

    @Test func classification() {
        #expect(isnan(nan()))
        #expect(isnan(NAN))
        #expect(isinf(HUGE_VAL))
        #expect(isfinite(1.0))
        #expect(!isnormal(0.0))
        #expect(fpclassify(1.0) == .positiveNormal)
        #expect(fpclassify(-0.0) == .negativeZero)
        #expect(isgreater(2, 1))
        #expect(isless(1, 2))
        #expect(islessgreater(1, 2))
        #expect(isunordered(nan(), 1))
        #expect(!isunordered(1, 2))
    }

    @Test func roundingMode() {
        let saved = fegetround()
        defer { fesetround(saved) }
        fesetround(FE_TONEAREST)
        #expect(fegetround() == FE_TONEAREST)
    }
}
