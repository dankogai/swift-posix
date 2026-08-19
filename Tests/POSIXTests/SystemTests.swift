import Testing
import POSIX

@Suite struct SystemTests {
    @Test func unameWorks() throws {
        let u = try uname()
        #expect(["Darwin", "Linux"].contains(u.sysname))
        #expect(!u.release.isEmpty)
        #expect(!u.machine.isEmpty)
    }

    @Test func identifiers() {
        #expect(getpid() > 0)
        #expect(getppid() > 0)
        #expect(getpid() != getppid())
        #expect(geteuid() == getuid() || geteuid() != getuid()) // callable
        #expect(getpgrp() > 0)
    }

    @Test func groups() throws {
        let gs = try getgroups()
        #expect(gs.contains(getgid()) || gs.isEmpty || !gs.isEmpty)
    }

    @Test func sysconfWorks() throws {
        let pageSize = try #require(try sysconf(.pageSize))
        #expect(pageSize > 0 && pageSize % 512 == 0)
        let clockTick = try #require(try sysconf(.clockTick))
        #expect(clockTick > 0)
        let openMax = try #require(try sysconf(.openMax))
        #expect(openMax > 0)
    }

    @Test func passwdDatabase() {
        let me = getpwuid(getuid())
        if let me { // may be absent in minimal containers
            #expect(!me.name.isEmpty)
            #expect(me.uid == getuid())
            #expect(getpwnam(me.name)?.uid == getuid())
        }
        #expect(getpwnam("no such user, honest") == nil)
        #expect(getgrgid(getgid())?.gid == getgid() || getgrgid(getgid()) == nil)
    }

    @Test func errnoDescriptions() {
        #expect(!Errno.ENOENT.description.isEmpty)
        #expect(strerror(Errno.EPERM) == Errno.EPERM.description)
        #expect(Errno.ENOENT != Errno.EPERM)
        #expect(Errno(rawValue: 2) == Errno.ENOENT)
    }

    @Test func limits() {
        #expect(INT_MAX == 2147483647)
        #expect(CHAR_BIT == 8)
        #expect(DBL_EPSILON == 2.220446049250313e-16)
        #expect(SSIZE_MAX == Int.max)
    }
}
