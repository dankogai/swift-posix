import Testing
import POSIX

@Suite struct SignalTests {
    @Test func sigsetMembership() {
        var set = SigSet()
        #expect(!set.contains(.SIGINT))
        set.insert(.SIGINT)
        #expect(set.contains(.SIGINT))
        #expect(!set.contains(.SIGTERM))
        set.remove(.SIGINT)
        #expect(!set.contains(.SIGINT))

        let both = SigSet(.SIGUSR1, .SIGUSR2)
        #expect(both.contains(.SIGUSR1) && both.contains(.SIGUSR2))
        #expect(SigSet.all.contains(.SIGHUP))
        #expect(!SigSet.empty.contains(.SIGHUP))
    }

    @Test func sigprocmaskRoundTrip() throws {
        // block SIGUSR2, verify, then restore — harmless to the process
        let old = try sigprocmask(.SIG_BLOCK, SigSet(.SIGUSR2))
        let current = try sigprocmask(.SIG_SETMASK, nil)
        #expect(current.contains(.SIGUSR2))
        try sigprocmask(.SIG_SETMASK, old)
        // the runner may block signals of its own, so compare against `old`
        let restored = try sigprocmask(.SIG_SETMASK, nil)
        #expect(restored.contains(.SIGUSR2) == old.contains(.SIGUSR2))
    }

    @Test func sigactionQuery() throws {
        // query without installing anything
        let action = try sigaction(.SIGUSR1)
        switch action.handler {
        case .defaultAction, .ignore, .handler: #expect(Bool(true))
        }
    }

    @Test func signalIgnoreAndRestore() throws {
        let old = try signal(.SIGUSR2, .ignore)
        try raise(.SIGUSR2) // ignored, so we survive
        _ = try signal(.SIGUSR2, old)
    }
}
