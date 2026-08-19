/// Platform.swift — platform imports, exported C typealiases, and
/// disambiguation shims.
///
/// This module deliberately re-declares many libc names with swifty
/// signatures.  Where our signature is *identical* to the C one (so an
/// unqualified call inside this module would recurse into itself), the
/// implementation calls the C function through the `C` namespace below,
/// which is qualified per platform.

#if canImport(Darwin)
import Darwin
import locale_h // Darwin's module map keeps <locale.h> separate
import fenv_h // ... and <fenv.h> too

// The Darwin overlay marks fork() unavailable in Swift; a POSIX layer
// wants it anyway, so bind the symbol directly.
@_silgen_name("fork")
private func darwin_fork() -> pid_t

// C integer/scalar types re-exported so that `import POSIX` suffices.
public typealias pid_t = Darwin.pid_t
public typealias uid_t = Darwin.uid_t
public typealias gid_t = Darwin.gid_t
public typealias mode_t = Darwin.mode_t
public typealias off_t = Darwin.off_t
public typealias time_t = Darwin.time_t
public typealias clock_t = Darwin.clock_t
public typealias dev_t = Darwin.dev_t
public typealias ino_t = Darwin.ino_t
public typealias nlink_t = Darwin.nlink_t
public typealias blkcnt_t = Darwin.blkcnt_t
public typealias blksize_t = Darwin.blksize_t
public typealias speed_t = Darwin.speed_t
public typealias tcflag_t = Darwin.tcflag_t
public typealias cc_t = Darwin.cc_t
public typealias wchar_t = Darwin.wchar_t

// Top-level C constants whose names we re-export at the top level must be
// module-qualified (a private alias would circularly find our own copy).
public let M_E = Darwin.M_E
public let M_LOG2E = Darwin.M_LOG2E
public let M_LOG10E = Darwin.M_LOG10E
public let M_LN2 = Darwin.M_LN2
public let M_LN10 = Darwin.M_LN10
public let M_PI = Darwin.M_PI
public let M_PI_2 = Darwin.M_PI_2
public let M_PI_4 = Darwin.M_PI_4
public let M_1_PI = Darwin.M_1_PI
public let M_2_PI = Darwin.M_2_PI
public let M_2_SQRTPI = Darwin.M_2_SQRTPI
public let M_SQRT2 = Darwin.M_SQRT2
public let M_SQRT1_2 = Darwin.M_SQRT1_2
public let FE_TONEAREST = fenv_h.FE_TONEAREST
public let FE_TOWARDZERO = fenv_h.FE_TOWARDZERO
public let FE_UPWARD = fenv_h.FE_UPWARD
public let FE_DOWNWARD = fenv_h.FE_DOWNWARD
public let CLOCKS_PER_SEC = Darwin.CLOCKS_PER_SEC
public let FD_CLOEXEC = Darwin.FD_CLOEXEC

internal enum C {
    // <math.h> — identical signatures, must be qualified
    static func acos(_ x: Double) -> Double { Darwin.acos(x) }
    static func acosh(_ x: Double) -> Double { Darwin.acosh(x) }
    static func asin(_ x: Double) -> Double { Darwin.asin(x) }
    static func asinh(_ x: Double) -> Double { Darwin.asinh(x) }
    static func atan(_ x: Double) -> Double { Darwin.atan(x) }
    static func atan2(_ y: Double, _ x: Double) -> Double { Darwin.atan2(y, x) }
    static func atanh(_ x: Double) -> Double { Darwin.atanh(x) }
    static func cbrt(_ x: Double) -> Double { Darwin.cbrt(x) }
    static func cos(_ x: Double) -> Double { Darwin.cos(x) }
    static func cosh(_ x: Double) -> Double { Darwin.cosh(x) }
    static func erf(_ x: Double) -> Double { Darwin.erf(x) }
    static func erfc(_ x: Double) -> Double { Darwin.erfc(x) }
    static func exp(_ x: Double) -> Double { Darwin.exp(x) }
    static func exp2(_ x: Double) -> Double { Darwin.exp2(x) }
    static func expm1(_ x: Double) -> Double { Darwin.expm1(x) }
    static func hypot(_ x: Double, _ y: Double) -> Double { Darwin.hypot(x, y) }
    static func log(_ x: Double) -> Double { Darwin.log(x) }
    static func log10(_ x: Double) -> Double { Darwin.log10(x) }
    static func log1p(_ x: Double) -> Double { Darwin.log1p(x) }
    static func log2(_ x: Double) -> Double { Darwin.log2(x) }
    static func logb(_ x: Double) -> Double { Darwin.logb(x) }
    static func ilogb(_ x: Double) -> Int32 { Darwin.ilogb(x) }
    static func pow(_ x: Double, _ y: Double) -> Double { Darwin.pow(x, y) }
    static func sin(_ x: Double) -> Double { Darwin.sin(x) }
    static func sinh(_ x: Double) -> Double { Darwin.sinh(x) }
    static func tan(_ x: Double) -> Double { Darwin.tan(x) }
    static func tanh(_ x: Double) -> Double { Darwin.tanh(x) }
    static func tgamma(_ x: Double) -> Double { Darwin.tgamma(x) }
    static func fegetround() -> Int32 { fenv_h.fegetround() }
    static func fesetround(_ r: Int32) -> Int32 { fenv_h.fesetround(r) }
    // <stdlib.h>
    static func exit(_ status: Int32) -> Never { Darwin.exit(status) }
    static func abort() -> Never { Darwin.abort() }
    // <unistd.h> and friends
    static func _exit(_ status: Int32) -> Never { Darwin._exit(status) }
    static func fork() -> pid_t { darwin_fork() }
    static func getpid() -> pid_t { Darwin.getpid() }
    static func getppid() -> pid_t { Darwin.getppid() }
    static func getuid() -> uid_t { Darwin.getuid() }
    static func geteuid() -> uid_t { Darwin.geteuid() }
    static func getgid() -> gid_t { Darwin.getgid() }
    static func getegid() -> gid_t { Darwin.getegid() }
    static func getpgrp() -> pid_t { Darwin.getpgrp() }
    static func setsid() -> pid_t { Darwin.setsid() }
    static func setuid(_ uid: uid_t) -> Int32 { Darwin.setuid(uid) }
    static func setgid(_ gid: gid_t) -> Int32 { Darwin.setgid(gid) }
    static func setpgid(_ pid: pid_t, _ pgid: pid_t) -> Int32 { Darwin.setpgid(pid, pgid) }
    static func umask(_ cmask: mode_t) -> mode_t { Darwin.umask(cmask) }
    static func alarm(_ seconds: UInt32) -> UInt32 { Darwin.alarm(seconds) }
    static func pause() -> Int32 { Darwin.pause() }
    static func sleep(_ seconds: UInt32) -> UInt32 { Darwin.sleep(seconds) }
    static func clock() -> clock_t { Darwin.clock() }
    static func isatty(_ fd: Int32) -> Int32 { Darwin.isatty(fd) }
    static func close(_ fd: Int32) -> Int32 { Darwin.close(fd) }
    static func dup(_ fd: Int32) -> Int32 { Darwin.dup(fd) }
    static func dup2(_ fd: Int32, _ fd2: Int32) -> Int32 { Darwin.dup2(fd, fd2) }
    static func nice(_ incr: Int32) -> Int32 { Darwin.nice(incr) }
    static func raise(_ sig: Int32) -> Int32 { Darwin.raise(sig) }
    static func getlogin() -> UnsafeMutablePointer<CChar>? { Darwin.getlogin() }
    static func ttyname(_ fd: Int32) -> UnsafeMutablePointer<CChar>? { Darwin.ttyname(fd) }
    // <time.h>
    static func difftime(_ t1: time_t, _ t0: time_t) -> Double { Darwin.difftime(t1, t0) }
    static func tzset() { Darwin.tzset() }
    // <locale.h>
    static func localeconv() -> UnsafeMutablePointer<lconv>? { locale_h.localeconv() }
    // <termios.h>
    static func tcdrain(_ fd: Int32) -> Int32 { Darwin.tcdrain(fd) }
    static func tcflow(_ fd: Int32, _ action: Int32) -> Int32 { Darwin.tcflow(fd, action) }
    static func tcflush(_ fd: Int32, _ queue: Int32) -> Int32 { Darwin.tcflush(fd, queue) }
    static func tcsendbreak(_ fd: Int32, _ duration: Int32) -> Int32 { Darwin.tcsendbreak(fd, duration) }
    static func tcgetpgrp(_ fd: Int32) -> pid_t { Darwin.tcgetpgrp(fd) }
    static func tcsetpgrp(_ fd: Int32, _ pgid: pid_t) -> Int32 { Darwin.tcsetpgrp(fd, pgid) }
}

#elseif canImport(Glibc)
import Glibc

// C integer/scalar types re-exported so that `import POSIX` suffices.
public typealias pid_t = Glibc.pid_t
public typealias uid_t = Glibc.uid_t
public typealias gid_t = Glibc.gid_t
public typealias mode_t = Glibc.mode_t
public typealias off_t = Glibc.off_t
public typealias time_t = Glibc.time_t
public typealias clock_t = Glibc.clock_t
public typealias dev_t = Glibc.dev_t
public typealias ino_t = Glibc.ino_t
public typealias nlink_t = Glibc.nlink_t
public typealias blkcnt_t = Glibc.blkcnt_t
public typealias blksize_t = Glibc.blksize_t
public typealias speed_t = Glibc.speed_t
public typealias tcflag_t = Glibc.tcflag_t
public typealias cc_t = Glibc.cc_t
public typealias wchar_t = Glibc.wchar_t

// Top-level C constants whose names we re-export at the top level must be
// module-qualified (a private alias would circularly find our own copy).
public let M_E = Glibc.M_E
public let M_LOG2E = Glibc.M_LOG2E
public let M_LOG10E = Glibc.M_LOG10E
public let M_LN2 = Glibc.M_LN2
public let M_LN10 = Glibc.M_LN10
public let M_PI = Glibc.M_PI
public let M_PI_2 = Glibc.M_PI_2
public let M_PI_4 = Glibc.M_PI_4
public let M_1_PI = Glibc.M_1_PI
public let M_2_PI = Glibc.M_2_PI
public let M_2_SQRTPI = Glibc.M_2_SQRTPI
public let M_SQRT2 = Glibc.M_SQRT2
public let M_SQRT1_2 = Glibc.M_SQRT1_2
// SwiftGlibc imports the FE_* rounding modes twice (an unresolvable
// ambiguity), so spell out these per-architecture ABI constants.
#if arch(x86_64) || arch(i386)
public let FE_TONEAREST: CInt = 0
public let FE_DOWNWARD: CInt = 0x400
public let FE_UPWARD: CInt = 0x800
public let FE_TOWARDZERO: CInt = 0xc00
#elseif arch(arm64) || arch(arm)
public let FE_TONEAREST: CInt = 0
public let FE_UPWARD: CInt = 0x400000
public let FE_DOWNWARD: CInt = 0x800000
public let FE_TOWARDZERO: CInt = 0xc00000
#elseif arch(riscv64)
public let FE_TONEAREST: CInt = 0
public let FE_TOWARDZERO: CInt = 1
public let FE_DOWNWARD: CInt = 2
public let FE_UPWARD: CInt = 3
#elseif arch(powerpc64) || arch(powerpc64le) || arch(s390x)
public let FE_TONEAREST: CInt = 0
public let FE_TOWARDZERO: CInt = 1
public let FE_UPWARD: CInt = 2
public let FE_DOWNWARD: CInt = 3
#endif // other architectures: no FE_* constants
public let CLOCKS_PER_SEC = Glibc.CLOCKS_PER_SEC
public let FD_CLOEXEC = Glibc.FD_CLOEXEC

internal enum C {
    // <math.h> — identical signatures, must be qualified
    static func acos(_ x: Double) -> Double { Glibc.acos(x) }
    static func acosh(_ x: Double) -> Double { Glibc.acosh(x) }
    static func asin(_ x: Double) -> Double { Glibc.asin(x) }
    static func asinh(_ x: Double) -> Double { Glibc.asinh(x) }
    static func atan(_ x: Double) -> Double { Glibc.atan(x) }
    static func atan2(_ y: Double, _ x: Double) -> Double { Glibc.atan2(y, x) }
    static func atanh(_ x: Double) -> Double { Glibc.atanh(x) }
    static func cbrt(_ x: Double) -> Double { Glibc.cbrt(x) }
    static func cos(_ x: Double) -> Double { Glibc.cos(x) }
    static func cosh(_ x: Double) -> Double { Glibc.cosh(x) }
    static func erf(_ x: Double) -> Double { Glibc.erf(x) }
    static func erfc(_ x: Double) -> Double { Glibc.erfc(x) }
    static func exp(_ x: Double) -> Double { Glibc.exp(x) }
    static func exp2(_ x: Double) -> Double { Glibc.exp2(x) }
    static func expm1(_ x: Double) -> Double { Glibc.expm1(x) }
    static func hypot(_ x: Double, _ y: Double) -> Double { Glibc.hypot(x, y) }
    static func log(_ x: Double) -> Double { Glibc.log(x) }
    static func log10(_ x: Double) -> Double { Glibc.log10(x) }
    static func log1p(_ x: Double) -> Double { Glibc.log1p(x) }
    static func log2(_ x: Double) -> Double { Glibc.log2(x) }
    static func logb(_ x: Double) -> Double { Glibc.logb(x) }
    static func ilogb(_ x: Double) -> Int32 { Glibc.ilogb(x) }
    static func pow(_ x: Double, _ y: Double) -> Double { Glibc.pow(x, y) }
    static func sin(_ x: Double) -> Double { Glibc.sin(x) }
    static func sinh(_ x: Double) -> Double { Glibc.sinh(x) }
    static func tan(_ x: Double) -> Double { Glibc.tan(x) }
    static func tanh(_ x: Double) -> Double { Glibc.tanh(x) }
    static func tgamma(_ x: Double) -> Double { Glibc.tgamma(x) }
    static func fegetround() -> Int32 { Glibc.fegetround() }
    static func fesetround(_ r: Int32) -> Int32 { Glibc.fesetround(r) }
    // <stdlib.h>
    static func exit(_ status: Int32) -> Never { Glibc.exit(status) }
    static func abort() -> Never { Glibc.abort() }
    // <unistd.h> and friends
    static func _exit(_ status: Int32) -> Never { Glibc._exit(status) }
    static func fork() -> pid_t { Glibc.fork() }
    static func getpid() -> pid_t { Glibc.getpid() }
    static func getppid() -> pid_t { Glibc.getppid() }
    static func getuid() -> uid_t { Glibc.getuid() }
    static func geteuid() -> uid_t { Glibc.geteuid() }
    static func getgid() -> gid_t { Glibc.getgid() }
    static func getegid() -> gid_t { Glibc.getegid() }
    static func getpgrp() -> pid_t { Glibc.getpgrp() }
    static func setsid() -> pid_t { Glibc.setsid() }
    static func setuid(_ uid: uid_t) -> Int32 { Glibc.setuid(uid) }
    static func setgid(_ gid: gid_t) -> Int32 { Glibc.setgid(gid) }
    static func setpgid(_ pid: pid_t, _ pgid: pid_t) -> Int32 { Glibc.setpgid(pid, pgid) }
    static func umask(_ cmask: mode_t) -> mode_t { Glibc.umask(cmask) }
    static func alarm(_ seconds: UInt32) -> UInt32 { Glibc.alarm(seconds) }
    static func pause() -> Int32 { Glibc.pause() }
    static func sleep(_ seconds: UInt32) -> UInt32 { Glibc.sleep(seconds) }
    static func clock() -> clock_t { Glibc.clock() }
    static func isatty(_ fd: Int32) -> Int32 { Glibc.isatty(fd) }
    static func close(_ fd: Int32) -> Int32 { Glibc.close(fd) }
    static func dup(_ fd: Int32) -> Int32 { Glibc.dup(fd) }
    static func dup2(_ fd: Int32, _ fd2: Int32) -> Int32 { Glibc.dup2(fd, fd2) }
    static func nice(_ incr: Int32) -> Int32 { Glibc.nice(incr) }
    static func raise(_ sig: Int32) -> Int32 { Glibc.raise(sig) }
    static func getlogin() -> UnsafeMutablePointer<CChar>? { Glibc.getlogin() }
    static func ttyname(_ fd: Int32) -> UnsafeMutablePointer<CChar>? { Glibc.ttyname(fd) }
    // <time.h>
    static func difftime(_ t1: time_t, _ t0: time_t) -> Double { Glibc.difftime(t1, t0) }
    static func tzset() { Glibc.tzset() }
    // <locale.h>
    static func localeconv() -> UnsafeMutablePointer<lconv>? { Glibc.localeconv() }
    // <termios.h>
    static func tcdrain(_ fd: Int32) -> Int32 { Glibc.tcdrain(fd) }
    static func tcflow(_ fd: Int32, _ action: Int32) -> Int32 { Glibc.tcflow(fd, action) }
    static func tcflush(_ fd: Int32, _ queue: Int32) -> Int32 { Glibc.tcflush(fd, queue) }
    static func tcsendbreak(_ fd: Int32, _ duration: Int32) -> Int32 { Glibc.tcsendbreak(fd, duration) }
    static func tcgetpgrp(_ fd: Int32) -> pid_t { Glibc.tcgetpgrp(fd) }
    static func tcsetpgrp(_ fd: Int32, _ pgid: pid_t) -> Int32 { Glibc.tcsetpgrp(fd, pgid) }
}
#endif

/// Converts a fixed-size C char array (imported as a tuple) to a String.
internal func stringFromCCharTuple<T>(_ tuple: T) -> String {
    withUnsafeBytes(of: tuple) { raw in
        String(decoding: raw.prefix(while: { $0 != 0 }), as: UTF8.self)
    }
}
