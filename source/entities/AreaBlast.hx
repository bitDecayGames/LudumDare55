package entities;

import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class AreaBlast extends CenterableEntity {
	public var damageType:Element = Element.None;
	public var potency:Float = 1.0;
	public var radius:Float = 1.0;
	public var lifespan:Float = 1.0;

	public function new(x:Float, y:Float, radius:Float, potency:Float, damageType:Element, lifespan:Float=1.0) {
		super(x, y);
		this.radius = radius;
		this.potency = potency;
		this.damageType = damageType;
		this.lifespan = lifespan;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		lifespan -= elapsed;
		if (lifespan < 0) {
			kill();
		}
	}

	public function hit(entities:List<BaseEntity>) {
		for (entity in entities) {
			new HitStatusEffect(entity, potency, damageType);
		}
		kill();
	}
}