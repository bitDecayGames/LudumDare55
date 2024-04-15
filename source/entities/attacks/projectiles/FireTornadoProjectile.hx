package entities.attacks.projectiles;

import entities.attacks.FireTornadoAttack.FireTornadoAttack;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireTornadoProjectile extends Projectile {

	public function new(group:FlxSpriteGroup, x:Float, y:Float, velocity:FlxPoint) {
		super(group, x, y, velocity, FireTornadoAttack.POTENCY, Element.Fire, FireTornadoAttack.HITS, FireTornadoAttack.LIFESPAN);
		loadGraphic(AssetPaths.firetornado__png);
		rotateTowardsDirection = false;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		angle += elapsed * 260;
	}
}
