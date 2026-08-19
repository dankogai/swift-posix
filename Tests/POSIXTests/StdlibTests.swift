import Testing
import POSIX

@Suite struct StdlibTests {
    @Test func strtodParses() {
        let (v, unparsed) = strtod("3.14foo")
        #expect(v == 3.14)
        #expect(unparsed == 3)
        #expect(strtod("1e3").value == 1000)
        #expect(strtod("junk").unparsed == 4)
    }

    @Test func strtolParses() {
        let (v, unparsed) = strtol(" 42abc")
        #expect(v == 42)
        #expect(unparsed == 3)
        #expect(strtol("ff", 16).value == 255)
        #expect(strtol("0x1A", 16).value == 26)
        #expect(strtol("777", 8).value == 511)
        #expect(strtoul("18446744073709551615").value == UInt.max)
    }

    @Test func environment() throws {
        try setenv("SWIFT_POSIX_TEST", "hello")
        #expect(getenv("SWIFT_POSIX_TEST") == "hello")
        try setenv("SWIFT_POSIX_TEST", "ignored", false)
        #expect(getenv("SWIFT_POSIX_TEST") == "hello")
        try unsetenv("SWIFT_POSIX_TEST")
        #expect(getenv("SWIFT_POSIX_TEST") == nil)
    }

    @Test func collation() {
        setlocale(.LC_ALL, "C")
        #expect(strcoll("abc", "abd") < 0)
        #expect(strcoll("abc", "abc") == 0)
        #expect(strxfrm("abc") == strxfrm("abc"))
    }

    @Test func multibyte() {
        #expect(mblen("abc") == 1)
        #expect(mblen("") == 0)
    }
}
