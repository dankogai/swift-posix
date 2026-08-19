# `<errno.h>` — Errno

Where C returns -1 and sets the global `errno` — and Perl returns
`undef` and sets `$!` — this module **throws `Errno`**.

```swift
public struct Errno: Error, RawRepresentable, Hashable, Sendable,
                     CustomStringConvertible {
    public var rawValue: CInt
    public init(rawValue: CInt)
    public init(_ rawValue: CInt)
    /// the calling thread's current errno (readable and writable)
    public static var current: Errno { get set }
    /// the strerror(3) message
    public var description: String
}

/// identical to C's strerror(3)
public func strerror(_ e: Errno) -> String
```

All the usual constants are static members: `EPERM`, `ENOENT`, `ESRCH`,
`EINTR`, `EIO`, `ENXIO`, `E2BIG`, `ENOEXEC`, `EBADF`, `ECHILD`,
`EAGAIN`, `ENOMEM`, `EACCES`, `EFAULT`, `EBUSY`, `EEXIST`, `EXDEV`,
`ENODEV`, `ENOTDIR`, `EISDIR`, `EINVAL`, `ENFILE`, `EMFILE`, `ENOTTY`,
`ETXTBSY`, `EFBIG`, `ENOSPC`, `ESPIPE`, `EROFS`, `EMLINK`, `EPIPE`,
`EDOM`, `ERANGE`, `EDEADLK`, `ENAMETOOLONG`, `ENOLCK`, `ENOSYS`,
`ENOTEMPTY`, `ELOOP`, `EWOULDBLOCK`, `ENOTSUP`, `EOPNOTSUPP`,
`ETIMEDOUT`, `EINPROGRESS`, `EALREADY`, `ECONNREFUSED`, `ECONNRESET`,
`EADDRINUSE`, `EOVERFLOW`, `EILSEQ`.

## Example

```swift
import POSIX

do {
    try POSIX.unlink("/no/such/file")
} catch let e as POSIX.Errno where e == .ENOENT {
    print(e)              // No such file or directory
    print(e.rawValue)     // 2
}
```

## Notes

* `Errno.current` reads and writes the thread-local `errno`, for the
  rare C-style protocols that need it (e.g. distinguishing "error" from
  "no limit" — which `sysconf`/`pathconf` already do for you).
* Values are platform-specific; compare against the named constants,
  not literals.
