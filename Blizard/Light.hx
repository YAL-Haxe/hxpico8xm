package;
import Pico.*;
/**
 * ...
 * @author YellowAfterlife
 */
@:publicFields
class Light {
	static var remap = [
		0,
		1+8,
		2+8,
		3+8,
		4+8,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15
	];
	static function apply(cx:Fixed, cy:Fixed, dx:Fixed) {
		var dy = 1;
		var re = 1 - dx;
		if (re >= 0) {
			dx -= 1;
			re += 2 * (dy - dx) + 1;
		} else re += 2 * dy + 1;
		var vx = dx, vy0 = dy, vy1 = dy;
		inline function proc(x:Fixed, y:Fixed) {
			pset(x, y, remap[pget(x, y)]);
		}
		while (dx > dy) {
			vy1 = dy;
			dy += 1;
			if (re >= 0) {
				dx -= 1;
				re += 2 * (dy - dx) + 1;
				//
				for (d in loop(-1, 1, 2)) {
					var p = cx - vx * d;
					for (i in loop(cy - vy1, cy + vy1)) proc(p, i);
					p = cy - vx * d;
					for (i in loop(cx - vy1, cx + vy1)) proc(i, p);
				}
				vx = dx;
				vy0 = dy;
			} else re += 2 * dy + 1;
		} // while (dx > dy)
		for (y in loop(cy - vx, cy + vx))
		for (x in loop(cx - vx, cx + vx)) {
			proc(x, y);
		}
	}
}