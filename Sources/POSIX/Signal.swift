/// Signal.swift — <signal.h>, with `sigset_t` and `struct sigaction`
/// made swifty.

#if canImport(Darwin)
import Darwin
internal typealias CSigHandler = sig_t
#elseif canImport(Glibc)
import Glibc
internal typealias CSigHandler = __sighandler_t
#endif

/// A POSIX signal, as `Signal.SIGINT` etc.
public struct Signal: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
    public init(_ rawValue: CInt) { self.rawValue = rawValue }
}

private let _SIGHUP = SIGHUP
private let _SIGINT = SIGINT
private let _SIGQUIT = SIGQUIT
private let _SIGILL = SIGILL
private let _SIGTRAP = SIGTRAP
private let _SIGABRT = SIGABRT
private let _SIGFPE = SIGFPE
private let _SIGKILL = SIGKILL
private let _SIGBUS = SIGBUS
private let _SIGSEGV = SIGSEGV
private let _SIGSYS = SIGSYS
private let _SIGPIPE = SIGPIPE
private let _SIGALRM = SIGALRM
private let _SIGTERM = SIGTERM
private let _SIGURG = SIGURG
private let _SIGSTOP = SIGSTOP
private let _SIGTSTP = SIGTSTP
private let _SIGCONT = SIGCONT
private let _SIGCHLD = SIGCHLD
private let _SIGTTIN = SIGTTIN
private let _SIGTTOU = SIGTTOU
private let _SIGIO = SIGIO
private let _SIGXCPU = SIGXCPU
private let _SIGXFSZ = SIGXFSZ
private let _SIGVTALRM = SIGVTALRM
private let _SIGPROF = SIGPROF
private let _SIGWINCH = SIGWINCH
private let _SIGUSR1 = SIGUSR1
private let _SIGUSR2 = SIGUSR2

extension Signal {
    public static let SIGHUP = Signal(_SIGHUP)
    public static let SIGINT = Signal(_SIGINT)
    public static let SIGQUIT = Signal(_SIGQUIT)
    public static let SIGILL = Signal(_SIGILL)
    public static let SIGTRAP = Signal(_SIGTRAP)
    public static let SIGABRT = Signal(_SIGABRT)
    public static let SIGFPE = Signal(_SIGFPE)
    public static let SIGKILL = Signal(_SIGKILL)
    public static let SIGBUS = Signal(_SIGBUS)
    public static let SIGSEGV = Signal(_SIGSEGV)
    public static let SIGSYS = Signal(_SIGSYS)
    public static let SIGPIPE = Signal(_SIGPIPE)
    public static let SIGALRM = Signal(_SIGALRM)
    public static let SIGTERM = Signal(_SIGTERM)
    public static let SIGURG = Signal(_SIGURG)
    public static let SIGSTOP = Signal(_SIGSTOP)
    public static let SIGTSTP = Signal(_SIGTSTP)
    public static let SIGCONT = Signal(_SIGCONT)
    public static let SIGCHLD = Signal(_SIGCHLD)
    public static let SIGTTIN = Signal(_SIGTTIN)
    public static let SIGTTOU = Signal(_SIGTTOU)
    public static let SIGIO = Signal(_SIGIO)
    public static let SIGXCPU = Signal(_SIGXCPU)
    public static let SIGXFSZ = Signal(_SIGXFSZ)
    public static let SIGVTALRM = Signal(_SIGVTALRM)
    public static let SIGPROF = Signal(_SIGPROF)
    public static let SIGWINCH = Signal(_SIGWINCH)
    public static let SIGUSR1 = Signal(_SIGUSR1)
    public static let SIGUSR2 = Signal(_SIGUSR2)
}

/// identical to C's `kill(2)`.
public func kill(_ pid: pid_t, _ sig: Signal) throws {
    try check(kill(pid, sig.rawValue))
}

/// identical to C's `raise(3)`.
public func raise(_ sig: Signal) throws {
    try check(C.raise(sig.rawValue))
}

/// A swifty `sigset_t` — like Perl's `POSIX::SigSet`.
public struct SigSet: Sendable {
    internal var raw = sigset_t()

    /// An empty set.
    public init() { sigemptyset(&raw) }
    /// A set containing the given signals.
    public init(_ signals: Signal...) {
        sigemptyset(&raw)
        for s in signals { insert(s) }
    }
    internal init(raw: sigset_t) { self.raw = raw }

    /// The empty set.
    public static var empty: SigSet { SigSet() }
    /// The full set (`sigfillset`).
    public static var all: SigSet {
        var s = SigSet()
        sigfillset(&s.raw)
        return s
    }

    /// `sigaddset`.
    public mutating func insert(_ sig: Signal) { sigaddset(&raw, sig.rawValue) }
    /// `sigdelset`.
    public mutating func remove(_ sig: Signal) { sigdelset(&raw, sig.rawValue) }
    /// `sigismember`.
    public func contains(_ sig: Signal) -> Bool {
        var copy = raw
        return sigismember(&copy, sig.rawValue) == 1
    }
}

/// `sigprocmask(2)` how values.
public struct SigmaskHow: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
}
private let _SIG_BLOCK = SIG_BLOCK
private let _SIG_UNBLOCK = SIG_UNBLOCK
private let _SIG_SETMASK = SIG_SETMASK
extension SigmaskHow {
    public static let SIG_BLOCK = SigmaskHow(rawValue: _SIG_BLOCK)
    public static let SIG_UNBLOCK = SigmaskHow(rawValue: _SIG_UNBLOCK)
    public static let SIG_SETMASK = SigmaskHow(rawValue: _SIG_SETMASK)
}

/// identical to C's `sigprocmask(2)`; returns the previous mask.
@discardableResult
public func sigprocmask(_ how: SigmaskHow, _ set: SigSet?) throws -> SigSet {
    var old = sigset_t()
    if var new = set?.raw {
        try check(sigprocmask(how.rawValue, &new, &old))
    } else {
        try check(sigprocmask(how.rawValue, nil, &old))
    }
    return SigSet(raw: old)
}

/// identical to C's `sigpending(2)`.
public func sigpending() throws -> SigSet {
    var set = sigset_t()
    try check(sigpending(&set))
    return SigSet(raw: set)
}

/// identical to C's `sigsuspend(2)`: atomically sets the signal mask and
/// waits for a signal.
public func sigsuspend(_ mask: SigSet) {
    var m = mask.raw
    _ = sigsuspend(&m)
}

/// A signal disposition — like Perl's `POSIX::SigAction`, but swifty.
public enum SigHandler {
    /// `SIG_DFL`
    case defaultAction
    /// `SIG_IGN`
    case ignore
    /// a C-convention handler function
    case handler(@convention(c) (CInt) -> Void)

    internal var cHandler: CSigHandler? {
        switch self {
        case .defaultAction: return nil // SIG_DFL
        case .ignore: return unsafeBitCast(1 as Int, to: CSigHandler.self) // SIG_IGN
        case .handler(let f): return f
        }
    }
    internal init(_ c: CSigHandler?) {
        switch unsafeBitCast(c, to: Int.self) {
        case 0: self = .defaultAction
        case 1: self = .ignore
        default: self = .handler(unsafeBitCast(c, to: (@convention(c) (CInt) -> Void).self))
        }
    }
}

/// A swifty `struct sigaction`.
public struct SigAction {
    public var handler: SigHandler
    public var mask: SigSet
    public var flags: CInt
    public init(handler: SigHandler = .defaultAction, mask: SigSet = SigSet(), flags: CInt = 0) {
        self.handler = handler
        self.mask = mask
        self.flags = flags
    }
}

/// identical to C's `sigaction(2)`; installs `action` (if non-nil) and
/// returns the previous action.
@discardableResult
public func sigaction(_ sig: Signal, _ action: SigAction? = nil) throws -> SigAction {
    var old = sigaction()
    if let action {
        var new = sigaction()
        #if canImport(Darwin)
        new.__sigaction_u.__sa_handler = action.handler.cHandler
        #else
        new.__sigaction_handler.sa_handler = action.handler.cHandler
        #endif
        new.sa_mask = action.mask.raw
        new.sa_flags = action.flags
        try check(sigaction(sig.rawValue, &new, &old))
    } else {
        try check(sigaction(sig.rawValue, nil, &old))
    }
    #if canImport(Darwin)
    let oldHandler = SigHandler(old.__sigaction_u.__sa_handler)
    #else
    let oldHandler = SigHandler(old.__sigaction_handler.sa_handler)
    #endif
    return SigAction(handler: oldHandler, mask: SigSet(raw: old.sa_mask), flags: old.sa_flags)
}

/// identical to C's `signal(3)`; returns the previous handler.
@discardableResult
public func signal(_ sig: Signal, _ handler: SigHandler) throws -> SigHandler {
    let old = try sigaction(sig, SigAction(handler: handler))
    return old.handler
}
