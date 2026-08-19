# `<pwd.h>`, `<grp.h>` — the user and group databases

`struct passwd` and `struct group` become value types (the lookups use
the `_r` reentrant variants internally):

```swift
public struct Passwd: Hashable, Sendable {
    let name: String      // pw_name
    let uid: uid_t        // pw_uid
    let gid: gid_t        // pw_gid
    let gecos: String     // pw_gecos (real name)
    let dir: String       // pw_dir (home directory)
    let shell: String     // pw_shell
}

public struct Group: Hashable, Sendable {
    let name: String      // gr_name
    let gid: gid_t        // gr_gid
    let members: [String] // gr_mem
}

getpwnam(_ name: String) -> Passwd?
getpwuid(_ uid: uid_t) -> Passwd?
getgrnam(_ name: String) -> Group?
getgrgid(_ gid: gid_t) -> Group?
```

`nil` means "no such entry".

## Example

```swift
import POSIX

if let me = POSIX.getpwuid(POSIX.getuid()) {
    me.name       // "dankogai"
    me.dir        // "/Users/dankogai"
    me.shell      // "/bin/zsh"
}
POSIX.getgrgid(POSIX.getgid())?.name   // "staff"
POSIX.getpwnam("root")?.uid            // 0
```
