package entities.attacks.projectiles;

import entities.attacks.blasts.FireballBlast;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireballProjectile extends Projectile {

	public function new(group:FlxSpriteGroup, x:Float, y:Float, velocity:FlxPoint) {
		super(group, x, y, velocity, FireballAttack.POTENCY, Element.Fire, 1, FireballAttack.LIFESPAN);
		loadGraphic(AssetPaths.fireball__png);
	}

	override function kill() {
		trace("fireball is dead, spawning blast");
		super.kill();
		var c = center();
		group.add(new FireballBlast(c.x, c.y, FireballAttack.RADIUS, potency));
	}
}
