import Testing
import POSIXGlobals

@Suite struct CTypeTests {
    @Test func classifiers() {
        #expect(isalpha("abcXYZ"))
        #expect(!isalpha("abc1"))
        #expect(!isalpha(""))
        #expect(isdigit("0123456789"))
        #expect(!isdigit("12a"))
        #expect(isalnum("abc123"))
        #expect(!isalnum("abc 123"))
        #expect(isspace(" \t\n\r"))
        #expect(!isspace("a b"))
        #expect(isupper("ABC"))
        #expect(!isupper("AbC"))
        #expect(islower("abc"))
        #expect(isxdigit("deadBEEF42"))
        #expect(!isxdigit("g"))
        #expect(ispunct("!,;:"))
        #expect(!ispunct("a!"))
        #expect(isprint("hello, world"))
        #expect(isgraph("hello,world"))
        #expect(!isgraph("hello world"))
        #expect(iscntrl("\u{01}\u{1f}\u{7f}"))
        #expect(!isalpha("日本語"))
    }

    @Test func caseMapping() {
        #expect(toupper("hello, world!") == "HELLO, WORLD!")
        #expect(tolower("Hello, World!") == "hello, world!")
        // C-locale semantics: non-ASCII passes through untouched
        #expect(tolower("ÅÉ") == "ÅÉ")
    }
}
