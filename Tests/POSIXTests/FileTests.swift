import Testing
import POSIXGlobals

@Suite struct FileTests {
    @Test func statDirectory() throws {
        let st = try stat(".")
        #expect(st.isDirectory)
        #expect(!st.isRegularFile)
        #expect(st.type == .directory)
        #expect(st.nlink >= 1)
    }

    @Test func statFile() throws {
        let st = try stat("Package.swift")
        #expect(st.isRegularFile)
        #expect(st.size > 0)
        #expect(st.permissions.contains(.S_IRUSR))
        #expect(st.mtime.seconds > 0)
        #expect(st.mtime.timeInterval >= Double(st.mtime.seconds))
    }

    @Test func statFailure() {
        #expect(throws: Errno.ENOENT) {
            try stat("/nonexistent/really/not/here")
        }
    }

    @Test func devNull() throws {
        let fd = try open("/dev/null", .O_RDWR)
        defer { try? close(fd) }
        #expect(fd >= 0)
        #expect(!isatty(fd))
        let st = try fstat(fd)
        #expect(st.isCharacterDevice)
        #expect(try write(fd, "hello") == 5)
        #expect(try read(fd, 10).isEmpty) // reading /dev/null gives EOF
    }

    @Test func pipeReadWrite() throws {
        let (r, w) = try pipe()
        defer { try? close(r); try? close(w) }
        try write(w, "swifty")
        let bytes = try read(r, 16)
        #expect(String(decoding: bytes, as: UTF8.self) == "swifty")
    }

    @Test func directoryListing() throws {
        let names = Array(try Dir("."))
        #expect(names.contains("."))
        #expect(names.contains("Package.swift"))
        // and the free-function spelling
        let dir = try opendir(".")
        var found = false
        while let name = readdir(dir) {
            if name == "Sources" { found = true }
        }
        #expect(found)
        rewinddir(dir)
        #expect(readdir(dir) != nil)
        closedir(dir)
    }

    @Test func workingDirectory() throws {
        let cwd = try getcwd()
        #expect(cwd.hasPrefix("/"))
        #expect(access(cwd, [.R_OK, .X_OK]))
        #expect(access(cwd))
        #expect(!access("/nonexistent/really/not/here"))
    }

    @Test func pathconfWorks() throws {
        if let nameMax = try pathconf(".", .nameMax) {
            #expect(nameMax >= 14) // _POSIX_NAME_MAX
        }
    }

    @Test func fcntlFlags() throws {
        let fd = try open("/dev/null", .O_WRONLY)
        defer { try? close(fd) }
        let flags = try fcntl(fd, .F_GETFL)
        #expect(OpenFlags(rawValue: flags).contains(.O_WRONLY))
        let fdflags = try fcntl(fd, .F_GETFD)
        #expect(fdflags & FD_CLOEXEC == 0)
    }
}
