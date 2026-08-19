/// Stdlib.swift — <stdlib.h>.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// identical to C's `exit(3)`.
public func exit(_ status: CInt = 0) -> Never { C.exit(status) }

/// identical to C's `abort(3)`.
public func abort() -> Never { C.abort() }

public let EXIT_SUCCESS: CInt = 0
public let EXIT_FAILURE: CInt = 1

/// identical to C's `getenv(3)`.
public func getenv(_ name: String) -> String? {
    name.withCString { p -> String? in
        guard let v = getenv(p) else { return nil }
        return String(cString: v)
    }
}

/// identical to C's `setenv(3)`.
public func setenv(_ name: String, _ value: String, _ overwrite: Bool = true) throws {
    _ = try name.withCString { n in
        try value.withCString { v in
            try check(setenv(n, v, overwrite ? 1 : 0))
        }
    }
}

/// identical to C's `unsetenv(3)`.
public func unsetenv(_ name: String) throws {
    _ = try name.withCString { try check(unsetenv($0)) }
}

/// identical to C's `strtod(3)`; returns the parsed value and the number
/// of unparsed (trailing) bytes, like Perl's `POSIX::strtod`.
public func strtod(_ s: String) -> (value: Double, unparsed: Int) {
    s.withCString { p in
        var end: UnsafeMutablePointer<CChar>? = nil
        let v = strtod(p, &end)
        let consumed = end.map { p.distance(to: $0) } ?? 0
        return (v, s.utf8.count - consumed)
    }
}

/// identical to C's `strtol(3)`; returns the parsed value and the number
/// of unparsed (trailing) bytes, like Perl's `POSIX::strtol`.
public func strtol(_ s: String, _ base: CInt = 10) -> (value: Int, unparsed: Int) {
    s.withCString { p in
        var end: UnsafeMutablePointer<CChar>? = nil
        let v = strtol(p, &end, base)
        let consumed = end.map { p.distance(to: $0) } ?? 0
        return (v, s.utf8.count - consumed)
    }
}

/// identical to C's `strtoul(3)`; returns the parsed value and the number
/// of unparsed (trailing) bytes, like Perl's `POSIX::strtoul`.
public func strtoul(_ s: String, _ base: CInt = 10) -> (value: UInt, unparsed: Int) {
    s.withCString { p in
        var end: UnsafeMutablePointer<CChar>? = nil
        let v = strtoul(p, &end, base)
        let consumed = end.map { p.distance(to: $0) } ?? 0
        return (v, s.utf8.count - consumed)
    }
}

/// identical to C's `mblen(3)`: the length in bytes of the first
/// multibyte character of the string.
public func mblen(_ s: String) -> Int {
    // + 1 so the terminating NUL is visible: mblen("") is then 0, not -1
    s.withCString { Int(mblen($0, s.utf8.count + 1)) }
}

/// identical to C's `mbtowc(3)`: converts the first multibyte character
/// to a wide character; returns the wide character and the number of
/// bytes consumed, or nil on an invalid sequence.
public func mbtowc(_ s: String) -> (wc: wchar_t, length: Int)? {
    s.withCString { p -> (wc: wchar_t, length: Int)? in
        var wc: wchar_t = 0
        let n = mbtowc(&wc, p, s.utf8.count)
        guard n >= 0 else { return nil }
        return (wc, Int(n))
    }
}

/// identical to C's `wctomb(3)`: converts a wide character to its
/// multibyte representation, or nil if it has none.
public func wctomb(_ wc: wchar_t) -> String? {
    var buf = [CChar](repeating: 0, count: 16) // >= MB_CUR_MAX
    let n = wctomb(&buf, wc)
    guard n >= 0 else { return nil }
    return String(decoding: buf.prefix(Int(n)).map { UInt8(bitPattern: $0) }, as: UTF8.self)
}

/// identical to C's `mbstowcs(3)`: converts a multibyte string to an
/// array of wide characters, or nil on an invalid sequence.
public func mbstowcs(_ s: String) -> [wchar_t]? {
    s.withCString { p -> [wchar_t]? in
        let n = mbstowcs(nil, p, 0)
        guard n != -1 else { return nil }
        var wcs = [wchar_t](repeating: 0, count: n + 1)
        guard mbstowcs(&wcs, p, n + 1) != -1 else { return nil }
        return Array(wcs.prefix(n))
    }
}

/// identical to C's `wcstombs(3)`: converts an array of wide characters
/// to a (multibyte) string, or nil if it cannot be represented.
public func wcstombs(_ wcs: [wchar_t]) -> String? {
    var w = wcs + [0]
    let n = wcstombs(nil, &w, 0)
    guard n != -1 else { return nil }
    var buf = [CChar](repeating: 0, count: n + 1)
    guard wcstombs(&buf, &w, n + 1) != -1 else { return nil }
    return String(decoding: buf.prefix(n).map { UInt8(bitPattern: $0) }, as: UTF8.self)
}

// MARK: <string.h> (locale-aware pieces; the rest is C-specific)

/// identical to C's `strcoll(3)`: locale-aware comparison.
/// Returns a negative, zero, or positive value.
public func strcoll(_ a: String, _ b: String) -> Int {
    a.withCString { pa in b.withCString { pb in Int(strcoll(pa, pb)) } }
}

/// identical to C's `strxfrm(3)`: the locale-collation transform of the string.
public func strxfrm(_ s: String) -> String {
    s.withCString { p -> String in
        let n = strxfrm(nil, p, 0)
        var buf = [CChar](repeating: 0, count: n + 1)
        _ = strxfrm(&buf, p, n + 1)
        return stringFromCChars(buf)
    }
}
