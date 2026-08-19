/// SysWait.swift — <sys/wait.h>, with the W* status macros made swifty.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// A swifty wait status: the `W*` macros as properties.
public struct WaitStatus: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }

    private var wstatus: CInt { rawValue & 0x7f }

    /// `WIFEXITED`: the child terminated normally.
    public var exited: Bool { wstatus == 0 }
    /// `WEXITSTATUS`: the exit status, if `exited`.
    public var exitStatus: CInt? { exited ? (rawValue >> 8) & 0xff : nil }
    /// `WIFSIGNALED`: the child was terminated by a signal.
    public var signaled: Bool { wstatus != 0x7f && wstatus != 0 }
    /// `WTERMSIG`: the terminating signal, if `signaled`.
    public var termSignal: Signal? { signaled ? Signal(wstatus) : nil }
    /// `WCOREDUMP`: the child produced a core dump.
    public var coreDumped: Bool { signaled && rawValue & 0x80 != 0 }
    /// `WIFSTOPPED`: the child is currently stopped.
    public var stopped: Bool {
        #if canImport(Darwin)
        return wstatus == 0x7f && (rawValue >> 8) & 0xff != 0x13
        #else
        return rawValue & 0xff == 0x7f
        #endif
    }
    /// `WSTOPSIG`: the stopping signal, if `stopped`.
    public var stopSignal: Signal? { stopped ? Signal((rawValue >> 8) & 0xff) : nil }
    /// `WIFCONTINUED`: the child was resumed by SIGCONT.
    public var continued: Bool {
        #if canImport(Darwin)
        return wstatus == 0x7f && (rawValue >> 8) & 0xff == 0x13
        #else
        return rawValue == 0xffff
        #endif
    }
}

/// `waitpid(2)` option flags, as an OptionSet.
public struct WaitOptions: OptionSet, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
}
private let _WNOHANG = WNOHANG
private let _WUNTRACED = WUNTRACED
private let _WCONTINUED = WCONTINUED
extension WaitOptions {
    public static let WNOHANG = WaitOptions(rawValue: _WNOHANG)
    public static let WUNTRACED = WaitOptions(rawValue: _WUNTRACED)
    public static let WCONTINUED = WaitOptions(rawValue: _WCONTINUED)
}

/// identical to C's `wait(2)`; returns the reaped pid and its status.
public func wait() throws -> (pid: pid_t, status: WaitStatus) {
    var status: CInt = 0
    let pid = try check(wait(&status))
    return (pid, WaitStatus(rawValue: status))
}

/// identical to C's `waitpid(2)`; returns the reaped pid (0 with
/// `.WNOHANG` when nothing has changed) and its status.
public func waitpid(_ pid: pid_t, _ options: WaitOptions = []) throws -> (pid: pid_t, status: WaitStatus) {
    var status: CInt = 0
    let r = try check(waitpid(pid, &status, options.rawValue))
    return (r, WaitStatus(rawValue: status))
}
