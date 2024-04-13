package entities;

import entities.statuseffect.DifficultTerrainStatusEffect;

class DifficultTerrainAreaEffect extends AreaEffect {
	public function new(x:Float, y:Float, radius:Float, potency:Float) {
		super(x, y, radius, potency);
	}

	override function onEnter(entity:BaseEntity) {
		super.onEnter(entity);
		entity.effects.add(new DifficultTerrainStatusEffect(entity, potency, id));
	}

	override function onExit(entity:BaseEntity) {
		super.onExit(entity);
		entity.effects.removeByOwner(id);
	}
}