import Testing
// Perl's @EXPORT_OK, the Swift way: cherry-pick single symbols.
import func POSIXGlobals.floor
import struct POSIXGlobals.Errno

@Suite struct ScopedImportTests {
    @Test func cherryPickedSymbols() {
        #expect(floor(3.7) == 3)
        #expect(Errno.ENOENT.rawValue == 2)
    }
}
