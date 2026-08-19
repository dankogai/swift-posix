# `<signal.h>` — Signal, SigSet, sigaction

## Signal

A typed signal number with the classic names as static members:

```swift
public struct Signal: RawRepresentable, Hashable, Sendable {
    var rawValue: CInt
}
// SIGHUP SIGINT SIGQUIT SIGILL SIGTRAP SIGABRT SIGFPE SIGKILL SIGBUS
// SIGSEGV SIGSYS SIGPIPE SIGALRM SIGTERM SIGURG SIGSTOP SIGTSTP
// SIGCONT SIGCHLD SIGTTIN SIGTTOU SIGIO SIGXCPU SIGXFSZ SIGVTALRM
// SIGPROF SIGWINCH SIGUSR1 SIGUSR2

kill(_ pid: pid_t, _ sig: Signal) throws
raise(_ sig: Signal) throws
```

## SigSet — Perl's POSIX::SigSet

```swift
public struct SigSet: Sendable {
    init()                            // empty (sigemptyset)
    init(_ signals: Signal...)        // e.g. SigSet(.SIGINT, .SIGTERM)
    static var empty: SigSet
    static var all: SigSet            // sigfillset
    mutating func insert(_ sig: Signal)   // sigaddset
    mutating func remove(_ sig: Signal)   // sigdelset
    func contains(_ sig: Signal) -> Bool  // sigismember
}
```

## Masks and pending signals

```swift
sigprocmask(_ how: SigmaskHow, _ set: SigSet?) throws -> SigSet  // old mask
sigpending() throws -> SigSet
sigsuspend(_ mask: SigSet)
```

`SigmaskHow`: `.SIG_BLOCK`, `.SIG_UNBLOCK`, `.SIG_SETMASK`.  Pass
`nil` as the set to query without changing anything.

## Handlers — Perl's POSIX::SigAction

```swift
public enum SigHandler {
    case defaultAction                       // SIG_DFL
    case ignore                              // SIG_IGN
    case handler(@convention(c) (CInt) -> Void)
}

public struct SigAction {
    var handler: SigHandler
    var mask: SigSet
    var flags: CInt
}

sigaction(_ sig: Signal, _ action: SigAction? = nil) throws -> SigAction
    // installs action if non-nil; returns the previous one
signal(_ sig: Signal, _ handler: SigHandler) throws -> SigHandler
    // returns the previous handler
```

## Example

```swift
import POSIX

// ignore SIGPIPE, the classic server incantation
try POSIX.signal(.SIGPIPE, .ignore)

// block SIGINT around a critical section
let old = try POSIX.sigprocmask(.SIG_BLOCK, POSIX.SigSet(.SIGINT))
// ... critical section ...
try POSIX.sigprocmask(.SIG_SETMASK, old)

// a real handler must be a C-convention function: no captures
try POSIX.signal(.SIGUSR1, .handler({ signo in
    // async-signal-safe work only!
}))
```

## Notes

* Handler closures are `@convention(c)`: they cannot capture state, and
  everything inside must be async-signal-safe — same rules as C.
* `setjmp`/`longjmp`-style escapes are C-specific and unimplemented.
