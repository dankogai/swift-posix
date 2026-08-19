/*:
 # swift-posix

 A thin but swifty POSIX layer, modeled after Perl's POSIX module:
 keep the C names and semantics, fix the types.

 > To run these pages: open the swift-posix package directory in Xcode,
 > build the **POSIX** scheme once (⌘B), then open this playground.

 ## Importing

 `import POSIX` brings exactly *one* name into scope — the `POSIX`
 namespace.  Nothing collides with Foundation or the C overlays:
 */
import POSIX

try POSIX.getcwd()
POSIX.tolower("Hello, POSIX!")
POSIX.M_PI
/*:
 ## Exporting on demand

 When you want the names at the top level (Perl's `use POSIX`),
 opt in with `POSIXGlobals`:
 */
import POSIXGlobals

try getcwd()                 // no prefix needed now
floor(3.7)
/*:
 Or cherry-pick single symbols, `@EXPORT_OK`-style, with Swift's
 scoped imports — try replacing the import above with:

     import func POSIXGlobals.floor
     import struct POSIXGlobals.Errno

 Both modules share the same underlying types, so the styles mix freely.

 [Next: Math](@next)
 */
