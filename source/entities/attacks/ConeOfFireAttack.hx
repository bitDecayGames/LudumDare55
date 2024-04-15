package entities.attacks;

import entities.attacks.projectiles.FireProjectile;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class ConeOfFireAttack extends SingleAttack {
	public static var SPEED = 200.0;
	public static var COOLDOWN = 0.1;
	public static var POTENCY = 10.0;
	public static var LIFESPAN = 0.5;
	public static var HITS = 2;

	public function new(group:FlxSpriteGroup) {
		super(group, POTENCY, Element.Fire, COOLDOWN);
	}

	override function start() {
		super.start();

		group.add(new FireProjectile(group, attackOrigin.x, attackOrigin.y, FlxPoint.get(attackDirection.x * SPEED, attackDirection.y * SPEED)));
	}

}
