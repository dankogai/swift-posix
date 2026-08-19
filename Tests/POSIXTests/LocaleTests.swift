import Testing
import POSIXGlobals

@Suite struct LocaleTests {
    @Test func cLocale() {
        #expect(setlocale(.LC_ALL, "C") == "C")
        let lc = localeconv()
        #expect(lc.decimalPoint == ".")
        #expect(lc.thousandsSep == "")
        #expect(lc.grouping.isEmpty)
        #expect(lc.fracDigits == nil) // CHAR_MAX in the C locale
        #expect(setlocale(.LC_ALL) == "C")
    }

    @Test func badLocale() {
        setlocale(.LC_ALL, "C")
        #expect(setlocale(.LC_ALL, "no_SUCH.locale-42") == nil)
    }
}
