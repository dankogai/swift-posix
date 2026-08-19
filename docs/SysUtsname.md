# `<sys/utsname.h>` — uname

`struct utsname`'s fixed-size char arrays become Strings:

```swift
public struct Utsname: Hashable, Sendable {
    let sysname: String    // operating system name
    let nodename: String   // network node name
    let release: String    // OS release
    let version: String    // OS version
    let machine: String    // hardware identifier
}

uname() throws -> Utsname
```

## Example

```swift
import POSIX

let u = try POSIX.uname()
u.sysname     // "Darwin" or "Linux"
u.release     // "25.6.0"
u.machine     // "arm64", "x86_64", ...
```
