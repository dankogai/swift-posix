/*:
 [Previous](@previous)

 # `<sys/stat.h>`, `<fcntl.h>`, `<dirent.h>` — files, made swifty

 `struct stat` becomes `Stat`: macros become properties, timestamps
 become `TimeSpec`, and failures throw `Errno`.
 */
import POSIX

let cwd = try POSIX.getcwd()
let st = try POSIX.stat(cwd)
st.isDirectory                       // S_ISDIR(st_mode)
st.type                              // .directory
st.permissions.contains(.S_IRUSR)
st.mtime.timeInterval                // nanosecond-resolution Double
st.size
st.nlink
//: `access(2)` returns a Bool; flags are OptionSets:
POSIX.access(cwd, [.R_OK, .X_OK])
POSIX.access("/no/such/path")        // false, no throwing needed
//: A full create-write-read-remove round trip in the temp directory:
let template = (POSIX.getenv("TMPDIR") ?? "/tmp/") + "posix-demo.XXXXXX"
let (fd, path) = try POSIX.mkstemp(template)
path                                 // the XXXXXX got replaced
try POSIX.write(fd, "thin but swifty\n")
try POSIX.lseek(fd, 0)               // rewind (.SEEK_SET is the default)
let bytes = try POSIX.read(fd, 1024)
String(decoding: bytes, as: UTF8.self)
try POSIX.fstat(fd).isRegularFile
try POSIX.close(fd)
try POSIX.unlink(path)               // clean up after ourselves
//: `DIR *` becomes `Dir`, a `Sequence` of entry names:
let entries = Array(try POSIX.Dir(cwd)).sorted()
entries.contains("Package.swift")
for name in try POSIX.Dir(cwd) where !name.hasPrefix(".") {
    name
}
//: `pathconf(3)` with a swifty name (nil means "no limit"):
try POSIX.pathconf(cwd, .nameMax)
/*:
 [Next: Time](@next)
 */
