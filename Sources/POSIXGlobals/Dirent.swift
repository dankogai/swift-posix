/// Dirent.swift — <dirent.h>, with `DIR *` made swifty.

#if canImport(Darwin)
import Darwin
internal typealias CDirPointer = UnsafeMutablePointer<DIR>
#elseif canImport(Glibc)
import Glibc
internal typealias CDirPointer = OpaquePointer
#endif

/// An open directory stream.  Iterable: yields entry names (including
/// "." and "..", like `readdir(3)`).
public final class Dir: Sequence, IteratorProtocol {
    internal var dirp: CDirPointer?

    /// identical to C's `opendir(3)`.
    public init(_ path: String) throws {
        dirp = try path.withCString { try check(opendir($0)) }
    }

    /// identical to C's `readdir(3)`; returns the next entry name, or
    /// nil at the end of the stream.
    public func next() -> String? {
        guard let dirp else { return nil }
        guard let entry = readdir(dirp) else { return nil }
        return stringFromCCharTuple(entry.pointee.d_name)
    }

    /// identical to C's `rewinddir(3)`.
    public func rewind() {
        guard let dirp else { return }
        rewinddir(dirp)
    }

    /// identical to C's `telldir(3)`.
    public func tell() -> Int {
        guard let dirp else { return -1 }
        return Int(telldir(dirp))
    }

    /// identical to C's `seekdir(3)`.
    public func seek(_ pos: Int) {
        guard let dirp else { return }
        seekdir(dirp, pos)
    }

    /// identical to C's `closedir(3)`.  Also called automatically when
    /// the object is deinitialized.
    public func close() {
        guard let dirp else { return }
        closedir(dirp)
        self.dirp = nil
    }

    deinit { close() }
}

/// identical to C's `opendir(3)`.
public func opendir(_ path: String) throws -> Dir { try Dir(path) }
/// identical to C's `readdir(3)`.
public func readdir(_ dir: Dir) -> String? { dir.next() }
/// identical to C's `rewinddir(3)`.
public func rewinddir(_ dir: Dir) { dir.rewind() }
/// identical to C's `telldir(3)`.
public func telldir(_ dir: Dir) -> Int { dir.tell() }
/// identical to C's `seekdir(3)`.
public func seekdir(_ dir: Dir, _ pos: Int) { dir.seek(pos) }
/// identical to C's `closedir(3)`.
public func closedir(_ dir: Dir) { dir.close() }
