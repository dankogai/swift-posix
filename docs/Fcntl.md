# `<fcntl.h>` — open, creat, fcntl

```swift
open(_ path: String, _ flags: OpenFlags = .O_RDONLY,
     _ mode: mode_t = 0o666) throws -> CInt
creat(_ path: String, _ mode: mode_t = 0o666) throws -> CInt
fcntl(_ fd: CInt, _ cmd: FcntlCommand, _ arg: CInt = 0) throws -> CInt
```

`OpenFlags` is an OptionSet with the C names as members:
`.O_RDONLY .O_WRONLY .O_RDWR .O_APPEND .O_CREAT .O_EXCL .O_TRUNC
.O_NONBLOCK .O_NOCTTY .O_CLOEXEC .O_NOFOLLOW .O_DIRECTORY .O_SYNC`

`FcntlCommand`: `.F_DUPFD .F_GETFD .F_SETFD .F_GETFL .F_SETFL
.F_GETOWN .F_SETOWN` — plus the `FD_CLOEXEC` constant for the
`F_GETFD`/`F_SETFD` bit.

## Example

```swift
import POSIX

let fd = try POSIX.open("/tmp/log", [.O_WRONLY, .O_CREAT, .O_APPEND], 0o644)
try POSIX.write(fd, "hello\n")

// set close-on-exec via fcntl
let old = try POSIX.fcntl(fd, .F_GETFD)
try POSIX.fcntl(fd, .F_SETFD, old | POSIX.FD_CLOEXEC)

try POSIX.close(fd)
```

## Notes

* `fcntl` covers the integer-argument commands; the lock-struct
  commands (`F_SETLK` …) are out of scope for a thin layer.
* The mode is masked by the process [`umask`](SysStat.md), as always.
