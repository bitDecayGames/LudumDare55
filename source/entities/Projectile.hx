package entities;

import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class Projectile extends FlxSprite {
	public var damageType:Element = Element.None;
	public var potency:Float = 1.0;
	public var hits:Int = 1;

	public function new(x:Float, y:Float, velocity:FlxPoint, potency:Float, damageType:Element, hits:Int = 1) {
		super(x, y);
		this.velocity = FlxPoint.get(velocity.x, velocity.y);
		this.potency = potency;
		this.damageType = damageType;
		this.hits = hits;
	}

	public function hit(entity:BaseEntity) {
		entity.effects.add(new HitStatusEffect(entity, potency, damageType));
		hits--;
		if (hits <= 0) {
			kill();
		}
	}
}
