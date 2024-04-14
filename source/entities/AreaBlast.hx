package entities;

import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class AreaBlast extends FlxSprite {
	public var damageType:Element = Element.None;
	public var potency:Float = 1.0;
	public var radius:Float = 1.0;

	public function new(x:Float, y:Float, radius:Float, potency:Float, damageType:Element) {
		super(x, y);
		this.radius = radius;
		this.potency = potency;
		this.damageType = damageType;
	}

	public function hit(entities:List<BaseEntity>) {
		for (entity in entities) {
			new HitStatusEffect(entity, potency, damageType);
		}
		kill();
	}
}