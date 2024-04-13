package entities;

import entities.statuseffect.StatusEffects;
import entities.statemachine.BaseState;
import entities.statemachine.StateMachine;
import entities.statuseffect.BaseStatusEffect;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

import loaders.Aseprite;
import loaders.AsepriteMacros;

class BaseEntity extends FlxSprite {
	public static var anims = AsepriteMacros.tagNames("assets/aseprite/characters/player.json");
	public static var layers = AsepriteMacros.layerNames("assets/aseprite/characters/player.json");
	public static var eventData = AsepriteMacros.frameUserData("assets/aseprite/characters/player.json", "Layer 1");

	public var speed:Float = 1;
	public var maxSpeed:Float = 1;
	public var target:FlxPoint = null;
	public var targetEntity:BaseEntity = null;
	public var canMove:Bool = true;
	public var canAttack:Bool = true;
	public var canTarget:Bool = true;
	public var friction:Float = 1.0;

	public var stateMachine: StateMachine;
	public var effects: StatusEffects;

	public function new() {
		super();
		effects = new StatusEffects(this);
		stateMachine = new StateMachine(this);

		// need to call this from the child classes
		// init(AssetPaths.player__json);
	}

	private function init(data:String) {
		// This call can be used once https://github.com/HaxeFlixel/flixel/pull/2860 is merged
		// FlxAsepriteUtil.loadAseAtlasAndTags(this, AssetPaths.player__png, AssetPaths.player__json);
		Aseprite.loadAllAnimations(this, data);
		animation.play(anims.right);
		animation.callback = (anim, frame, index) -> {
			if (eventData.exists(index)) {
				trace('frame $index has data ${eventData.get(index)}');
			}
		};

	}

	override public function update(delta:Float) {
		super.update(delta);
		stateMachine.update(delta);
		effects.update(delta);
	}
}
