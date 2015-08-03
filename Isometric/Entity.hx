@:publicFields
class Entity {
	var x:Int;
	var y:Int;
	function moveTo(nx:Int, ny:Int):Bool {
		var xmap = World.emap[ny];
		if (xmap == null) {
			xmap = new Map();
			World.emap[ny] = xmap;
		} else if (xmap[nx] != null) {
			return false;
		}
		if (y != null) World.emap[y][x] = null;
		xmap[nx] = this;
		this.x = nx;
		this.y = ny;
		return true;
	}
	dynamic function draw(dx:Int, dy:Int):Void {
		
	}
	dynamic function interact():Void {
		
	}
}