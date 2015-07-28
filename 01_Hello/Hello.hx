package;
import Pico.*;
class Hello {
	static inline function main() {
		// clear the screen:
		cls();
		// display a snippet of text:
		trace("hello!");
		// or, alternatively (will not print filename:linenumber):
		print("hello!");
	}
}