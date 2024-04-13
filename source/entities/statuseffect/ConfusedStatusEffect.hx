package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class ConfusedStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Confused;
	}

	override function canBeAdded():Bool {
		return !self.effects.has(StatusEffect.Enranged);
	}
}
