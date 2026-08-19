/// Unimplemented.swift — the C-specific functions that POSIX.pm leaves
/// unimplemented, forwarded into the `POSIX` namespace for parity.
/// Each halts with advice pointing at the swifty way.

import POSIXGlobals

extension POSIX {
    // <stdlib.h>
    public static func atexit(_: Any...) -> Never { POSIXGlobals.atexit() }
    public static func atof(_: Any...) -> Never { POSIXGlobals.atof() }
    public static func atoi(_: Any...) -> Never { POSIXGlobals.atoi() }
    public static func atol(_: Any...) -> Never { POSIXGlobals.atol() }
    public static func bsearch(_: Any...) -> Never { POSIXGlobals.bsearch() }
    public static func calloc(_: Any...) -> Never { POSIXGlobals.calloc() }
    public static func div(_: Any...) -> Never { POSIXGlobals.div() }
    public static func labs(_: Any...) -> Never { POSIXGlobals.labs() }
    public static func ldiv(_: Any...) -> Never { POSIXGlobals.ldiv() }
    public static func malloc(_: Any...) -> Never { POSIXGlobals.malloc() }
    public static func free(_: Any...) -> Never { POSIXGlobals.free() }
    public static func realloc(_: Any...) -> Never { POSIXGlobals.realloc() }
    public static func qsort(_: Any...) -> Never { POSIXGlobals.qsort() }
    public static func rand(_: Any...) -> Never { POSIXGlobals.rand() }
    public static func srand(_: Any...) -> Never { POSIXGlobals.srand() }
    // <stdio.h>
    public static func clearerr(_: Any...) -> Never { POSIXGlobals.clearerr() }
    public static func fclose(_: Any...) -> Never { POSIXGlobals.fclose() }
    public static func fdopen(_: Any...) -> Never { POSIXGlobals.fdopen() }
    public static func feof(_: Any...) -> Never { POSIXGlobals.feof() }
    public static func ferror(_: Any...) -> Never { POSIXGlobals.ferror() }
    public static func fflush(_: Any...) -> Never { POSIXGlobals.fflush() }
    public static func fgetc(_: Any...) -> Never { POSIXGlobals.fgetc() }
    public static func fgetpos(_: Any...) -> Never { POSIXGlobals.fgetpos() }
    public static func fgets(_: Any...) -> Never { POSIXGlobals.fgets() }
    public static func fileno(_: Any...) -> Never { POSIXGlobals.fileno() }
    public static func fopen(_: Any...) -> Never { POSIXGlobals.fopen() }
    public static func fprintf(_: Any...) -> Never { POSIXGlobals.fprintf() }
    public static func fputc(_: Any...) -> Never { POSIXGlobals.fputc() }
    public static func fputs(_: Any...) -> Never { POSIXGlobals.fputs() }
    public static func fread(_: Any...) -> Never { POSIXGlobals.fread() }
    public static func freopen(_: Any...) -> Never { POSIXGlobals.freopen() }
    public static func fscanf(_: Any...) -> Never { POSIXGlobals.fscanf() }
    public static func fseek(_: Any...) -> Never { POSIXGlobals.fseek() }
    public static func fsetpos(_: Any...) -> Never { POSIXGlobals.fsetpos() }
    public static func ftell(_: Any...) -> Never { POSIXGlobals.ftell() }
    public static func fwrite(_: Any...) -> Never { POSIXGlobals.fwrite() }
    public static func getc(_: Any...) -> Never { POSIXGlobals.getc() }
    public static func getchar(_: Any...) -> Never { POSIXGlobals.getchar() }
    public static func gets(_: Any...) -> Never { POSIXGlobals.gets() }
    public static func printf(_: Any...) -> Never { POSIXGlobals.printf() }
    public static func putc(_: Any...) -> Never { POSIXGlobals.putc() }
    public static func putchar(_: Any...) -> Never { POSIXGlobals.putchar() }
    public static func puts(_: Any...) -> Never { POSIXGlobals.puts() }
    public static func scanf(_: Any...) -> Never { POSIXGlobals.scanf() }
    public static func setbuf(_: Any...) -> Never { POSIXGlobals.setbuf() }
    public static func setvbuf(_: Any...) -> Never { POSIXGlobals.setvbuf() }
    public static func sprintf(_: Any...) -> Never { POSIXGlobals.sprintf() }
    public static func sscanf(_: Any...) -> Never { POSIXGlobals.sscanf() }
    public static func tmpfile(_: Any...) -> Never { POSIXGlobals.tmpfile() }
    public static func tmpnam(_: Any...) -> Never { POSIXGlobals.tmpnam() }
    public static func ungetc(_: Any...) -> Never { POSIXGlobals.ungetc() }
    public static func vfprintf(_: Any...) -> Never { POSIXGlobals.vfprintf() }
    public static func vprintf(_: Any...) -> Never { POSIXGlobals.vprintf() }
    public static func vsprintf(_: Any...) -> Never { POSIXGlobals.vsprintf() }
    public static func perror(_: Any...) -> Never { POSIXGlobals.perror() }
    // <string.h> / <stddef.h>
    public static func memchr(_: Any...) -> Never { POSIXGlobals.memchr() }
    public static func memcmp(_: Any...) -> Never { POSIXGlobals.memcmp() }
    public static func memcpy(_: Any...) -> Never { POSIXGlobals.memcpy() }
    public static func memmove(_: Any...) -> Never { POSIXGlobals.memmove() }
    public static func memset(_: Any...) -> Never { POSIXGlobals.memset() }
    public static func strcat(_: Any...) -> Never { POSIXGlobals.strcat() }
    public static func strchr(_: Any...) -> Never { POSIXGlobals.strchr() }
    public static func strcmp(_: Any...) -> Never { POSIXGlobals.strcmp() }
    public static func strcpy(_: Any...) -> Never { POSIXGlobals.strcpy() }
    public static func strcspn(_: Any...) -> Never { POSIXGlobals.strcspn() }
    public static func strlen(_: Any...) -> Never { POSIXGlobals.strlen() }
    public static func strncat(_: Any...) -> Never { POSIXGlobals.strncat() }
    public static func strncmp(_: Any...) -> Never { POSIXGlobals.strncmp() }
    public static func strncpy(_: Any...) -> Never { POSIXGlobals.strncpy() }
    public static func strpbrk(_: Any...) -> Never { POSIXGlobals.strpbrk() }
    public static func strrchr(_: Any...) -> Never { POSIXGlobals.strrchr() }
    public static func strspn(_: Any...) -> Never { POSIXGlobals.strspn() }
    public static func strstr(_: Any...) -> Never { POSIXGlobals.strstr() }
    public static func strtok(_: Any...) -> Never { POSIXGlobals.strtok() }
    public static func offsetof(_: Any...) -> Never { POSIXGlobals.offsetof() }
    // <setjmp.h>
    public static func setjmp(_: Any...) -> Never { POSIXGlobals.setjmp() }
    public static func longjmp(_: Any...) -> Never { POSIXGlobals.longjmp() }
    public static func sigsetjmp(_: Any...) -> Never { POSIXGlobals.sigsetjmp() }
    public static func siglongjmp(_: Any...) -> Never { POSIXGlobals.siglongjmp() }
    // <unistd.h>
    public static func execl(_: Any...) -> Never { POSIXGlobals.execl() }
    public static func execle(_: Any...) -> Never { POSIXGlobals.execle() }
    public static func execlp(_: Any...) -> Never { POSIXGlobals.execlp() }
    public static func execv(_: Any...) -> Never { POSIXGlobals.execv() }
    public static func execve(_: Any...) -> Never { POSIXGlobals.execve() }
    public static func execvp(_: Any...) -> Never { POSIXGlobals.execvp() }
}
