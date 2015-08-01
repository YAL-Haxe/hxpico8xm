package;
import Pico.*;
class Main {
	/// Returns whether the given point contains nothing "solid"
	/// (tiles are marked as "solid" using the sprite editor flags)
	public static function pointFree(x:Fixed, y:Fixed):Bool {
		return !fget(mget(x / 8, y / 8), 0);
	}
	static inline function main() {
		// There's now a bit more to the player behavior, so it've been made
		// into a class. Check it out:
		var player = new Player();
		onUpdate = function() {
			player.update();
		};
		onDraw = function() {
			cls();
			// clear the screen with a blue color:
			rectfill(0, 0, 127, 127, clDarkBlue);
			// draw the tiles:
			map(0, 0, 0, 0, 16, 16);
			// draw the player:
			player.draw();
		}
	}
}