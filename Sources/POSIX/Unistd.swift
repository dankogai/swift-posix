/// Unistd.swift — <unistd.h>.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

// MARK: process identity

/// identical to C's `getpid(2)`.
public func getpid() -> pid_t { C.getpid() }
/// identical to C's `getppid(2)`.
public func getppid() -> pid_t { C.getppid() }
/// identical to C's `getuid(2)`.
public func getuid() -> uid_t { C.getuid() }
/// identical to C's `geteuid(2)`.
public func geteuid() -> uid_t { C.geteuid() }
/// identical to C's `getgid(2)`.
public func getgid() -> gid_t { C.getgid() }
/// identical to C's `getegid(2)`.
public func getegid() -> gid_t { C.getegid() }
/// identical to C's `getpgrp(2)`.
public func getpgrp() -> pid_t { C.getpgrp() }
/// identical to C's `setuid(2)`.
public func setuid(_ uid: uid_t) throws { try check(C.setuid(uid)) }
/// identical to C's `setgid(2)`.
public func setgid(_ gid: gid_t) throws { try check(C.setgid(gid)) }
/// identical to C's `setpgid(2)`.
public func setpgid(_ pid: pid_t, _ pgid: pid_t) throws { try check(C.setpgid(pid, pgid)) }
/// identical to C's `setsid(2)`.
@discardableResult
public func setsid() throws -> pid_t { try check(C.setsid()) }

/// identical to C's `getgroups(2)`: the supplementary group ids.
public func getgroups() throws -> [gid_t] {
    let n = try check(getgroups(0, nil))
    guard n > 0 else { return [] }
    var groups = [gid_t](repeating: 0, count: Int(n))
    let m = try check(getgroups(n, &groups))
    return Array(groups.prefix(Int(m)))
}

/// identical to C's `getlogin(3)`.
public func getlogin() -> String? {
    guard let p = C.getlogin() else { return nil }
    return String(cString: p)
}

// MARK: processes

/// identical to C's `fork(2)`; returns 0 in the child and the child's
/// pid in the parent.
public func fork() throws -> pid_t { try check(C.fork()) }

/// identical to C's `_exit(2)`: exits without running cleanup.
public func _exit(_ status: CInt = 0) -> Never { C._exit(status) }

/// identical to C's `nice(3)`.
@discardableResult
public func nice(_ increment: CInt) throws -> CInt {
    // -1 is a legal return value; disambiguate with errno.
    Errno.current = Errno(0)
    let r = C.nice(increment)
    if r == -1 && Errno.current.rawValue != 0 { throw Errno.current }
    return r
}

/// identical to C's `alarm(2)`.
@discardableResult
public func alarm(_ seconds: UInt32) -> UInt32 { C.alarm(seconds) }

/// identical to C's `pause(2)`: waits until a signal is delivered.
public func pause() { _ = C.pause() }

/// identical to C's `sleep(3)`; returns the unslept seconds.
@discardableResult
public func sleep(_ seconds: UInt32) -> UInt32 { C.sleep(seconds) }

// MARK: file descriptors

/// identical to C's `close(2)`.
public func close(_ fd: CInt) throws { try check(C.close(fd)) }

/// identical to C's `dup(2)`.
public func dup(_ fd: CInt) throws -> CInt { try check(C.dup(fd)) }

/// identical to C's `dup2(2)`.
@discardableResult
public func dup2(_ fd: CInt, _ fd2: CInt) throws -> CInt { try check(C.dup2(fd, fd2)) }

/// identical to C's `pipe(2)`; returns the read and write descriptors.
public func pipe() throws -> (read: CInt, write: CInt) {
    var fds: [CInt] = [0, 0]
    try check(pipe(&fds))
    return (fds[0], fds[1])
}

/// identical to C's `isatty(3)`.
public func isatty(_ fd: CInt) -> Bool { C.isatty(fd) == 1 }

/// identical to C's `ttyname(3)`.
public func ttyname(_ fd: CInt) -> String? {
    guard let p = C.ttyname(fd) else { return nil }
    return String(cString: p)
}

/// `lseek(2)` whence values, as `Whence.SEEK_SET` etc.
public struct Whence: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
}
private let _SEEK_SET = SEEK_SET
private let _SEEK_CUR = SEEK_CUR
private let _SEEK_END = SEEK_END
extension Whence {
    public static let SEEK_SET = Whence(rawValue: _SEEK_SET)
    public static let SEEK_CUR = Whence(rawValue: _SEEK_CUR)
    public static let SEEK_END = Whence(rawValue: _SEEK_END)
}

/// identical to C's `lseek(2)`; returns the new offset.
@discardableResult
public func lseek(_ fd: CInt, _ offset: off_t, _ whence: Whence = .SEEK_SET) throws -> off_t {
    try check(lseek(fd, offset, whence.rawValue))
}

/// identical to C's `read(2)`, but returns the bytes read.
public func read(_ fd: CInt, _ count: Int) throws -> [UInt8] {
    var n = 0
    var buf = [UInt8](repeating: 0, count: count)
    n = try buf.withUnsafeMutableBytes { raw in
        try check(read(fd, raw.baseAddress, count))
    }
    return Array(buf.prefix(n))
}

/// identical to C's `write(2)`; returns the number of bytes written.
@discardableResult
public func write(_ fd: CInt, _ bytes: [UInt8]) throws -> Int {
    try bytes.withUnsafeBytes { raw in
        try check(write(fd, raw.baseAddress, raw.count))
    }
}

/// identical to C's `write(2)`, taking the UTF-8 bytes of a String.
@discardableResult
public func write(_ fd: CInt, _ string: String) throws -> Int {
    try write(fd, Array(string.utf8))
}

// MARK: filesystem

/// `access(2)` mode flags, as `AccessMode.R_OK` etc.
public struct AccessMode: OptionSet, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
}
private let _F_OK = F_OK
private let _R_OK = R_OK
private let _W_OK = W_OK
private let _X_OK = X_OK
extension AccessMode {
    public static let F_OK = AccessMode(rawValue: _F_OK)
    public static let R_OK = AccessMode(rawValue: _R_OK)
    public static let W_OK = AccessMode(rawValue: _W_OK)
    public static let X_OK = AccessMode(rawValue: _X_OK)
}

/// identical to C's `access(2)`, but returns a Bool.
public func access(_ path: String, _ mode: AccessMode = .F_OK) -> Bool {
    path.withCString { access($0, mode.rawValue) == 0 }
}

/// identical to C's `chdir(2)`.
public func chdir(_ path: String) throws {
    try path.withCString { try check(chdir($0)) }
}

/// identical to C's `chown(2)`.
public func chown(_ path: String, _ owner: uid_t, _ group: gid_t) throws {
    try path.withCString { try check(chown($0, owner, group)) }
}

/// identical to C's `getcwd(3)`.
public func getcwd() throws -> String {
    guard let p = getcwd(nil, 0) else { throw Errno.current }
    defer { free(p) }
    return String(cString: p)
}

/// identical to C's `link(2)`.
public func link(_ existing: String, _ new: String) throws {
    try existing.withCString { e in
        try new.withCString { n in
            try check(link(e, n))
        }
    }
}

/// identical to C's `unlink(2)`.
public func unlink(_ path: String) throws {
    try path.withCString { try check(unlink($0)) }
}

/// identical to C's `rmdir(2)`.
public func rmdir(_ path: String) throws {
    try path.withCString { try check(rmdir($0)) }
}

// MARK: sysconf / pathconf

/// A `sysconf(3)` variable name, as `SysconfName.pageSize` etc.
public struct SysconfName: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }

    public static let argMax = SysconfName(rawValue: _SC_ARG_MAX)
    public static let childMax = SysconfName(rawValue: _SC_CHILD_MAX)
    public static let clockTick = SysconfName(rawValue: _SC_CLK_TCK)
    public static let ngroupsMax = SysconfName(rawValue: _SC_NGROUPS_MAX)
    public static let openMax = SysconfName(rawValue: _SC_OPEN_MAX)
    public static let pageSize = SysconfName(rawValue: _SC_PAGESIZE)
    public static let streamMax = SysconfName(rawValue: _SC_STREAM_MAX)
    public static let tznameMax = SysconfName(rawValue: _SC_TZNAME_MAX)
    public static let jobControl = SysconfName(rawValue: _SC_JOB_CONTROL)
    public static let savedIDs = SysconfName(rawValue: _SC_SAVED_IDS)
    public static let version = SysconfName(rawValue: _SC_VERSION)
    public static let processorsOnline = SysconfName(rawValue: _SC_NPROCESSORS_ONLN)
}

/// identical to C's `sysconf(3)`; nil means "no limit / not supported".
public func sysconf(_ name: SysconfName) throws -> Int? {
    Errno.current = Errno(0)
    let r = sysconf(name.rawValue)
    if r == -1 {
        if Errno.current.rawValue != 0 { throw Errno.current }
        return nil
    }
    return r
}

/// A `pathconf(3)` variable name, as `PathconfName.nameMax` etc.
public struct PathconfName: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }

    public static let linkMax = PathconfName(rawValue: _PC_LINK_MAX)
    public static let maxCanon = PathconfName(rawValue: _PC_MAX_CANON)
    public static let maxInput = PathconfName(rawValue: _PC_MAX_INPUT)
    public static let nameMax = PathconfName(rawValue: _PC_NAME_MAX)
    public static let pathMax = PathconfName(rawValue: _PC_PATH_MAX)
    public static let pipeBuf = PathconfName(rawValue: _PC_PIPE_BUF)
    public static let chownRestricted = PathconfName(rawValue: _PC_CHOWN_RESTRICTED)
    public static let noTrunc = PathconfName(rawValue: _PC_NO_TRUNC)
    public static let vdisable = PathconfName(rawValue: _PC_VDISABLE)
}

/// identical to C's `pathconf(3)`; nil means "no limit / not supported".
public func pathconf(_ path: String, _ name: PathconfName) throws -> Int? {
    Errno.current = Errno(0)
    let r = path.withCString { pathconf($0, name.rawValue) }
    if r == -1 {
        if Errno.current.rawValue != 0 { throw Errno.current }
        return nil
    }
    return r
}

/// identical to C's `fpathconf(3)`; nil means "no limit / not supported".
public func fpathconf(_ fd: CInt, _ name: PathconfName) throws -> Int? {
    Errno.current = Errno(0)
    let r = fpathconf(fd, name.rawValue)
    if r == -1 {
        if Errno.current.rawValue != 0 { throw Errno.current }
        return nil
    }
    return r
}

// MARK: terminal process group

/// identical to C's `tcgetpgrp(3)`.
public func tcgetpgrp(_ fd: CInt) throws -> pid_t { try check(C.tcgetpgrp(fd)) }

/// identical to C's `tcsetpgrp(3)`.
public func tcsetpgrp(_ fd: CInt, _ pgid: pid_t) throws { try check(C.tcsetpgrp(fd, pgid)) }
