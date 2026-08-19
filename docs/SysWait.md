# `<sys/wait.h>` — wait, waitpid, WaitStatus

The `W*` status macros become properties of `WaitStatus`:

```swift
public struct WaitStatus: RawRepresentable, Hashable, Sendable {
    var rawValue: CInt

    var exited: Bool            // WIFEXITED
    var exitStatus: CInt?       // WEXITSTATUS, if exited
    var signaled: Bool          // WIFSIGNALED
    var termSignal: Signal?     // WTERMSIG, if signaled
    var coreDumped: Bool        // WCOREDUMP
    var stopped: Bool           // WIFSTOPPED
    var stopSignal: Signal?     // WSTOPSIG, if stopped
    var continued: Bool         // WIFCONTINUED
}
```

## Functions

```swift
wait() throws -> (pid: pid_t, status: WaitStatus)
waitpid(_ pid: pid_t, _ options: WaitOptions = [])
    throws -> (pid: pid_t, status: WaitStatus)
```

`WaitOptions` is an OptionSet: `.WNOHANG`, `.WUNTRACED`,
`.WCONTINUED`.  With `.WNOHANG`, a returned pid of 0 means "nothing
has changed yet".

## Example

```swift
import POSIX

let child = try POSIX.fork()
if child == 0 {
    // ... child work ...
    POSIX._exit(7)
}
let (pid, status) = try POSIX.waitpid(child)
pid == child             // true
status.exited            // true
status.exitStatus        // 7
status.termSignal        // nil — it was not signaled
```
