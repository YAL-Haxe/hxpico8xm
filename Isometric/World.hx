@:publicFields
class World {
	static var emap:Map<Int, Map<Int, Entity>> = new Map();
	static function eget(x:Int, y:Int):Entity {
		var xmap = emap[y];
		return xmap != null ? xmap[x] : null;
	}
	static function eset(x:Int, y:Int, e:Entity) {
		var xmap = emap[y];
		if (xmap == null) {
			xmap = new Map();
			emap[y] = xmap;
		} else if (xmap[y] != null) {
			return false;
		}
		xmap[y] = e;
		return true;
	}
	/// Returns tile index at XY
	static function tget(x:Int, y:Int) {
		return Pico.mget(x * 2, y);
	}
	/// Returns altitude at XY
	static function zget(x:Int, y:Int) {
		return Pico.mget(x * 2 + 1, y);
	}
}