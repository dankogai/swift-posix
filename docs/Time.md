# `<time.h>`, `<sys/times.h>` — Tm, strftime, times

`struct tm` becomes `Tm`, a value type — no shared static buffers, no
nine-element lists:

```swift
public struct Tm: Hashable, Sendable {
    var sec: Int      // 0...61
    var min: Int      // 0...59
    var hour: Int     // 0...23
    var mday: Int     // 1...31
    var mon: Int      // 0...11 (January is 0, as in C and Perl)
    var year: Int     // years since 1900
    var wday: Int     // 0...6, Sunday is 0
    var yday: Int     // 0...365
    var isdst: Int    // >0 in effect, 0 not, <0 unknown
    var gmtoff: Int   // seconds east of UTC
    var zone: String? // timezone abbreviation
}
```

## Functions

```swift
time() -> time_t                       // seconds since the epoch
difftime(_ t1: time_t, _ t0: time_t) -> Double
gmtime(_ t: time_t = time()) -> Tm     // UTC (gmtime_r)
localtime(_ t: time_t = time()) -> Tm  // local time (localtime_r)
mktime(_ tm: Tm) throws -> time_t      // local-time Tm -> epoch seconds
asctime(_ tm: Tm) -> String            // "Thu Jan  1 00:00:00 1970\n"
ctime(_ t: time_t = time()) -> String  // asctime(localtime(t))
strftime(_ format: String, _ tm: Tm) -> String
clock() -> clock_t                     // CPU time, CLOCKS_PER_SEC ticks
tzset()
tzname() -> (standard: String, daylight: String)
```

## `times(3)`

Returns a struct including elapsed real time, like Perl's five-element
`POSIX::times()`.  Values are in `sysconf(.clockTick)` ticks:

```swift
public struct Times: Hashable, Sendable {
    let elapsed: clock_t      // real time since an arbitrary point
    let user: clock_t         // tms_utime
    let system: clock_t       // tms_stime
    let childUser: clock_t    // tms_cutime
    let childSystem: clock_t  // tms_cstime
}
times() throws -> Times
```

## Example

```swift
import POSIX

let now = POSIX.time()
let tm = POSIX.localtime(now)
POSIX.strftime("%Y-%m-%d %H:%M:%S %Z", tm)
try POSIX.mktime(tm) == now                       // round trip
POSIX.strftime("%Y-%m-%d", POSIX.gmtime(0))       // "1970-01-01"
POSIX.asctime(POSIX.gmtime(0))                    // fixed C format
```

## Notes

* `tzname()` avoids the non-thread-safe C global by deriving the pair
  from `tm_zone` in January and July.
* There is no `strptime` in POSIX.pm, so there is none here; parse with
  `strtol` or Swift facilities.
