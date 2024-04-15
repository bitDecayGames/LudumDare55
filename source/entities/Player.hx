package entities;

import shaders.OutlineShader;
import flixel.group.FlxSpriteGroup;
import entities.attacks.AttackPicker;
import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.FlxG;
import entities.statemachine.DefaultPlayerState;
import entities.attacks.BaseAttack;

import loaders.Aseprite;
import loaders.AsepriteMacros;

class Player extends BaseEntity {

	public var playerNum = 0;
	public var clock:SummonerClock;
	public var attacks:AttackPicker;
	public var currentAttack:BaseAttack;

	public function new(X:Float, Y:Float, clock:SummonerClock, projectileGroup: FlxSpriteGroup) {
		// needs to be before super call to set health properly
		maxHealth = 100;

		super(X, Y);
		loadGraphic(AssetPaths.guy__png);

		speed = 2000;
		maxSpeed = speed*2;
		naturalSpeed = speed;
		turnSpeed = 10;
		friction = 1000;

		this.clock = clock;

		attacks = new AttackPicker(projectileGroup);

		stateMachine.switchTo(cast new DefaultPlayerState(this));

		FlxG.debugger.addTrackerProfile(new TrackerProfile(Player, ["x", "y", "speed", "velocity", "effects", "stateMachine", "facingDegrees"]));
		FlxG.debugger.track(this, "Player");

	}

	override function update(delta:Float) {
		super.update(delta);
		attacks.update(delta);
	}
}
