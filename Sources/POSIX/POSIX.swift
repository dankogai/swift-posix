/// POSIX.swift — the `POSIX` namespace.
///
/// `import POSIX` brings exactly one name into scope: the caseless enum
/// `POSIX`.  Everything the library offers hangs off it — `POSIX.getcwd()`,
/// `POSIX.Stat`, `POSIX.M_PI` — so nothing collides with Foundation or
/// the C overlays.
///
/// If you want the names at the top level, Perl-style, opt in with
/// `import POSIXGlobals` (or cherry-pick: `import func POSIXGlobals.floor`).

import POSIXGlobals
// for the underlying C types of re-exported constants (e.g. clock_t)
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// The POSIX namespace.  A caseless enum: it only carries static members.
public enum POSIX {}

// MARK: - types

extension POSIX {
    // C scalar types
    public typealias pid_t = POSIXGlobals.pid_t
    public typealias uid_t = POSIXGlobals.uid_t
    public typealias gid_t = POSIXGlobals.gid_t
    public typealias mode_t = POSIXGlobals.mode_t
    public typealias off_t = POSIXGlobals.off_t
    public typealias time_t = POSIXGlobals.time_t
    public typealias clock_t = POSIXGlobals.clock_t
    public typealias dev_t = POSIXGlobals.dev_t
    public typealias ino_t = POSIXGlobals.ino_t
    public typealias nlink_t = POSIXGlobals.nlink_t
    public typealias blkcnt_t = POSIXGlobals.blkcnt_t
    public typealias blksize_t = POSIXGlobals.blksize_t
    public typealias speed_t = POSIXGlobals.speed_t
    public typealias tcflag_t = POSIXGlobals.tcflag_t
    public typealias cc_t = POSIXGlobals.cc_t
    public typealias wchar_t = POSIXGlobals.wchar_t

    // swifty wrappers
    public typealias Errno = POSIXGlobals.Errno
    public typealias Stat = POSIXGlobals.Stat
    public typealias TimeSpec = POSIXGlobals.TimeSpec
    public typealias FileType = POSIXGlobals.FileType
    public typealias FilePermissions = POSIXGlobals.FilePermissions
    public typealias Tm = POSIXGlobals.Tm
    public typealias Times = POSIXGlobals.Times
    public typealias Utsname = POSIXGlobals.Utsname
    public typealias WaitStatus = POSIXGlobals.WaitStatus
    public typealias WaitOptions = POSIXGlobals.WaitOptions
    public typealias Signal = POSIXGlobals.Signal
    public typealias SigSet = POSIXGlobals.SigSet
    public typealias SigmaskHow = POSIXGlobals.SigmaskHow
    public typealias SigHandler = POSIXGlobals.SigHandler
    public typealias SigAction = POSIXGlobals.SigAction
    public typealias LocaleCategory = POSIXGlobals.LocaleCategory
    public typealias Lconv = POSIXGlobals.Lconv
    public typealias Termios = POSIXGlobals.Termios
    public typealias BaudRate = POSIXGlobals.BaudRate
    public typealias TcsetattrAction = POSIXGlobals.TcsetattrAction
    public typealias TcflushQueue = POSIXGlobals.TcflushQueue
    public typealias TcflowAction = POSIXGlobals.TcflowAction
    public typealias Dir = POSIXGlobals.Dir
    public typealias Passwd = POSIXGlobals.Passwd
    public typealias Group = POSIXGlobals.Group
    public typealias OpenFlags = POSIXGlobals.OpenFlags
    public typealias FcntlCommand = POSIXGlobals.FcntlCommand
    public typealias AccessMode = POSIXGlobals.AccessMode
    public typealias Whence = POSIXGlobals.Whence
    public typealias SysconfName = POSIXGlobals.SysconfName
    public typealias PathconfName = POSIXGlobals.PathconfName
}

// MARK: - constants

extension POSIX {
    // <math.h>
    public static let M_E = POSIXGlobals.M_E
    public static let M_LOG2E = POSIXGlobals.M_LOG2E
    public static let M_LOG10E = POSIXGlobals.M_LOG10E
    public static let M_LN2 = POSIXGlobals.M_LN2
    public static let M_LN10 = POSIXGlobals.M_LN10
    public static let M_PI = POSIXGlobals.M_PI
    public static let M_PI_2 = POSIXGlobals.M_PI_2
    public static let M_PI_4 = POSIXGlobals.M_PI_4
    public static let M_1_PI = POSIXGlobals.M_1_PI
    public static let M_2_PI = POSIXGlobals.M_2_PI
    public static let M_2_SQRTPI = POSIXGlobals.M_2_SQRTPI
    public static let M_SQRT2 = POSIXGlobals.M_SQRT2
    public static let M_SQRT1_2 = POSIXGlobals.M_SQRT1_2
    public static let HUGE_VAL = POSIXGlobals.HUGE_VAL
    public static let INFINITY = POSIXGlobals.INFINITY
    public static let NAN = POSIXGlobals.NAN
    // <fenv.h>
    public static let FE_TONEAREST = POSIXGlobals.FE_TONEAREST
    public static let FE_TOWARDZERO = POSIXGlobals.FE_TOWARDZERO
    public static let FE_UPWARD = POSIXGlobals.FE_UPWARD
    public static let FE_DOWNWARD = POSIXGlobals.FE_DOWNWARD
    // <time.h>, <fcntl.h>, <stdlib.h>
    public static let CLOCKS_PER_SEC = POSIXGlobals.CLOCKS_PER_SEC
    public static let FD_CLOEXEC = POSIXGlobals.FD_CLOEXEC
    public static let EXIT_SUCCESS = POSIXGlobals.EXIT_SUCCESS
    public static let EXIT_FAILURE = POSIXGlobals.EXIT_FAILURE
    // <limits.h>
    public static let CHAR_BIT = POSIXGlobals.CHAR_BIT
    public static let SCHAR_MAX = POSIXGlobals.SCHAR_MAX
    public static let SCHAR_MIN = POSIXGlobals.SCHAR_MIN
    public static let UCHAR_MAX = POSIXGlobals.UCHAR_MAX
    public static let CHAR_MAX = POSIXGlobals.CHAR_MAX
    public static let CHAR_MIN = POSIXGlobals.CHAR_MIN
    public static let SHRT_MAX = POSIXGlobals.SHRT_MAX
    public static let SHRT_MIN = POSIXGlobals.SHRT_MIN
    public static let USHRT_MAX = POSIXGlobals.USHRT_MAX
    public static let INT_MAX = POSIXGlobals.INT_MAX
    public static let INT_MIN = POSIXGlobals.INT_MIN
    public static let UINT_MAX = POSIXGlobals.UINT_MAX
    public static let LONG_MAX = POSIXGlobals.LONG_MAX
    public static let LONG_MIN = POSIXGlobals.LONG_MIN
    public static let ULONG_MAX = POSIXGlobals.ULONG_MAX
    public static let LLONG_MAX = POSIXGlobals.LLONG_MAX
    public static let LLONG_MIN = POSIXGlobals.LLONG_MIN
    public static let ULLONG_MAX = POSIXGlobals.ULLONG_MAX
    public static let SSIZE_MAX = POSIXGlobals.SSIZE_MAX
    // <float.h>
    public static let FLT_RADIX = POSIXGlobals.FLT_RADIX
    public static let DBL_MAX = POSIXGlobals.DBL_MAX
    public static let DBL_MIN = POSIXGlobals.DBL_MIN
    public static let DBL_TRUE_MIN = POSIXGlobals.DBL_TRUE_MIN
    public static let DBL_EPSILON = POSIXGlobals.DBL_EPSILON
    public static let DBL_MANT_DIG = POSIXGlobals.DBL_MANT_DIG
    public static let DBL_MAX_EXP = POSIXGlobals.DBL_MAX_EXP
    public static let DBL_MIN_EXP = POSIXGlobals.DBL_MIN_EXP
    public static let FLT_MAX = POSIXGlobals.FLT_MAX
    public static let FLT_MIN = POSIXGlobals.FLT_MIN
    public static let FLT_TRUE_MIN = POSIXGlobals.FLT_TRUE_MIN
    public static let FLT_EPSILON = POSIXGlobals.FLT_EPSILON
    public static let FLT_MANT_DIG = POSIXGlobals.FLT_MANT_DIG
}
