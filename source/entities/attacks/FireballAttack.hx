package entities.attacks;

import entities.attacks.projectiles.FireballProjectile;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireballAttack extends SingleAttack {
	public static var SPEED = 150.0;
	public static var COOLDOWN = 2.0;
	public static var POTENCY = 30.0;
	public static var RADIUS = 30.0;
	public static var LIFESPAN = 1.5;

	public function new(group:FlxSpriteGroup) {
		super(group, POTENCY, Element.Fire, COOLDOWN);
	}

	override function start() {
		super.start();

		group.add(new FireballProjectile(group, attackOrigin.x, attackOrigin.y, FlxPoint.get(attackDirection.x * SPEED, attackDirection.y * SPEED)));
	}
}
