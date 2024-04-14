package entities;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import loaders.Aseprite;
import loaders.AsepriteMacros;
import flixel.FlxSprite;

class ClockGemGlow extends FlxSprite {
	private var showTween:FlxTween;
	private var hideTween:FlxTween;
	private var animDur:Float = 0.2;
	public function new(x:Float, y:Float) {
		super(x, y, AssetPaths.gem_glow__png);
		alpha = 0.0;
	}

	public function show() {
		if (hideTween != null) {
			hideTween.cancel();
			hideTween = null;
		}
		if (showTween == null) {
			showTween = FlxTween.num(1, 0, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));
		}
	}
	
	public function hide() {
		if (showTween != null) {
			showTween.cancel();
			showTween = null;
		}
		if (hideTween == null) {
			hideTween = FlxTween.num(0, 1, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));
		}
	}

	function tweenFunction(s:FlxSprite, v:Float) {
		s.alpha = v;
	}
}
