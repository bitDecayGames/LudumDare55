package entities;

import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import elements.DamageTracker;
import elements.Resistances;
import entities.statuseffect.StatusEffects;
import entities.statemachine.BaseState;
import entities.statemachine.StateMachine;
import entities.statuseffect.BaseStatusEffect;
import elements.Element;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

import loaders.Aseprite;
import loaders.AsepriteMacros;

class BaseEntity extends CenterableEntity {
	public static var anims = AsepriteMacros.tagNames("assets/aseprite/characters/player.json");
	public static var layers = AsepriteMacros.layerNames("assets/aseprite/characters/player.json");
	public static var eventData = AsepriteMacros.frameUserData("assets/aseprite/characters/player.json", "Layer 1");
	public static var sturdinessScalar = 0.2;

	public var id:Int = -1;

	public var maxHealth:Float = 100;
	public var speed:Float = 100;
	public var maxSpeed:Float = 100;
	public var naturalSpeed:Float = 100;
	public var turnSpeed:Float = 1;
	public var maxTurnSpeed:Float = 1;
	public var naturalTurnSpeed:Float = 1;
	public var facingDegrees:Float = 0;
	public var facingTarget:Float = 0;
	public var target:FlxPoint = null;
	public var targetEntity:BaseEntity = null;
	public var canMove:Bool = true;
	public var canAttack:Bool = true;
	public var canTarget:Bool = true;
	public var canBeTargeted:Bool = true;
	public var canBeAttacked:Bool = true;
	public var canBeDamaged:Bool = true;
	public var friction:Float = .9;
	public var sturdiness:Float = 1.0;
	public var z:Float = 0.0;
	private var zRandomStart:Int;
	public var rnd:FlxRandom;


	public var stateMachine: StateMachine<BaseEntity>;
	public var effects: StatusEffects;
	public var resistance:Resistances;
	public var damage:DamageTracker;

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
		super(X, Y, SimpleGraphic);
		id = EntityIdManager.instance.get();
		effects = new StatusEffects(this);
		stateMachine = new StateMachine(this);
		resistance = new Resistances();
		damage = new DamageTracker();
		velocity = FlxPoint.get();
		health = maxHealth;
		rnd = new FlxRandom();
		zRandomStart = rnd.int(0, 1000);
	}

	override public function update(delta:Float) {
		super.update(delta);
		stateMachine.update(delta);
		effects.update(delta);
		damage.update(delta);

		// Turning
		facingDegrees += getFacingDifference() * turnSpeed * delta;
		facingDegrees %= 360;

		// Movement
		maxVelocity.set(maxSpeed, maxSpeed);
		if (speed > maxSpeed) {
			speed = maxSpeed;
		} else if (speed < 0) {
			speed = 0;
		} else {
			speed += (naturalSpeed - speed) * 0.1; 
		}
		drag.set(friction, friction);

		// Movement Animation
		if (velocity.length > 0) {
			var sin = Math.sin((FlxG.game.ticks + zRandomStart) * 0.02);
			z = sin * 3;
			offset.set(0, z);
			sin = Math.sin((FlxG.game.ticks + zRandomStart) * 0.01);
			angle = sin * 10;
		} else {
			z = 0;
			offset.set(0, z);
			angle = 0;
		}

	}

	private function getFacingDifference():Float {
		var diff = facingTarget - facingDegrees;
		if (diff > 180 || diff < -180) {
			diff = (facingTarget + 360) - facingDegrees;
			if (diff > 180 || diff < -180) {
				diff = (facingTarget - 360) - facingDegrees;
			}
		}
		return diff;
	}

	public function setFacingTarget(p:FlxPoint) {
		facingTarget = p.degreesTo(FlxPoint.get(x, y));
	}

	public function move(dir:FlxPoint) {
		if (dir.length > 1.0) {
			dir.normalize();
		}
		velocity.set(dir.x*speed, dir.y*speed);
	}
}
