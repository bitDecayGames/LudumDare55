package entities.attacks;

import flixel.group.FlxSpriteGroup;
import elements.Element;

class AttackPicker {
	public var group:FlxSpriteGroup;
	public var empty:EmptyAttack;
	public var attacks:Map<Element, Map<Element, BaseAttack>>;

	public function new(group:FlxSpriteGroup) {
		this.group = group;
		attacks = [
			None => [
				None => new FireballAttack(group),
			],
			Fire => [
				Fire => new FireballAttack(group),
				Metal => new FireSpikeAttack(group),
				Wind => new FireTornadoAttack(group),
			],
		];
		
	}

	public function get(primary:Element, secondary:Element):BaseAttack {
		if (!attacks.exists(primary) || !attacks.get(primary).exists(secondary)) {
			return empty;
		}
		return attacks.get(primary).get(secondary);
	}

	public function update(delta:Float) {
		for (attackGrp in attacks) {
			for (attack in attackGrp) {
				attack.update(delta);
			}
		}
	}
}
