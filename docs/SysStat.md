# `<sys/stat.h>` — Stat and friends

`struct stat` made swifty: fields lose their `st_` prefix, the
`S_IS*` macros become properties, and timestamps carry their
nanoseconds.

```swift
public struct Stat: Sendable {
    let dev: dev_t          // st_dev
    let ino: ino_t          // st_ino
    let mode: mode_t        // st_mode (raw)
    let nlink: nlink_t      // st_nlink
    let uid: uid_t          // st_uid
    let gid: gid_t          // st_gid
    let rdev: dev_t         // st_rdev
    let size: off_t         // st_size
    let atime: TimeSpec     // st_atime, with nanoseconds
    let mtime: TimeSpec
    let ctime: TimeSpec
    let blksize: blksize_t
    let blocks: blkcnt_t

    var type: FileType                  // from the mode bits
    var permissions: FilePermissions    // mode & 0o7777
    var isRegularFile: Bool             // S_ISREG
    var isDirectory: Bool               // S_ISDIR
    var isSymbolicLink: Bool            // S_ISLNK
    var isFIFO: Bool                    // S_ISFIFO
    var isSocket: Bool                  // S_ISSOCK
    var isBlockDevice: Bool             // S_ISBLK
    var isCharacterDevice: Bool         // S_ISCHR
}

public struct TimeSpec: Hashable, Sendable, Comparable {
    var seconds: Int
    var nanoseconds: Int
    var timeInterval: Double            // seconds, as a Double
}
```

`FileType` is an enum: `.regular .directory .symbolicLink .fifo
.socket .blockDevice .characterDevice .unknown`.

`FilePermissions` is an OptionSet with the C names: `.S_IRUSR
.S_IWUSR .S_IXUSR .S_IRWXU` (likewise `…G`, `…O`) plus `.S_ISUID
.S_ISGID .S_ISVTX`.

## Functions

```swift
stat(_ path: String) throws -> Stat
lstat(_ path: String) throws -> Stat    // does not follow symlinks
fstat(_ fd: CInt) throws -> Stat
chmod(_ path: String, _ mode: mode_t) throws
mkdir(_ path: String, _ mode: mode_t = 0o777) throws
mkfifo(_ path: String, _ mode: mode_t = 0o666) throws
umask(_ cmask: mode_t) -> mode_t        // returns the previous mask
utime(_ path: String, atime: time_t? = nil, mtime: time_t? = nil) throws
                                        // nil means "now"
```

## Example

```swift
import POSIX

let st = try POSIX.stat("Package.swift")
st.isRegularFile                     // true
st.size                              // bytes
st.permissions.contains(.S_IWUSR)    // writable by owner?
st.mtime.timeInterval                // 1755590000.5817671

if try POSIX.lstat("some-link").isSymbolicLink {
    // ...
}
```
