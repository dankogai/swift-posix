import Testing
import POSIX

@Suite struct TimeTests {
    @Test func epoch() {
        let tm = gmtime(0)
        #expect(tm.year == 70)
        #expect(tm.mon == 0)
        #expect(tm.mday == 1)
        #expect(tm.hour == 0)
        #expect(tm.wday == 4) // Thursday
        #expect(tm.yday == 0)
        #expect(tm.gmtoff == 0)
    }

    @Test func mktimeRoundTrip() throws {
        let now = time()
        #expect(now > 1_700_000_000)
        let tm = localtime(now)
        #expect(try mktime(tm) == now)
    }

    @Test func formatting() {
        #expect(strftime("%Y-%m-%d %H:%M:%S", gmtime(0)) == "1970-01-01 00:00:00")
        #expect(asctime(gmtime(0)) == "Thu Jan  1 00:00:00 1970\n")
        #expect(strftime("", gmtime(0)) == "")
        // a format whose output is empty must not loop forever
        #expect(strftime("%p", Tm(hour: 1)).count <= 2)
    }

    @Test func differences() {
        #expect(difftime(100, 40) == 60)
        #expect(difftime(40, 100) == -60)
    }

    @Test func processTimes() throws {
        let a = try times()
        let b = try times()
        #expect(b.elapsed >= a.elapsed)
        let c0 = clock()
        let c1 = clock()
        #expect(c1 >= c0)
    }

    @Test func timezone() {
        tzset()
        let (std, _) = tzname()
        #expect(!std.isEmpty)
    }
}
