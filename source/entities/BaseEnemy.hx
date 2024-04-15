package entities;

import entities.statemachine.DefaultEnemyState;
import shaders.OutlineShader;
import flixel.group.FlxSpriteGroup;
import entities.attacks.AttackPicker;
import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.FlxG;
import entities.statemachine.DefaultPlayerState;
import entities.attacks.BaseAttack;

import loaders.Aseprite;
import loaders.AsepriteMacros;

class BaseEnemy extends BaseEntity {

	public var currentAttack:BaseAttack;
	public var player:Player;

	public function new(X:Float, Y:Float, health:Float, player:Player, projectileGroup: FlxSpriteGroup) {
		maxHealth = health;

		super(X, Y);

		speed = 500;
		maxSpeed = speed*2;
		naturalSpeed = speed;
		turnSpeed = 10;
		friction = 1000;


		FlxG.debugger.addTrackerProfile(new TrackerProfile(BaseEnemy, ["x", "y", "speed", "velocity", "effects", "stateMachine", "facingDegrees"]));
		FlxG.debugger.track(this, "Enemy");
	}
}
