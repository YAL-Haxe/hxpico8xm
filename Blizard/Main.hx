package;
import Pico.*;
@:publicFields
class Main {
	static var currentColor = -1;
	static inline var totalColors = 4;
	static var darkColor;
	static var lightColor;
	static var darkColors = [
		clDarkBlue,
		clDarkPurple,
		clDarkGreen,
		clDarkGray,
	];
	static var lightColors = [
		clBlue,
		clPink,
		clGreen,
		clLightGray,
	];
	static var text = [
		null,
		"this is a lizard",
		"that once met a wizard",
		"and passes through solids akind",
		"perhaps all this story",
		"could be somewhat boring",
		"but it was a bit colorblind.",
		"as fruit-eating hopper",
		"and skilled wall-bop-er",
		"it's making it's way\nthrough just fine.",
		"but still can't stop thinking",
		"until the late evening",
		"if that fruit was yellow or lime.",
		// as there is no reason
		// why harvesting season
		// should start not\ntoday but sometime
	];
	static inline function _pal(c0:Int, c1:Int) {
		Pico.pal(c0, c1, 1);
	}
	static function recolor() {
		currentColor += 1 + flr(rand(totalColors - 1));
		currentColor %= totalColors;
		darkColor = darkColors[currentColor];
		lightColor = lightColors[currentColor];
		for (i in iloop(1, 4)) {
			_pal(i, lightColor);
			var c = Player.mode == i ? darkColor : lightColor;
			_pal(i + 8, c);
		}
		_pal(clDarkGray, darkColor);
		_pal(clIndigo, lightColor);
	}
	static var level;
	static var levelTime = 0;
	static function loadLevel(i:Int) {
		level = i;
		var sx = (i % 8) * 16;
		var sy = flr(i / 8) * 16;
		for (y in 0 ... 16)
		for (x in 0 ... 16) {
			mset(x, y, 0);
			var d = mget(sx + x, sy + y);
			switch (d) {
			case 2:
				Player.x = x * 8 + 4;
				Player.y = y * 8 + 4;
			default: mset(x, y, d);
			}
		}
		Player.mode = 1;
		levelTime = 0;
		recolor();
	}
	static inline function main() {
		loadLevel(1);
		onUpdate = function() {
			levelTime += 1;
			Player.update();
		};
		onDraw = function() {
			cls();
			// draw the tiles:
			map(0, 0, 0, 0, 16, 16);
			Light.apply(Player.x, Player.y, 12);
			Player.draw();
			map(0, 0, 0, 0, 16, 16, 128);
			print(sub(text[level], 1, levelTime / 2), 1, 1, clWhite);
		}
	}
}