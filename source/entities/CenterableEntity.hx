package entities;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import shaders.OutlineShader;

class CenterableEntity extends FlxSprite {

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
	}

	override function graphicLoaded() {
		super.graphicLoaded();
		x -= width * .5;
		y -= height * .5;
		shader = new OutlineShader();
	}

	public function center():FlxPoint {
		return FlxPoint.get(x + width * .5, y + height * .5);
	}
	
	public function setCenter(x:Float, y:Float) {
		return FlxPoint.get(x - width * .5, y - height * .5);
	}
}
