/// PwdGrp.swift — <pwd.h> and <grp.h>, with `struct passwd` and
/// `struct group` made swifty.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// A swifty `struct passwd`.
public struct Passwd: Hashable, Sendable {
    /// user name (`pw_name`)
    public let name: String
    /// user id (`pw_uid`)
    public let uid: uid_t
    /// group id (`pw_gid`)
    public let gid: gid_t
    /// real name / GECOS field (`pw_gecos`)
    public let gecos: String
    /// home directory (`pw_dir`)
    public let dir: String
    /// login shell (`pw_shell`)
    public let shell: String

    internal init(_ pw: passwd) {
        name = pw.pw_name.map { String(cString: $0) } ?? ""
        uid = pw.pw_uid
        gid = pw.pw_gid
        gecos = pw.pw_gecos.map { String(cString: $0) } ?? ""
        dir = pw.pw_dir.map { String(cString: $0) } ?? ""
        shell = pw.pw_shell.map { String(cString: $0) } ?? ""
    }
}

private let pwBufSize = 4096

/// identical to C's `getpwnam(3)` (via `getpwnam_r`).
public func getpwnam(_ name: String) -> Passwd? {
    var pw = passwd()
    var buf = [CChar](repeating: 0, count: pwBufSize)
    var result: UnsafeMutablePointer<passwd>? = nil
    let r = name.withCString { getpwnam_r($0, &pw, &buf, pwBufSize, &result) }
    guard r == 0, result != nil else { return nil }
    return Passwd(pw)
}

/// identical to C's `getpwuid(3)` (via `getpwuid_r`).
public func getpwuid(_ uid: uid_t) -> Passwd? {
    var pw = passwd()
    var buf = [CChar](repeating: 0, count: pwBufSize)
    var result: UnsafeMutablePointer<passwd>? = nil
    let r = getpwuid_r(uid, &pw, &buf, pwBufSize, &result)
    guard r == 0, result != nil else { return nil }
    return Passwd(pw)
}

/// A swifty `struct group`.
public struct Group: Hashable, Sendable {
    /// group name (`gr_name`)
    public let name: String
    /// group id (`gr_gid`)
    public let gid: gid_t
    /// member user names (`gr_mem`)
    public let members: [String]

    internal init(_ gr: group) {
        name = gr.gr_name.map { String(cString: $0) } ?? ""
        gid = gr.gr_gid
        var members: [String] = []
        if var p = gr.gr_mem {
            while let m = p.pointee {
                members.append(String(cString: m))
                p += 1
            }
        }
        self.members = members
    }
}

/// identical to C's `getgrnam(3)` (via `getgrnam_r`).
public func getgrnam(_ name: String) -> Group? {
    var gr = group()
    var buf = [CChar](repeating: 0, count: pwBufSize)
    var result: UnsafeMutablePointer<group>? = nil
    let r = name.withCString { getgrnam_r($0, &gr, &buf, pwBufSize, &result) }
    guard r == 0, result != nil else { return nil }
    return Group(gr)
}

/// identical to C's `getgrgid(3)` (via `getgrgid_r`).
public func getgrgid(_ gid: gid_t) -> Group? {
    var gr = group()
    var buf = [CChar](repeating: 0, count: pwBufSize)
    var result: UnsafeMutablePointer<group>? = nil
    let r = getgrgid_r(gid, &gr, &buf, pwBufSize, &result)
    guard r == 0, result != nil else { return nil }
    return Group(gr)
}
