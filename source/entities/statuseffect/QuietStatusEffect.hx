package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class QuietStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity) {
		super(self, -1);
		type = StatusEffect.Quiet;
	}

	override function onEnter() {
		super.onEnter();
		self.effects.removeByType(StatusEffect.Loud);
	}
}
