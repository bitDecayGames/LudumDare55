package entities;

import entities.statuseffect.SlowStatusEffect;

class SlowTerrainAreaEffect extends AreaEffect {
	public function new(x:Float, y:Float, radius:Float, potency:Float) {
		super(x, y, radius, potency);
	}

	override function onEnter(entity:BaseEntity) {
		super.onEnter(entity);
		entity.effects.add(new SlowStatusEffect(entity, potency, -1, id));
	}

	override function onExit(entity:BaseEntity) {
		super.onExit(entity);
		entity.effects.removeByOwner(id);
	}
}