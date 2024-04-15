package entities.attacks;

import entities.attacks.projectiles.FireProjectile;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class ConeOfFireAttack extends ContinuousAttack {
	public static var SPEED = 300.0;
	public static var COOLDOWN = 0.1;
	public static var POTENCY = 1.0;
	public static var LIFESPAN = 0.5;
	public static var HITS = 2;
	public static var RANDOM_SPEED = .8;
	public static var RANDOM_DIR = .3;

	public function new(group:FlxSpriteGroup) {
		super(group, POTENCY, Element.Fire, COOLDOWN);
	}

	override function spawn() {
		super.spawn();
		var speed = rnd.float(RANDOM_SPEED * SPEED, SPEED);
		var rndX = rnd.float()*RANDOM_DIR;
		var rndY = rnd.float()*RANDOM_DIR;
		group.add(new FireProjectile(group, attackOrigin.x, attackOrigin.y, FlxPoint.get((rndX + attackDirection.x) * speed, (rndY + attackDirection.y) * speed)));
	}

}
