package;
import Pico.*;
/**
 * Player class. If you woul 
 * @author YellowAfterlife
 */
@:publicFields
class Player {
	var x:Fixed = 64;
	var y:Fixed = 64;
	var flip:Bool = true;
	var frame:Fixed = 0;
	/// vertical speed (pixels per step)
	var vspeed:Fixed = 0;
	function new() {
		
	}
	
	/// Returns whether the player can move to the given new coordinates.
	function canMoveTo(nx:Fixed, ny:Fixed) {
		return nx >= 4 && nx <= 124 && ny <= 64;
	}
	
	/// Returns whether the player is standing on ground.
	function isOnGround() {
		return !canMoveTo(x, y + 1);
	}
	
	/// Tries to move the player by the given offset. Returns if successful.
	function move(dx:Fixed, dy:Fixed) {
		var nx = x + dx;
		var ny = y + dy;
		if (canMoveTo(nx, ny)) {
			x = nx;
			y = ny;
			return true;
		} else return false;
	}
	
	function update() {
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
		// (copying instance variable to local variables saves some tokens)
		var vspeed = this.vspeed;
		var frame = this.frame;
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
				this.vspeed = 0;
				break;
			}
		}
		
		// finally, assign the animation frame back to the instance:
		this.frame = frame;
	}
	
	inline function draw() {
		// nothing new, except some centering
		spr(frame, x - 4, y - 4, 1, 1, flip);
	}
}