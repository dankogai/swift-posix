/*:
 [Previous](@previous)

 # `<time.h>` — `struct tm` becomes `Tm`

 No nine-element tuples, no pointer juggling, no shared static buffers.
 */
import POSIX

let now = POSIX.time()               // seconds since the epoch
//: `gmtime`/`localtime` return a value type:
let epoch = POSIX.gmtime(0)
epoch.year + 1900                    // 1970
epoch.wday                           // 4 — a Thursday
let local = POSIX.localtime()        // defaults to now
local.zone                           // e.g. "JST"
local.gmtoff                         // seconds east of UTC
//: `mktime` goes the other way (and round-trips):
try POSIX.mktime(local) == now
//: `strftime` formats, `asctime`/`ctime` use the classic fixed format:
POSIX.strftime("%Y-%m-%d %H:%M:%S", local)
POSIX.strftime("%A, %B %e", local)
POSIX.asctime(epoch)                 // "Thu Jan  1 00:00:00 1970\n"
POSIX.ctime()                        // now, in local time
//: Timezone helpers:
POSIX.tzset()
POSIX.tzname()                       // (standard, daylight) abbreviations
POSIX.difftime(now, 0) == Double(now)
//: `times(3)` returns a struct (ticks; see `sysconf(.clockTick)`):
let t = try POSIX.times()
t.user
t.system
POSIX.clock()                        // CPU time in CLOCKS_PER_SEC ticks
/*:
 [Next: Process and System](@next)
 */
