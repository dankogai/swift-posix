# Deliberately unimplemented

Perl's POSIX module leaves the C-specific functions unimplemented and
croaks with advice ("C-specific: use eval {} instead").  This module
keeps that interface parity: the functions **exist** — so POSIX-shaped
code compiles and the intent is discoverable — but calling one halts
with `fatalError` and a pointer at the swifty way:

```swift
POSIX.strlen("hello")
// Fatal error: POSIX.strlen() is C-specific and unimplemented:
//              use String.count or utf8.count
```

| group | functions | use instead |
|---|---|---|
| memory | `malloc calloc realloc free` | `UnsafeMutablePointer.allocate` / `deallocate` |
| conversion | `atof atoi atol` | `Double(_:)`, `Int(_:)`, or [`strtod`/`strtol`](Stdlib.md) |
| algorithms | `qsort bsearch` | `sorted(by:)`, `firstIndex(where:)` |
| randomness | `rand srand` | `Int.random(in:)`, `RandomNumberGenerator` |
| integer division | `div ldiv labs` | `quotientAndRemainder(dividingBy:)`, `abs` |
| exit hooks | `atexit` | your own shutdown hook |
| stream I/O | `fopen fclose fdopen freopen fflush feof ferror clearerr fileno setbuf setvbuf tmpfile tmpnam` | file descriptors: [`open`](Fcntl.md), [`close`](Unistd.md), [`mkstemp`](Stdio.md) |
| stream reading | `fread fgets fgetc getc getchar gets fscanf scanf sscanf ungetc fgetpos fseek fsetpos ftell` | [`read`](Unistd.md), [`lseek`](Unistd.md), `Swift.readLine` |
| stream writing | `fwrite fputs fputc putc putchar puts printf fprintf sprintf vprintf vfprintf vsprintf perror` | [`write`](Unistd.md), `Swift.print`, string interpolation |
| byte shuffling | `memchr memcmp memcpy memmove memset` | `UnsafeRawBufferPointer` APIs, `==` |
| C strings | `strlen strcpy strncpy strcat strncat strcmp strncmp strchr strrchr strstr strtok strspn strcspn strpbrk` | `String` and `Collection` APIs |
| non-local exits | `setjmp longjmp sigsetjmp siglongjmp` | `throw` / `catch` |
| exec family | `execl execle execlp execv execve execvp` | `posix_spawn`, Foundation's `Process` |
| offsets | `offsetof` | `MemoryLayout.offset(of:)` |

Each takes `(_: Any...)`, so any C-shaped call compiles — and each
returns `Never`, so the compiler knows nothing follows.

## Testing note

These are verified by swift-testing *exit tests*: the suite spawns a
child process and asserts that it dies.
