/*:
 [Previous](@previous)

 # `<errno.h>` and `<signal.h>` — throws, not -1

 Where C returns -1 and sets `errno`, this module throws `Errno` —
 a `RawRepresentable` error carrying all the `E*` constants.
 */
import POSIX

do {
    try POSIX.unlink("/no/such/file")
} catch let e as POSIX.Errno {
    e                                // ENOENT
    e.rawValue                       // 2
    e.description                    // strerror(3): "No such file or directory"
    e == .ENOENT                     // true
}
POSIX.strerror(.EACCES)
POSIX.strerror(.EPIPE)
//: `sigset_t` becomes `SigSet`, a value type:
var set = POSIX.SigSet(.SIGINT, .SIGTERM)
set.contains(.SIGINT)
set.remove(.SIGINT)
set.contains(.SIGINT)
POSIX.SigSet.all.contains(.SIGHUP)
//: Block a signal, observe the mask, restore — harmlessly:
let old = try POSIX.sigprocmask(.SIG_BLOCK, POSIX.SigSet(.SIGUSR2))
try POSIX.sigprocmask(.SIG_SETMASK, nil).contains(.SIGUSR2)  // true
try POSIX.sigprocmask(.SIG_SETMASK, old)                     // restored
//: `signal(3)`: ignore SIGUSR2, raise it, survive, restore:
let previous = try POSIX.signal(.SIGUSR2, .ignore)
try POSIX.raise(.SIGUSR2)            // ignored — we live to tell
try POSIX.signal(.SIGUSR2, previous)
//: `sigaction(2)` without arguments just queries:
let action = try POSIX.sigaction(.SIGWINCH)
action.handler                       // .defaultAction, most likely
/*:
 [Next: Terminal](@next)
 */
