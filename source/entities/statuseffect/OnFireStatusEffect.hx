package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class OnFireStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.OnFire;
	}

	override function canBeAdded():Bool {
		return !self.effects.has(StatusEffect.Wet) && !self.effects.has(StatusEffect.Frozen);
	}
}
