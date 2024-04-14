package entities.attacks;

import flixel.group.FlxSpriteGroup;
import elements.Element;

class EmptyAttack extends SingleAttack {
	public static var COOLDOWN = 10.0;

	public function new(group:FlxSpriteGroup) {
		super(group, 0, Element.None, COOLDOWN);
	}
}
