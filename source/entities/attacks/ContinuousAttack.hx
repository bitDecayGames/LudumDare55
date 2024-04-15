package entities.attacks;

import flixel.group.FlxSpriteGroup;
import elements.Element;

class ContinuousAttack extends BaseAttack {

	public function new(group:FlxSpriteGroup, potency:Float, damageType:Element, cooldown:Float) {
		super(group, potency, damageType, cooldown);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (started) {
			spawn();
		}
	}

	public function spawn() {

	}
}
