package entities.attacks;

import flixel.math.FlxRandom;
import flixel.group.FlxSpriteGroup;
import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class BaseAttack {
	public var group:FlxSpriteGroup;
	public var damageType:Element = Element.None;
	public var potency:Float = 1.0;
	public var ready:Bool = true;
	public var attackOrigin:FlxPoint;
	public var attackDirection:FlxPoint;
	public var chargeTime:Float = 0.01;
	private var _chargeTime:Float = 0.0;
	public var cooldown:Float = 1.0;
	private var _cooldown:Float = 0.0;
	public var started:Bool = false;
	public var rnd:FlxRandom;

	public function new(group:FlxSpriteGroup, potency:Float, damageType:Element, cooldown:Float, chargeTime:Float = 0.01) {
		this.group = group;
		this.potency = potency;
		this.damageType = damageType;
		this.cooldown = cooldown;
		this.chargeTime = chargeTime;
		attackOrigin = FlxPoint.get();
		attackDirection = FlxPoint.get();
		rnd = new FlxRandom();
	}

	public function trigger(x:Float, y:Float, direction:FlxPoint) {
		if (ready) {
			attackOrigin = FlxPoint.get(x, y);
			this.attackDirection = direction;
			_chargeTime = chargeTime;
			ready = false;
		}
	}

	private function start() {
		started = true;
	}

	public function stop() {
		started = false;
		if (_chargeTime <= 0) {
			_cooldown = cooldown;
		} else {
			// they canceled during charging, don't make them wait for cooldown again
			_cooldown = 0;
			ready = true;
		}
	}

	public function update(elapsed:Float) {
		if (_cooldown > 0) {
			_cooldown -= elapsed;
			if (_cooldown <= 0) {
				ready = true;
			}
		}
		if (_chargeTime > 0) {
			_chargeTime -= elapsed;
			if (_chargeTime <= 0) {
				start();
			}
		}
	}
}
