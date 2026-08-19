/// Errno.swift — `errno` made swifty.
///
/// Where Perl's POSIX functions return `undef` and set `$!`, this module
/// `throw`s an `Errno` instead.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// A POSIX error number, thrown by the functions in this module.
public struct Errno: Error, RawRepresentable, Hashable, Sendable, CustomStringConvertible {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
    public init(_ rawValue: CInt) { self.rawValue = rawValue }
    /// The calling thread's current `errno` value.
    public static var current: Errno {
        get { Errno(errno) }
        set { errno = newValue.rawValue }
    }
    /// The result of `strerror(3)`.
    public var description: String {
        guard let s = strerror(rawValue) else { return "Unknown error \(rawValue)" }
        return String(cString: s)
    }
}

/// identical to C's `strerror(3)`.
public func strerror(_ e: Errno) -> String { e.description }

// The E* constants, as `Errno.EPERM` etc.
// (private top-level aliases pick up the libc value without self-reference)
private let _EPERM = EPERM
private let _ENOENT = ENOENT
private let _ESRCH = ESRCH
private let _EINTR = EINTR
private let _EIO = EIO
private let _ENXIO = ENXIO
private let _E2BIG = E2BIG
private let _ENOEXEC = ENOEXEC
private let _EBADF = EBADF
private let _ECHILD = ECHILD
private let _EAGAIN = EAGAIN
private let _ENOMEM = ENOMEM
private let _EACCES = EACCES
private let _EFAULT = EFAULT
private let _EBUSY = EBUSY
private let _EEXIST = EEXIST
private let _EXDEV = EXDEV
private let _ENODEV = ENODEV
private let _ENOTDIR = ENOTDIR
private let _EISDIR = EISDIR
private let _EINVAL = EINVAL
private let _ENFILE = ENFILE
private let _EMFILE = EMFILE
private let _ENOTTY = ENOTTY
private let _ETXTBSY = ETXTBSY
private let _EFBIG = EFBIG
private let _ENOSPC = ENOSPC
private let _ESPIPE = ESPIPE
private let _EROFS = EROFS
private let _EMLINK = EMLINK
private let _EPIPE = EPIPE
private let _EDOM = EDOM
private let _ERANGE = ERANGE
private let _EDEADLK = EDEADLK
private let _ENAMETOOLONG = ENAMETOOLONG
private let _ENOLCK = ENOLCK
private let _ENOSYS = ENOSYS
private let _ENOTEMPTY = ENOTEMPTY
private let _ELOOP = ELOOP
private let _EWOULDBLOCK = EWOULDBLOCK
private let _ENOTSUP = ENOTSUP
private let _EOPNOTSUPP = EOPNOTSUPP
private let _ETIMEDOUT = ETIMEDOUT
private let _EINPROGRESS = EINPROGRESS
private let _EALREADY = EALREADY
private let _ECONNREFUSED = ECONNREFUSED
private let _ECONNRESET = ECONNRESET
private let _EADDRINUSE = EADDRINUSE
private let _EOVERFLOW = EOVERFLOW
private let _EILSEQ = EILSEQ

extension Errno {
    public static let EPERM = Errno(_EPERM)
    public static let ENOENT = Errno(_ENOENT)
    public static let ESRCH = Errno(_ESRCH)
    public static let EINTR = Errno(_EINTR)
    public static let EIO = Errno(_EIO)
    public static let ENXIO = Errno(_ENXIO)
    public static let E2BIG = Errno(_E2BIG)
    public static let ENOEXEC = Errno(_ENOEXEC)
    public static let EBADF = Errno(_EBADF)
    public static let ECHILD = Errno(_ECHILD)
    public static let EAGAIN = Errno(_EAGAIN)
    public static let ENOMEM = Errno(_ENOMEM)
    public static let EACCES = Errno(_EACCES)
    public static let EFAULT = Errno(_EFAULT)
    public static let EBUSY = Errno(_EBUSY)
    public static let EEXIST = Errno(_EEXIST)
    public static let EXDEV = Errno(_EXDEV)
    public static let ENODEV = Errno(_ENODEV)
    public static let ENOTDIR = Errno(_ENOTDIR)
    public static let EISDIR = Errno(_EISDIR)
    public static let EINVAL = Errno(_EINVAL)
    public static let ENFILE = Errno(_ENFILE)
    public static let EMFILE = Errno(_EMFILE)
    public static let ENOTTY = Errno(_ENOTTY)
    public static let ETXTBSY = Errno(_ETXTBSY)
    public static let EFBIG = Errno(_EFBIG)
    public static let ENOSPC = Errno(_ENOSPC)
    public static let ESPIPE = Errno(_ESPIPE)
    public static let EROFS = Errno(_EROFS)
    public static let EMLINK = Errno(_EMLINK)
    public static let EPIPE = Errno(_EPIPE)
    public static let EDOM = Errno(_EDOM)
    public static let ERANGE = Errno(_ERANGE)
    public static let EDEADLK = Errno(_EDEADLK)
    public static let ENAMETOOLONG = Errno(_ENAMETOOLONG)
    public static let ENOLCK = Errno(_ENOLCK)
    public static let ENOSYS = Errno(_ENOSYS)
    public static let ENOTEMPTY = Errno(_ENOTEMPTY)
    public static let ELOOP = Errno(_ELOOP)
    public static let EWOULDBLOCK = Errno(_EWOULDBLOCK)
    public static let ENOTSUP = Errno(_ENOTSUP)
    public static let EOPNOTSUPP = Errno(_EOPNOTSUPP)
    public static let ETIMEDOUT = Errno(_ETIMEDOUT)
    public static let EINPROGRESS = Errno(_EINPROGRESS)
    public static let EALREADY = Errno(_EALREADY)
    public static let ECONNREFUSED = Errno(_ECONNREFUSED)
    public static let ECONNRESET = Errno(_ECONNRESET)
    public static let EADDRINUSE = Errno(_EADDRINUSE)
    public static let EOVERFLOW = Errno(_EOVERFLOW)
    public static let EILSEQ = Errno(_EILSEQ)
}

/// Throws `Errno.current` when a C call reports failure with -1.
@discardableResult
internal func check<T: SignedInteger>(_ result: T) throws -> T {
    guard result != -1 else { throw Errno.current }
    return result
}

/// Throws `Errno.current` when a C call reports failure with NULL.
internal func check<T>(_ result: T?) throws -> T {
    guard let result else { throw Errno.current }
    return result
}
