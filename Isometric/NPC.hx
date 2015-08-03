import Pico.iloop;
class NPC extends Sprite {
	var text:String;
	function new(sprite:Int, text:String) {
		super(sprite);
		this.text = text;
	}
	override function interact():Void {
		flip = this.x - this.y < Game.player.x - Game.player.y;
		var s = text;
		var h = 7;
		for (i in iloop(1, s.length)) {
			if (s.lcharAt(i) == "\n") h += 6;
		}
		Game.draw();
		Pico.rectfill(0, 0, 127, h, Pico.clRed);
		var x = 2, y = 1;
		for (i in iloop(1, s.length)) {
			var c = s.lcharAt(i);
			var t = 2;
			if (c == "\n") {
				y += 6;
				x = 2;
				t = 5;
			} else if (c == "_") {
				t = 5;
			} else {
				if (c == ",") t = 5;
				else if (c == "." || c == "!") t = 7;
				Pico.print(c, x, y, Pico.clWhite);
				x += 4;
			}
			for (_ in iloop(1, t)) Pico.flip();
		}
		while (!Pico.btnp(Pico.btA)) Pico.flip();
	}
}