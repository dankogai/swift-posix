# swift-posix

[![CI via GitHub Actions](https://github.com/dankogai/swift-posix/actions/workflows/swift.yml/badge.svg)](https://github.com/dankogai/swift-posix/actions/workflows/swift.yml)

A thin but swifty POSIX layer.

`import Foundation` (or `Darwin`/`Glibc`) dumps libc into your namespace
exactly as C has it: `UnsafePointer<CChar>?` instead of `String`, `-1`
and a global `errno` instead of errors, and C structs full of
`st_`-prefixed fields.  This module is modeled after [Perl's POSIX
module], which has long been a good example of an interface between raw
libc and the host language: keep the names and the semantics, fix the
types.

[Perl's POSIX module]: https://perldoc.perl.org/POSIX

```swift
import POSIX

// Strings in, Strings out
let cwd  = try getcwd()                    // "/Users/dankogai"
let real = tolower("Hello, World!")        // C-locale case mapping

// throws Errno instead of returning -1
do {
    try unlink("/no/such/file")
} catch let e as Errno where e == .ENOENT {
    print(e)                               // "No such file or directory"
}

// C structs, made swifty
let st = try stat("Package.swift")
st.isRegularFile                           // true (S_ISREG)
st.size                                    // 501
st.permissions.contains(.S_IRUSR)          // true
st.mtime.timeInterval                      // 1755590000.5817671

// out-parameters become tuples
let (mantissa, exponent) = frexp(8)        // (0.5, 4)
let (value, unparsed) = strtod("3.14foo")  // (3.14, 3)
let (r, w) = try pipe()

// flags become OptionSets
let fd = try open("/tmp/log", [.O_WRONLY, .O_CREAT, .O_APPEND], 0o644)
try write(fd, "hello\n")
try close(fd)

// and time is a struct, not a tuple of nine Ints
strftime("%Y-%m-%d", gmtime(0))            // "1970-01-01"
asctime(gmtime(0))                         // "Thu Jan  1 00:00:00 1970\n"
```

## Requirements

Swift 6.0 or later, on macOS (Darwin) or Linux (Glibc).

## Usage

Add to your `Package.swift`:

```swift
.package(url: "https://github.com/dankogai/swift-posix.git", from: "0.0.1")
```

and `import POSIX`.  Everything the module exports is also reachable
fully qualified (`POSIX.floor`, `POSIX.open`, …), which is handy when
you also import Foundation and names collide.

## Design

* **Same names as C** — `getcwd`, `strftime`, `mkfifo`, `SIGINT`,
  `O_CREAT`.  If you know POSIX you already know this module.  Swifty
  renaming is limited to types (`Stat`, `Tm`, `SigSet`, …) which C
  spells the same as functions.
* **`String` where C has `char *`** — and `[UInt8]` where C means bytes
  (`read`/`write`).
* **`throws Errno` where C returns -1** — `Errno` is a
  `RawRepresentable` error with all the `E*` constants
  (`Errno.ENOENT`) and a `strerror` description.  Functions that
  cannot fail (`getpid`) don't throw.
* **Swifty structs where C has structs** — `Stat`, `Tm`, `Times`,
  `Utsname`, `Lconv`, `Termios`, `WaitStatus`, `SigSet`, `SigAction`,
  `Passwd`, `Group`, and `Dir` (a `Sequence` of entry names).  Macros
  become properties: `S_ISDIR(st_mode)` is `st.isDirectory`,
  `WIFEXITED(status)` is `status.exited`.
* **`OptionSet`s and wrapper types where C has flag/enum constants** —
  `OpenFlags`, `FilePermissions`, `AccessMode`, `WaitOptions`,
  `Signal`, `LocaleCategory`, `Whence`, `BaudRate`, and the
  `Termios` flag sets, each with the original C constant names as
  members.
* **Out-parameters become tuples** — `frexp`, `modf`, `remquo`,
  `strtod`, `strtol`, `pipe`, `wait`, `mkstemp`.
* **Thin** — no Foundation, no dependencies; every wrapper is a few
  lines over libc.

## What's deliberately not implemented

Perl's POSIX module leaves the C-specific functions unimplemented and
croaks with advice ("C-specific: use eval {} instead").  This module
keeps that interface parity: `atoi`, `malloc`, `strlen`, `printf`,
`setjmp`, `qsort`, `execl`, and friends all exist but halt with
`fatalError` pointing at the swifty way:

```swift
strlen("hello")
// Fatal error: POSIX.strlen() is C-specific and unimplemented:
//              use String.count or utf8.count
```

## Coverage

| header | provided |
|---|---|
| `<ctype.h>` | `isalpha` … `isxdigit`, `tolower`, `toupper` (Perl semantics: whole-string tests, C-locale/ASCII rules) |
| `<dirent.h>` | `Dir` (a `Sequence`), `opendir`, `readdir`, `rewinddir`, `telldir`, `seekdir`, `closedir` |
| `<errno.h>` | `Errno` with `E*` constants, `strerror`, `Errno.current` |
| `<fcntl.h>` | `open`, `creat`, `fcntl` with `OpenFlags`, `FcntlCommand`, `FD_CLOEXEC` |
| `<fenv.h>` | `fegetround`, `fesetround`, `FE_*` |
| `<float.h>`, `<limits.h>` | `DBL_MAX`, `INT_MAX`, … (defined from Swift's numeric types) |
| `<grp.h>`, `<pwd.h>` | `getpwnam`, `getpwuid`, `getgrnam`, `getgrgid` returning `Passwd`/`Group` |
| `<locale.h>` | `setlocale` with `LocaleCategory`, `localeconv` returning `Lconv` |
| `<math.h>` | the full C99 repertoire, `Double` in and out; `fpclassify` returns Swift's `FloatingPointClassification` |
| `<signal.h>` | `Signal` constants, `kill`, `raise`, `signal`, `sigaction`, `SigSet`, `sigprocmask`, `sigpending`, `sigsuspend` |
| `<stdio.h>` | `ctermid`, `cuserid`, `remove`, `rename`, `mkstemp` (stream I/O is C-specific — unimplemented) |
| `<stdlib.h>` | `exit`, `abort`, `getenv`/`setenv`/`unsetenv`, `strtod`/`strtol`/`strtoul`, `mblen`/`mbtowc`/`wctomb`/`mbstowcs`/`wcstombs` |
| `<string.h>` | `strcoll`, `strxfrm` (the rest is C-specific — unimplemented) |
| `<sys/stat.h>` | `Stat`, `stat`, `lstat`, `fstat`, `chmod`, `mkdir`, `mkfifo`, `umask`, `utime` |
| `<sys/times.h>` | `times` returning `Times` (with elapsed real time, like Perl's) |
| `<sys/utsname.h>` | `uname` returning `Utsname` |
| `<sys/wait.h>` | `wait`, `waitpid`, `WaitStatus` (the `W*` macros as properties) |
| `<termios.h>` | `Termios` with typed flag sets and `BaudRate`, `tcgetattr`, `tcsetattr`, `tcdrain`, `tcflow`, `tcflush`, `tcsendbreak` |
| `<time.h>` | `Tm`, `time`, `gmtime`, `localtime`, `mktime`, `strftime`, `asctime`, `ctime`, `difftime`, `clock`, `tzset`, `tzname` |
| `<unistd.h>` | ids, `fork`, `pipe`, `read`, `write`, `open`/`close`/`dup`/`lseek`, `getcwd`/`chdir`, `link`/`unlink`/`rmdir`, `access`, `sysconf`/`pathconf`, `isatty`/`ttyname`, `alarm`/`pause`/`sleep`, `getgroups`, `getlogin`, `nice`, `tcgetpgrp`/`tcsetpgrp` |

## License

MIT.  See [LICENSE](LICENSE).
