package entities;

import loaders.Aseprite;
import loaders.AsepriteMacros;
import flixel.FlxSprite;

class ClockGem extends CenterableEntity {
	public var glow:ClockGemGlow;
	public function new(x:Float, y:Float, glow:ClockGemGlow, assetPath:String) {
		color = glow.color;
		super(x, y, assetPath);
		this.glow = glow;
	}
}
