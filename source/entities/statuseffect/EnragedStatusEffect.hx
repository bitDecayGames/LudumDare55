package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class EnragedStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Enranged;
	}

	override function canBeAdded():Bool {
		return !self.effects.has(StatusEffect.Asleep);
	}

	override function onEnter() {
		super.onEnter();
		self.effects.removeByType(StatusEffect.Confused);
	}
}
