# `<ctype.h>` — character classification

The classifiers take a `String` and follow Perl POSIX semantics:
**true iff the string is non-empty and every character belongs to the
class.**  Classification follows the POSIX ("C") locale — ASCII rules —
so non-ASCII characters never classify and pass through case mapping
untouched.

```swift
public func isalnum(_ s: String) -> Bool   // letters and digits
public func isalpha(_ s: String) -> Bool   // letters
public func iscntrl(_ s: String) -> Bool   // control characters
public func isdigit(_ s: String) -> Bool   // decimal digits
public func isgraph(_ s: String) -> Bool   // printable, non-space
public func islower(_ s: String) -> Bool   // lowercase letters
public func isprint(_ s: String) -> Bool   // printable, including space
public func ispunct(_ s: String) -> Bool   // punctuation
public func isspace(_ s: String) -> Bool   // " \t\n\v\f\r"
public func isupper(_ s: String) -> Bool   // uppercase letters
public func isxdigit(_ s: String) -> Bool  // hexadecimal digits

public func tolower(_ s: String) -> String // ASCII-lowercased
public func toupper(_ s: String) -> String // ASCII-uppercased
```

## Example

```swift
import POSIX

POSIX.isdigit("12345")        // true
POSIX.isdigit("12a45")        // false
POSIX.isdigit("")             // false — empty never classifies
POSIX.isxdigit("deadBEEF")    // true
POSIX.toupper("posix")        // "POSIX"
POSIX.tolower("Åland")        // "Åland" — non-ASCII passes through
```

## Notes

* Perl removed the `isXXX` functions in 5.24; they are kept here
  because Swift has no locale-free ASCII classifiers of its own.
* For Unicode-aware classification use Swift's `Character` properties
  (`isLetter`, `isNumber`, …) instead.
