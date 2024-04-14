package entities;

import flixel.group.FlxSpriteGroup;
import entities.attacks.AttackPicker;
import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.FlxG;
import entities.statemachine.DefaultPlayerState;
import entities.attacks.BaseAttack;

import loaders.Aseprite;
import loaders.AsepriteMacros;

class Player extends BaseEntity {
	public static var anims = AsepriteMacros.tagNames("assets/aseprite/characters/player.json");
	public static var layers = AsepriteMacros.layerNames("assets/aseprite/characters/player.json");
	public static var eventData = AsepriteMacros.frameUserData("assets/aseprite/characters/player.json", "Layer 1");

	public var playerNum = 0;
	public var clock:SummonerClock;
	public var attacks:AttackPicker;
	public var currentAttack:BaseAttack;

	public function new(X:Float, Y:Float, clock:SummonerClock, projectileGroup: FlxSpriteGroup) {
		// needs to be before super call to set health properly
		maxHealth = 100;

		super(X, Y);

		speed = 1000;
		maxSpeed = speed*2;
		naturalSpeed = speed;
		turnSpeed = 10;
		friction = 1000;

		this.clock = clock;

		attacks = new AttackPicker(projectileGroup);

		// This call can be used once https://github.com/HaxeFlixel/flixel/pull/2860 is merged
		// FlxAsepriteUtil.loadAseAtlasAndTags(this, AssetPaths.player__png, AssetPaths.player__json);
		Aseprite.loadAllAnimations(this, AssetPaths.player__json);
		animation.play(anims.right);
		animation.callback = (anim, frame, index) -> {
			if (eventData.exists(index)) {
				// trace('frame $index has data ${eventData.get(index)}');
			}
		};

		stateMachine.switchTo(cast new DefaultPlayerState(this));

		FlxG.debugger.addTrackerProfile(new TrackerProfile(Player, ["x", "y", "speed", "velocity", "effects", "stateMachine", "facingDegrees"]));
		FlxG.debugger.track(this, "Player");
	}

	override function update(delta:Float) {
		super.update(delta);
		attacks.update(delta);
	}
}
