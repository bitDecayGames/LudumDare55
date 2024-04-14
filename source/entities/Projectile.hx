package entities;

import flixel.group.FlxSpriteGroup;
import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class Projectile extends FlxSprite {
	public var group:FlxSpriteGroup;
	public var damageType:Element = Element.None;
	public var potency:Float = 1.0;
	public var hits:Int = 1;
	public var lifespan:Float = 2.0;

	public function new(group:FlxSpriteGroup, x:Float, y:Float, velocity:FlxPoint, potency:Float, damageType:Element, hits:Int = 1, lifespan:Float = 2.0) {
		super(x, y);
		this.group = group;
		this.velocity = FlxPoint.get(velocity.x, velocity.y);
		this.potency = potency;
		this.damageType = damageType;
		this.hits = hits;
		this.lifespan = lifespan;
	}

	public function hit(entity:BaseEntity) {
		new HitStatusEffect(entity, potency, damageType);
		hits--;
		if (hits <= 0) {
			kill();
		}
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		lifespan -= elapsed;
		if (lifespan < 0) {
			kill();
		}
	}
}
