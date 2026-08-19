# `<termios.h>` — Termios

The counterpart of Perl's `POSIX::Termios`: `struct termios` wrapped in
a value type, with each flag word typed as its own OptionSet, `c_cc`
behind a subscript, and speeds as `BaudRate`.

```swift
public struct Termios: Sendable {
    var raw: termios                      // the underlying C struct
    init()                                // zeroed

    var inputFlags: InputFlags            // c_iflag
    var outputFlags: OutputFlags          // c_oflag
    var controlFlags: ControlFlags        // c_cflag
    var localFlags: LocalFlags            // c_lflag
    subscript(_: ControlCharacter) -> cc_t // c_cc
    var inputSpeed: BaudRate              // cfgetispeed/cfsetispeed
    var outputSpeed: BaudRate             // cfgetospeed/cfsetospeed
}
```

The members keep their C names:

* `InputFlags`: `IGNBRK BRKINT IGNPAR PARMRK INPCK ISTRIP INLCR IGNCR
  ICRNL IXON IXOFF IXANY`
* `OutputFlags`: `OPOST ONLCR OCRNL ONOCR ONLRET`
* `ControlFlags`: `CSIZE CS5 CS6 CS7 CS8 CSTOPB CREAD PARENB PARODD
  HUPCL CLOCAL`
* `LocalFlags`: `ECHO ECHOE ECHOK ECHONL ICANON ISIG IEXTEN NOFLSH
  TOSTOP`
* `ControlCharacter`: `VEOF VEOL VERASE VINTR VKILL VMIN VQUIT VSTART
  VSTOP VSUSP VTIME`
* `BaudRate`: `B0 B50 B75 B110 B134 B150 B200 B300 B600 B1200 B1800
  B2400 B4800 B9600 B19200 B38400 B57600 B115200 B230400`

## Functions

```swift
tcgetattr(_ fd: CInt) throws -> Termios
tcsetattr(_ fd: CInt, _ action: TcsetattrAction = .TCSANOW,
          _ termios: Termios) throws
tcdrain(_ fd: CInt) throws
tcflow(_ fd: CInt, _ action: TcflowAction) throws      // TCOOFF TCOON TCIOFF TCION
tcflush(_ fd: CInt, _ queue: TcflushQueue) throws      // TCIFLUSH TCOFLUSH TCIOFLUSH
tcsendbreak(_ fd: CInt, _ duration: CInt = 0) throws
```

`TcsetattrAction`: `.TCSANOW`, `.TCSADRAIN`, `.TCSAFLUSH`.

## Example — raw mode

```swift
import POSIX

var tio = try POSIX.tcgetattr(0)
let saved = tio
tio.localFlags.remove([.ICANON, .ECHO])
tio[.VMIN] = 1
tio[.VTIME] = 0
try POSIX.tcsetattr(0, .TCSANOW, tio)
// ... read keystrokes byte-by-byte ...
try POSIX.tcsetattr(0, .TCSANOW, saved)
```

## Notes

* On Linux, input and output speed share the kernel's one `CBAUD`
  field, so setting one may change the other; on macOS they are
  independent.
* Related: [`tcgetpgrp`/`tcsetpgrp`](Unistd.md), and
  [`ctermid`](Stdio.md).
