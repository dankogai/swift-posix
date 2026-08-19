import Testing
import POSIX

@Suite struct UnimplementedTests {
    @Test func cSpecificFunctionsTrap() async {
        await #expect(processExitsWith: .failure) {
            strlen("hello")
        }
        await #expect(processExitsWith: .failure) {
            malloc(42)
        }
    }
}
