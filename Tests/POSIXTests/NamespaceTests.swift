import Testing
import POSIX // and only POSIX: everything below goes through the namespace

@Suite struct NamespaceTests {
    @Test func mathThroughNamespace() {
        #expect(POSIX.floor(3.7) == 3)
        #expect(POSIX.pow(2, 10) == 1024)
        #expect(POSIX.frexp(8) == (0.5, 4))
        #expect(POSIX.isnan(POSIX.nan()))
        #expect(POSIX.M_PI == Double.pi)
        #expect(POSIX.fpclassify(1.0) == .positiveNormal)
    }

    @Test func stringsThroughNamespace() {
        #expect(POSIX.toupper("swifty") == "SWIFTY")
        #expect(POSIX.isdigit("42"))
        #expect(POSIX.strtod("3.14foo") == (3.14, 3))
        #expect(!POSIX.strerror(POSIX.Errno.ENOENT).isEmpty)
    }

    @Test func systemThroughNamespace() throws {
        #expect(POSIX.getpid() > 0)
        #expect(try POSIX.getcwd().hasPrefix("/"))
        #expect(try POSIX.stat(".").isDirectory)
        #expect(["Darwin", "Linux"].contains(try POSIX.uname().sysname))
        #expect(try POSIX.sysconf(.pageSize) ?? 0 > 0)
        #expect(throws: POSIX.Errno.ENOENT) {
            try POSIX.stat("/nonexistent/really/not/here")
        }
    }

    @Test func timeThroughNamespace() throws {
        let tm = POSIX.gmtime(0)
        #expect(tm.year == 70)
        #expect(POSIX.strftime("%Y-%m-%d", tm) == "1970-01-01")
        #expect(try POSIX.mktime(POSIX.localtime(POSIX.time())) == POSIX.time())
    }

    @Test func typesThroughNamespace() {
        // types are reachable (only) under the namespace
        let mode: POSIX.mode_t = 0o644
        #expect(POSIX.FilePermissions(rawValue: mode).contains(.S_IRUSR))
        var set = POSIX.SigSet()
        set.insert(.SIGINT)
        #expect(set.contains(.SIGINT))
        var t = POSIX.Termios()
        t.localFlags = [.ICANON]
        #expect(t.localFlags.contains(.ICANON))
        #expect(POSIX.WaitStatus(rawValue: 0).exited)
        #expect(POSIX.OpenFlags([.O_WRONLY, .O_CREAT]).contains(.O_CREAT))
        #expect(POSIX.INT_MAX == Int32.max)
    }

    @Test func directoryThroughNamespace() throws {
        let names = Array(try POSIX.Dir("."))
        #expect(names.contains("Package.swift"))
    }

    @Test func unimplementedThroughNamespace() async {
        await #expect(processExitsWith: .failure) {
            POSIX.strlen("hello")
        }
    }
}
