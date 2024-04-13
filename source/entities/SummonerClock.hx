package entities;

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

	private var timer:Float = 0.0;
	private var animDur:Float = 0.05;
	private var inOut:Float = 0.0;
	private var animYOffset:Float = -20;
	private var originalY:Float = 0;

	public function new(x:Float, y:Float) {
		super(x, y);
		originalY = y;

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
		timer = 0.0;
		inOut = 1.0;
	}

	public function hide() {
		timer = animDur;
		inOut = -1.0;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if ((inOut >= 1.0 && timer < animDur) || (inOut <= -1.0 && timer > 0)) {
			timer += elapsed * inOut;
			if (timer > animDur) {
				timer = animDur;
				inOut = 0.0;
			} else if (timer < 0.0) {
				timer = 0.0;
				inOut = 0.0;
			}
		}
		var ratio = timer / animDur;
		y = originalY + (animYOffset * ratio);
		color.alpha = Std.int(255.0 * ratio);
	}
}
