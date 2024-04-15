package entities.attacks.projectiles;

import entities.attacks.FireTornadoAttack.FireTornadoAttack;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireProjectile extends Projectile {

	public function new(group:FlxSpriteGroup, x:Float, y:Float, velocity:FlxPoint) {
		super(group, x, y, velocity, FireTornadoAttack.POTENCY, Element.Fire, ConeOfFireAttack.HITS, ConeOfFireAttack.LIFESPAN);
		loadGraphic(AssetPaths.fire__png);
	}
}
