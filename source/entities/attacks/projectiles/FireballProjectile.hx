package entities.attacks.projectiles;

import entities.attacks.blasts.FireballBlast;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireballProjectile extends Projectile {

	public function new(group:FlxSpriteGroup, x:Float, y:Float, velocity:FlxPoint) {
		super(group, x, y, velocity, FireballAttack.POTENCY, Element.Fire, 1, FireballAttack.LIFESPAN);
	}

	override function hit(entity:BaseEntity) {
		kill();
	}

	override function kill() {
		super.kill();
		group.add(new FireballBlast(x, y, FireballAttack.RADIUS, potency));
	}
}
