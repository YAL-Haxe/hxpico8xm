package;
import Pico.*;
class Main {
	/// Returns whether the given point contains nothing "solid"
	/// (tiles are marked as "solid" using the sprite editor flags)
	public static function pointFree(x:Fixed, y:Fixed):Bool {
		return !fget(mget(x / 8, y / 8), 0);
	}
	static inline function main() {
		onUpdate = function() {
			Player.update();
		};
		onDraw = function() {
			cls();
			// clear the screen with a blue color:
			rectfill(0, 0, 127, 127, clDarkBlue);
			// draw the tiles:
			map(0, 0, 0, 0, 16, 16);
			// draw the player:
			Player.draw();
		}
	}
}