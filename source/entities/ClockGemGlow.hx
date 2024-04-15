package entities;

import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import loaders.Aseprite;
import loaders.AsepriteMacros;
import flixel.FlxSprite;

class ClockGemGlow extends CenterableEntity {
	private var showTween:FlxTween;
	private var hideTween:FlxTween;
	private var animDur:Float = 0.2;
	public function new(x:Float, y:Float, color:FlxColor, assetPath:String) {
		super(x, y-10, AssetPaths.gem__png);
		alpha = 1.0;
		visible = true;
	}

	public function show() {
		if (hideTween != null) {
			hideTween.cancel();
			hideTween = null;
		}
		//showTween = FlxTween.num(1, 0, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));
	}
	
	public function hide() {
		if (showTween != null) {
			showTween.cancel();
			showTween = null;
		}
		//hideTween = FlxTween.num(0, 1, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));
	}

	function tweenFunction(s:FlxSprite, v:Float) {
		s.alpha = v;
	}
}
