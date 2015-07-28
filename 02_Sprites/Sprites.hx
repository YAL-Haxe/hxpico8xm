package;
import Pico.*;
class Sprites {
	static inline var num = 5;
	static inline function main() {
		// clear the screen:
		var t:Fixed = 0;
		onUpdate = function() {
			t += 0.1;
		};
		onDraw = function() {
			cls();
			// draw some lizards:
			for (i in 0 ... num) {
				// (centering):
				var x = i * 8 + (128 - num * 8) / 2;
				var y = (128 - 8) / 2;
				spr(flr(t + i) % 2, x, y);
			}
		}
	}
}