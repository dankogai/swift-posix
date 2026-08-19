/// SysUtsname.swift — <sys/utsname.h>, with `struct utsname` made swifty.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// A swifty `struct utsname`.
public struct Utsname: Hashable, Sendable {
    /// operating system name (`sysname`)
    public let sysname: String
    /// network node name (`nodename`)
    public let nodename: String
    /// operating system release (`release`)
    public let release: String
    /// operating system version (`version`)
    public let version: String
    /// hardware identifier (`machine`)
    public let machine: String
}

/// identical to C's `uname(3)`, but returns a swifty `Utsname`.
public func uname() throws -> Utsname {
    var u = utsname()
    try check(uname(&u))
    return Utsname(
        sysname: stringFromCCharTuple(u.sysname),
        nodename: stringFromCCharTuple(u.nodename),
        release: stringFromCCharTuple(u.release),
        version: stringFromCCharTuple(u.version),
        machine: stringFromCCharTuple(u.machine)
    )
}
