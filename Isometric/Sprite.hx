@:publicFields
class Sprite extends Entity {
	var sprite:Int;
	var flip:Bool;
	function new(s:Int) {
		sprite = s;
	}
	override function draw(dx:Int, dy:Int):Void {
		Pico.spr(sprite, dx - 4, dy - 8, 1, 1, flip);
	}
}