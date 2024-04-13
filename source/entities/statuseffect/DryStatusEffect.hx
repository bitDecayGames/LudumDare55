package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class DryStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Dry;
	}

	override function canBeAdded():Bool {
		return !self.effects.has(StatusEffect.Frozen);
	}

	override function onEnter() {
		super.onEnter();
		self.effects.removeByType(StatusEffect.Wet);
	}
}
