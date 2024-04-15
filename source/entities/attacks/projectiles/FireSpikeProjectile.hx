package entities.attacks.projectiles;

import entities.attacks.blasts.FireballBlast;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireSpikeProjectile extends Projectile {

	public function new(group:FlxSpriteGroup, x:Float, y:Float, velocity:FlxPoint) {
		super(group, x, y, velocity, FireballAttack.POTENCY, Element.Fire, 5, FireballAttack.LIFESPAN);
		loadGraphic(AssetPaths.firespike__png);
	}
}