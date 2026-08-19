/// Unimplemented.swift — functions that Perl's POSIX module deliberately
/// leaves unimplemented ("C-specific" or "not supplied"), kept here for
/// interface parity.  Each one halts with a pointer to the swifty way,
/// the same way POSIX.pm croaks with "use method x instead".

private func unimplemented(_ name: String, _ advice: String) -> Never {
    fatalError("POSIX.\(name)() is C-specific and unimplemented: \(advice)")
}

// MARK: <stdlib.h>

public func atexit(_: Any...) -> Never { unimplemented("atexit", "use deinit or your own shutdown hook") }
public func atof(_: Any...) -> Never { unimplemented("atof", "use Double(_:) or POSIX.strtod") }
public func atoi(_: Any...) -> Never { unimplemented("atoi", "use Int(_:) or POSIX.strtol") }
public func atol(_: Any...) -> Never { unimplemented("atol", "use Int(_:) or POSIX.strtol") }
public func bsearch(_: Any...) -> Never { unimplemented("bsearch", "use Collection.firstIndex(where:) or your own binary search") }
public func calloc(_: Any...) -> Never { unimplemented("calloc", "use UnsafeMutablePointer.allocate(capacity:)") }
public func div(_: Any...) -> Never { unimplemented("div", "use quotientAndRemainder(dividingBy:)") }
public func labs(_: Any...) -> Never { unimplemented("labs", "use Swift.abs or .magnitude") }
public func ldiv(_: Any...) -> Never { unimplemented("ldiv", "use quotientAndRemainder(dividingBy:)") }
public func malloc(_: Any...) -> Never { unimplemented("malloc", "use UnsafeMutableRawPointer.allocate(byteCount:alignment:)") }
public func free(_: Any...) -> Never { unimplemented("free", "use deallocate()") }
public func realloc(_: Any...) -> Never { unimplemented("realloc", "use Array or reallocate manually") }
public func qsort(_: Any...) -> Never { unimplemented("qsort", "use Sequence.sorted(by:)") }
public func rand(_: Any...) -> Never { unimplemented("rand", "non-portable; use Int.random(in:)") }
public func srand(_: Any...) -> Never { unimplemented("srand", "non-portable; use a seeded RandomNumberGenerator") }

// MARK: <stdio.h>

public func clearerr(_: Any...) -> Never { unimplemented("clearerr", "C-stream-specific; use FileDescriptor-based I/O") }
public func fclose(_: Any...) -> Never { unimplemented("fclose", "use POSIX.close") }
public func fdopen(_: Any...) -> Never { unimplemented("fdopen", "use the file descriptor directly") }
public func feof(_: Any...) -> Never { unimplemented("feof", "read(2) returning 0 bytes means EOF") }
public func ferror(_: Any...) -> Never { unimplemented("ferror", "POSIX functions throw Errno instead") }
public func fflush(_: Any...) -> Never { unimplemented("fflush", "unbuffered write(2) needs no flushing") }
public func fgetc(_: Any...) -> Never { unimplemented("fgetc", "use POSIX.read") }
public func fgetpos(_: Any...) -> Never { unimplemented("fgetpos", "use POSIX.lseek(fd, 0, .SEEK_CUR)") }
public func fgets(_: Any...) -> Never { unimplemented("fgets", "use POSIX.read") }
public func fileno(_: Any...) -> Never { unimplemented("fileno", "this module deals in file descriptors already") }
public func fopen(_: Any...) -> Never { unimplemented("fopen", "use POSIX.open") }
public func fprintf(_: Any...) -> Never { unimplemented("fprintf", "use POSIX.write(fd, \"...\") with string interpolation") }
public func fputc(_: Any...) -> Never { unimplemented("fputc", "use POSIX.write") }
public func fputs(_: Any...) -> Never { unimplemented("fputs", "use POSIX.write") }
public func fread(_: Any...) -> Never { unimplemented("fread", "use POSIX.read") }
public func freopen(_: Any...) -> Never { unimplemented("freopen", "use POSIX.open and POSIX.dup2") }
public func fscanf(_: Any...) -> Never { unimplemented("fscanf", "use POSIX.read and parse in Swift") }
public func fseek(_: Any...) -> Never { unimplemented("fseek", "use POSIX.lseek") }
public func fsetpos(_: Any...) -> Never { unimplemented("fsetpos", "use POSIX.lseek") }
public func ftell(_: Any...) -> Never { unimplemented("ftell", "use POSIX.lseek(fd, 0, .SEEK_CUR)") }
public func fwrite(_: Any...) -> Never { unimplemented("fwrite", "use POSIX.write") }
public func getc(_: Any...) -> Never { unimplemented("getc", "use POSIX.read") }
public func getchar(_: Any...) -> Never { unimplemented("getchar", "use POSIX.read(0, 1) or Swift.readLine()") }
public func gets(_: Any...) -> Never { unimplemented("gets", "use Swift.readLine()") }
public func printf(_: Any...) -> Never { unimplemented("printf", "use Swift.print with string interpolation") }
public func putc(_: Any...) -> Never { unimplemented("putc", "use POSIX.write") }
public func putchar(_: Any...) -> Never { unimplemented("putchar", "use POSIX.write or Swift.print") }
public func puts(_: Any...) -> Never { unimplemented("puts", "use Swift.print") }
public func scanf(_: Any...) -> Never { unimplemented("scanf", "use Swift.readLine() and parse in Swift") }
public func setbuf(_: Any...) -> Never { unimplemented("setbuf", "C-stream-specific") }
public func setvbuf(_: Any...) -> Never { unimplemented("setvbuf", "C-stream-specific") }
public func sprintf(_: Any...) -> Never { unimplemented("sprintf", "use string interpolation or String(format:) from Foundation") }
public func sscanf(_: Any...) -> Never { unimplemented("sscanf", "parse with Swift String APIs") }
public func tmpfile(_: Any...) -> Never { unimplemented("tmpfile", "use POSIX.mkstemp") }
public func tmpnam(_: Any...) -> Never { unimplemented("tmpnam", "insecure and removed from perl too; use POSIX.mkstemp") }
public func ungetc(_: Any...) -> Never { unimplemented("ungetc", "buffer in Swift instead") }
public func vfprintf(_: Any...) -> Never { unimplemented("vfprintf", "use string interpolation") }
public func vprintf(_: Any...) -> Never { unimplemented("vprintf", "use string interpolation") }
public func vsprintf(_: Any...) -> Never { unimplemented("vsprintf", "use string interpolation") }
public func perror(_: Any...) -> Never { unimplemented("perror", "Errno is CustomStringConvertible; print it") }

// MARK: <string.h> / <stddef.h>

public func memchr(_: Any...) -> Never { unimplemented("memchr", "use Collection.firstIndex(of:)") }
public func memcmp(_: Any...) -> Never { unimplemented("memcmp", "use == on Array/Data") }
public func memcpy(_: Any...) -> Never { unimplemented("memcpy", "use UnsafeMutableRawBufferPointer.copyMemory(from:)") }
public func memmove(_: Any...) -> Never { unimplemented("memmove", "use UnsafeMutableRawBufferPointer.copyMemory(from:)") }
public func memset(_: Any...) -> Never { unimplemented("memset", "use initializeMemory(as:repeating:)") }
public func strcat(_: Any...) -> Never { unimplemented("strcat", "use +") }
public func strchr(_: Any...) -> Never { unimplemented("strchr", "use String.firstIndex(of:)") }
public func strcmp(_: Any...) -> Never { unimplemented("strcmp", "use ==, <, >") }
public func strcpy(_: Any...) -> Never { unimplemented("strcpy", "use =") }
public func strcspn(_: Any...) -> Never { unimplemented("strcspn", "use String.prefix(while:)") }
public func strlen(_: Any...) -> Never { unimplemented("strlen", "use String.count or utf8.count") }
public func strncat(_: Any...) -> Never { unimplemented("strncat", "use + and prefix(_:)") }
public func strncmp(_: Any...) -> Never { unimplemented("strncmp", "use hasPrefix or compare prefixes") }
public func strncpy(_: Any...) -> Never { unimplemented("strncpy", "use = and prefix(_:)") }
public func strpbrk(_: Any...) -> Never { unimplemented("strpbrk", "use String.firstIndex(where:)") }
public func strrchr(_: Any...) -> Never { unimplemented("strrchr", "use String.lastIndex(of:)") }
public func strspn(_: Any...) -> Never { unimplemented("strspn", "use String.prefix(while:)") }
public func strstr(_: Any...) -> Never { unimplemented("strstr", "use String.range(of:)") }
public func strtok(_: Any...) -> Never { unimplemented("strtok", "use String.split(separator:)") }
public func offsetof(_: Any...) -> Never { unimplemented("offsetof", "use MemoryLayout.offset(of:)") }

// MARK: <setjmp.h>

public func setjmp(_: Any...) -> Never { unimplemented("setjmp", "use Swift error handling (throw/catch)") }
public func longjmp(_: Any...) -> Never { unimplemented("longjmp", "use Swift error handling (throw/catch)") }
public func sigsetjmp(_: Any...) -> Never { unimplemented("sigsetjmp", "use Swift error handling (throw/catch)") }
public func siglongjmp(_: Any...) -> Never { unimplemented("siglongjmp", "use Swift error handling (throw/catch)") }

// MARK: <unistd.h>

public func execl(_: Any...) -> Never { unimplemented("execl", "use posix_spawn or Foundation's Process") }
public func execle(_: Any...) -> Never { unimplemented("execle", "use posix_spawn or Foundation's Process") }
public func execlp(_: Any...) -> Never { unimplemented("execlp", "use posix_spawn or Foundation's Process") }
public func execv(_: Any...) -> Never { unimplemented("execv", "use posix_spawn or Foundation's Process") }
public func execve(_: Any...) -> Never { unimplemented("execve", "use posix_spawn or Foundation's Process") }
public func execvp(_: Any...) -> Never { unimplemented("execvp", "use posix_spawn or Foundation's Process") }
