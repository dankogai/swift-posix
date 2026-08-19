# `<locale.h>` — setlocale, localeconv

```swift
setlocale(_ category: LocaleCategory, _ locale: String? = nil) -> String?
localeconv() -> Lconv
```

`LocaleCategory` carries the C names: `.LC_ALL .LC_COLLATE .LC_CTYPE
.LC_MONETARY .LC_NUMERIC .LC_TIME .LC_MESSAGES`.

`setlocale` with `nil` queries; with a name (`"C"`, `""` for the
environment's choice, `"en_US.UTF-8"`, …) it sets.  It returns the
resulting locale name, or `nil` if the request cannot be honored.

## Lconv

`struct lconv` made swifty — strings are `String`, groupings are
`[Int]`, and the numeric fields that C marks "unavailable" with
`CHAR_MAX` come through as `nil`:

```swift
public struct Lconv: Sendable {
    let decimalPoint: String        // decimal_point
    let thousandsSep: String        // thousands_sep
    let grouping: [Int]
    let intCurrSymbol: String       // int_curr_symbol
    let currencySymbol: String      // currency_symbol
    let monDecimalPoint: String     // mon_decimal_point
    let monThousandsSep: String     // mon_thousands_sep
    let monGrouping: [Int]
    let positiveSign: String
    let negativeSign: String
    let intFracDigits: Int?         // int_frac_digits
    let fracDigits: Int?            // frac_digits
    let pCsPrecedes: Int?           // p_cs_precedes
    let pSepBySpace: Int?           // p_sep_by_space
    let nCsPrecedes: Int?
    let nSepBySpace: Int?
    let pSignPosn: Int?
    let nSignPosn: Int?
}
```

## Example

```swift
import POSIX

POSIX.setlocale(.LC_ALL, "C")            // "C"
POSIX.localeconv().decimalPoint          // "."
POSIX.localeconv().fracDigits            // nil in the C locale

POSIX.setlocale(.LC_MONETARY, "ja_JP.UTF-8")
POSIX.localeconv().currencySymbol        // "￥"
```

## Notes

* The locale also affects [`strcoll`/`strxfrm`](Stdlib.md), the
  multibyte functions, and `strftime`'s `%a %A %b %B` names.
* The C locale state is process-global — set it early, not
  concurrently.
