# `<dirent.h>` — Dir

`DIR *` becomes `Dir`, a class that is also a `Sequence` of entry
names (including `"."` and `".."`, like `readdir(3)`):

```swift
public final class Dir: Sequence, IteratorProtocol {
    init(_ path: String) throws          // opendir
    func next() -> String?               // readdir
    func rewind()                        // rewinddir
    func tell() -> Int                   // telldir
    func seek(_ pos: Int)                // seekdir
    func close()                         // closedir (also runs on deinit)
}
```

The C-flavored free functions are there too:

```swift
opendir(_ path: String) throws -> Dir
readdir(_ dir: Dir) -> String?
rewinddir(_ dir: Dir)
telldir(_ dir: Dir) -> Int
seekdir(_ dir: Dir, _ pos: Int)
closedir(_ dir: Dir)
```

## Example

```swift
import POSIX

// swifty: a Dir is a Sequence
for name in try POSIX.Dir(".") where !name.hasPrefix(".") {
    print(name)
}
let entries = Array(try POSIX.Dir(".")).sorted()

// C-flavored, if you prefer
let dir = try POSIX.opendir(".")
while let name = POSIX.readdir(dir) {
    print(name)
}
POSIX.closedir(dir)
```

## Notes

* `Dir` closes itself on deinit; explicit `close()` is optional.
* Entry order is whatever the filesystem returns — sort if you care.
