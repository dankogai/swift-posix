# `<stdlib.h>`, `<string.h>` — process exit, environment, parsing

## Termination

```swift
exit(_ status: CInt = 0) -> Never    // exit(3), with cleanup
abort() -> Never                     // abort(3)
// constants: EXIT_SUCCESS, EXIT_FAILURE
```

(`_exit` — exit *without* cleanup — is in [Unistd.md](Unistd.md).)

## Environment

```swift
getenv(_ name: String) -> String?
setenv(_ name: String, _ value: String, _ overwrite: Bool = true) throws
unsetenv(_ name: String) throws
```

## Number parsing

Each returns the parsed value **and the number of unparsed (trailing)
bytes**, like Perl's `POSIX::strtod`:

```swift
strtod(_ s: String) -> (value: Double, unparsed: Int)
strtol(_ s: String, _ base: CInt = 10) -> (value: Int, unparsed: Int)
strtoul(_ s: String, _ base: CInt = 10) -> (value: UInt, unparsed: Int)
```

## Multibyte conversion

Locale-dependent (see [Locale.md](Locale.md)):

```swift
mblen(_ s: String) -> Int
mbtowc(_ s: String) -> (wc: wchar_t, length: Int)?
wctomb(_ wc: wchar_t) -> String?
mbstowcs(_ s: String) -> [wchar_t]?
wcstombs(_ wcs: [wchar_t]) -> String?
```

## Collation (the non-C-specific corner of `<string.h>`)

```swift
strcoll(_ a: String, _ b: String) -> Int   // negative / zero / positive
strxfrm(_ s: String) -> String
```

## Example

```swift
import POSIX

POSIX.strtod("3.14 is pi")     // (value: 3.14, unparsed: 6)
POSIX.strtol("0x1A", 16)       // (value: 26, unparsed: 0)

try POSIX.setenv("ANSWER", "42")
POSIX.getenv("ANSWER")         // Optional("42")
try POSIX.unsetenv("ANSWER")
```

## Notes

* `atoi`/`atof`/`atol`, `malloc`/`free`, `qsort`, `bsearch`, `rand`/
  `srand`, and the `str*` byte-shuffling functions are C-specific and
  unimplemented — see [Unimplemented.md](Unimplemented.md).
