/*:
 [Previous](@previous)

 # `<ctype.h>`, `<stdlib.h>`, `<string.h>` — strings, not pointers

 The character classifiers take a `String` and follow Perl's POSIX
 semantics: true iff the string is non-empty and *every* character
 belongs to the class (C-locale / ASCII rules).
 */
import POSIX

POSIX.isdigit("12345")               // true
POSIX.isdigit("12a45")               // false
POSIX.isalpha("swifty")
POSIX.isxdigit("deadBEEF")
POSIX.isspace(" \t\n")
POSIX.ispunct("!?")
//: Case mapping is C-locale too — ASCII only, the rest passes through:
POSIX.toupper("posix and perl")      // "POSIX AND PERL"
POSIX.tolower("Åland Islands")       // "Åland islands" — Å survives
//: `strtod`/`strtol` return the value *and* the unparsed byte count:
POSIX.strtod("3.14 is pi")           // (value: 3.14, unparsed: 6)
POSIX.strtol("0x1A", 16)             // (value: 26, unparsed: 0)
POSIX.strtol("777", 8)               // (value: 511, unparsed: 0)
POSIX.strtoul("18446744073709551615") // UInt.max
//: Locale-aware collation:
POSIX.setlocale(.LC_ALL, "C")
POSIX.strcoll("abc", "abd")          // negative: "abc" sorts first
POSIX.localeconv().decimalPoint      // "." in the C locale
//: Multibyte conversions:
POSIX.setlocale(.LC_ALL, "en_US.UTF-8")
POSIX.mblen("日")                    // 3 bytes in UTF-8
POSIX.mbstowcs("日本語")?.count      // 3 wide characters
POSIX.setlocale(.LC_ALL, "C")
/*:
 [Next: Files and Directories](@next)
 */
