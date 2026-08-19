/// SysStat.swift — <sys/stat.h>, with `struct stat` made swifty.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// A point in time with nanosecond resolution, as found in `struct stat`.
public struct TimeSpec: Hashable, Sendable, Comparable {
    public var seconds: Int
    public var nanoseconds: Int
    public init(seconds: Int, nanoseconds: Int = 0) {
        self.seconds = seconds
        self.nanoseconds = nanoseconds
    }
    internal init(_ ts: timespec) {
        self.init(seconds: Int(ts.tv_sec), nanoseconds: Int(ts.tv_nsec))
    }
    /// Seconds since the epoch, as a Double.
    public var timeInterval: Double { Double(seconds) + Double(nanoseconds) / 1e9 }
    public static func < (lhs: TimeSpec, rhs: TimeSpec) -> Bool {
        (lhs.seconds, lhs.nanoseconds) < (rhs.seconds, rhs.nanoseconds)
    }
}

/// File permission bits, as an OptionSet: `[.S_IRUSR, .S_IWUSR]`.
public struct FilePermissions: OptionSet, Sendable {
    public var rawValue: mode_t
    public init(rawValue: mode_t) { self.rawValue = rawValue }
}
private let _S_ISUID = S_ISUID
private let _S_ISGID = S_ISGID
private let _S_ISVTX = S_ISVTX
private let _S_IRWXU = S_IRWXU
private let _S_IRUSR = S_IRUSR
private let _S_IWUSR = S_IWUSR
private let _S_IXUSR = S_IXUSR
private let _S_IRWXG = S_IRWXG
private let _S_IRGRP = S_IRGRP
private let _S_IWGRP = S_IWGRP
private let _S_IXGRP = S_IXGRP
private let _S_IRWXO = S_IRWXO
private let _S_IROTH = S_IROTH
private let _S_IWOTH = S_IWOTH
private let _S_IXOTH = S_IXOTH
extension FilePermissions {
    public static let S_ISUID = FilePermissions(rawValue: mode_t(_S_ISUID))
    public static let S_ISGID = FilePermissions(rawValue: mode_t(_S_ISGID))
    public static let S_ISVTX = FilePermissions(rawValue: mode_t(_S_ISVTX))
    public static let S_IRWXU = FilePermissions(rawValue: mode_t(_S_IRWXU))
    public static let S_IRUSR = FilePermissions(rawValue: mode_t(_S_IRUSR))
    public static let S_IWUSR = FilePermissions(rawValue: mode_t(_S_IWUSR))
    public static let S_IXUSR = FilePermissions(rawValue: mode_t(_S_IXUSR))
    public static let S_IRWXG = FilePermissions(rawValue: mode_t(_S_IRWXG))
    public static let S_IRGRP = FilePermissions(rawValue: mode_t(_S_IRGRP))
    public static let S_IWGRP = FilePermissions(rawValue: mode_t(_S_IWGRP))
    public static let S_IXGRP = FilePermissions(rawValue: mode_t(_S_IXGRP))
    public static let S_IRWXO = FilePermissions(rawValue: mode_t(_S_IRWXO))
    public static let S_IROTH = FilePermissions(rawValue: mode_t(_S_IROTH))
    public static let S_IWOTH = FilePermissions(rawValue: mode_t(_S_IWOTH))
    public static let S_IXOTH = FilePermissions(rawValue: mode_t(_S_IXOTH))
}

private let _S_IFMT = S_IFMT
private let _S_IFIFO = S_IFIFO
private let _S_IFCHR = S_IFCHR
private let _S_IFDIR = S_IFDIR
private let _S_IFBLK = S_IFBLK
private let _S_IFREG = S_IFREG
private let _S_IFLNK = S_IFLNK
private let _S_IFSOCK = S_IFSOCK

/// The type of a file, derived from `st_mode`.
public enum FileType: Sendable {
    case regular, directory, symbolicLink, fifo, socket
    case blockDevice, characterDevice, unknown

    internal init(mode: mode_t) {
        switch mode & mode_t(_S_IFMT) {
        case mode_t(_S_IFREG): self = .regular
        case mode_t(_S_IFDIR): self = .directory
        case mode_t(_S_IFLNK): self = .symbolicLink
        case mode_t(_S_IFIFO): self = .fifo
        case mode_t(_S_IFSOCK): self = .socket
        case mode_t(_S_IFBLK): self = .blockDevice
        case mode_t(_S_IFCHR): self = .characterDevice
        default: self = .unknown
        }
    }
}

/// A swifty `struct stat`.
public struct Stat: Sendable {
    /// device id (`st_dev`)
    public let dev: dev_t
    /// inode number (`st_ino`)
    public let ino: ino_t
    /// file mode, type and permissions (`st_mode`)
    public let mode: mode_t
    /// number of hard links (`st_nlink`)
    public let nlink: nlink_t
    /// owner's user id (`st_uid`)
    public let uid: uid_t
    /// owner's group id (`st_gid`)
    public let gid: gid_t
    /// device id, for special files (`st_rdev`)
    public let rdev: dev_t
    /// size in bytes (`st_size`)
    public let size: off_t
    /// last access time (`st_atime`)
    public let atime: TimeSpec
    /// last modification time (`st_mtime`)
    public let mtime: TimeSpec
    /// last status change time (`st_ctime`)
    public let ctime: TimeSpec
    /// preferred I/O block size (`st_blksize`)
    public let blksize: blksize_t
    /// number of 512-byte blocks allocated (`st_blocks`)
    public let blocks: blkcnt_t

    /// the file's type, from the mode bits.
    public var type: FileType { FileType(mode: mode) }
    /// the permission (and setuid/setgid/sticky) bits of the mode.
    public var permissions: FilePermissions { FilePermissions(rawValue: mode & 0o7777) }
    /// true iff this is a regular file (`S_ISREG`).
    public var isRegularFile: Bool { type == .regular }
    /// true iff this is a directory (`S_ISDIR`).
    public var isDirectory: Bool { type == .directory }
    /// true iff this is a symbolic link (`S_ISLNK`).
    public var isSymbolicLink: Bool { type == .symbolicLink }
    /// true iff this is a FIFO (`S_ISFIFO`).
    public var isFIFO: Bool { type == .fifo }
    /// true iff this is a socket (`S_ISSOCK`).
    public var isSocket: Bool { type == .socket }
    /// true iff this is a block device (`S_ISBLK`).
    public var isBlockDevice: Bool { type == .blockDevice }
    /// true iff this is a character device (`S_ISCHR`).
    public var isCharacterDevice: Bool { type == .characterDevice }

    internal init(_ st: stat) {
        dev = st.st_dev
        ino = st.st_ino
        mode = st.st_mode
        nlink = st.st_nlink
        uid = st.st_uid
        gid = st.st_gid
        rdev = st.st_rdev
        size = st.st_size
        #if canImport(Darwin)
        atime = TimeSpec(st.st_atimespec)
        mtime = TimeSpec(st.st_mtimespec)
        ctime = TimeSpec(st.st_ctimespec)
        #else
        atime = TimeSpec(st.st_atim)
        mtime = TimeSpec(st.st_mtim)
        ctime = TimeSpec(st.st_ctim)
        #endif
        blksize = st.st_blksize
        blocks = st.st_blocks
    }
}

/// identical to C's `stat(2)`, but returns a swifty `Stat`.
public func stat(_ path: String) throws -> Stat {
    var st = stat()
    _ = try path.withCString { try check(stat($0, &st)) }
    return Stat(st)
}

/// identical to C's `lstat(2)`, but returns a swifty `Stat`.
public func lstat(_ path: String) throws -> Stat {
    var st = stat()
    _ = try path.withCString { try check(lstat($0, &st)) }
    return Stat(st)
}

/// identical to C's `fstat(2)`, but returns a swifty `Stat`.
public func fstat(_ fd: CInt) throws -> Stat {
    var st = stat()
    try check(fstat(fd, &st))
    return Stat(st)
}

/// identical to C's `chmod(2)`.
public func chmod(_ path: String, _ mode: mode_t) throws {
    _ = try path.withCString { try check(chmod($0, mode)) }
}

/// identical to C's `mkdir(2)`.
public func mkdir(_ path: String, _ mode: mode_t = 0o777) throws {
    _ = try path.withCString { try check(mkdir($0, mode)) }
}

/// identical to C's `mkfifo(2)`.
public func mkfifo(_ path: String, _ mode: mode_t = 0o666) throws {
    _ = try path.withCString { try check(mkfifo($0, mode)) }
}

/// identical to C's `umask(2)`; returns the previous mask.
@discardableResult
public func umask(_ cmask: mode_t) -> mode_t { C.umask(cmask) }

/// identical to C's `utime(3)`; nil times mean "now".
public func utime(_ path: String, atime: time_t? = nil, mtime: time_t? = nil) throws {
    try path.withCString { p in
        if atime == nil && mtime == nil {
            try check(utime(p, nil))
        } else {
            let now = time(nil)
            var times = utimbuf(actime: atime ?? now, modtime: mtime ?? now)
            try check(utime(p, &times))
        }
    }
}
