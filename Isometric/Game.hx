import Pico.*;
/**
 * This is an experiment with a isometric renderer and related mechanics.
 * It's not exactly optimized but is interesting nevertheless.
 */
@:publicFields
class Game {
	static var player:Player;
	static function draw() {
		cls();
		rectfill(0, 0, 127, 127, clDarkBlue);
		// draw the borders on top:
		line(5, 63, 63, 34, clWhite);
		line(64, 34, 122, 63, clWhite);
		// draw the visible map section:
		for (y in iloop(-3, 3))
		for (x in iloop( -3, 3)) {
			var wx = player.x + x;
			var wy = player.y + y;
			var t = World.tget(wx, wy);
			if (t == 0) t = 64;
			var z = World.zget(wx, wy);
			// draw the tile:
			var dx = 56 + (x - y) * 8;
			var dy = 61 + (x + y) * 4 - z;
			// (1 + (z / 8) is to draw "just enough" of the tile)
			spr(t, dx, dy, 2, 1 + z / 8);
			// draw entity on top of it (if any):
			var e = World.eget(wx, wy);
			if (e != null) e.draw(dx + 8, dy + 4);
		}
		// cover the visible bits of tiles on the bottom:
		for (k in loop(0, 2, 2)) {
			line(5, 64 + k, 64, 93 + k, clDarkBlue);
			line(63, 93 + k, 122, 64 + k, clDarkBlue);
		}
		// draw the bottom' borders:
		line(3, 64, 64, 94, clWhite);
		line(63, 94, 124, 64, clWhite);
	}
	static inline function main() {
		player = new Player();
		player.moveTo(3, 3);
		// NPC for a test:
		new NPC(112, "hey listen!\ndo you like _v_i_d_e_o_g_a_m_e_s_?").moveTo(5, 4);
		onUpdate = function() {
			player.update();
		};
		onDraw = draw;
	}
}