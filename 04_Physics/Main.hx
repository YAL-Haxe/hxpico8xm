package;
import Pico.*;
class Main {
	static inline function main() {
		// There's now a bit more to the player behavior, so it've been made
		// into a class (Player)
		onUpdate = function() {
			Player.update();
		};
		onDraw = function() {
			cls();
			// clear the screen with a blue color:
			rectfill(0, 0, 127, 127, clDarkBlue);
			// draw a "ground" line:
			line(1, 68, 126, 68, clWhite);
			// draw the player:
			Player.draw();
		}
	}
}