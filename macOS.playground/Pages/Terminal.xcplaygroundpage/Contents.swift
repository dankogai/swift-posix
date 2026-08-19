/*:
 [Previous](@previous)

 # `<termios.h>` — `POSIX::Termios`, the Swift edition

 `struct termios` becomes `Termios`, with each flag word typed as its
 own OptionSet and `c_cc` reachable by subscript.
 */
import POSIX

var t = POSIX.Termios()
//: Flags are OptionSets — compose, test, and remove them swiftily:
t.localFlags = [.ICANON, .ECHO, .ISIG]
t.localFlags.contains(.ECHO)
t.localFlags.remove(.ECHO)           // "raw-ish" mode, one flag at a time
t.localFlags
t.inputFlags = [.ICRNL, .IXON]
t.outputFlags = [.OPOST, .ONLCR]
t.controlFlags = [.CREAD, .CS8]
//: Control characters live behind a subscript:
t[.VMIN] = 1
t[.VTIME] = 10                       // deciseconds
t[.VMIN]
//: Baud rates are typed, too:
t.inputSpeed = .B9600
t.outputSpeed = .B9600
t.inputSpeed == .B9600
/*:
 A playground process has no controlling terminal, so the live calls
 mostly decline politely — which itself demonstrates the interface:
 */
POSIX.isatty(0)                      // false here; true in a real shell
POSIX.ttyname(0)                     // nil for the same reason
do {
    let live = try POSIX.tcgetattr(0)
    live.localFlags.contains(.ECHO)  // only reached from a real terminal
} catch let e as POSIX.Errno {
    e                                // ENOTTY or ENXIO, as C promises
}
/*:
 In a real terminal program the classic "raw mode" dance reads:

     var tio  = try POSIX.tcgetattr(0)
     tio.localFlags.remove([.ICANON, .ECHO])
     tio[.VMIN] = 1
     tio[.VTIME] = 0
     try POSIX.tcsetattr(0, .TCSANOW, tio)

 That is the end of the tour.  See the manuals in `docs/` for the
 complete reference.

 [Back to Welcome](Welcome)
 */
