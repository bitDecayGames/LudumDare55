package entities.attacks;

import flixel.group.FlxSpriteGroup;
import entities.statuseffect.HitStatusEffect;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import elements.Element;

class ContinuousAttack extends BaseAttack {

	public function new(group:FlxSpriteGroup, potency:Float, damageType:Element, cooldown:Float) {
		super(group, potency, damageType, cooldown);
	}

}
