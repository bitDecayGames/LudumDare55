package entities.attacks;

import entities.attacks.projectiles.FireSpikeProjectile;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import elements.Element;

class FireSpikeAttack extends SingleAttack {
	public static var SPEED = 300.0;
	public static var COOLDOWN = 0.5;
	public static var POTENCY = 50.0;
	public static var RADIUS = 25.0;
	public static var LIFESPAN = 1.0;

	public function new(group:FlxSpriteGroup) {
		super(group, POTENCY, Element.Fire, COOLDOWN);
	}

	override function start() {
		super.start();

		group.add(new FireSpikeProjectile(group, attackOrigin.x, attackOrigin.y, FlxPoint.get(attackDirection.x * SPEED, attackDirection.y * SPEED)));
	}
}
