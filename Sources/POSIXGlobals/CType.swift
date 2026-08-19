/// CType.swift — <ctype.h>, with Perl POSIX semantics:
/// each classifier takes a `String` and returns true iff the string is
/// non-empty and *every* character is a member of the class.
/// Classification follows the POSIX ("C") locale, i.e. ASCII.

private func all(_ s: String, _ p: (UInt32) -> Bool) -> Bool {
    !s.isEmpty && s.unicodeScalars.allSatisfy { p($0.value) }
}

private func isUpperV(_ v: UInt32) -> Bool { 0x41...0x5a ~= v }
private func isLowerV(_ v: UInt32) -> Bool { 0x61...0x7a ~= v }
private func isAlphaV(_ v: UInt32) -> Bool { isUpperV(v) || isLowerV(v) }
private func isDigitV(_ v: UInt32) -> Bool { 0x30...0x39 ~= v }
private func isPrintV(_ v: UInt32) -> Bool { 0x20...0x7e ~= v }
private func isGraphV(_ v: UInt32) -> Bool { 0x21...0x7e ~= v }
private func isSpaceV(_ v: UInt32) -> Bool {
    v == 0x20 || 0x09...0x0d ~= v // ' ', \t \n \v \f \r
}

/// true iff every character is alphanumeric.
public func isalnum(_ s: String) -> Bool { all(s) { isAlphaV($0) || isDigitV($0) } }
/// true iff every character is a letter.
public func isalpha(_ s: String) -> Bool { all(s, isAlphaV) }
/// true iff every character is a control character.
public func iscntrl(_ s: String) -> Bool { all(s) { $0 < 0x20 || $0 == 0x7f } }
/// true iff every character is a decimal digit.
public func isdigit(_ s: String) -> Bool { all(s, isDigitV) }
/// true iff every character is printable and non-space.
public func isgraph(_ s: String) -> Bool { all(s, isGraphV) }
/// true iff every character is a lowercase letter.
public func islower(_ s: String) -> Bool { all(s, isLowerV) }
/// true iff every character is printable (including space).
public func isprint(_ s: String) -> Bool { all(s, isPrintV) }
/// true iff every character is punctuation.
public func ispunct(_ s: String) -> Bool { all(s) { isGraphV($0) && !isAlphaV($0) && !isDigitV($0) } }
/// true iff every character is whitespace.
public func isspace(_ s: String) -> Bool { all(s, isSpaceV) }
/// true iff every character is an uppercase letter.
public func isupper(_ s: String) -> Bool { all(s, isUpperV) }
/// true iff every character is a hexadecimal digit.
public func isxdigit(_ s: String) -> Bool {
    all(s) { isDigitV($0) || 0x41...0x46 ~= $0 || 0x61...0x66 ~= $0 }
}

/// Lowercases the ASCII letters in the string (C-locale `tolower(3)`).
public func tolower(_ s: String) -> String {
    String(String.UnicodeScalarView(s.unicodeScalars.map {
        isUpperV($0.value) ? Unicode.Scalar($0.value + 0x20)! : $0
    }))
}

/// Uppercases the ASCII letters in the string (C-locale `toupper(3)`).
public func toupper(_ s: String) -> String {
    String(String.UnicodeScalarView(s.unicodeScalars.map {
        isLowerV($0.value) ? Unicode.Scalar($0.value - 0x20)! : $0
    }))
}
