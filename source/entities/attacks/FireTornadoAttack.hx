package entities.attacks;

import entities.attacks.projectiles.FireTornadoProjectile;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireTornadoAttack extends SingleAttack {
	public static var SPEED = 100.0;
	public static var COOLDOWN = 2.0;
	public static var POTENCY = 30.0;
	public static var LIFESPAN = 2.5;
	public static var HITS = 10;

	public function new(group:FlxSpriteGroup) {
		super(group, POTENCY, Element.Fire, COOLDOWN);
	}

	override function start() {
		super.start();

		group.add(new FireTornadoProjectile(group, attackOrigin.x, attackOrigin.y, FlxPoint.get(attackDirection.x * SPEED, attackDirection.y * SPEED)));
	}
}
