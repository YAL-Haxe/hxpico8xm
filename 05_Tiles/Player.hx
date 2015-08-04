package;
import Pico.*;
import Main.pointFree;
/**
 * Player class. Since there's only one player instance, it's more reasonable
 * to keep it's fields static.
 * @author YellowAfterlife
 */
@:publicFields
class Player {
	static var x:Fixed = 64;
	static var y:Fixed = 64;
	static var flip:Bool = true;
	static var frame:Fixed = 0;
	/// vertical speed (pixels per step)
	static var vspeed:Fixed = 0;
	
	/// Returns whether the player can move to the given new coordinates.
	static function canMoveTo(nx:Fixed, ny:Fixed) {
		// check if all 4 corners of player's hitbox are free
		var sizeX = 2.5;
		var sizeY = 3.5;
		return pointFree(nx - sizeX, ny - sizeY)
			&& pointFree(nx + sizeX, ny - sizeY)
			&& pointFree(nx - sizeX, ny + sizeY)
			&& pointFree(nx + sizeX, ny + sizeY);
	}
	
	/// Returns whether the player is standing on ground.
	static function isOnGround() {
		return !canMoveTo(x, y + 1);
	}
	
	/// Tries to move the player by the given offset. Returns if successful.
	static function move(dx:Fixed, dy:Fixed) {
		if (canMoveTo(x + dx, y + dy)) {
			x += dx;
			y += dy;
			return true;
		} else return false;
	}
	
	static function update() {
		// handle jumping:
		if (isOnGround()) {
			if (btnp(btA)) vspeed = -3;
		} else vspeed += 0.333;
		
		// horizontal movement:
		var dx = 0;
		if (btn(btLeft)) dx -= 1;
		if (btn(btRight)) dx += 1;
		if (dx != 0) {
			flip = dx > 0;
			// (just try moving the player twice in given direction)
			for (i in 0 ... 2) {
				if (!move(dx, 0)) {
					dx = 0; // used as indication to stop walking animation
				}
			}
		}
		
		// decide on the next animation frame:
		if (!isOnGround()) {
			// jumping/falling
			frame = 4;
		} else if (frame >= 5) {
			// display the landing frame for few steps, revert to normal after:
			frame += 0.1;
			if (frame % 1 >= 0.2) frame = 0;
		} else if (dx != 0) {
			// walk animation:
			frame = (frame + 0.2) % 4;
		} else frame = 0; // standing
		
		// vertical movement:
		var dy = sign(vspeed);
		for (i in loop(1, abs(vspeed))) {
			if (!move(0, dy)) {
				// override with landing/ceiling hit frame:
				frame = vspeed < 0 ? 6 : 5;
				// reset vertical speed:
				vspeed = 0;
				break;
			}
		}
	}
	
	static inline function draw() {
		// nothing new, except some centering
		spr(frame, x - 4, y - 4, 1, 1, flip);
	}
}