package entities;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import entities.statuseffect.HasteStatusEffect;
import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.FlxG;
import entities.statemachine.DefaultPlayerState;
import elements.Element;
import flixel.FlxSprite;

import input.InputCalcuator;
import input.SimpleController;
import loaders.Aseprite;
import loaders.AsepriteMacros;

class SummonerClock extends FlxSprite {
	public static var anims = AsepriteMacros.tagNames("assets/aseprite/characters/player.json");
	public static var layers = AsepriteMacros.layerNames("assets/aseprite/characters/player.json");
	public static var eventData = AsepriteMacros.frameUserData("assets/aseprite/characters/player.json", "Layer 1");

	public var primary:Element = Element.None;
	public var secondary:Element = Element.None;

	private var animDur:Float = 0.15;
	private var animYOffset:Float = -10;
	private var originalY:Float = 0;
	private var tween:FlxTween;
	private var colorTween:FlxTween;

	public function new(x:Float, y:Float) {
		super(x, y);
		originalY = y;
		y = originalY - animYOffset;
		alpha = 0;

		// This call can be used once https://github.com/HaxeFlixel/flixel/pull/2860 is merged
		// FlxAsepriteUtil.loadAseAtlasAndTags(this, AssetPaths.player__png, AssetPaths.player__json);
		Aseprite.loadAllAnimations(this, AssetPaths.player__json);
		animation.play(anims.right);
		animation.callback = (anim, frame, index) -> {
			if (eventData.exists(index)) {
				trace('frame $index has data ${eventData.get(index)}');
			}
		};
		FlxG.watch.add(this, "timer");
	}

	public function show() {
		if (tween != null) {
			tween.cancel();
		}
		if (colorTween != null) {
			colorTween.cancel();
		}
		tween = FlxTween.tween(this, {y: originalY}, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn});
		function tweenFunction(s:FlxSprite, v:Float) {
			s.alpha = v;
		}
		colorTween = FlxTween.num(0, 1, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));
	}

	public function hide() {
		if (tween != null) {
			tween.cancel();
		}
		if (colorTween != null) {
			colorTween.cancel();
		}
		tween = FlxTween.tween(this, {y: originalY-animYOffset}, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn});
		function tweenFunction(s:FlxSprite, v:Float) {
			s.alpha = v;
		}
		colorTween = FlxTween.num(1, 0, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
