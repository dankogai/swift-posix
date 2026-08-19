/// Functions.swift — the functions of POSIXGlobals, forwarded as static
/// members of the `POSIX` namespace.

import POSIXGlobals

// MARK: - <ctype.h>

extension POSIX {
    /// true iff every character is alphanumeric.
    public static func isalnum(_ s: String) -> Bool { POSIXGlobals.isalnum(s) }
    /// true iff every character is a letter.
    public static func isalpha(_ s: String) -> Bool { POSIXGlobals.isalpha(s) }
    /// true iff every character is a control character.
    public static func iscntrl(_ s: String) -> Bool { POSIXGlobals.iscntrl(s) }
    /// true iff every character is a decimal digit.
    public static func isdigit(_ s: String) -> Bool { POSIXGlobals.isdigit(s) }
    /// true iff every character is printable and non-space.
    public static func isgraph(_ s: String) -> Bool { POSIXGlobals.isgraph(s) }
    /// true iff every character is a lowercase letter.
    public static func islower(_ s: String) -> Bool { POSIXGlobals.islower(s) }
    /// true iff every character is printable (including space).
    public static func isprint(_ s: String) -> Bool { POSIXGlobals.isprint(s) }
    /// true iff every character is punctuation.
    public static func ispunct(_ s: String) -> Bool { POSIXGlobals.ispunct(s) }
    /// true iff every character is whitespace.
    public static func isspace(_ s: String) -> Bool { POSIXGlobals.isspace(s) }
    /// true iff every character is an uppercase letter.
    public static func isupper(_ s: String) -> Bool { POSIXGlobals.isupper(s) }
    /// true iff every character is a hexadecimal digit.
    public static func isxdigit(_ s: String) -> Bool { POSIXGlobals.isxdigit(s) }
    /// Lowercases the ASCII letters in the string (C-locale `tolower(3)`).
    public static func tolower(_ s: String) -> String { POSIXGlobals.tolower(s) }
    /// Uppercases the ASCII letters in the string (C-locale `toupper(3)`).
    public static func toupper(_ s: String) -> String { POSIXGlobals.toupper(s) }
}

// MARK: - <math.h> / <fenv.h>

extension POSIX {
    public static func acos(_ x: Double) -> Double { POSIXGlobals.acos(x) }
    public static func acosh(_ x: Double) -> Double { POSIXGlobals.acosh(x) }
    public static func asin(_ x: Double) -> Double { POSIXGlobals.asin(x) }
    public static func asinh(_ x: Double) -> Double { POSIXGlobals.asinh(x) }
    public static func atan(_ x: Double) -> Double { POSIXGlobals.atan(x) }
    public static func atan2(_ y: Double, _ x: Double) -> Double { POSIXGlobals.atan2(y, x) }
    public static func atanh(_ x: Double) -> Double { POSIXGlobals.atanh(x) }
    public static func cbrt(_ x: Double) -> Double { POSIXGlobals.cbrt(x) }
    public static func ceil(_ x: Double) -> Double { POSIXGlobals.ceil(x) }
    public static func copysign(_ x: Double, _ y: Double) -> Double { POSIXGlobals.copysign(x, y) }
    public static func cos(_ x: Double) -> Double { POSIXGlobals.cos(x) }
    public static func cosh(_ x: Double) -> Double { POSIXGlobals.cosh(x) }
    public static func erf(_ x: Double) -> Double { POSIXGlobals.erf(x) }
    public static func erfc(_ x: Double) -> Double { POSIXGlobals.erfc(x) }
    public static func exp(_ x: Double) -> Double { POSIXGlobals.exp(x) }
    public static func exp2(_ x: Double) -> Double { POSIXGlobals.exp2(x) }
    public static func expm1(_ x: Double) -> Double { POSIXGlobals.expm1(x) }
    public static func fabs(_ x: Double) -> Double { POSIXGlobals.fabs(x) }
    public static func fdim(_ x: Double, _ y: Double) -> Double { POSIXGlobals.fdim(x, y) }
    public static func floor(_ x: Double) -> Double { POSIXGlobals.floor(x) }
    public static func fma(_ x: Double, _ y: Double, _ z: Double) -> Double { POSIXGlobals.fma(x, y, z) }
    public static func fmax(_ x: Double, _ y: Double) -> Double { POSIXGlobals.fmax(x, y) }
    public static func fmin(_ x: Double, _ y: Double) -> Double { POSIXGlobals.fmin(x, y) }
    public static func fmod(_ x: Double, _ y: Double) -> Double { POSIXGlobals.fmod(x, y) }
    /// returns the mantissa in [0.5, 1) and the exponent.
    public static func frexp(_ x: Double) -> (mantissa: Double, exponent: Int) { POSIXGlobals.frexp(x) }
    public static func hypot(_ x: Double, _ y: Double) -> Double { POSIXGlobals.hypot(x, y) }
    public static func ilogb(_ x: Double) -> Int { POSIXGlobals.ilogb(x) }
    public static func ldexp(_ x: Double, _ exp: Int) -> Double { POSIXGlobals.ldexp(x, exp) }
    public static func lgamma(_ x: Double) -> Double { POSIXGlobals.lgamma(x) }
    public static func log(_ x: Double) -> Double { POSIXGlobals.log(x) }
    public static func log10(_ x: Double) -> Double { POSIXGlobals.log10(x) }
    public static func log1p(_ x: Double) -> Double { POSIXGlobals.log1p(x) }
    public static func log2(_ x: Double) -> Double { POSIXGlobals.log2(x) }
    public static func logb(_ x: Double) -> Double { POSIXGlobals.logb(x) }
    public static func lrint(_ x: Double) -> Int { POSIXGlobals.lrint(x) }
    public static func lround(_ x: Double) -> Int { POSIXGlobals.lround(x) }
    /// returns the fractional and integral parts.
    public static func modf(_ x: Double) -> (fractional: Double, integral: Double) { POSIXGlobals.modf(x) }
    public static func nan(_ tag: String = "") -> Double { POSIXGlobals.nan(tag) }
    public static func nearbyint(_ x: Double) -> Double { POSIXGlobals.nearbyint(x) }
    public static func nextafter(_ x: Double, _ y: Double) -> Double { POSIXGlobals.nextafter(x, y) }
    public static func pow(_ x: Double, _ y: Double) -> Double { POSIXGlobals.pow(x, y) }
    public static func remainder(_ x: Double, _ y: Double) -> Double { POSIXGlobals.remainder(x, y) }
    /// returns the remainder and the low quotient bits.
    public static func remquo(_ x: Double, _ y: Double) -> (remainder: Double, quotient: Int) { POSIXGlobals.remquo(x, y) }
    public static func rint(_ x: Double) -> Double { POSIXGlobals.rint(x) }
    public static func round(_ x: Double) -> Double { POSIXGlobals.round(x) }
    public static func scalbn(_ x: Double, _ exp: Int) -> Double { POSIXGlobals.scalbn(x, exp) }
    public static func sin(_ x: Double) -> Double { POSIXGlobals.sin(x) }
    public static func sinh(_ x: Double) -> Double { POSIXGlobals.sinh(x) }
    public static func sqrt(_ x: Double) -> Double { POSIXGlobals.sqrt(x) }
    public static func tan(_ x: Double) -> Double { POSIXGlobals.tan(x) }
    public static func tanh(_ x: Double) -> Double { POSIXGlobals.tanh(x) }
    public static func tgamma(_ x: Double) -> Double { POSIXGlobals.tgamma(x) }
    public static func trunc(_ x: Double) -> Double { POSIXGlobals.trunc(x) }
    /// returns Swift's `FloatingPointClassification` instead of an `FP_*` integer.
    public static func fpclassify(_ x: Double) -> FloatingPointClassification { POSIXGlobals.fpclassify(x) }
    public static func isnan(_ x: Double) -> Bool { POSIXGlobals.isnan(x) }
    public static func isinf(_ x: Double) -> Bool { POSIXGlobals.isinf(x) }
    public static func isfinite(_ x: Double) -> Bool { POSIXGlobals.isfinite(x) }
    public static func isnormal(_ x: Double) -> Bool { POSIXGlobals.isnormal(x) }
    public static func signbit(_ x: Double) -> Bool { POSIXGlobals.signbit(x) }
    public static func isgreater(_ x: Double, _ y: Double) -> Bool { POSIXGlobals.isgreater(x, y) }
    public static func isgreaterequal(_ x: Double, _ y: Double) -> Bool { POSIXGlobals.isgreaterequal(x, y) }
    public static func isless(_ x: Double, _ y: Double) -> Bool { POSIXGlobals.isless(x, y) }
    public static func islessequal(_ x: Double, _ y: Double) -> Bool { POSIXGlobals.islessequal(x, y) }
    public static func islessgreater(_ x: Double, _ y: Double) -> Bool { POSIXGlobals.islessgreater(x, y) }
    public static func isunordered(_ x: Double, _ y: Double) -> Bool { POSIXGlobals.isunordered(x, y) }
    public static func fegetround() -> CInt { POSIXGlobals.fegetround() }
    @discardableResult
    public static func fesetround(_ mode: CInt) -> CInt { POSIXGlobals.fesetround(mode) }
}

// MARK: - <stdlib.h> / <string.h>

extension POSIX {
    /// identical to C's `exit(3)`.
    public static func exit(_ status: CInt = 0) -> Never { POSIXGlobals.exit(status) }
    /// identical to C's `abort(3)`.
    public static func abort() -> Never { POSIXGlobals.abort() }
    /// identical to C's `getenv(3)`.
    public static func getenv(_ name: String) -> String? { POSIXGlobals.getenv(name) }
    /// identical to C's `setenv(3)`.
    public static func setenv(_ name: String, _ value: String, _ overwrite: Bool = true) throws {
        try POSIXGlobals.setenv(name, value, overwrite)
    }
    /// identical to C's `unsetenv(3)`.
    public static func unsetenv(_ name: String) throws { try POSIXGlobals.unsetenv(name) }
    /// returns the parsed value and the number of unparsed (trailing) bytes.
    public static func strtod(_ s: String) -> (value: Double, unparsed: Int) { POSIXGlobals.strtod(s) }
    /// returns the parsed value and the number of unparsed (trailing) bytes.
    public static func strtol(_ s: String, _ base: CInt = 10) -> (value: Int, unparsed: Int) {
        POSIXGlobals.strtol(s, base)
    }
    /// returns the parsed value and the number of unparsed (trailing) bytes.
    public static func strtoul(_ s: String, _ base: CInt = 10) -> (value: UInt, unparsed: Int) {
        POSIXGlobals.strtoul(s, base)
    }
    /// identical to C's `mblen(3)`.
    public static func mblen(_ s: String) -> Int { POSIXGlobals.mblen(s) }
    /// identical to C's `mbtowc(3)`.
    public static func mbtowc(_ s: String) -> (wc: wchar_t, length: Int)? { POSIXGlobals.mbtowc(s) }
    /// identical to C's `wctomb(3)`.
    public static func wctomb(_ wc: wchar_t) -> String? { POSIXGlobals.wctomb(wc) }
    /// identical to C's `mbstowcs(3)`.
    public static func mbstowcs(_ s: String) -> [wchar_t]? { POSIXGlobals.mbstowcs(s) }
    /// identical to C's `wcstombs(3)`.
    public static func wcstombs(_ wcs: [wchar_t]) -> String? { POSIXGlobals.wcstombs(wcs) }
    /// identical to C's `strcoll(3)`: locale-aware comparison.
    public static func strcoll(_ a: String, _ b: String) -> Int { POSIXGlobals.strcoll(a, b) }
    /// identical to C's `strxfrm(3)`.
    public static func strxfrm(_ s: String) -> String { POSIXGlobals.strxfrm(s) }
}

// MARK: - <stdio.h>

extension POSIX {
    /// identical to C's `ctermid(3)`.
    public static func ctermid() -> String { POSIXGlobals.ctermid() }
    /// identical to C's `cuserid(3)`.
    public static func cuserid() -> String? { POSIXGlobals.cuserid() }
    /// identical to C's `remove(3)`.
    public static func remove(_ path: String) throws { try POSIXGlobals.remove(path) }
    /// identical to C's `rename(2)`.
    public static func rename(_ old: String, _ new: String) throws { try POSIXGlobals.rename(old, new) }
    /// identical to C's `mkstemp(3)`.
    public static func mkstemp(_ template: String) throws -> (fd: CInt, path: String) {
        try POSIXGlobals.mkstemp(template)
    }
}

// MARK: - <unistd.h>

extension POSIX {
    public static func getpid() -> pid_t { POSIXGlobals.getpid() }
    public static func getppid() -> pid_t { POSIXGlobals.getppid() }
    public static func getuid() -> uid_t { POSIXGlobals.getuid() }
    public static func geteuid() -> uid_t { POSIXGlobals.geteuid() }
    public static func getgid() -> gid_t { POSIXGlobals.getgid() }
    public static func getegid() -> gid_t { POSIXGlobals.getegid() }
    public static func getpgrp() -> pid_t { POSIXGlobals.getpgrp() }
    public static func setuid(_ uid: uid_t) throws { try POSIXGlobals.setuid(uid) }
    public static func setgid(_ gid: gid_t) throws { try POSIXGlobals.setgid(gid) }
    public static func setpgid(_ pid: pid_t, _ pgid: pid_t) throws { try POSIXGlobals.setpgid(pid, pgid) }
    @discardableResult
    public static func setsid() throws -> pid_t { try POSIXGlobals.setsid() }
    /// the supplementary group ids.
    public static func getgroups() throws -> [gid_t] { try POSIXGlobals.getgroups() }
    public static func getlogin() -> String? { POSIXGlobals.getlogin() }
    /// returns 0 in the child and the child's pid in the parent.
    public static func fork() throws -> pid_t { try POSIXGlobals.fork() }
    /// exits without running cleanup.
    public static func _exit(_ status: CInt = 0) -> Never { POSIXGlobals._exit(status) }
    @discardableResult
    public static func nice(_ increment: CInt) throws -> CInt { try POSIXGlobals.nice(increment) }
    @discardableResult
    public static func alarm(_ seconds: UInt32) -> UInt32 { POSIXGlobals.alarm(seconds) }
    /// waits until a signal is delivered.
    public static func pause() { POSIXGlobals.pause() }
    /// returns the unslept seconds.
    @discardableResult
    public static func sleep(_ seconds: UInt32) -> UInt32 { POSIXGlobals.sleep(seconds) }
    public static func close(_ fd: CInt) throws { try POSIXGlobals.close(fd) }
    public static func dup(_ fd: CInt) throws -> CInt { try POSIXGlobals.dup(fd) }
    @discardableResult
    public static func dup2(_ fd: CInt, _ fd2: CInt) throws -> CInt { try POSIXGlobals.dup2(fd, fd2) }
    /// returns the read and write descriptors.
    public static func pipe() throws -> (read: CInt, write: CInt) { try POSIXGlobals.pipe() }
    public static func isatty(_ fd: CInt) -> Bool { POSIXGlobals.isatty(fd) }
    public static func ttyname(_ fd: CInt) -> String? { POSIXGlobals.ttyname(fd) }
    /// returns the new offset.
    @discardableResult
    public static func lseek(_ fd: CInt, _ offset: off_t, _ whence: Whence = .SEEK_SET) throws -> off_t {
        try POSIXGlobals.lseek(fd, offset, whence)
    }
    /// identical to C's `read(2)`, but returns the bytes read.
    public static func read(_ fd: CInt, _ count: Int) throws -> [UInt8] { try POSIXGlobals.read(fd, count) }
    /// returns the number of bytes written.
    @discardableResult
    public static func write(_ fd: CInt, _ bytes: [UInt8]) throws -> Int { try POSIXGlobals.write(fd, bytes) }
    /// identical to C's `write(2)`, taking the UTF-8 bytes of a String.
    @discardableResult
    public static func write(_ fd: CInt, _ string: String) throws -> Int { try POSIXGlobals.write(fd, string) }
    /// identical to C's `access(2)`, but returns a Bool.
    public static func access(_ path: String, _ mode: AccessMode = .F_OK) -> Bool {
        POSIXGlobals.access(path, mode)
    }
    public static func chdir(_ path: String) throws { try POSIXGlobals.chdir(path) }
    public static func chown(_ path: String, _ owner: uid_t, _ group: gid_t) throws {
        try POSIXGlobals.chown(path, owner, group)
    }
    public static func getcwd() throws -> String { try POSIXGlobals.getcwd() }
    public static func link(_ existing: String, _ new: String) throws { try POSIXGlobals.link(existing, new) }
    public static func unlink(_ path: String) throws { try POSIXGlobals.unlink(path) }
    public static func rmdir(_ path: String) throws { try POSIXGlobals.rmdir(path) }
    /// nil means "no limit / not supported".
    public static func sysconf(_ name: SysconfName) throws -> Int? { try POSIXGlobals.sysconf(name) }
    /// nil means "no limit / not supported".
    public static func pathconf(_ path: String, _ name: PathconfName) throws -> Int? {
        try POSIXGlobals.pathconf(path, name)
    }
    /// nil means "no limit / not supported".
    public static func fpathconf(_ fd: CInt, _ name: PathconfName) throws -> Int? {
        try POSIXGlobals.fpathconf(fd, name)
    }
    public static func tcgetpgrp(_ fd: CInt) throws -> pid_t { try POSIXGlobals.tcgetpgrp(fd) }
    public static func tcsetpgrp(_ fd: CInt, _ pgid: pid_t) throws { try POSIXGlobals.tcsetpgrp(fd, pgid) }
}

// MARK: - <fcntl.h>

extension POSIX {
    /// returns the file descriptor.
    public static func open(_ path: String, _ flags: OpenFlags = .O_RDONLY, _ mode: mode_t = 0o666) throws -> CInt {
        try POSIXGlobals.open(path, flags, mode)
    }
    /// returns the file descriptor.
    public static func creat(_ path: String, _ mode: mode_t = 0o666) throws -> CInt {
        try POSIXGlobals.creat(path, mode)
    }
    /// identical to C's `fcntl(2)` for the integer-argument commands.
    @discardableResult
    public static func fcntl(_ fd: CInt, _ cmd: FcntlCommand, _ arg: CInt = 0) throws -> CInt {
        try POSIXGlobals.fcntl(fd, cmd, arg)
    }
}

// MARK: - <sys/stat.h>

extension POSIX {
    /// identical to C's `stat(2)`, but returns a swifty `Stat`.
    public static func stat(_ path: String) throws -> Stat { try POSIXGlobals.stat(path) }
    /// identical to C's `lstat(2)`, but returns a swifty `Stat`.
    public static func lstat(_ path: String) throws -> Stat { try POSIXGlobals.lstat(path) }
    /// identical to C's `fstat(2)`, but returns a swifty `Stat`.
    public static func fstat(_ fd: CInt) throws -> Stat { try POSIXGlobals.fstat(fd) }
    public static func chmod(_ path: String, _ mode: mode_t) throws { try POSIXGlobals.chmod(path, mode) }
    public static func mkdir(_ path: String, _ mode: mode_t = 0o777) throws { try POSIXGlobals.mkdir(path, mode) }
    public static func mkfifo(_ path: String, _ mode: mode_t = 0o666) throws { try POSIXGlobals.mkfifo(path, mode) }
    /// returns the previous mask.
    @discardableResult
    public static func umask(_ cmask: mode_t) -> mode_t { POSIXGlobals.umask(cmask) }
    /// nil times mean "now".
    public static func utime(_ path: String, atime: time_t? = nil, mtime: time_t? = nil) throws {
        try POSIXGlobals.utime(path, atime: atime, mtime: mtime)
    }
}

// MARK: - <time.h> / <sys/times.h>

extension POSIX {
    /// seconds since the epoch.
    public static func time() -> time_t { POSIXGlobals.time() }
    public static func difftime(_ time1: time_t, _ time0: time_t) -> Double {
        POSIXGlobals.difftime(time1, time0)
    }
    /// identical to C's `gmtime(3)`, but returns a swifty `Tm`.
    public static func gmtime(_ t: time_t = POSIXGlobals.time()) -> Tm { POSIXGlobals.gmtime(t) }
    /// identical to C's `localtime(3)`, but returns a swifty `Tm`.
    public static func localtime(_ t: time_t = POSIXGlobals.time()) -> Tm { POSIXGlobals.localtime(t) }
    /// converts a local-time `Tm` to seconds since the epoch.
    public static func mktime(_ tm: Tm) throws -> time_t { try POSIXGlobals.mktime(tm) }
    /// including the trailing newline.
    public static func asctime(_ tm: Tm) -> String { POSIXGlobals.asctime(tm) }
    /// `asctime(localtime(t))`.
    public static func ctime(_ t: time_t = POSIXGlobals.time()) -> String { POSIXGlobals.ctime(t) }
    /// identical to C's `strftime(3)`.
    public static func strftime(_ format: String, _ tm: Tm) -> String { POSIXGlobals.strftime(format, tm) }
    /// processor time used, in `CLOCKS_PER_SEC` ticks.
    public static func clock() -> clock_t { POSIXGlobals.clock() }
    public static func tzset() { POSIXGlobals.tzset() }
    /// the standard and daylight-saving timezone abbreviations.
    public static func tzname() -> (standard: String, daylight: String) { POSIXGlobals.tzname() }
    /// identical to C's `times(3)`, but returns a swifty `Times`.
    public static func times() throws -> Times { try POSIXGlobals.times() }
}

// MARK: - <sys/utsname.h> / <sys/wait.h>

extension POSIX {
    /// identical to C's `uname(3)`, but returns a swifty `Utsname`.
    public static func uname() throws -> Utsname { try POSIXGlobals.uname() }
    /// returns the reaped pid and its status.
    public static func wait() throws -> (pid: pid_t, status: WaitStatus) { try POSIXGlobals.wait() }
    /// returns the reaped pid (0 with `.WNOHANG` when nothing has changed) and its status.
    public static func waitpid(_ pid: pid_t, _ options: WaitOptions = []) throws -> (pid: pid_t, status: WaitStatus) {
        try POSIXGlobals.waitpid(pid, options)
    }
}

// MARK: - <signal.h>

extension POSIX {
    public static func kill(_ pid: pid_t, _ sig: Signal) throws { try POSIXGlobals.kill(pid, sig) }
    public static func raise(_ sig: Signal) throws { try POSIXGlobals.raise(sig) }
    /// returns the previous mask.
    @discardableResult
    public static func sigprocmask(_ how: SigmaskHow, _ set: SigSet?) throws -> SigSet {
        try POSIXGlobals.sigprocmask(how, set)
    }
    public static func sigpending() throws -> SigSet { try POSIXGlobals.sigpending() }
    /// atomically sets the signal mask and waits for a signal.
    public static func sigsuspend(_ mask: SigSet) { POSIXGlobals.sigsuspend(mask) }
    /// installs `action` (if non-nil) and returns the previous action.
    @discardableResult
    public static func sigaction(_ sig: Signal, _ action: SigAction? = nil) throws -> SigAction {
        try POSIXGlobals.sigaction(sig, action)
    }
    /// returns the previous handler.
    @discardableResult
    public static func signal(_ sig: Signal, _ handler: SigHandler) throws -> SigHandler {
        try POSIXGlobals.signal(sig, handler)
    }
}

// MARK: - <locale.h>

extension POSIX {
    /// pass nil to query, a locale name to set.
    @discardableResult
    public static func setlocale(_ category: LocaleCategory, _ locale: String? = nil) -> String? {
        POSIXGlobals.setlocale(category, locale)
    }
    /// identical to C's `localeconv(3)`, but returns a swifty `Lconv`.
    public static func localeconv() -> Lconv { POSIXGlobals.localeconv() }
}

// MARK: - <termios.h>

extension POSIX {
    /// identical to C's `tcgetattr(3)`, but returns a swifty `Termios`.
    public static func tcgetattr(_ fd: CInt) throws -> Termios { try POSIXGlobals.tcgetattr(fd) }
    /// identical to C's `tcsetattr(3)`.
    public static func tcsetattr(_ fd: CInt, _ action: TcsetattrAction = .TCSANOW, _ termios: Termios) throws {
        try POSIXGlobals.tcsetattr(fd, action, termios)
    }
    public static func tcdrain(_ fd: CInt) throws { try POSIXGlobals.tcdrain(fd) }
    public static func tcflow(_ fd: CInt, _ action: TcflowAction) throws { try POSIXGlobals.tcflow(fd, action) }
    public static func tcflush(_ fd: CInt, _ queue: TcflushQueue) throws { try POSIXGlobals.tcflush(fd, queue) }
    public static func tcsendbreak(_ fd: CInt, _ duration: CInt = 0) throws {
        try POSIXGlobals.tcsendbreak(fd, duration)
    }
}

// MARK: - <dirent.h>

extension POSIX {
    /// identical to C's `opendir(3)`.
    public static func opendir(_ path: String) throws -> Dir { try POSIXGlobals.opendir(path) }
    /// identical to C's `readdir(3)`.
    public static func readdir(_ dir: Dir) -> String? { POSIXGlobals.readdir(dir) }
    /// identical to C's `rewinddir(3)`.
    public static func rewinddir(_ dir: Dir) { POSIXGlobals.rewinddir(dir) }
    /// identical to C's `telldir(3)`.
    public static func telldir(_ dir: Dir) -> Int { POSIXGlobals.telldir(dir) }
    /// identical to C's `seekdir(3)`.
    public static func seekdir(_ dir: Dir, _ pos: Int) { POSIXGlobals.seekdir(dir, pos) }
    /// identical to C's `closedir(3)`.
    public static func closedir(_ dir: Dir) { POSIXGlobals.closedir(dir) }
}

// MARK: - <pwd.h> / <grp.h> / <errno.h>

extension POSIX {
    public static func getpwnam(_ name: String) -> Passwd? { POSIXGlobals.getpwnam(name) }
    public static func getpwuid(_ uid: uid_t) -> Passwd? { POSIXGlobals.getpwuid(uid) }
    public static func getgrnam(_ name: String) -> Group? { POSIXGlobals.getgrnam(name) }
    public static func getgrgid(_ gid: gid_t) -> Group? { POSIXGlobals.getgrgid(gid) }
    /// identical to C's `strerror(3)`.
    public static func strerror(_ e: Errno) -> String { POSIXGlobals.strerror(e) }
}
