/// Time.swift — <time.h> and <sys/times.h>, with `struct tm` made swifty.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// A swifty `struct tm`.
public struct Tm: Hashable, Sendable {
    /// seconds after the minute [0, 61] (`tm_sec`)
    public var sec: Int
    /// minutes after the hour [0, 59] (`tm_min`)
    public var min: Int
    /// hours since midnight [0, 23] (`tm_hour`)
    public var hour: Int
    /// day of the month [1, 31] (`tm_mday`)
    public var mday: Int
    /// months since January [0, 11] (`tm_mon`)
    public var mon: Int
    /// years since 1900 (`tm_year`)
    public var year: Int
    /// days since Sunday [0, 6] (`tm_wday`)
    public var wday: Int
    /// days since January 1 [0, 365] (`tm_yday`)
    public var yday: Int
    /// daylight saving time flag: positive if in effect, 0 if not,
    /// negative if unknown (`tm_isdst`)
    public var isdst: Int
    /// offset from UTC in seconds (`tm_gmtoff`)
    public var gmtoff: Int
    /// timezone abbreviation (`tm_zone`)
    public var zone: String?

    public init(
        sec: Int = 0, min: Int = 0, hour: Int = 0,
        mday: Int = 1, mon: Int = 0, year: Int = 70,
        wday: Int = 0, yday: Int = 0, isdst: Int = -1,
        gmtoff: Int = 0, zone: String? = nil
    ) {
        self.sec = sec; self.min = min; self.hour = hour
        self.mday = mday; self.mon = mon; self.year = year
        self.wday = wday; self.yday = yday; self.isdst = isdst
        self.gmtoff = gmtoff; self.zone = zone
    }

    internal init(_ ctm: tm) {
        sec = Int(ctm.tm_sec); min = Int(ctm.tm_min); hour = Int(ctm.tm_hour)
        mday = Int(ctm.tm_mday); mon = Int(ctm.tm_mon); year = Int(ctm.tm_year)
        wday = Int(ctm.tm_wday); yday = Int(ctm.tm_yday); isdst = Int(ctm.tm_isdst)
        gmtoff = Int(ctm.tm_gmtoff)
        zone = ctm.tm_zone.map { String(cString: $0) }
    }

    internal var ctm: tm {
        var t = tm()
        t.tm_sec = CInt(sec); t.tm_min = CInt(min); t.tm_hour = CInt(hour)
        t.tm_mday = CInt(mday); t.tm_mon = CInt(mon); t.tm_year = CInt(year)
        t.tm_wday = CInt(wday); t.tm_yday = CInt(yday); t.tm_isdst = CInt(isdst)
        t.tm_gmtoff = gmtoff
        return t
    }
}

/// identical to C's `time(2)`: seconds since the epoch.
public func time() -> time_t { time(nil) }

/// identical to C's `difftime(3)`.
public func difftime(_ time1: time_t, _ time0: time_t) -> Double { C.difftime(time1, time0) }

/// identical to C's `gmtime(3)` (via `gmtime_r`), but returns a swifty `Tm`.
public func gmtime(_ t: time_t = time(nil)) -> Tm {
    var tv = t
    var result = tm()
    gmtime_r(&tv, &result)
    return Tm(result)
}

/// identical to C's `localtime(3)` (via `localtime_r`), but returns a swifty `Tm`.
public func localtime(_ t: time_t = time(nil)) -> Tm {
    var tv = t
    var result = tm()
    localtime_r(&tv, &result)
    return Tm(result)
}

/// identical to C's `mktime(3)`: converts a local-time `Tm` to seconds
/// since the epoch.
public func mktime(_ tm: Tm) throws -> time_t {
    var ctm = tm.ctm
    return try check(mktime(&ctm))
}

/// identical to C's `asctime(3)` (via `asctime_r`), including the trailing newline.
public func asctime(_ tm: Tm) -> String {
    var ctm = tm.ctm
    var buf = [CChar](repeating: 0, count: 32) // >= 26
    guard asctime_r(&ctm, &buf) != nil else { return "" }
    return stringFromCChars(buf)
}

/// identical to C's `ctime(3)`: `asctime(localtime(t))`.
public func ctime(_ t: time_t = time(nil)) -> String { asctime(localtime(t)) }

/// identical to C's `strftime(3)`.
public func strftime(_ format: String, _ tm: Tm) -> String {
    var ctm = tm.ctm
    return format.withCString { fmt in
        var capacity = 128
        while capacity <= 64 * 1024 {
            var buf = [CChar](repeating: 0, count: capacity)
            let n = strftime(&buf, capacity, fmt, &ctm)
            if n > 0 || format.isEmpty { return stringFromCChars(buf) }
            capacity *= 4
        }
        return ""
    }
}

/// identical to C's `clock(3)`: processor time used, in `CLOCKS_PER_SEC` ticks.
public func clock() -> clock_t { C.clock() }

// (CLOCKS_PER_SEC is re-exported in Platform.swift)

/// identical to C's `tzset(3)`.
public func tzset() { C.tzset() }

/// like C's `tzname`: the standard and daylight-saving timezone
/// abbreviations of the current timezone (derived from `tm_zone` in
/// January and July, to avoid the non-thread-safe C global).
public func tzname() -> (standard: String, daylight: String) {
    C.tzset()
    // 2021-01-01 and 2021-07-01, chosen for opposite DST states.
    let jan = localtime(1609459200)
    let jul = localtime(1625097600)
    let (std, dst) = jan.isdst > 0 ? (jul, jan) : (jan, jul)
    return (std.zone ?? "", dst.zone ?? "")
}

// MARK: <sys/times.h>

/// A swifty `struct tms`, plus the elapsed real time, like Perl's
/// five-element `POSIX::times()`.
public struct Times: Hashable, Sendable {
    /// elapsed real time since an arbitrary point, in clock ticks
    public let elapsed: clock_t
    /// user CPU time (`tms_utime`)
    public let user: clock_t
    /// system CPU time (`tms_stime`)
    public let system: clock_t
    /// user CPU time of terminated children (`tms_cutime`)
    public let childUser: clock_t
    /// system CPU time of terminated children (`tms_cstime`)
    public let childSystem: clock_t
}

/// identical to C's `times(3)`, but returns a swifty `Times`
/// (in `sysconf(.clockTick)` ticks, not `CLOCKS_PER_SEC`).
public func times() throws -> Times {
    var t = tms()
    let elapsed = times(&t)
    guard elapsed != ~clock_t(0) else { throw Errno.current } // (clock_t)-1
    return Times(
        elapsed: elapsed,
        user: t.tms_utime, system: t.tms_stime,
        childUser: t.tms_cutime, childSystem: t.tms_cstime
    )
}
