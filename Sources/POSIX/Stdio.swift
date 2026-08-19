/// Stdio.swift — the small portion of <stdio.h> that is not C-specific.
/// (Stream I/O is C-specific; see Unimplemented.swift.)

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// identical to C's `ctermid(3)`: the pathname of the controlling terminal.
public func ctermid() -> String {
    var buf = [CChar](repeating: 0, count: 1024) // >= L_ctermid
    _ = ctermid(&buf)
    return String(cString: buf)
}

/// identical to C's `cuserid(3)`: the name associated with the effective
/// user id (implemented via `getpwuid_r(3)`, which is what it means).
public func cuserid() -> String? {
    getpwuid(C.geteuid())?.name
}

/// identical to C's `remove(3)`.
public func remove(_ path: String) throws {
    try path.withCString { try check(remove($0)) }
}

/// identical to C's `rename(2)`.
public func rename(_ old: String, _ new: String) throws {
    try old.withCString { o in
        try new.withCString { n in
            try check(rename(o, n))
        }
    }
}

/// identical to C's `mkstemp(3)`: creates and opens a unique temporary
/// file from a template ending in "XXXXXX"; returns the open file
/// descriptor and the actual path, like Perl's `POSIX::mkstemp`.
public func mkstemp(_ template: String) throws -> (fd: CInt, path: String) {
    var buf = Array(template.utf8CString)
    let fd = try check(mkstemp(&buf))
    return (fd, String(cString: buf))
}
