# `<stdio.h>` — the non-stream corner

C stream I/O (`fopen`, `printf`, …) is C-specific and unimplemented
(see [Unimplemented.md](Unimplemented.md)); this module deals in file
descriptors.  What remains of `<stdio.h>`:

```swift
ctermid() -> String                  // path of the controlling terminal
cuserid() -> String?                 // name for the effective uid
remove(_ path: String) throws
rename(_ old: String, _ new: String) throws
mkstemp(_ template: String) throws -> (fd: CInt, path: String)
```

`mkstemp` takes a template ending in `"XXXXXX"`, creates and opens a
unique file, and returns both the open descriptor and the actual path —
like Perl's `POSIX::mkstemp` returning `($fh, $file)`.

## Example

```swift
import POSIX

let template = (POSIX.getenv("TMPDIR") ?? "/tmp/") + "demo.XXXXXX"
let (fd, path) = try POSIX.mkstemp(template)
try POSIX.write(fd, "hello\n")
try POSIX.close(fd)
try POSIX.rename(path, path + ".txt")
try POSIX.remove(path + ".txt")
```

## Notes

* `tmpnam` was insecure and has been removed from Perl too; use
  `mkstemp`.  `tmpfile` is likewise unimplemented.
* `cuserid` is implemented via `getpwuid_r(geteuid())`, which is what
  the (long-deprecated) C function meant.
