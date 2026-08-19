/// Termios.swift — <termios.h>, with `struct termios` made swifty
/// (the counterpart of Perl's `POSIX::Termios`).

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

// input flags
private let _IGNBRK = tcflag_t(IGNBRK)
private let _BRKINT = tcflag_t(BRKINT)
private let _IGNPAR = tcflag_t(IGNPAR)
private let _PARMRK = tcflag_t(PARMRK)
private let _INPCK = tcflag_t(INPCK)
private let _ISTRIP = tcflag_t(ISTRIP)
private let _INLCR = tcflag_t(INLCR)
private let _IGNCR = tcflag_t(IGNCR)
private let _ICRNL = tcflag_t(ICRNL)
private let _IXON = tcflag_t(IXON)
private let _IXOFF = tcflag_t(IXOFF)
private let _IXANY = tcflag_t(IXANY)
// output flags
private let _OPOST = tcflag_t(OPOST)
private let _ONLCR = tcflag_t(ONLCR)
private let _OCRNL = tcflag_t(OCRNL)
private let _ONOCR = tcflag_t(ONOCR)
private let _ONLRET = tcflag_t(ONLRET)
// control flags
private let _CSIZE = tcflag_t(CSIZE)
private let _CS5 = tcflag_t(CS5)
private let _CS6 = tcflag_t(CS6)
private let _CS7 = tcflag_t(CS7)
private let _CS8 = tcflag_t(CS8)
private let _CSTOPB = tcflag_t(CSTOPB)
private let _CREAD = tcflag_t(CREAD)
private let _PARENB = tcflag_t(PARENB)
private let _PARODD = tcflag_t(PARODD)
private let _HUPCL = tcflag_t(HUPCL)
private let _CLOCAL = tcflag_t(CLOCAL)
// local flags
private let _ECHO = tcflag_t(ECHO)
private let _ECHOE = tcflag_t(ECHOE)
private let _ECHOK = tcflag_t(ECHOK)
private let _ECHONL = tcflag_t(ECHONL)
private let _ICANON = tcflag_t(ICANON)
private let _ISIG = tcflag_t(ISIG)
private let _IEXTEN = tcflag_t(IEXTEN)
private let _NOFLSH = tcflag_t(NOFLSH)
private let _TOSTOP = tcflag_t(TOSTOP)
// control characters
private let _VEOF = Int(VEOF)
private let _VEOL = Int(VEOL)
private let _VERASE = Int(VERASE)
private let _VINTR = Int(VINTR)
private let _VKILL = Int(VKILL)
private let _VMIN = Int(VMIN)
private let _VQUIT = Int(VQUIT)
private let _VSTART = Int(VSTART)
private let _VSTOP = Int(VSTOP)
private let _VSUSP = Int(VSUSP)
private let _VTIME = Int(VTIME)
// baud rates
private let _B0 = speed_t(B0)
private let _B50 = speed_t(B50)
private let _B75 = speed_t(B75)
private let _B110 = speed_t(B110)
private let _B134 = speed_t(B134)
private let _B150 = speed_t(B150)
private let _B200 = speed_t(B200)
private let _B300 = speed_t(B300)
private let _B600 = speed_t(B600)
private let _B1200 = speed_t(B1200)
private let _B1800 = speed_t(B1800)
private let _B2400 = speed_t(B2400)
private let _B4800 = speed_t(B4800)
private let _B9600 = speed_t(B9600)
private let _B19200 = speed_t(B19200)
private let _B38400 = speed_t(B38400)
private let _B57600 = speed_t(B57600)
private let _B115200 = speed_t(B115200)
private let _B230400 = speed_t(B230400)
// tcsetattr actions
private let _TCSANOW = TCSANOW
private let _TCSADRAIN = TCSADRAIN
private let _TCSAFLUSH = TCSAFLUSH
// tcflush queues
private let _TCIFLUSH = TCIFLUSH
private let _TCOFLUSH = TCOFLUSH
private let _TCIOFLUSH = TCIOFLUSH
// tcflow actions
private let _TCOOFF = TCOOFF
private let _TCOON = TCOON
private let _TCIOFF = TCIOFF
private let _TCION = TCION

/// A swifty `struct termios`.
public struct Termios: Sendable {
    /// The underlying C `struct termios`.
    public var raw: termios
    public init() { raw = termios() }
    public init(raw: termios) { self.raw = raw }

    /// `c_iflag`, as an OptionSet.
    public struct InputFlags: OptionSet, Sendable {
        public var rawValue: tcflag_t
        public init(rawValue: tcflag_t) { self.rawValue = rawValue }
        public static let IGNBRK = InputFlags(rawValue: _IGNBRK)
        public static let BRKINT = InputFlags(rawValue: _BRKINT)
        public static let IGNPAR = InputFlags(rawValue: _IGNPAR)
        public static let PARMRK = InputFlags(rawValue: _PARMRK)
        public static let INPCK = InputFlags(rawValue: _INPCK)
        public static let ISTRIP = InputFlags(rawValue: _ISTRIP)
        public static let INLCR = InputFlags(rawValue: _INLCR)
        public static let IGNCR = InputFlags(rawValue: _IGNCR)
        public static let ICRNL = InputFlags(rawValue: _ICRNL)
        public static let IXON = InputFlags(rawValue: _IXON)
        public static let IXOFF = InputFlags(rawValue: _IXOFF)
        public static let IXANY = InputFlags(rawValue: _IXANY)
    }
    /// `c_oflag`, as an OptionSet.
    public struct OutputFlags: OptionSet, Sendable {
        public var rawValue: tcflag_t
        public init(rawValue: tcflag_t) { self.rawValue = rawValue }
        public static let OPOST = OutputFlags(rawValue: _OPOST)
        public static let ONLCR = OutputFlags(rawValue: _ONLCR)
        public static let OCRNL = OutputFlags(rawValue: _OCRNL)
        public static let ONOCR = OutputFlags(rawValue: _ONOCR)
        public static let ONLRET = OutputFlags(rawValue: _ONLRET)
    }
    /// `c_cflag`, as an OptionSet.
    public struct ControlFlags: OptionSet, Sendable {
        public var rawValue: tcflag_t
        public init(rawValue: tcflag_t) { self.rawValue = rawValue }
        public static let CSIZE = ControlFlags(rawValue: _CSIZE)
        public static let CS5 = ControlFlags(rawValue: _CS5)
        public static let CS6 = ControlFlags(rawValue: _CS6)
        public static let CS7 = ControlFlags(rawValue: _CS7)
        public static let CS8 = ControlFlags(rawValue: _CS8)
        public static let CSTOPB = ControlFlags(rawValue: _CSTOPB)
        public static let CREAD = ControlFlags(rawValue: _CREAD)
        public static let PARENB = ControlFlags(rawValue: _PARENB)
        public static let PARODD = ControlFlags(rawValue: _PARODD)
        public static let HUPCL = ControlFlags(rawValue: _HUPCL)
        public static let CLOCAL = ControlFlags(rawValue: _CLOCAL)
    }
    /// `c_lflag`, as an OptionSet.
    public struct LocalFlags: OptionSet, Sendable {
        public var rawValue: tcflag_t
        public init(rawValue: tcflag_t) { self.rawValue = rawValue }
        public static let ECHO = LocalFlags(rawValue: _ECHO)
        public static let ECHOE = LocalFlags(rawValue: _ECHOE)
        public static let ECHOK = LocalFlags(rawValue: _ECHOK)
        public static let ECHONL = LocalFlags(rawValue: _ECHONL)
        public static let ICANON = LocalFlags(rawValue: _ICANON)
        public static let ISIG = LocalFlags(rawValue: _ISIG)
        public static let IEXTEN = LocalFlags(rawValue: _IEXTEN)
        public static let NOFLSH = LocalFlags(rawValue: _NOFLSH)
        public static let TOSTOP = LocalFlags(rawValue: _TOSTOP)
    }
    /// An index into `c_cc`, as `ControlCharacter.VMIN` etc.
    public struct ControlCharacter: RawRepresentable, Hashable, Sendable {
        public var rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
        public static let VEOF = ControlCharacter(rawValue: _VEOF)
        public static let VEOL = ControlCharacter(rawValue: _VEOL)
        public static let VERASE = ControlCharacter(rawValue: _VERASE)
        public static let VINTR = ControlCharacter(rawValue: _VINTR)
        public static let VKILL = ControlCharacter(rawValue: _VKILL)
        public static let VMIN = ControlCharacter(rawValue: _VMIN)
        public static let VQUIT = ControlCharacter(rawValue: _VQUIT)
        public static let VSTART = ControlCharacter(rawValue: _VSTART)
        public static let VSTOP = ControlCharacter(rawValue: _VSTOP)
        public static let VSUSP = ControlCharacter(rawValue: _VSUSP)
        public static let VTIME = ControlCharacter(rawValue: _VTIME)
    }

    public var inputFlags: InputFlags {
        get { InputFlags(rawValue: raw.c_iflag) }
        set { raw.c_iflag = newValue.rawValue }
    }
    public var outputFlags: OutputFlags {
        get { OutputFlags(rawValue: raw.c_oflag) }
        set { raw.c_oflag = newValue.rawValue }
    }
    public var controlFlags: ControlFlags {
        get { ControlFlags(rawValue: raw.c_cflag) }
        set { raw.c_cflag = newValue.rawValue }
    }
    public var localFlags: LocalFlags {
        get { LocalFlags(rawValue: raw.c_lflag) }
        set { raw.c_lflag = newValue.rawValue }
    }

    /// The `c_cc` control characters, e.g. `termios[.VMIN]`.
    public subscript(_ index: ControlCharacter) -> cc_t {
        get {
            withUnsafeBytes(of: raw.c_cc) { $0[index.rawValue] }
        }
        set {
            withUnsafeMutableBytes(of: &raw.c_cc) { $0[index.rawValue] = newValue }
        }
    }

    /// `cfgetispeed(3)` / `cfsetispeed(3)`.
    public var inputSpeed: BaudRate {
        get { var r = raw; return BaudRate(rawValue: cfgetispeed(&r)) }
        set { _ = cfsetispeed(&raw, newValue.rawValue) }
    }
    /// `cfgetospeed(3)` / `cfsetospeed(3)`.
    public var outputSpeed: BaudRate {
        get { var r = raw; return BaudRate(rawValue: cfgetospeed(&r)) }
        set { _ = cfsetospeed(&raw, newValue.rawValue) }
    }
}

/// A terminal baud rate, as `BaudRate.B9600` etc.
public struct BaudRate: RawRepresentable, Hashable, Sendable {
    public var rawValue: speed_t
    public init(rawValue: speed_t) { self.rawValue = rawValue }
    public static let B0 = BaudRate(rawValue: _B0)
    public static let B50 = BaudRate(rawValue: _B50)
    public static let B75 = BaudRate(rawValue: _B75)
    public static let B110 = BaudRate(rawValue: _B110)
    public static let B134 = BaudRate(rawValue: _B134)
    public static let B150 = BaudRate(rawValue: _B150)
    public static let B200 = BaudRate(rawValue: _B200)
    public static let B300 = BaudRate(rawValue: _B300)
    public static let B600 = BaudRate(rawValue: _B600)
    public static let B1200 = BaudRate(rawValue: _B1200)
    public static let B1800 = BaudRate(rawValue: _B1800)
    public static let B2400 = BaudRate(rawValue: _B2400)
    public static let B4800 = BaudRate(rawValue: _B4800)
    public static let B9600 = BaudRate(rawValue: _B9600)
    public static let B19200 = BaudRate(rawValue: _B19200)
    public static let B38400 = BaudRate(rawValue: _B38400)
    public static let B57600 = BaudRate(rawValue: _B57600)
    public static let B115200 = BaudRate(rawValue: _B115200)
    public static let B230400 = BaudRate(rawValue: _B230400)
}

/// `tcsetattr(3)` optional actions.
public struct TcsetattrAction: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
    public static let TCSANOW = TcsetattrAction(rawValue: _TCSANOW)
    public static let TCSADRAIN = TcsetattrAction(rawValue: _TCSADRAIN)
    public static let TCSAFLUSH = TcsetattrAction(rawValue: _TCSAFLUSH)
}

/// `tcflush(3)` queue selectors.
public struct TcflushQueue: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
    public static let TCIFLUSH = TcflushQueue(rawValue: _TCIFLUSH)
    public static let TCOFLUSH = TcflushQueue(rawValue: _TCOFLUSH)
    public static let TCIOFLUSH = TcflushQueue(rawValue: _TCIOFLUSH)
}

/// `tcflow(3)` actions.
public struct TcflowAction: RawRepresentable, Hashable, Sendable {
    public var rawValue: CInt
    public init(rawValue: CInt) { self.rawValue = rawValue }
    public static let TCOOFF = TcflowAction(rawValue: _TCOOFF)
    public static let TCOON = TcflowAction(rawValue: _TCOON)
    public static let TCIOFF = TcflowAction(rawValue: _TCIOFF)
    public static let TCION = TcflowAction(rawValue: _TCION)
}

/// identical to C's `tcgetattr(3)`, but returns a swifty `Termios`.
public func tcgetattr(_ fd: CInt) throws -> Termios {
    var t = termios()
    try check(tcgetattr(fd, &t))
    return Termios(raw: t)
}

/// identical to C's `tcsetattr(3)`.
public func tcsetattr(_ fd: CInt, _ action: TcsetattrAction = .TCSANOW, _ termios: Termios) throws {
    var t = termios.raw
    try check(tcsetattr(fd, action.rawValue, &t))
}

/// identical to C's `tcdrain(3)`.
public func tcdrain(_ fd: CInt) throws { try check(C.tcdrain(fd)) }

/// identical to C's `tcflow(3)`.
public func tcflow(_ fd: CInt, _ action: TcflowAction) throws {
    try check(C.tcflow(fd, action.rawValue))
}

/// identical to C's `tcflush(3)`.
public func tcflush(_ fd: CInt, _ queue: TcflushQueue) throws {
    try check(C.tcflush(fd, queue.rawValue))
}

/// identical to C's `tcsendbreak(3)`.
public func tcsendbreak(_ fd: CInt, _ duration: CInt = 0) throws {
    try check(C.tcsendbreak(fd, duration))
}
