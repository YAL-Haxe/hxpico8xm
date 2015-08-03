@:publicFields
class Player extends Sprite {
	var moveTimer:Int = 0;
	function new() {
		super(112);
	}
	function moveRel(dx:Int, dy:Int) {
		if (moveTimer > 0) return false;
		var cx = this.x;
		var cy = this.y;
		var nx = cx + dx;
		var ny = cy + dy;
		if(Pico.fget(World.tget(nx, ny), 0)
		|| World.zget(nx, ny) - World.zget(cx, cy) > 2) {
			return false;
		}
		this.flip = dx > 0 || dy < 0;
		var e = World.eget(nx, ny);
		if (e != null) {
			e.interact();
		} else {
			this.moveTo(nx, ny);
		}
		moveTimer = 6;
		return true;
	}
	@:extern inline function update():Void {
		if (moveTimer > 0) moveTimer -= 1;
		//
		if (Pico.btn(Pico.btLeft)) moveRel( -1, 0);
		if (Pico.btn(Pico.btRight)) moveRel(1, 0);
		if (Pico.btn(Pico.btUp)) moveRel(0, -1);
		if (Pico.btn(Pico.btDown)) moveRel(0, 1);
	}
}