package;
import Pico.*;
class Input {
	static inline function main() {
		var player = {
			x: 60,
			y: 60,
			flip: true,
			frame: 0.
		};
		onUpdate = function() {
			// find delta x/y from key states:
			var dx = 0;
			if (btn(btLeft)) dx -= 1;
			if (btn(btRight)) dx += 1;
			var dy = 0;
			if (btn(btUp)) dy -= 1;
			if (btn(btDown)) dy += 1;
			// moving anywhere?
			if (dx != 0 || dy != 0) {
				// flip the sprite depending on horizontal direction:
				if (dx != 0) player.flip = dx > 0;
				// actual movement:
				player.x += dx;
				player.y += dy;
				// animation:
				player.frame = (player.frame + 0.2) % 4;
			} else player.frame = 0;
		};
		onDraw = function() {
			cls();
			// draw the player' graphic:
			spr(player.frame, player.x, player.y, 1, 1, player.flip);
		}
	}
}