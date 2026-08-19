/// Locale.swift — <locale.h>, with `struct lconv` made swifty.

#if canImport(Darwin)
import Darwin
import locale_h // Darwin's module map keeps <locale.h> separate
#elseif canImport(Glibc)
import Glibc
#endif

/// A locale category, as `LocaleCategory.LC_ALL` etc.
public struct LocaleCategory: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
}
private let _LC_ALL = LC_ALL
private let _LC_COLLATE = LC_COLLATE
private let _LC_CTYPE = LC_CTYPE
private let _LC_MONETARY = LC_MONETARY
private let _LC_NUMERIC = LC_NUMERIC
private let _LC_TIME = LC_TIME
private let _LC_MESSAGES = LC_MESSAGES
extension LocaleCategory {
    public static let LC_ALL = LocaleCategory(rawValue: _LC_ALL)
    public static let LC_COLLATE = LocaleCategory(rawValue: _LC_COLLATE)
    public static let LC_CTYPE = LocaleCategory(rawValue: _LC_CTYPE)
    public static let LC_MONETARY = LocaleCategory(rawValue: _LC_MONETARY)
    public static let LC_NUMERIC = LocaleCategory(rawValue: _LC_NUMERIC)
    public static let LC_TIME = LocaleCategory(rawValue: _LC_TIME)
    public static let LC_MESSAGES = LocaleCategory(rawValue: _LC_MESSAGES)
}

/// identical to C's `setlocale(3)`; pass nil to query, and a locale name
/// (e.g. "C", "", "en_US.UTF-8") to set.  Returns the locale name, or
/// nil if the request cannot be honored.
@discardableResult
public func setlocale(_ category: LocaleCategory, _ locale: String? = nil) -> String? {
    let result: UnsafeMutablePointer<CChar>?
    if let locale {
        result = locale.withCString { setlocale(category.rawValue, $0) }
    } else {
        result = setlocale(category.rawValue, nil)
    }
    return result.map { String(cString: $0) }
}

/// A swifty `struct lconv`.  Numeric fields that C marks "unavailable"
/// with CHAR_MAX come through as nil.
public struct Lconv: Sendable {
    public let decimalPoint: String
    public let thousandsSep: String
    public let grouping: [Int]
    public let intCurrSymbol: String
    public let currencySymbol: String
    public let monDecimalPoint: String
    public let monThousandsSep: String
    public let monGrouping: [Int]
    public let positiveSign: String
    public let negativeSign: String
    public let intFracDigits: Int?
    public let fracDigits: Int?
    public let pCsPrecedes: Int?
    public let pSepBySpace: Int?
    public let nCsPrecedes: Int?
    public let nSepBySpace: Int?
    public let pSignPosn: Int?
    public let nSignPosn: Int?
}

private func lcString(_ p: UnsafeMutablePointer<CChar>?) -> String {
    p.map { String(cString: $0) } ?? ""
}
private func lcChar(_ c: CChar) -> Int? {
    c == CChar.max ? nil : Int(c)
}
private func lcGrouping(_ p: UnsafeMutablePointer<CChar>?) -> [Int] {
    guard let p else { return [] }
    var result: [Int] = []
    var q = p
    while q.pointee != 0 && q.pointee != CChar.max {
        result.append(Int(q.pointee))
        q += 1
    }
    return result
}

/// identical to C's `localeconv(3)`, but returns a swifty `Lconv`.
public func localeconv() -> Lconv {
    guard let p = C.localeconv() else {
        return Lconv(
            decimalPoint: ".", thousandsSep: "", grouping: [],
            intCurrSymbol: "", currencySymbol: "",
            monDecimalPoint: "", monThousandsSep: "", monGrouping: [],
            positiveSign: "", negativeSign: "",
            intFracDigits: nil, fracDigits: nil,
            pCsPrecedes: nil, pSepBySpace: nil,
            nCsPrecedes: nil, nSepBySpace: nil,
            pSignPosn: nil, nSignPosn: nil
        )
    }
    let lc = p.pointee
    return Lconv(
        decimalPoint: lcString(lc.decimal_point),
        thousandsSep: lcString(lc.thousands_sep),
        grouping: lcGrouping(lc.grouping),
        intCurrSymbol: lcString(lc.int_curr_symbol),
        currencySymbol: lcString(lc.currency_symbol),
        monDecimalPoint: lcString(lc.mon_decimal_point),
        monThousandsSep: lcString(lc.mon_thousands_sep),
        monGrouping: lcGrouping(lc.mon_grouping),
        positiveSign: lcString(lc.positive_sign),
        negativeSign: lcString(lc.negative_sign),
        intFracDigits: lcChar(lc.int_frac_digits),
        fracDigits: lcChar(lc.frac_digits),
        pCsPrecedes: lcChar(lc.p_cs_precedes),
        pSepBySpace: lcChar(lc.p_sep_by_space),
        nCsPrecedes: lcChar(lc.n_cs_precedes),
        nSepBySpace: lcChar(lc.n_sep_by_space),
        pSignPosn: lcChar(lc.p_sign_posn),
        nSignPosn: lcChar(lc.n_sign_posn)
    )
}
