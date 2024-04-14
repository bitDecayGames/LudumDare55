package entities;

import entities.statuseffect.SlipperyStatusEffect;

class SlipperyAreaEffect extends AreaEffect {
	public function new(x:Float, y:Float, radius:Float, potency:Float) {
		super(x, y, radius, potency);
	}

	override function onEnter(entity:BaseEntity) {
		super.onEnter(entity);
		new SlipperyStatusEffect(entity, potency, id);
	}

	override function onExit(entity:BaseEntity) {
		super.onExit(entity);
		entity.effects.removeByOwner(id);
	}
}