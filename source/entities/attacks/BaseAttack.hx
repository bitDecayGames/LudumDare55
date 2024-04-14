package entities.attacks;

import flixel.group.FlxSpriteGroup;
import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class BaseAttack extends FlxSprite {
	public var group:FlxSpriteGroup;
	public var damageType:Element = Element.None;
	public var potency:Float = 1.0;
	public var ready:Bool = true;
	public var attackOrigin:FlxPoint;
	public var attackDirection:FlxPoint;
	public var cooldown:Float = 1.0;
	private var _cooldown:Float = 0.0;

	public function new(group:FlxSpriteGroup, potency:Float, damageType:Element, cooldown:Float) {
		super(x, y);
		this.group = group;
		this.potency = potency;
		this.damageType = damageType;
		this.cooldown = cooldown;
	}

	public function trigger(x:Float, y:Float, direction:FlxPoint) {
		if (ready) {
			attackOrigin = FlxPoint.get(x, y);
			this.attackDirection = direction;
			start();
		}
	}

	private function start() {
	}

	public function stop() {
		_cooldown = cooldown;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (_cooldown > 0) {
			_cooldown -= elapsed;
			if (_cooldown <= 0) {
				ready = true;
			}
		}
	}
}
