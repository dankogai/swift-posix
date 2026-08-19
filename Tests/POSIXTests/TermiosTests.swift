import Testing
import POSIX

// Pure struct manipulation; no terminal is touched.
@Suite struct TermiosTests {
    @Test func flagsRoundTrip() {
        var t = Termios()
        t.localFlags = [.ICANON, .ECHO, .ISIG]
        #expect(t.localFlags.contains(.ICANON))
        #expect(t.localFlags.contains(.ECHO))
        #expect(!t.localFlags.contains(.TOSTOP))
        t.localFlags.remove(.ECHO)
        #expect(!t.localFlags.contains(.ECHO))
        t.inputFlags = [.ICRNL, .IXON]
        #expect(t.inputFlags == [.ICRNL, .IXON])
        t.outputFlags = [.OPOST, .ONLCR]
        #expect(t.outputFlags.contains(.OPOST))
        t.controlFlags = [.CREAD, .CS8]
        #expect(t.controlFlags.contains(.CREAD))
    }

    @Test func controlCharacters() {
        var t = Termios()
        t[.VMIN] = 1
        t[.VTIME] = 10
        #expect(t[.VMIN] == 1)
        #expect(t[.VTIME] == 10)
        t[.VMIN] = 0
        #expect(t[.VMIN] == 0)
        #expect(t[.VTIME] == 10)
    }

    @Test func speeds() {
        // Linux keeps one shared CBAUD field, so test one speed at a time
        var t = Termios()
        t.inputSpeed = .B9600
        #expect(t.inputSpeed == .B9600)
        t.outputSpeed = .B38400
        #expect(t.outputSpeed == .B38400)
    }
}
