package entities;

import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.FlxG;
import entities.statemachine.DefaultPlayerState;

import loaders.Aseprite;
import loaders.AsepriteMacros;

class Player extends BaseEntity {
	public static var anims = AsepriteMacros.tagNames("assets/aseprite/characters/player.json");
	public static var layers = AsepriteMacros.layerNames("assets/aseprite/characters/player.json");
	public static var eventData = AsepriteMacros.frameUserData("assets/aseprite/characters/player.json", "Layer 1");

	public var playerNum = 0;
	public var clock:SummonerClock;

	public function new(clock:SummonerClock) {
		// needs to be before super call to set health properly
		maxHealth = 100;

		super();

		maxSpeed = 100;
		speed = 100;

		this.clock = clock;

		// This call can be used once https://github.com/HaxeFlixel/flixel/pull/2860 is merged
		// FlxAsepriteUtil.loadAseAtlasAndTags(this, AssetPaths.player__png, AssetPaths.player__json);
		Aseprite.loadAllAnimations(this, AssetPaths.player__json);
		animation.play(anims.right);
		animation.callback = (anim, frame, index) -> {
			if (eventData.exists(index)) {
				trace('frame $index has data ${eventData.get(index)}');
			}
		};

		stateMachine.switchTo(cast new DefaultPlayerState(this));

		FlxG.debugger.addTrackerProfile(new TrackerProfile(Player, ["x", "y", "speed", "velocity", "effects", "stateMachine"]));
		FlxG.debugger.track(this, "Player");
	}
}
