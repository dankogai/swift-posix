import Testing
import POSIXGlobals

// Pure bit-twiddling on wait statuses; no processes are spawned.
@Suite struct WaitTests {
    @Test func exitStatuses() {
        let ok = WaitStatus(rawValue: 0)
        #expect(ok.exited)
        #expect(ok.exitStatus == 0)
        #expect(!ok.signaled)
        #expect(ok.termSignal == nil)

        let five = WaitStatus(rawValue: 5 << 8)
        #expect(five.exited)
        #expect(five.exitStatus == 5)
    }

    @Test func signalStatuses() {
        let term = WaitStatus(rawValue: Signal.SIGTERM.rawValue)
        #expect(term.signaled)
        #expect(term.termSignal == .SIGTERM)
        #expect(!term.exited)
        #expect(term.exitStatus == nil)
        #expect(!term.coreDumped)

        let abrt = WaitStatus(rawValue: Signal.SIGABRT.rawValue | 0x80)
        #expect(abrt.signaled)
        #expect(abrt.termSignal == .SIGABRT)
        #expect(abrt.coreDumped)
    }

    @Test func stopStatuses() {
        let stopped = WaitStatus(rawValue: (Signal.SIGTSTP.rawValue << 8) | 0x7f)
        #expect(stopped.stopped)
        #expect(stopped.stopSignal == .SIGTSTP)
        #expect(!stopped.exited)
        #expect(!stopped.signaled)
    }
}
