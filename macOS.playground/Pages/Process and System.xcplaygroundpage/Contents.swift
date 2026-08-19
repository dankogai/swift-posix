/*:
 [Previous](@previous)

 # `<unistd.h>`, `<sys/utsname.h>`, `<pwd.h>` — the process and its world
 */
import POSIX

POSIX.getpid()
POSIX.getppid()
POSIX.getuid()
POSIX.geteuid()
POSIX.getgid()
try POSIX.getgroups()
POSIX.getlogin()
//: `uname(3)` returns a struct of Strings:
let u = try POSIX.uname()
u.sysname                            // "Darwin"
u.release
u.machine                            // "arm64"
//: `sysconf(3)` with swifty names — nil means "no limit":
try POSIX.sysconf(.pageSize)
try POSIX.sysconf(.openMax)
try POSIX.sysconf(.clockTick)
try POSIX.sysconf(.processorsOnline)
//: The environment, without Foundation:
try POSIX.setenv("POSIX_PLAYGROUND", "hello")
POSIX.getenv("POSIX_PLAYGROUND")
try POSIX.unsetenv("POSIX_PLAYGROUND")
POSIX.getenv("POSIX_PLAYGROUND")     // nil
//: The user database, as value types:
if let me = POSIX.getpwuid(POSIX.getuid()) {
    me.name
    me.dir
    me.shell
}
POSIX.getgrgid(POSIX.getgid())?.name
//: `pipe(2)` returns a tuple — here is a self-contained echo:
let (r, w) = try POSIX.pipe()
try POSIX.write(w, "through the pipe")
String(decoding: try POSIX.read(r, 64), as: UTF8.self)
try POSIX.close(r)
try POSIX.close(w)
/*:
 `fork`, `wait`, `kill` and friends are all here too — they just make
 poor playground material.  `WaitStatus` shows off without forking:
 */
let status = POSIX.WaitStatus(rawValue: 5 << 8)
status.exited                        // WIFEXITED
status.exitStatus                    // WEXITSTATUS: 5
let killed = POSIX.WaitStatus(rawValue: POSIX.Signal.SIGTERM.rawValue)
killed.signaled                      // WIFSIGNALED
killed.termSignal == .SIGTERM        // WTERMSIG
/*:
 [Next: Errors and Signals](@next)
 */
