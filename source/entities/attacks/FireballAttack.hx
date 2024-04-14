package entities.attacks;

import entities.attacks.projectiles.FireballProjectile;
import flixel.group.FlxSpriteGroup;
import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class FireballAttack extends SingleAttack {
	public static var SPEED = 30.0;
	public static var COOLDOWN = 30.0;
	public static var POTENCY = 30.0;
	public static var RADIUS = 30.0;
	public static var LIFESPAN = 30.0;

	public function new(group:FlxSpriteGroup) {
		super(group, POTENCY, Element.Fire, COOLDOWN);

		loadGraphic(AssetPaths.gem__png);
	}

	override function start() {
		super.start();

		group.add(new FireballProjectile(group, attackOrigin.x, attackOrigin.y, FlxPoint.get(attackDirection.x * SPEED, attackDirection.y * SPEED)));
	}
}
