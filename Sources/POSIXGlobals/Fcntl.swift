/// Fcntl.swift — <fcntl.h>.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// `open(2)` flags, as an OptionSet: `[.O_WRONLY, .O_CREAT, .O_TRUNC]`.
public struct OpenFlags: OptionSet, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
}
private let _O_RDONLY = O_RDONLY
private let _O_WRONLY = O_WRONLY
private let _O_RDWR = O_RDWR
private let _O_APPEND = O_APPEND
private let _O_CREAT = O_CREAT
private let _O_EXCL = O_EXCL
private let _O_TRUNC = O_TRUNC
private let _O_NONBLOCK = O_NONBLOCK
private let _O_NOCTTY = O_NOCTTY
private let _O_CLOEXEC = O_CLOEXEC
private let _O_NOFOLLOW = O_NOFOLLOW
private let _O_DIRECTORY = O_DIRECTORY
private let _O_SYNC = O_SYNC
extension OpenFlags {
    public static let O_RDONLY = OpenFlags(rawValue: _O_RDONLY) // == []
    public static let O_WRONLY = OpenFlags(rawValue: _O_WRONLY)
    public static let O_RDWR = OpenFlags(rawValue: _O_RDWR)
    public static let O_APPEND = OpenFlags(rawValue: _O_APPEND)
    public static let O_CREAT = OpenFlags(rawValue: _O_CREAT)
    public static let O_EXCL = OpenFlags(rawValue: _O_EXCL)
    public static let O_TRUNC = OpenFlags(rawValue: _O_TRUNC)
    public static let O_NONBLOCK = OpenFlags(rawValue: _O_NONBLOCK)
    public static let O_NOCTTY = OpenFlags(rawValue: _O_NOCTTY)
    public static let O_CLOEXEC = OpenFlags(rawValue: _O_CLOEXEC)
    public static let O_NOFOLLOW = OpenFlags(rawValue: _O_NOFOLLOW)
    public static let O_DIRECTORY = OpenFlags(rawValue: _O_DIRECTORY)
    public static let O_SYNC = OpenFlags(rawValue: _O_SYNC)
}

/// identical to C's `open(2)`; returns the file descriptor.
public func open(_ path: String, _ flags: OpenFlags = .O_RDONLY, _ mode: mode_t = 0o666) throws -> CInt {
    try path.withCString { try check(open($0, flags.rawValue, mode)) }
}

/// identical to C's `creat(2)`; returns the file descriptor.
public func creat(_ path: String, _ mode: mode_t = 0o666) throws -> CInt {
    try path.withCString { try check(creat($0, mode)) }
}

/// An `fcntl(2)` command, as `FcntlCommand.F_GETFL` etc.
public struct FcntlCommand: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
}
private let _F_DUPFD = F_DUPFD
private let _F_GETFD = F_GETFD
private let _F_SETFD = F_SETFD
private let _F_GETFL = F_GETFL
private let _F_SETFL = F_SETFL
private let _F_GETOWN = F_GETOWN
private let _F_SETOWN = F_SETOWN
extension FcntlCommand {
    public static let F_DUPFD = FcntlCommand(rawValue: _F_DUPFD)
    public static let F_GETFD = FcntlCommand(rawValue: _F_GETFD)
    public static let F_SETFD = FcntlCommand(rawValue: _F_SETFD)
    public static let F_GETFL = FcntlCommand(rawValue: _F_GETFL)
    public static let F_SETFL = FcntlCommand(rawValue: _F_SETFL)
    public static let F_GETOWN = FcntlCommand(rawValue: _F_GETOWN)
    public static let F_SETOWN = FcntlCommand(rawValue: _F_SETOWN)
}

// (FD_CLOEXEC is re-exported in Platform.swift)

/// identical to C's `fcntl(2)` for the integer-argument commands.
@discardableResult
public func fcntl(_ fd: CInt, _ cmd: FcntlCommand, _ arg: CInt = 0) throws -> CInt {
    try check(fcntl(fd, cmd.rawValue, arg))
}
