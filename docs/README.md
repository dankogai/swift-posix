# swift-posix manual

A thin but swifty POSIX layer, modeled after [Perl's POSIX
module](https://perldoc.perl.org/POSIX): keep the C names and
semantics, fix the types.

## Importing

```swift
import POSIX                      // one name in scope: the POSIX namespace
try POSIX.getcwd()

import POSIXGlobals               // Perl's `use POSIX`: everything top-level
try getcwd()

import func POSIXGlobals.floor    // Perl's @EXPORT_OK: single symbols
import struct POSIXGlobals.Errno
```

Both modules ship in the one `POSIX` library product and share the same
underlying types, so the styles mix freely.  The manuals below write
`POSIX.name`; drop the prefix when you use `POSIXGlobals`.

## Conventions

* **Same names as C.**  `getcwd`, `strftime`, `mkfifo`, `SIGINT`,
  `O_CREAT`.  Renaming is limited to types (`Stat`, `Tm`, `SigSet`, …),
  which C spells the same as its functions.
* **`String` where C has `char *`;** `[UInt8]` where C means bytes.
* **`throws Errno` where C returns -1** and sets `errno`.  Functions
  that cannot fail do not throw.
* **Swifty structs where C has structs;** macros become properties
  (`S_ISDIR(m)` → `st.isDirectory`, `WIFEXITED(s)` → `status.exited`).
* **`OptionSet`s and wrapper types where C has flag constants,** with
  the original C constant names as members (`[.O_WRONLY, .O_CREAT]`).
* **Out-parameters become tuples** (`frexp`, `modf`, `strtod`, `pipe`,
  `wait`, `mkstemp`).
* **C-specific functions stay unimplemented,** exactly as in POSIX.pm —
  they exist but halt with advice.  See
  [Unimplemented.md](Unimplemented.md).

## Manuals by header

| manual | header | contents |
|---|---|---|
| [Errno.md](Errno.md) | `<errno.h>` | the `Errno` error type, `E*` constants, `strerror` |
| [CType.md](CType.md) | `<ctype.h>` | `isalpha` …, `tolower`, `toupper` |
| [Math.md](Math.md) | `<math.h>`, `<fenv.h>` | the C99 math repertoire |
| [Stdlib.md](Stdlib.md) | `<stdlib.h>`, `<string.h>` | `exit`, environment, `strtod`, multibyte, `strcoll` |
| [Stdio.md](Stdio.md) | `<stdio.h>` | `ctermid`, `remove`, `rename`, `mkstemp` |
| [Unistd.md](Unistd.md) | `<unistd.h>` | ids, descriptors, filesystem, `sysconf` |
| [Fcntl.md](Fcntl.md) | `<fcntl.h>` | `open`, `creat`, `fcntl`, `OpenFlags` |
| [SysStat.md](SysStat.md) | `<sys/stat.h>` | `Stat`, `stat`, `chmod`, `mkdir`, `umask` |
| [Time.md](Time.md) | `<time.h>`, `<sys/times.h>` | `Tm`, `strftime`, `mktime`, `times` |
| [SysUtsname.md](SysUtsname.md) | `<sys/utsname.h>` | `uname` and `Utsname` |
| [SysWait.md](SysWait.md) | `<sys/wait.h>` | `wait`, `waitpid`, `WaitStatus` |
| [Signal.md](Signal.md) | `<signal.h>` | `Signal`, `SigSet`, `sigaction` |
| [Locale.md](Locale.md) | `<locale.h>` | `setlocale`, `localeconv`, `Lconv` |
| [Termios.md](Termios.md) | `<termios.h>` | `Termios`, `BaudRate`, `tcsetattr` |
| [Dirent.md](Dirent.md) | `<dirent.h>` | `Dir` and the `*dir` functions |
| [PwdGrp.md](PwdGrp.md) | `<pwd.h>`, `<grp.h>` | `Passwd`, `Group` lookups |
| [Limits.md](Limits.md) | `<limits.h>`, `<float.h>` | numeric constants |
| [Unimplemented.md](Unimplemented.md) | various | the deliberately-unimplemented list |

## Trying it out

`macOS.playground` at the repository root walks through all of the
above interactively: open the package directory in Xcode, build the
**POSIX** scheme once (⌘B), then open the playground pages.
