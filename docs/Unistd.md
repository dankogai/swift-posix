# `<unistd.h>` — processes, descriptors, and the filesystem

## Process identity

```swift
getpid() -> pid_t          getppid() -> pid_t
getuid() -> uid_t          geteuid() -> uid_t
getgid() -> gid_t          getegid() -> gid_t
getpgrp() -> pid_t         getlogin() -> String?
getgroups() throws -> [gid_t]
setuid(_ uid: uid_t) throws
setgid(_ gid: gid_t) throws
setpgid(_ pid: pid_t, _ pgid: pid_t) throws
setsid() throws -> pid_t             // @discardableResult
```

## Processes

```swift
fork() throws -> pid_t               // 0 in the child, child pid in parent
_exit(_ status: CInt = 0) -> Never   // exit WITHOUT cleanup
nice(_ increment: CInt) throws -> CInt
alarm(_ seconds: UInt32) -> UInt32
pause()                              // wait for a signal
sleep(_ seconds: UInt32) -> UInt32   // returns unslept seconds
```

`exec*` are C-specific and unimplemented; use `posix_spawn` or
Foundation's `Process`.

## File descriptors

```swift
close(_ fd: CInt) throws
dup(_ fd: CInt) throws -> CInt
dup2(_ fd: CInt, _ fd2: CInt) throws -> CInt
pipe() throws -> (read: CInt, write: CInt)
isatty(_ fd: CInt) -> Bool
ttyname(_ fd: CInt) -> String?
lseek(_ fd: CInt, _ offset: off_t, _ whence: Whence = .SEEK_SET) throws -> off_t
read(_ fd: CInt, _ count: Int) throws -> [UInt8]
write(_ fd: CInt, _ bytes: [UInt8]) throws -> Int
write(_ fd: CInt, _ string: String) throws -> Int    // UTF-8 bytes
```

`Whence`: `.SEEK_SET`, `.SEEK_CUR`, `.SEEK_END`.

## Filesystem

```swift
access(_ path: String, _ mode: AccessMode = .F_OK) -> Bool
chdir(_ path: String) throws
chown(_ path: String, _ owner: uid_t, _ group: gid_t) throws
getcwd() throws -> String
link(_ existing: String, _ new: String) throws
unlink(_ path: String) throws
rmdir(_ path: String) throws
```

`AccessMode` is an OptionSet: `.F_OK`, `.R_OK`, `.W_OK`, `.X_OK`.

## Configuration queries

`nil` means "no limit / not supported" (C's ambiguous -1, resolved):

```swift
sysconf(_ name: SysconfName) throws -> Int?
pathconf(_ path: String, _ name: PathconfName) throws -> Int?
fpathconf(_ fd: CInt, _ name: PathconfName) throws -> Int?
```

`SysconfName`: `.argMax .childMax .clockTick .ngroupsMax .openMax
.pageSize .streamMax .tznameMax .jobControl .savedIDs .version
.processorsOnline` — or `SysconfName(rawValue:)` for anything else.

`PathconfName`: `.linkMax .maxCanon .maxInput .nameMax .pathMax
.pipeBuf .chownRestricted .noTrunc .vdisable`.

## Terminal process group

```swift
tcgetpgrp(_ fd: CInt) throws -> pid_t
tcsetpgrp(_ fd: CInt, _ pgid: pid_t) throws
```

## Example

```swift
import POSIX

let (r, w) = try POSIX.pipe()
try POSIX.write(w, "hello")
String(decoding: try POSIX.read(r, 64), as: UTF8.self)  // "hello"
try POSIX.close(r); try POSIX.close(w)

try POSIX.sysconf(.pageSize)   // Optional(16384)
POSIX.access("/etc/passwd", .R_OK)
```
